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
	AddCSLuaFile( "shared.lua" )

	SWEP.BackHolster 		= true
end

if CLIENT then
	SWEP.PrintName			= "Shotgun"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "k"
end

SWEP.HoldType				= "ar2"
SWEP.HoldTypeNorm			= "passive"

SWEP.Base					= "weapon_perp_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel				= Model( "models/weapons/v_shot_m3super90.mdl" )
SWEP.WorldModel				= Model( "models/weapons/w_shot_m3super90.mdl" )

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.AnimPrefix	 			= "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_M3.Single" )
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots		= 8
SWEP.Primary.Cone			= 0.1
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.95
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"
SWEP.Numbul 				= 10

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 			= Vector(5.7185, -5.8064, 3.345)
SWEP.IronSightsAng 			= Vector( 0, 0, 0 )
SWEP.NormalPos 				= Vector( 0, 0, 3.4 )
SWEP.NormalAng 				= Vector(  -19, 0, 0 )

SWEP.MaxPenetration 		= PENETRATION_SHOTGUN

SWEP.GrantExperience_Skill 	= SKILL_SHOTGUN_MARK
SWEP.GrantExperience_Exp 	= 500

function SWEP:Reload()
	self:SetIronsights( false )
	
	if self.Weapon:GetGNWVar( "reloading" ) then return end
	
	if self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
		if SERVER then self.Weapon:SetGNWVar( "reloading", true ) end
		self.Weapon:SetVar( "reloadtimer", CurTime() + 0.5 )
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	end
end

function SWEP:Think()
	if self.Weapon:GetGNWVar( "reloading" ) then
		if self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() then
			if self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
				return SERVER and self.Weapon:SetGNWVar( "reloading", nil )
			end
			
			self.Weapon:SetVar( "reloadtimer", CurTime() + 0.3 )
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
			
			if self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			end
		end
	end
end