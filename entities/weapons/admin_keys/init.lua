--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

SWEP.LockSound = "doors/door_latch1.wav"
SWEP.UnlockSound = "doors/door_latch3.wav"

function SWEP:PrimaryAttack()
	local EyeTrace = self.Owner:GetEyeTrace()

	if not EyeTrace.Entity or not IsValid( EyeTrace.Entity ) or not ( EyeTrace.Entity:IsDoor() or EyeTrace.Entity:IsVehicle() ) then return false end

	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

	if Distance > 75 and not EyeTrace.Entity:IsDoor() then return false end
	if Distance > 100 and not EyeTrace.Entity:IsVehicle() then return false end

	self.Weapon:SetNextPrimaryFire( CurTime() +  1 )

	EyeTrace.Entity:Fire( "lock", "", 0 )
	self.Owner:EmitSound( self.LockSound )
end

function SWEP:SecondaryAttack()
	local EyeTrace = self.Owner:GetEyeTrace()

	if not EyeTrace.Entity or not IsValid( EyeTrace.Entity ) or not ( EyeTrace.Entity:IsDoor() or EyeTrace.Entity:IsVehicle() ) then return false end

	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

	if Distance > 75 and not EyeTrace.Entity:IsDoor() then return false end
	if Distance > 100 and not EyeTrace.Entity:IsVehicle() then return false end

	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )

	EyeTrace.Entity:Fire( "unlock", "", 0 )
	self.Owner:EmitSound( self.UnlockSound )
end
