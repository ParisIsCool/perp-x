AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

-- To-do
-- - Recompile model under pt
-- - Fix weird chair physics issue
-- - Implement local bet with slots_spin command
-- - Define multiplier combinations (In-Progress)

/*---------------------------------------------------------
	Basics
---------------------------------------------------------*/
function ENT:Initialize()
	self.BetAmount = 500
	self.SlotsPlaying = nil
	self.SlotsSpinning = false
	self.LastSpin = CurTime()
	
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow( false )
	self:SetAngles( Angle( 0, 90, 0 ) )
	
	self:SetupChair()

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:EnableMotion( false )
		phys:Sleep()
	end
end

function ENT:Think()
	if self:IsInUse() then
		-- Player In Chair Check
		if not self.SlotsPlaying then	-- Game not in play, player in chair
			self:SendPlaying()
		end

		-- Player Idling Check
		if ( self.LastSpin + ( 60 * 3 ) < CurTime() ) then
			local ply = self:GetPlayer()
			ply:ExitVehicle()
			ply:ChatPrint( "You have been ejected due to idling!" )
			ply:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
		end
	else
		if self.SlotsPlaying then	-- Game in play, nobody in chair
			if IsValid( self.chair ) then
				self.chair:Remove()
			end
			self.SlotsPlaying = nil
		end
	end
	
	if self.Jackpot and self.Jackpot < CurTime() then
		self.Jackpot = nil
	end
	
	self:NextThink( CurTime() ) -- Don't change this, the animation requires it
	
	return true
end

/*---------------------------------------------------------
	Chair Related Functions
---------------------------------------------------------*/
local function HandleRollercoasterAnimation( vehicle, player )
	return player:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER )
end

function ENT:SetupChair()
	-- Chair Model
	self.chairMdl = ents.Create( "prop_physics_multiplayer" )
	--self.chairMdl:SetModel("models/props/cs_militia/barstool01.mdl")
	self.chairMdl:SetModel( self.ChairModel )
	--self.chairMdl:SetParent(self)
	self.chairMdl:SetPos( self:GetPos() + Vector( 0, 35, -2 ) )
	self.chairMdl:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
	self.chairMdl:DrawShadow( false )
	
	self.chairMdl:PhysicsInit( SOLID_VPHYSICS )
	self.chairMdl:SetMoveType( MOVETYPE_NONE )
	self.chairMdl:SetSolid( SOLID_VPHYSICS )
	
	self.chairMdl:Spawn()
	self.chairMdl:Activate()

	self.chairMdl.NoDelete = true
	
	local phys = self.chairMdl:GetPhysicsObject()
	if IsValid( phys ) then
		phys:EnableMotion( false )
		phys:Sleep()
	end
	
	self.chairMdl:SetKeyValue( "minhealthdmg", "999999" )
end

function ENT:SetupVehicle()
	-- Chair Vehicle
	self.chair = ents.Create( "prop_vehicle_prisoner_pod" )
	self.chair:SetModel( "models/nova/airboat_seat.mdl" )
	self.chair:SetKeyValue( "vehiclescript","scripts/vehicles/prisoner_pod.txt" )
	--self.chair:SetParent(self)
	self.chair:SetPos( self:GetPos() + Vector( 0, 35, 30 ) )
	self.chair:SetAngles( Angle( 0, 180, 0 ) )
	self.chair:SetNotSolid( true )
	self.chair:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.chair:SetNoDraw( true )
	self.chair:DrawShadow( false )

	self.chair.HandleAnimation = HandleRollercoasterAnimation
	self.chair.bSlots = true

	self.chair:Spawn()
	self.chair:Activate()

	self.chair.NoDelete = true
	
	local phys = self.chair:GetPhysicsObject()
	if IsValid( phys ) then
		phys:EnableMotion( false )
		phys:Sleep()
	end
end

function ENT:IsInUse()
	if IsValid( self.chair ) and self.chair:GetDriver():IsPlayer() then
		return true
	end
end

/*---------------------------------------------------------
	Initial Player Interaction
---------------------------------------------------------*/
function ENT:Use( ply )
	if not IsValid( ply ) or not ply:IsPlayer() then
		return
	end

	if ply:Team() ~= TEAM_CITIZEN then
		return ply:ChatPrint( "You must be a citizen to play slot machines!" )
	end
	
	if not self:IsInUse() then
		self:SetupVehicle()
	
		if not IsValid( self.chair ) then return end -- just making sure...
	
		ply.SeatEnt = self.chair
		ply.EntryPoint = ply:GetPos()
		ply.EntryAngles = ply:EyeAngles()
		
		ply:EnterVehicle( self.chair )
		self:SendPlaying( ply )
	end
