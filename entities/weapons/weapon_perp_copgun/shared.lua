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
end

if CLIENT then
	SWEP.PrintName			= "Service Pistol"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "u"
end

SWEP.HoldType				= "pistol"
SWEP.HoldTypeNorm			= "normal"

SWEP.Base					= "weapon_perp_base"

SWEP.ViewModel				= Model( "models/weapons/v_pist_fiveseven.mdl" )
SWEP.WorldModel				= Model( "models/weapons/w_pist_fiveseven.mdl" )

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.AnimPrefix	 			= "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_FiveSeven.Single" )
SWEP.Primary.Recoil			= 1.2
SWEP.Primary.Damage		= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 15
SWEP.Primary.Delay			= 0.05
SWEP.Primary.DefaultClip	        = 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 			= Vector(4.5198, -2.9805, 3.3317)
SWEP.IronSightsAng 			= Vector( 0, 0, 0 )
SWEP.NormalPos 				= Vector( 0, 0, 3.5 )
SWEP.NormalAng 				= Vector(  -20, 0, 0 )

SWEP.MaxPenetration 		= PENETRATION_PISTOL