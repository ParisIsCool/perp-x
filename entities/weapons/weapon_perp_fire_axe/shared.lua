--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Fire Axe"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "G-Force"
SWEP.Instructions = "Left Click: Swing - Useful for knocking down doors."

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = Model( "models/weapons/v_fireaxe.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_fireaxe.mdl" )
if CLIENT then SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/myicon/fireaxe" ) end

function SWEP:Initialize() self:SetWeaponHoldType("melee") end

function SWEP:CanPrimaryAttack ( ) return true end

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	
	self.Weapon:SetNextPrimaryFire(CurTime() + .5)
	self.Weapon:SetNextSecondaryFire(CurTime() + .5)
	
	local EyeTrace = self.Owner:GetEyeTrace()
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos)
	if Distance > 75 then return false end
	
	if EyeTrace.MatType == MAT_GLASS then
		self.Weapon:EmitSound("physics/glass/glass_cup_break" .. math.random(1, 2) .. ".wav")
		return false
	end
	
	--FireAxe does damage
	
	if EyeTrace.MatType == MAT_FLESH then
		self.Weapon:EmitSound( "physics/flesh/flesh_impact_bullet" .. math.random( 1, 5 ) .. ".wav" )
		
		local OurEffect = EffectData()
		OurEffect:SetOrigin( EyeTrace.HitPos )
		util.Effect( "BloodImpact", OurEffect )
		
		if SERVER and EyeTrace.Entity:IsPlayer() then
			--if not EyeTrace.Entity:Team() == TEAM_MAYOR then
				EyeTrace.Entity:TakeDamage( math.random( 5, 25 ), self.Owner, self.Weapon )
				--EyeTrace.Entity:TakeDamage( 20, self.Owner, self.Weapon )
				EyeTrace.Entity:SetVelocity( self.Owner:GetAimVector() * 500 )
			--end
		end
		
		return false
	else
		self.Weapon:EmitSound( "physics/flesh/flesh_impact_bullet" .. math.random( 1, 5 ) .. ".wav" )
	end
	
	if EyeTrace.HitWorld then
		self.Weapon:EmitSound("physics/metal/metal_canister_impact_hard" .. math.random(1, 3) .. ".wav")
		
		util.Decal('Impact.Metal', EyeTrace.HitPos + EyeTrace.HitNormal, EyeTrace.HitPos - EyeTrace.HitNormal)
		return false
	end
	
	if not IsValid( EyeTrace.Entity ) or not EyeTrace.HitNonWorld then return false end
	
	if string.find(EyeTrace.Entity:GetClass(), 'door') then
		self.Weapon:EmitSound("physics/wood/wood_box_impact_hard" .. math.random(1, 3) .. ".wav")
		
		if (SERVER) then
			local NearFire = false
			for k, v in pairs(ents.FindInSphere(EyeTrace.Entity:GetPos(), 750)) do
				if v:GetClass() == 'ent_fire' then
					NearFire = true
				end
			end
			
			if NearFire then
				EyeTrace.Entity.AxeDoorHealth = EyeTrace.Entity.AxeDoorHealth or math.random(3, 6)
				EyeTrace.Entity.AxeDoorHealth = EyeTrace.Entity.AxeDoorHealth - 1
					
				if EyeTrace.Entity.AxeDoorHealth == 0 then
					EyeTrace.Entity.AxeDoorHealth = nil
						
					EyeTrace.Entity:Fire('unlock', '', 0)
					EyeTrace.Entity:Fire('open', '', .5)
				end
			else
				self.Owner:Notify('Why would you bust down this door if there is no fire nearby?')
			end
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end
