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
	self:SetModel( "models/unioncity2/props_unioncity/gaspump_712.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():EnableMotion(false)
end

function ENT:PhysicsCollide( data, phys )
	if ( data.Speed > 500 ) and not self.Exploded then
		util.BlastDamage( self, self, self:GetPos(), 1000, 800 )
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
			if v:IsPlayer() and not v:HasGodMode() then
				v:Kill()
			end
		end
		ParticleEffect( "explosion_huge", self:GetPos(), Angle( 0, 0, 0 ) )
		self:EmitSound("phx/explode0"..math.random(0,6)..".wav", 160, 100, 1, CHAN_AUTO, 0, 119)
		self:SetColor(Color(51,51,51))
		self.Exploded = true

		timer.Simple(200, function()
			self.Exploded = false
			self:SetColor(Color(255,255,255))
		end)
	end
end