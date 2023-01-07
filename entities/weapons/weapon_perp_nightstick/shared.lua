if SERVER then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.PrintName 			= "Night Stick"
	SWEP.Author 			= "G-Force"
	SWEP.Instructions 		= "Left Click: Hit, Right Click: Hit"
	SWEP.Slot 				= 2
	SWEP.SlotPos 			= 1
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
end

SWEP.ViewModelFOV 			= 62
SWEP.ViewModelFlip 			= false

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= 0
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ViewModel 				= Model( "models/weapons/v_n_stick.mdl" )
SWEP.WorldModel 			= Model( "models/weapons/w_n_stick.mdl" )


function SWEP:Initialize()
	self:SetWeaponHoldType( "melee" )
end

function SWEP:CanPrimaryAttack() return true end

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound( "npc/vort/claw_swing" .. math.random( 1, 2 ) .. ".wav" )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + .5 )
	self.Weapon:SetNextSecondaryFire( CurTime() + .5 )
	
	local EyeTrace = self.Owner:GetEyeTrace()
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos)
	if Distance > 75 then return end
	
	if EyeTrace.MatType == MAT_GLASS then
		return self.Weapon:EmitSound( "physics/glass/glass_cup_break" .. math.random( 1, 2 ) .. ".wav" )
	end
	
	if EyeTrace.HitWorld then
		self.Weapon:EmitSound( "physics/plastic/plastic_barrel_impact_bullet" .. math.random( 1, 3 ) .. ".wav" )
		
		util.Decal( "Impact.Metal", EyeTrace.HitPos + EyeTrace.HitNormal, EyeTrace.HitPos - EyeTrace.HitNormal )
		return
	end
	
	if not EyeTrace.Entity or not IsValid( EyeTrace.Entity ) or not EyeTrace.HitNonWorld then return end
	
	if EyeTrace.MatType == MAT_FLESH then
		self.Weapon:EmitSound( "physics/flesh/flesh_impact_hard" .. math.random( 1, 6 ) .. ".wav" )
		
		local OurEffect = EffectData()
		OurEffect:SetOrigin( EyeTrace.HitPos )
		util.Effect( "BloodImpact", OurEffect )
		
		if SERVER then
			if EyeTrace.Entity:IsPlayer() then
				if EyeTrace.Entity.CurrentlyArrested then
					EyeTrace.Entity:SetVelocity( self.Owner:GetAimVector() * 800 )
				else
					EyeTrace.Entity:TakeDamage( 20, self.Owner, self.Weapon )
					EyeTrace.Entity:SetVelocity( self.Owner:GetAimVector() * 500 )
				end
			end
		end
		
		return
	else
		self.Weapon:EmitSound( "physics/plastic/plastic_barrel_impact_bullet" .. math.random( 1, 3 ) .. ".wav" )
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end