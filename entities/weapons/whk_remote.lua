AddCSLuaFile()

SWEP.PrintName = "WHK Remote"
SWEP.Category = "Wyozi Home Kit"

SWEP.Spawnable		= true
SWEP.AdminOnly		= true

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.ViewModel = "models/props/cs_office/projector_remote.mdl"
SWEP.WorldModel = "models/props/cs_office/projector_remote.mdl"

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:PrimaryAttack()
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if IsValid(ent) and ent.WHK_MediaSource then
			self.Owner:ConCommand("whk_mediachooser " .. ent:EntIndex())
		end
		self:SetNextPrimaryFire(CurTime() + 0.5)
	end
end
function SWEP:SecondaryAttack()
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if IsValid(ent) and ent.WHK_MediaSource and ent.CanSetUrl and ent:CanInteract(self.Owner) then
			ent:SetUrl("")
		end
		self:SetNextSecondaryFire(CurTime() + 0.5)
	end
end

if CLIENT then

	function SWEP:GetViewModelPosition(pos, ang)

		local mypitch = self.Owner:EyeAngles().p
		if mypitch <-40 then
			ang:RotateAroundAxis( ang:Right(), ang.p + 40)
		elseif mypitch > 40 then
			ang:RotateAroundAxis( ang:Right(), ang.p - 40)
		end

		pos = pos + ang:Forward() * 15
		pos = pos + ang:Up() * -5
		pos = pos + ang:Right() * 5

		ang:RotateAroundAxis(ang:Up(), 90)

		self.ViewModelPos = {pos, ang}

		return pos, ang
	end

	function SWEP:GetWorldPos()
		if not IsValid(self.Owner) then return self:GetPos(), self:GetAngles() end

		local BoneIndx = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
		local BonePos , BoneAng = self.Owner:GetBonePosition( BoneIndx )

		local pos = BonePos
		local ang = BoneAng

		--ang:RotateAroundAxis(ang:Right(), 180)

		--ang:RotateAroundAxis(ang:Right(), 10)
		ang:RotateAroundAxis(ang:Forward(), 90)

		pos = pos + ang:Right() * 1
		pos = pos + ang:Forward() * 3
		pos = pos + ang:Up() * 1

		return pos, ang
	end

	local matLight = Material( "sprites/light_glow02_add" )
	function SWEP:DrawWorldModel()

		local pos, ang = self:GetWorldPos()
		if not pos or not ang then return end

		self:SetRenderOrigin(pos)
		self:SetRenderAngles(ang)
		self:SetupBones()
		self:DrawModel()
	end

end
