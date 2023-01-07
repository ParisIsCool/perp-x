DEFINE_BASECLASS("whk_ent")

ENT.Base = "whk_ent"
ENT.WHK_MediaSource = true

ENT.CanSetUrl = true

function ENT:SetupDataTables()
	if BaseClass.SetupDataTables then BaseClass.SetupDataTables(self) end
	self:NetworkVar("Float", 0, "MediaStartTime")
	self:NetworkVar("String", 0, "Url")
end

function ENT:CanInteract(ply)
	if self:GetNWBool("WHK_LockSetMedia", false) == true then
		return ply == self:CPPIGetOwner() or ply:IsAdmin()
	end
	return BaseClass.CanInteract(self, ply)
end

hook.Add("WHK_AllowInteraction", "WHK_MediaSource_Default", function(ply, ent)
	-- allow everyone to interact with media sources by default
	if ent.WHK_MediaSource then return true end
end)
