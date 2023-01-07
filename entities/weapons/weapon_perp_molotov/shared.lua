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
	SWEP.PrintName 			= "Molotov Cocktail"
	SWEP.Author 			= "G-Force"
	SWEP.Instructions 		= "Left Click: Throw"

	SWEP.Slot 				= 2
	SWEP.SlotPos 			= 1
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
end

SWEP.ViewModelFOV 			= 62
SWEP.ViewModelFlip 			= false

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ViewModel 				= Model( "models/weapons/v_molotov.mdl" )
SWEP.WorldModel 			= Model( "models/weapons/w_beerbot.mdl" )

function SWEP:Initialize()
	self:SetWeaponHoldType( "melee" )
end

function SWEP:CanPrimaryAttack() return true end

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound( "npc/vort/claw_swing" .. math.random( 1, 2 ) .. ".wav" )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	
	if SERVER then
		local trd	= {}
		trd.start 	= self.Owner:EyePos()
		trd.endpos 	= trd.start + self.Owner:GetAimVector()
		trd.filter 	= self.Owner
			
		local tr = util.TraceLine( trd )

		local Molotov = ents.Create( "ent_molotov" )
			Molotov:SetPos( tr.HitPos )
			Molotov:Spawn()
			Molotov.Owner = self.Owner
			Molotov:GetPhysicsObject():ApplyForceCenter( self.Owner:GetAimVector() * 1500 )

		Log( Format( "%s(%s) threw a molotov at %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:GetZoneName() ), Color( 255, 0, 0 ) )

		local Log = Format( "%s(%s)<%s> threw a molotov at %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:SteamID(), self.Owner:GetZoneName() )
		GAMEMODE:Log( "mollies", Log )
		
		self.Owner:RemoveEquipped( EQUIP_SIDE )
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end