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
	self:SetModel( "models/props_junk/meathook001a.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():SetMass( 20 )
	
	self:SetUseType( ONOFF_USE )
	
	self.Weld = nil
	self.NextAttach = CurTime()
end

function ENT:OnRemove()
	if not IsValid( self.Controller ) then return end

	self.Controller.DownSound:Stop()
	self.Controller.UpSound:Stop()

	self.Controller:EmitSound("plats/crane/vertical_stop.wav")
end

function ENT:Attach( Entity )
	if self.Weld then return end
	//if self.NextAttach > CurTime() then return end
	
	--[[if Entity:IsVehicle() and Entity.vehicleTable then
		if Entity.vehicleTable.RequiredClass then
			return
		end
	end]]--
	
	self.AttachedEntity = Entity
	
	self:EmitSound( "physics/metal/sawblade_stick1.wav" )
	
	local eff = EffectData()
	eff:SetOrigin( self:GetPos() )
	util.Effect( "ManhackSparks", eff )
	
	self.Weld = constraint.Weld( self, Entity, 0, 0, 0, true )
	
	self:GetPhysicsObject():SetMass( 500 )
	
	if Entity:IsVehicle() then
		Entity:Fire( "HandBrakeOff", "", 0 )
	end
end

function ENT:Detach()
	if self.AttachedEntity and IsValid( self.AttachedEntity ) and self.AttachedEntity:IsVehicle() then
		self.AttachedEntity:Fire( "HandBreakOn", "", 0 )
	end

	constraint.RemoveConstraints( self, "Weld" )
	
	self:GetPhysicsObject():SetMass( 20 )
	
	self.Weld = nil
	self.NextAttach = CurTime() + 2
end

function ENT:Think()
	self:Extinguish()
	
	if not IsValid( self.AttachedEntity ) then
		self:Detach()
		
		self.AttachedEntity = nil
	end
end

function ENT:Use( Player )
	if not Player:IsPlayer() then return end
	if Player:GetPos():Distance( self:GetPos() ) > 100 then return end

	if Player:Team() ~= TEAM_ROADSERVICE and not Player:IsOwner() then return end
	
	self:Detach()
end

function ENT:StartTouch( Entity )
	if Entity == self.Vehicle then return end
	if Entity == self.Pulley then return end
	if Entity == self.Controller then return end
	if Entity == game.GetWorld() then return end
	if not Entity:IsVehicle() then return end

	if self:GetVelocity():Length() > 50 then return end
	
	if Entity:GetPhysicsObject() then
		self:Attach( Entity )
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

hook.Add( "GravGunOnPickedUp", "TowtruckHookGravGunOnPickedUp", function( Player, Entity )
	if Entity:GetClass() == "ent_servicetruck_hook" then
		if Entity.Weld then
			Entity:Detach()
		end
	end
end )