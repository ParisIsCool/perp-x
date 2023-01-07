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
	self:SetModel( "models/props/water_bottle/perp2_bottle.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetAngles( Angle( 0, math.random( 1, 360 ), 0 ) )
	
	self.willBurn = math.random( 1, 10 ) == 1

	self:GetPhysicsObject():Wake()

	--timer.Simple( 0, function() -- Next frame
	--	self.RefundTable = table.insert( SPAWNED_ITEMS, { Items = { 9 }, Owner = self.maker } ) -- In case of a server crash it'll refund props
	--	file.Write( "perp/items.txt", util.TableToJSON( SPAWNED_ITEMS ) )
	--end )
end

function ENT:Use( activator, caller )
	if not activator:IsPlayer() then return false end
	
	if activator:Team() == TEAM_POLICE || activator:Team() == TEAM_SWAT || activator:Team() == TEAM_CHIEF || activator:Team() == TEAM_DETECTIVE || activator:Team() == TEAM_FBI then
		self.Tapped = true
		
		activator:GiveCash( 150 )
		activator:ChatPrint( "You have been rewarded $100 for destroying meth." )

		return self:Remove()
	end

	if self:GetGNWVar( "Smoking" ) then
		if not self.smokeStart then self.smokeStart = CurTime() end

		if CurTime() - self.smokeStart >= METH_BURN_TIME then
			if not activator:CanHoldItem( 11, 1 ) then
				 return activator:Notify( "You don't have enough inventory room!" )
			end

			activator:GiveItem( 11, 1 )
		else
			if not activator:CanHoldItem( 10, 1 ) then
				return activator:Notify( "You don't have enough inventory room!" )
			end

			activator:GiveItem( 10, 1 )
		end
	else
		if not activator:CanHoldItem( 9, 1 ) then
			return activator:Notify( "You don't have enough inventory room!" )
		end

		activator:GiveItem( 9, 1 )
	end

	self:Remove()
end

function ENT:Explode()
	local effect = EffectData()
		effect:SetOrigin( self:GetPos() )
	util.Effect( "explosion_meth", effect )
				
	local f = ents.Create( "ent_fire" )
		f:SetPos( self:GetPos() )
	f:Spawn()

	util.BlastDamage( self, self, self:GetPos(), 350, 200 )
	
	self:Remove()
end

function ENT:PhysicsCollide( data, phys )
	if IsValid(data.HitEntity) and not data.HitEntity:IsWorld() then
		if GAMEMODE.FindHeatSource( self:GetPos(), MixRange, true ) then
			if ( CurTime() - self.smokeStart ) >= ( METH_COOK_TIME * .25 ) and ( CurTime() - self.smokeStart ) <= ( METH_COOK_TIME * .75 ) then
				if math.random(1,3) == 1 then
					self:Explode()
				end
			end
		end
	end
end

function ENT:Think()
	local nearHeatSource = GAMEMODE.FindHeatSource( self:GetPos(), MixRange, true )
	
	if nearHeatSource then
		if not self.smokeStart then self.smokeStart = CurTime() end
		
		if self.willBurn and ( CurTime() - self.smokeStart ) >= ( METH_COOK_TIME * .25 ) then				
			for _, v in pairs( ents.FindInSphere( self:GetPos(), 128 ) ) do
				if v:GetClass() == "ent_meth" then
					v:Explode()
				end
			end
			
			self:Explode()
		elseif CurTime() - self.smokeStart >= METH_COOK_TIME and not self:GetGNWVar( "Smoking" ) then
			self:SetGNWVar( "Smoking", true )
		elseif CurTime() - self.smokeStart >= METH_BURN_TIME then
			self:SetColor( Color( 150, 150, 150, 255 ) )
		end
	elseif self.smokeStart then
		self.smokeStart = nil
	end
	
	self:NextThink( CurTime() + 0.5 )
	
	return true
end