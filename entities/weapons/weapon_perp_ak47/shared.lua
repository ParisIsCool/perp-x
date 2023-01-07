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
	SWEP.BackHolster = true
end

if CLIENT then
	SWEP.PrintName			= "AK-47"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "b"
end

SWEP.HoldType			= "ar2"
SWEP.HoldTypeNorm		= "normal"

SWEP.Base				= "weapon_perp_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.AnimPrefix	 = "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Recoil			= .8
SWEP.Primary.Damage			= 35
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= .01
SWEP.Primary.ClipSize		= 31
SWEP.Primary.Delay			= 0.07
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 			= Vector(6.0868, -6.2605, 2.25)
SWEP.IronSightsAng 			= Vector( 2, 0, 0 )
SWEP.NormalPos 				= Vector( 0, 0, 3.5 )
SWEP.NormalAng 				= Vector(  -20, 0, 0 )

SWEP.MaxPenetration = PENETRATION_RIFLE

SWEP.GrantExperience_Skill 	= SKILL_RIFLE_MARK
SWEP.GrantExperience_Exp	= 1