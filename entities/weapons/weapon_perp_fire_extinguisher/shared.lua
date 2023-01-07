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
	SWEP.PrintName 			= "Fire Extinguisher"
	SWEP.Author 			= "Huntskikbut"
	SWEP.Instructions 		= "Left Click: Extinguish Fires"

	SWEP.Slot 				= 2
	SWEP.SlotPos 			= 1
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
end

SWEP.ViewModelFOV 			= 62
SWEP.ViewModelFlip 			= false

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= 0
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ViewModel 				= Model( "models/weapons/v_fire_extinguisher.mdl" )
SWEP.WorldModel 			= Model( "models/perp2/w_fists.mdl" )
if CLIENT then SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/myicon/fire" ) end

SWEP.ShootSound 			= Sound("ambient/wind/wind_hit2.wav")

function SWEP:Initialize()
	self:SetWeaponHoldType( "normal" )
end

function SWEP:CanPrimaryAttack() return end

function SWEP:PrimaryAttack()	
	if self.LastNoise == nil then self.LastNoise = true end

	if self.LastNoise then
		self.Weapon:EmitSound( self.ShootSound )
		self.LastNoise = false
	else
		self.LastNoise = true
	end
	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Weapon:SetNextPrimaryFire( CurTime() + .1 )
	
	if CLIENT then		
		local ED = EffectData()
			ED:SetEntity( self.Owner )
		util.Effect( "fire_extinguish", ED)
	end
	
	if SERVER then
		local Trace2 = {}
		Trace2.start = self.Owner:GetShootPos()
		Trace2.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 150
		Trace2.filter = self.Owner

		local Trace = util.TraceLine( Trace2 )
				
		local CloseEnts = ents.FindInSphere( Trace.HitPos, 50 )
		
		for _, v in pairs( CloseEnts ) do
			if v:GetClass() == "ent_fire" then
				v:HitByExtinguisher( self.Owner )
			end
			
			if v:IsOnFire() then v:Extinguish() end
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end