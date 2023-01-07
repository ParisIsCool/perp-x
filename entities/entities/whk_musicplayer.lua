AddCSLuaFile()

ENT.Base = "whk_mediasource"

ENT.PrintName		= "Music Player"
ENT.Author			= "Wyozi"
ENT.Category		= "Wyozi Home Kit"

ENT.Spawnable		= true
ENT.AdminOnly		= true

ENT.Model = "models/props/cs_office/radio.mdl"

ENT.Price = 250

if SERVER then
	local cvar_health = CreateConVar("whk_health_mediaplayer", "0", FCVAR_ARCHIVE)
	function ENT:Initialize()
		self.BaseClass.Initialize(self)

		local health = cvar_health:GetInt()
		self:SetHealth(health == 0 and 99999999 or health)
		self:PrecacheGibs()
	end

	function ENT:OnTakeDamage(dmginfo)
		self:SetHealth(self:Health() - dmginfo:GetDamage())

		if self:Health() <= 0 then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			util.Effect("StunstickImpact", effectdata)

			self:GibBreakClient(Vector(0, 0, 0))

			self:Remove()
		end
	end
end
