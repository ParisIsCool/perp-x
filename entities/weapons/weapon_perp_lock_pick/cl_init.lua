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

SWEP.PrintName 			= "Lock Pick"
SWEP.Slot 				= 2
SWEP.SlotPos 			= 1
SWEP.DrawAmmo 			= false
SWEP.DrawCrosshair 		= false

function SWEP:PrimaryAttack()
	local EyeTrace = self.Owner:GetEyeTrace()
	if not IsValid( EyeTrace.Entity ) then return end

	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
	if Distance > 75 then return end
	
	if EyeTrace.Entity:IsDoor() then
		if self.Owner:CanManipulateDoor( EyeTrace.Entity ) then return end

		self:EmitSound( self.BatterSound )

		self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
		self.Weapon:SetNextSecondaryFire( CurTime() + 3 )
	elseif EyeTrace.Entity:IsVehicle() and EyeTrace.Entity.Owner and EyeTrace.Entity:GetClass() == "prop_vehicle_jeep" then
		if self.Owner:CanManipulateDoor( EyeTrace.Entity ) then return end
		if IsValid( EyeTrace.Entity:GetDriver() ) then return end

		EyeTrace.Entity:EmitSound( self.BatterSound )
		--surface.PlaySound(self.BatterSoundFX)

		self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
		self.Weapon:SetNextSecondaryFire( CurTime() + 3 )
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end