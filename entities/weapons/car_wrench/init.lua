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

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound( "npc/vort/claw_swing" .. math.random( 1, 2 ) .. ".wav" )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )
	
	local EyeTrace = self.Owner:GetEyeTrace()
	
	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
	if Distance > 75 then return false end
	
	if IsValid( EyeTrace.Entity ) and EyeTrace.Entity:IsVehicle() and EyeTrace.Entity.CarDamage then

		if EyeTrace.Entity.CarDamage > 49 and EyeTrace.Entity.Disabled then
			EyeTrace.Entity:EnableVehicle()
		else
		
			EyeTrace.Entity.CarDamage = math.Clamp( EyeTrace.Entity.CarDamage + 5, 0, 54 )
			EyeTrace.Entity:FixTires()
			
			for i= 0, 1.3, 0.3 do
				timer.Simple( i, function()
					if IsValid( EyeTrace.Entity ) then
						local num = ( math.random( 1, 2 ) == 1 and math.random( 1, 3 ) ) or math.random( 5, 8 )
						EyeTrace.Entity:EmitSound( "npc/dog/dog_servo" .. num .. ".wav" )
					end
				end )
			end
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end