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
	SWEP.PrintName = "Baseball Bat"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "CVey"
SWEP.Instructions = "Left Click: To hit things"
SWEP.Contact = ""
SWEP.Purpose = "Roleplay"
SWEP.UseHands = true;

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = "models/weapons/v_basebat.mdl";
SWEP.WorldModel = "models/weapons/w_basebat.mdl";
SWEP.UseHands = true

function SWEP:Initialize()
	self:SetWeaponHoldType("melee2");
end

function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	
	self.Weapon:SetNextPrimaryFire(CurTime() + .5)
	self.Weapon:SetNextSecondaryFire(CurTime() + .5)
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
	if Distance > 75 then 
		self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER );
		return false; 
	end
	
	if EyeTrace.MatType == MAT_GLASS then
		self.Weapon:EmitSound("physics/glass/glass_cup_break" .. math.random(1, 2) .. ".wav");
		self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER );
		return false;
	end
	
	if EyeTrace.HitWorld then
		self.Weapon:EmitSound("physics/metal/metal_canister_impact_hard" .. math.random(1, 3) .. ".wav");
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );
		util.Decal('Impact.Metal', EyeTrace.HitPos + EyeTrace.HitNormal, EyeTrace.HitPos - EyeTrace.HitNormal);
		return false;
	end
	
	if !EyeTrace.Entity or !EyeTrace.Entity:IsValid() or !EyeTrace.HitNonWorld then return false; end
	
	if EyeTrace.MatType == MAT_FLESH then
		// probably another person or NPC
		self.Weapon:EmitSound("physics/flesh/flesh_impact_hard" .. math.random(1, 6) .. ".wav")
		self.Weapon:EmitSound("physics/concrete/concrete_block_impact_hard" .. math.random(1, 3) .. ".wav")
		self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER );
		
		local OurEffect = EffectData();
		OurEffect:SetOrigin(EyeTrace.HitPos);
		util.Effect("BloodImpact", OurEffect);
		
		if SERVER then
			if EyeTrace.Entity:IsPlayer() then
			local hitgroup = EyeTrace.HitGroup
				if(hitgroup == HITGROUP_LEFTLEG || hitgroup == HITGROUP_RIGHTLEG) then
					local ran = math.random(1, 5)
					if ran == 5 then
						EyeTrace.Entity:GetTable().Crippled = true
						EyeTrace.Entity:EmitSound("physics/body/body_medium_break4.wav")
						EyeTrace.Entity:TakeDamage(math.random(20, 30), self.Owner, self.Weapon);
					end
				elseif(hitgroup == HITGROUP_HEAD) then
					local vec1 = self.Owner:GetForward()
					local vec2 = EyeTrace.Entity:GetForward()
					local scalar = vec1.x*vec2.x+vec1.y*vec2.y+vec1.z*vec2.z
					scalar = scalar / (vec1:Length()*vec2:Length())
					local angle = math.acos(scalar)
					if(angle < 80 || angle > 280) then
						EyeTrace.Entity:TakeDamage(math.random(45, 60), self.Owner, self.Weapon);
						EyeTrace.Entity:EmitSound("physics/body/body_medium_break4.wav")
					else
						EyeTrace.Entity:TakeDamage(math.random(25, 40), self.Owner, self.Weapon);
						EyeTrace.Entity:EmitSound("physics/body/body_medium_break4.wav")
					end
				else
					EyeTrace.Entity:TakeDamage(math.random(10, 20), self.Owner, self.Weapon);
				end
			end
		end
		
		return false;
	else
		// something else?
		self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER );
		self.Weapon:EmitSound("physics/metal/metal_canister_impact_hard" .. math.random(1, 3) .. ".wav");
		
		if (SERVER && EyeTrace.Entity.HasHealth) then
			EyeTrace.Entity:TakeDamage(1, self.Owner, self);
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
	
	self:SetDeploySpeed(self.Weapon:SequenceDuration());
	
	if (CLIENT) then
		local sex = "his";
		
		if (self.Owner:GetSex() == SEX_FEMALE) then
			sex = "her";
		end
		
		tosay = sex .. " " .. self.PrintName;
		
		RunConsoleCommand("say", "/me pulls out " .. tosay);
	end
end