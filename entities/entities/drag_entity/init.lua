AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
function ENT:Initialize()
	self.Entity:SetModel("models/Gibs/HGIBS.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
end

function ENT:Think()
	if(!self:IsPlayerHolding() or !constraint.HasConstraints(self))then
	self:Remove()
	end
end