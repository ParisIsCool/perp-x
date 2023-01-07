--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]



SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = "models/wrepons/v_crowbar.mdl"
SWEP.WorldModel = "models/wrepons/W_crowbar.mdl"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.AnimPrefix  = "stunstick"

function SWEP:Initialize()
	self:SetWeaponHoldType( "melee" )
end

function SWEP:CanPrimaryAttack() return true end