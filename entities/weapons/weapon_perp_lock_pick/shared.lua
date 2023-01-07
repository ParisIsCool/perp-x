--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

SWEP.Author 				= "G-Force"
SWEP.Instructions 			= "Left Click: Attempt to pick lock."

SWEP.HoldType 				= "melee"
SWEP.ViewModel 				= Model( "models/weapons/v_crowbar.mdl" )
SWEP.WorldModel 			= Model( "models/weapons/w_crowbar.mdl" )

SWEP.ViewModelFOV 			= 62
SWEP.ViewModelFlip 			= false
SWEP.AnimPrefix	 			= "melee"

SWEP.BreakSound 			= Sound( "doors/handle_pushbar_locked1.wav" )
SWEP.BatterSound 			= Sound( "doors/door_locked2.wav" )
SWEP.BatterSoundFX          = "doors/door_locked2.wav"

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= 0
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

function SWEP:Initialize() self:SetWeaponHoldType( "melee" ) end