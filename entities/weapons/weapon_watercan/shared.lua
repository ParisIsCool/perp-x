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
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Watering Can"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Paris"
SWEP.Instructions = "Click: Water"

SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = Model(  "models/perp2/v_fists.mdl" )
SWEP.WorldModel	= Model(  "models/perp2/w_fists.mdl" )


function SWEP:Initialize() self:SetWeaponHoldType("normal") end

function SWEP:CanPrimaryAttack ( )
	return (self:GetNextPrimaryFire() <= CurTime()) 
end

SWEP.CanSecondaryAttack = SWEP.CanPrimaryFire

game.AddParticles( "particles/WATER_LEAKS.pcf" )
PrecacheParticleSystem( "WaterLeak_Pipe_1_SmallDrops" )

function SWEP:PrimaryAttack() 
    if ( CLIENT ) then
        local id = math.random(1, 100)
        local p = self:CreateParticleEffect( "WaterLeak_Pipe_1_SmallDrops",id)
        --p:SetControlPoint( id, self.Owner:GetPos() + Vector(0,0,50) )
        p:SetControlPointOrientation( id, self.Owner:GetForward(), self.Owner:GetRight(), self.Owner:GetUp() )
        p:SetIsViewModelEffect( true )
        --self.Owner:GetPos() + (self.Owner:GetForward()*50) + Vector(0,0,100), Angle( 0, 0, 0 )
        p:StartEmission()
        timer.Simple(0.5, function() p:StopEmission() end)
    end
    self:SetNextPrimaryFire(CurTime()+0.05)
end


SWEP.SecondaryAttack = SWEP.PrimaryAttack

function SWEP:Think ( )

end

function SWEP:Holster ( )
    return true
end

function SWEP:Reload ( ) end
