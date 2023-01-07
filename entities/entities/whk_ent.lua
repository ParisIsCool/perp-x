AddCSLuaFile()

ENT.Type = "anim"
ENT.WHK_Entity = true

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Setowning_ent(ent)
	if ent:IsPlayer() then
		self:CPPISetOwner(ent)
	end
end

function ENT:CanInteract(ply)
	return hook.Run("WHK_AllowInteraction", ply, self) == true
end

function ENT:CanEditVariables(ply)
	return ply:IsAdmin() or self:CanInteract(ply)
end

hook.Add("WHK_AllowInteraction", "WHK_Default", function(ply, ent)
	if ply == ent:GetOwner() then return true end
	if ent.CPPIGetOwner and ply == ent:CPPIGetOwner() then return true end
end)
