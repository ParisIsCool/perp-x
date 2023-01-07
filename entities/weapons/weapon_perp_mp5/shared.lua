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
	SWEP.PrintName			= "Tactical MP5"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "x"
end

SWEP.HoldType				= "ar2"
SWEP.HoldTypeNorm			= "passive"

SWEP.Base					= "weapon_perp_base"
SWEP.Category				= "Counter-Strike"

SWEP.ViewModel 				= Model( "models/weapons/v_smg_mp5.mdl" )
SWEP.WorldModel 			= Model( "models/weapons/w_smg_mp5.mdl" )

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.AnimPrefix	 			= "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_MP5Navy.Single" )
SWEP.Primary.Recoil 		        = 0.6
SWEP.Primary.Damage 		= 35
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.009
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Delay 			= 0.075
SWEP.Primary.DefaultClip 	        = 0
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector (4.7617, -5.1273, 1.9673)
SWEP.IronSightsAng = Vector (.6, 0, 0)
SWEP.NormalPos 			= Vector( 0, 0, 3 )
SWEP.NormalAng 			= Vector(  -20, 0, 0 )

SWEP.MaxPenetration 		= PENETRATION_RIFLE

SWEP.GrantExperience_Skill 	= SKILL_RIFLE_MARK
SWEP.GrantExperience_Exp	= 1