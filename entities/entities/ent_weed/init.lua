--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_c17/pottery06a.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetAngles( Angle( 0, math.random( 1, 360 ), 0 ) )

	self.SpawnTime = CurTime()
	self:SetGNWVar( "SpawnTime", CurTime() )

	self.GrowthTime = WEED_GROW_TIME

	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():SetDamping( 0, 1000 )

	--timer.Simple( 0, function() -- Next frame
	--	self.RefundTable = table.insert( SPAWNED_ITEMS, { Items = { 14, 15 }, Owner = self.maker } ) -- In case of a server crash it'll refund props
	--	file.Write( "perp/items.txt", util.TableToJSON( SPAWNED_ITEMS ) )
	--end )
end

function ENT:Use( activator, caller )
	if not activator:IsPlayer() then return false end
	if self.Tapped then return false end

	if activator:Team() == TEAM_POLICE || activator:Team() == TEAM_SWAT || activator:Team() == TEAM_CHIEF || activator:Team() == TEAM_DETECTIVE || activator:Team() == TEAM_FBI then
		self.Tapped = true
		activator:GiveCash( 100 )
		activator:ChatPrint( "You have been rewarded $100 for destroying marijuana." )
		self:Remove()
	elseif activator:Team() ~= TEAM_CITIZEN then
		return activator:ChatPrint( "Computer says no." )
	elseif self.SpawnTime + self.GrowthTime < CurTime() then
		local roll = math.random( 2, 8 )
		local sroll = math.random( 0, 2 )

		if not activator:CanHoldItem( 13, roll ) then
			return activator:Notify( "You don't have enough inventory room!" )
		end

		if not activator:CanHoldItem( 14, sroll ) then
			return activator:Notify( "You don't have enough inventory room!" )
		end

		if not activator:CanHoldItem( 15, 1 ) then
			return activator:Notify( "You don't have enough inventory room!" )
		end

		activator:GiveItem( 13, roll )

		self.Tapped = true

		if sroll ~= 0 then
			activator:GiveItem( 14, sroll )
		end

		local Pos = self:GetPos()
		local Ang = self:GetAngles()
		self:Remove()

		activator:GiveItem( 15, 1 )
		activator:Notify( "You've received " .. roll .. " marijuana grams. The pot has also been returned to your inventory." )
	elseif self.SpawnTime + self.GrowthTime * .5 < CurTime() then
		local roll = math.random( 0, 3 )

		if not activator:CanHoldItem( 13, roll ) then
			return activator:Notify( "You don't have enough inventory room!" )
		end

		if not activator:CanHoldItem( 15, 1 ) then
			return activator:Notify( "You don't have enough inventory room!" )
		end

		if roll == 0 then
			activator:Notify( "You nearly salvaged some, but you picked too early to get any usable marijuana." )
		else
			activator:Notify( "You picked too early for any seeds to be found, but some marijuana was usable." )
		end

		activator:GiveItem( 13, roll )

		self.Tapped = true

		local Pos = self:GetPos()
		local Ang = self:GetAngles()
		self:Remove()

		activator:GiveItem( 15, 1 )
		activator:Notify( "You've received " .. roll .. " marijuana bags. The pot has also been returned to your inventory." )
	end
end

function ENT:StartTouch( Entity )
	if not IsValid( self.weld ) and Entity:GetClass() == "prop_vehicle_jeep" and Entity.vehicleTable and Entity.vehicleTable.Truck then
		self.weld = constraint.Weld( self, Entity, 0, 0, 0, true )

		local eff = EffectData()
		eff:SetOrigin( self:GetPos() )
		util.Effect( "ManhackSparks", eff )

		self:EmitSound( "physics/metal/sawblade_stick1.wav" )

		if self:IsPlayerHolding() then
			self:GetPhysicsObject():EnableMotion( false )

			timer.Simple( 0.5, function()
				if IsValid( self ) and IsValid( self:GetPhysicsObject() ) then
					self:GetPhysicsObject():EnableMotion( true )
				end
			end )
		end
	end
end