end

hook.Add( "PlayerLeaveVehicle", "ResetCollisionVehicle", function( ply, veh )
	if ply.SlotMachine then
		ply:SetCollisionGroup( COLLISION_GROUP_NONE )
		ply.SlotMachine = nil
	end

	if veh.AntiStuck then
		local pos = ply:GetPos()

		ply:SetPos( Vector( pos.x, pos.y, pos.z - 10 ) )
	end
end )

hook.Add( "CanExitVehicle", "PreventExit", function( vehicle, ply )
	if ply.SlotMachine and ply.SlotMachine.SlotsSpinning then
		return
	end

	if ply.SlotMachine then ply:ChatPrint( Format( "You spun %i time(s) and gained/lost a total of: $%s", ply.spuntimes or 0, ply.moneyslot and ( ply.moneyslot <= -1000 or ply.moneyslot >= 0 ) and util.FormatNumber( ply.moneyslot ) or 0 ) ) end

	ply.spuntimes = nil
	ply.moneyslot = nil
end )

/*---------------------------------------------------------
	Console Commands
---------------------------------------------------------*/
concommand.Add( "slotm_spin", function( ply, cmd, args )
	local bet = math.Clamp( tonumber( args[1] ) or 500, 500, 1000 )

	local ent = ply.SlotMachine
	if IsValid( ent ) and not ent.SlotsSpinning and not ent.Jackpot then
		ent.LastSpin = CurTime()

		local spuntimes = ply.spuntimes or 0
		ply.spuntimes = spuntimes + 1

		if ply:GetCash() < bet then
			ply:ChatPrint( "You don't have enough money :(" )
			ent:PullLever()

			ent.SlotsSpinning = true

			timer.Simple( 1, function() ent.SlotsSpinning = false end )

			return -- Like a baws :)
		end

		local Log = Format( "%s spent $%s on a slot machine.", ply:Nick(), util.FormatNumber( bet ) )	
		GAMEMODE:Log( "cashlog", Log, ply:SteamID() )
		
		ply:TakeCash( bet, true )

		local money = ply.moneyslot or 0
		ply.moneyslot = money - bet
		
		ent.BetAmount = bet
		ent:PullLever()
		ent:PickResults()
		ply:AddProgress(28, 1)
	end
end )

/*---------------------------------------------------------
	Slot Machine Functions
---------------------------------------------------------*/
function ENT:GetPlayer()
	local ply = player.GetByID( self.SlotsPlaying )

	if IsValid( ply ) and ply:IsPlayer() and self:IsInUse() then
		return ply
	end
end

function ENT:SendPlaying()
	if not IsValid( self ) or not IsValid( self.chair ) then return end

	self.SlotsPlaying = self.chair:GetDriver():EntIndex()
	self.LastSpin = CurTime()
	
	local ply = self:GetPlayer()
	ply.SlotMachine = self

	umsg.Start( "slotsPlaying", ply )
		umsg.Short( self:EntIndex() )
	umsg.End()
end

function ENT:PullLever()
	local seq = self:LookupSequence( "pull_handle" )
	
	if seq == -1 then return end
	
	self:ResetSequence( seq )
end

local function getRand()
	local rand = math.random( 1, 6 )

	return rand
end

function ENT:PickResults()
	self.SlotsSpinning = true
	
	local random = { getRand(), getRand(), getRand() }
	if random[1] == 2 then
		random[1] = math.random( 1, 6 )
	end
	if random[2] == 2 then
		random[2] = math.random( 1, 6 )
	end
	
	umsg.Start( "slotsResult" )
		umsg.Short( self:EntIndex() )
		umsg.Short( random[1] )
		umsg.Short( random[2] )
		umsg.Short( random[3] )
	umsg.End()
	
	self:EmitSound( Casino.SlotPullSound, 30, 100 )
	
	timer.Simple( Casino.SlotSpinTime[3], function()
		self:CalcWinnings( random )
	end )
	
	-- Prevent spin button spam
	timer.Simple( Casino.SlotSpinTime[3] + 1, function()
		self.SlotsSpinning = false
	end )
end

-- Ranked highest to lowest
ENT.ExactCombos = {
	[ "6" ] = { 2, 2, 2 }, --Jackpot?
	[ "5.5" ] = { 1, 1, 1 },
	[ "5" ] = { 3, 3, 3 },
	[ "4.5" ] = { 4, 4, 4 },
	[ "4" ] = { 5, 5, 5 },
	[ "3.5" ] = { 6, 6, 6 },
}

ENT.AnyTwoCombos = {
	[ "2.5" ] = 2,
}

