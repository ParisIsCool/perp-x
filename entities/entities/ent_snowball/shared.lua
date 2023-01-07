ENT.Type			= "anim"
ENT.Base			= "base_gmodentity"
ENT.PrintName		= "snowball_entity"
ENT.Author			= "Blackjackit"
ENT.Purpose 		= "snowball_entity"
ENT.Category		= "Snowballs"

ENT.Spawnable			= false
ENT.AdminSpawnable		= false 

function ENT:Initialize()
	if SERVER then return end
	if file.Exists("models/weapons/w_snowball_thrown.mdl","GAME") then 
		return
	end
	self.Entity:SetModel("models/combine_helicopter/helicopter_bomb01.mdl")
	self.Entity:SetModelScale(0.1,0)
	self.Entity:SetMaterial("models/debug/debugwhite")
end