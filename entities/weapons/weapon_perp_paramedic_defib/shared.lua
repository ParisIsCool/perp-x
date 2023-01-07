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
SWEP.Instructions 			= "Left Click: Attempt to shock victim back to life. Right Click: Charge defibrillator."

SWEP.ViewModelFOV 			= 62
SWEP.ViewModelFlip 			= false
SWEP.AnimPrefix	 			= "rpg"

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= 0
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ViewModel = Model( "models/weapons/v_defilibrator.mdl" )
SWEP.WorldModel = Model( "models/perp2/w_fists.mdl" )
if CLIENT then SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/myicon/defibillator" ) end

function SWEP:Initialize()
	self:SetWeaponHoldType( "normal" )

	self.ChargeAmmount = 0
	self.NextDecharge = CurTime() + 5
	self.SmoothCharge = CurTime() + 5
	self.LastNoChargeError = CurTime()
end

function SWEP:CanPrimaryAttack() return true end

function SWEP:SecondaryAttack()
	if self.Weapon.LastChargeUp and self.Weapon.LastChargeUp + .75 > CurTime() then return end
	self.Weapon.LastChargeUp = CurTime()
	
	self.Weapon:SetNextSecondaryFire( CurTime() + .75 )
	self.Weapon:SetNextPrimaryFire( CurTime() + .75 )
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

	self.ChargeAmmount = math.Clamp( self.ChargeAmmount + 25, 0, 100 )
end