local messaged = 0
function ENT:CalcWinnings( random )
	if not self:IsInUse() then
		return
	end
	
	local ply = self:GetPlayer()
	local winnings = 0
	
	-- Jackpot
	if table.concat( random ) == "222" then
		local winnings = math.Round( self:GetJackpot() + self.BetAmount )
		self:SendWinnings( ply, winnings, true )

		local Log = Format( "%s(%s)<%s> won the jackpot of $%s", ply:Nick(), ply:GetRPName(), ply:SteamID(), util.FormatNumber( winnings ) )
		GAMEMODE:Log( "jackpot", Log, ply:SteamID() )

		self:SetJackpot( 10000 )
		file.Write( "perp/slot_jackpot.txt", 10000 )
		
		return
	end
	
	-- Exact Combos
	for x, combo in pairs( self.ExactCombos ) do
		if table.concat( random ) == table.concat( combo ) then
			local winnings = math.Round( self.BetAmount * tonumber(x) )
			self:SendWinnings( ply, winnings )
			return
		end
	end

	-- Any Two Combos
	for x, combo in pairs( self.AnyTwoCombos ) do
		if random[3] == combo then
			local winnings = math.Round( self.BetAmount * tonumber(x) )
			self:SendWinnings( ply, winnings )
			return
		end
	end
	
	-- Player lost
	self:SetJackpot( self:GetJackpot() + self.BetAmount )
	file.Write( "perp/slot_jackpot.txt", self:GetJackpot() )

	if self:GetJackpot() >= 1000000 and messaged ~= 6 then
		messaged = 6
		PrintMessage( HUD_PRINTTALK, "[Casino]: JACKPOT IS 1 MILLION!!!" )
	elseif self:GetJackpot() >= 750000 and self:GetJackpot() < 1000000 and messaged ~= 5 then
		messaged = 5
		PrintMessage( HUD_PRINTTALK, "[Casino]: JACKPOT IS 750 THOUSAND!!!" )
	elseif self:GetJackpot() == 500000 and self:GetJackpot() < 750000 and messaged ~= 4 then
		messaged = 4
		PrintMessage( HUD_PRINTTALK, "[Casino]: JACKPOT IS 500 THOUSAND!!!" )
	elseif self:GetJackpot() == 250000 and self:GetJackpot() < 500000 and messaged ~= 3 then
		messaged = 3
		PrintMessage( HUD_PRINTTALK, "[Casino]: JACKPOT IS 250 THOUSAND!!!" )
	elseif self:GetJackpot() == 100000 and self:GetJackpot() < 250000 and messaged ~= 2 then
		messaged = 2
		PrintMessage( HUD_PRINTTALK, "[Casino]: JACKPOT IS 100 THOUSAND!!!" )
	elseif self:GetJackpot() == 50000 and self:GetJackpot() < 100000 and messaged ~= 1 then
		messaged = 1
		PrintMessage( HUD_PRINTTALK, "[Casino]: JACKPOT IS 50 THOUSAND!!!" )
	elseif self:GetJackpot() == 10000 then
		messaged = 0
	end
end

function ENT:SetJackpot( amount )
	SetGNWVar( "jackpot", amount )
end

function ENT:SendWinnings( ply, amount, bJackpot )
	if bJackpot then
		PrintMessage( HUD_PRINTTALK, "[Casino]: " .. ply:GetRPName() .. " HAS WON THE JACKPOT! A total of $" .. util.FormatNumber( amount ) .. "!" )
		ply:ChatPrint( "YOU WON THE JACKPOT!" )
		self:EmitSound( Casino.SlotJackpotSound, 100, 100 )
		self.Jackpot = CurTime() + 25
		
		local Log = Format( "%s won the jackpot of $%s", ply:Nick(), util.FormatNumber( amount ) )
		GAMEMODE:Log( "slot_jackpot", Log )
	else
		self:EmitSound( Casino.SlotWinSound, 75, 100 )
		ply:ChatPrint( "You won $" .. util.FormatNumber( amount ) .. "!" )
	end
	
	local light = ents.Create( "slotmachine_light" )
		light.Jackpot = bJackpot
		light:SetPos( self:GetPos() + Vector( 0, -8, 85 ) )

	light:Spawn()
	light:Activate()
	
	local Log = Format("%s earned $%s from slots " .. ( bJackpot and "jackpot" or "machine" ), ply:Nick(), util.FormatNumber( amount ))
	GAMEMODE:Log( "cashlog", Log, ply:SteamID() )
	
	ply:GiveCash( amount, true )

	local money = ply.moneyslot or 0
	ply.moneyslot = money + amount
end