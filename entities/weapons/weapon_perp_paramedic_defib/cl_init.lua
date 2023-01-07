--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

include( "shared.lua" )

SWEP.PrintName 		= "Defibrillator"
SWEP.Slot 			= 2
SWEP.SlotPos 		= 1
SWEP.DrawAmmo 		= false
SWEP.DrawCrosshair 	= false

function SWEP:GetViewModelPosition( Pos, Ang )
	Pos = Pos + Ang:Up() * 6
	
	return Pos, Ang
end 

function SWEP:PrimaryAttack()
	if self.ChargeAmmount < 75 then return false end

	local EyeTrace = self.Owner:GetEyeTrace()
	if not EyeTrace.Entity and not EyeTrace.Entity:GetClass() == "prop_ragdoll" then return false end
	
	local Distance = self.Owner:EyePos():Distance( EyeTrace.Entity:GetPos() )
	if Distance > 75 then return false end

	LastCPRUpdate = LastCPRUpdate or 0
		
	if LastCPRUpdate + .5 < CurTime() then
		LastCPRUpdate = CurTime()

		self.Weapon:EmitSound( "perp2.5/revive.wav" )
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			
		self.ChargeAmmount = self.ChargeAmmount - 75
	end
end