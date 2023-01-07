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
	SWEP.PrintName = "Keys"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "aSocket"
SWEP.Instructions = "Left Click: Lock Door, Right Click: Unlock Door"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.LockSound = Sound( "doors/door_latch1.wav" )
SWEP.UnlockSound = Sound( "doors/door_latch3.wav" )

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.UseHands = true

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = Model( "models/craphead_scripts/adv_keys/weapons/c_key.mdl" )
SWEP.WorldModel = Model( "models/craphead_scripts/adv_keys/weapons/w_key.mdl" )
if CLIENT then SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/myicon/keys" ) end

function SWEP:Initialize()
	self:SetHoldType( "slam" )
end

function SWEP:Deploy()
    self:SetHoldType( "slam" )
	self:SendWeaponAnim( ACT_VM_DRAW )
	--self.Owner:ConCommand( "play craphead_scripts/adv_keys/pull_out.mp3" )
	-- 76561198120410391
end

function SWEP:CanPrimaryAttack() return true end

local function FlashHeadlights( ent )
	if not IsValid( ent ) then return end
	if not ent:IsVehicle() then return end

	if not VCMod1 then return end

	ent:VC_SetHighBeams(true)
	ent:VC_SetRunningLights(true)
	ent:VC_SetFogLights(true)
	timer.Simple( .2, function() ent:VC_SetHighBeams(true) end )
	timer.Simple( .2, function() 	ent:VC_SetRunningLights(true) end )
	timer.Simple( .2, function() 	ent:VC_SetFogLights(true) end )
	timer.Simple( .5, function() ent:VC_SetHighBeams(false) end )
	timer.Simple( .5, function() ent:VC_SetRunningLights(true) end )
	timer.Simple( .5, function() ent:VC_SetFogLights(true) end )
	timer.Simple( 2, function() ent:VC_SetHighBeams(true); ent:VC_SetHighBeams(false); end )
	timer.Simple( 2, function() ent:VC_SetRunningLights(true); ent:VC_SetRunningLights(false); end )
	timer.Simple( 2, function() ent:VC_SetFogLights(true); ent:VC_SetFogLights(false); end )

end

local function FlashHeadlightsUnlock( ent )
	if not IsValid( ent ) then return end
	if not ent:IsVehicle() then return end

	ent:VC_SetHighBeams(true)
	ent:VC_SetRunningLights(true)
	ent:VC_SetFogLights(true)
	timer.Simple( .2, function() ent:VC_SetHighBeams(true) end )
	timer.Simple( .2, function() 	ent:VC_SetRunningLights(true) end )
	timer.Simple( .2, function() 	ent:VC_SetFogLights(true) end )
	timer.Simple( .5, function() ent:VC_SetHighBeams(false) end )
	timer.Simple( .5, function() ent:VC_SetRunningLights(true) end )
	timer.Simple( .5, function() ent:VC_SetFogLights(true) end )
	timer.Simple( 2, function() ent:VC_SetHighBeams(true); ent:VC_SetHighBeams(false); end )
	timer.Simple( 2, function() ent:VC_SetRunningLights(true); ent:VC_SetRunningLights(false); end )
	timer.Simple( 2, function() ent:VC_SetFogLights(true); ent:VC_SetFogLights(false); end )
end

local function ELSToggle( ent )
	if not IsValid( ent ) then return end
	if not ent:IsVehicle() then return end

		if IsValid(ent) then
			ent:VC_SetRunningLights(true)
			print("Turning vehicles running lights on.")
		else
				print("Invalid entity.")
		end

end

function SWEP:Reload()
	if CLIENT then return false; end

	local EyeTrace = self.Owner:GetEyeTrace()
	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

	if self.Owner:IsVIP() then
		if IsValid( EyeTrace.Entity ) and not EyeTrace.Entity:IsVehicle() and Distance < 100 then
			local ent = EyeTrace.Entity
			if self.Owner:CanManipulateDoor( ent ) then
		--		ent:Fire( "lock", "", 0 )
				--self.Owner:EmitSound( "perp2.5/car_horn_dixie.mp3" )
				self.Weapon:SetNextPrimaryFire( CurTime() + 1 )

				return true
			end
		else
			local closest = nil
			local dist = 500
			for k,v in pairs( ents.FindByClass( "prop_vehicle_jeep" ) ) do
				local bufdist = v:GetPos():Distance( self.Owner:GetPos() )
				if bufdist < dist and self.Owner:CanManipulateDoor( v ) then
					dist = bufdist
					closest = v
				end
			end
			if IsValid( closest ) then
		--		if closest:GetSaveTable().VehicleLocked then return self.Owner:Notify( "The car is already locked!" ) end

				if IsValid( closest:GetDriver() ) then return end
			--	closest:Fire( "lock", "", 0 )
			--	closest:EmitSound( "perp2.5/car_horn_dixie.mp3" )
			--[[if self.Owner:IsAdmin() then
				closest:EmitSound( "perp2.5/car_horn_dixie.mp3" )
			end]]

				if closest.Owner == self.Owner then
				--	self.Owner:Notify( "You locked your vehicle." )
				else
			--		self.Owner:Notify( "You locked " .. closest.Owner:GetRPName() .. "'s vehicle." )
				end

				ELSToggle( closest )

				self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
			end
		end
	else
	
	
		self.Owner:Notify( "Dixie horns are for VIP only!" )
		
		--[[
		if not IsValid( EyeTrace.Entity ) then return false end

		local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

		if Distance > 75 and EyeTrace.Entity:IsDoor() then return false end
		if Distance > 100 and EyeTrace.Entity:IsVehicle() then return false end

		if EyeTrace.Entity:IsPlayer() then return end

		self.Weapon:SetNextPrimaryFire( CurTime() + 1 )

		if not self.Owner:CanManipulateDoor( EyeTrace.Entity ) then return false end

		--EyeTrace.Entity:Fire( "lock", "", 0 )
	--	EyeTrace.Entity:Fire( "close", "", 0 )
		self.Owner:EmitSound( "perp2.5/car_horn_dixie.mp3" )
		]]
	end
end



function SWEP:PrimaryAttack()
	if CLIENT then return false; end

	local EyeTrace = self.Owner:GetEyeTrace()
	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

	if self.Owner:IsVIP() then
		if IsValid( EyeTrace.Entity ) and not EyeTrace.Entity:IsVehicle() and Distance < 100 then
			local ent = EyeTrace.Entity
			if self.Owner:CanManipulateDoor( ent ) then
				ent:Fire( "lock", "", 0 )
				self.Owner:EmitSound( self.LockSound )
				self.Weapon:SetNextPrimaryFire( CurTime() + 1 )

				return true
			end
		else
			local closest = nil
			local dist = 500
			for k,v in pairs( ents.FindByClass( "prop_vehicle_jeep" ) ) do
				local bufdist = v:GetPos():Distance( self.Owner:GetPos() )
				if bufdist < dist and self.Owner:CanManipulateDoor( v ) then
					dist = bufdist
					closest = v
				end
			end
			if IsValid( closest ) then
				if closest:GetSaveTable().VehicleLocked then return self.Owner:Notify( "The car is already locked!" ) end

				if IsValid( closest:GetDriver() ) then return end
				closest:Fire( "lock", "", 0 )
				closest:EmitSound( "perp2.5/car_alarm_chirp2.wav" )
				closest:EmitSound( "perp2.5/car_alarm_chirp2.wav" )

				if closest.Owner == self.Owner then
					self.Owner:Notify( "You locked your vehicle." )
				else
					self.Owner:Notify( "You locked " .. closest.Owner:GetRPName() .. "'s vehicle." )
				end

				FlashHeadlights( closest )

				self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
			end
		end
	else
		if not IsValid( EyeTrace.Entity ) then return false end

		local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

		if Distance > 75 and EyeTrace.Entity:IsDoor() then return false end
		if Distance > 100 and EyeTrace.Entity:IsVehicle() then return false end

		if EyeTrace.Entity:IsPlayer() then return end

		self.Weapon:SetNextPrimaryFire( CurTime() + 1 )

		if not self.Owner:CanManipulateDoor( EyeTrace.Entity ) then return false end

		EyeTrace.Entity:Fire( "lock", "", 0 )
		EyeTrace.Entity:Fire( "close", "", 0 )
		self.Owner:EmitSound( self.LockSound )
	end
end

function SWEP:SecondaryAttack()
	if CLIENT then return false; end

	local EyeTrace = self.Owner:GetEyeTrace()
	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

	if self.Owner:IsVIP() then
		if IsValid( EyeTrace.Entity ) and not EyeTrace.Entity:IsVehicle() and Distance < 100 then
			local ent = EyeTrace.Entity
			if self.Owner:CanManipulateDoor( ent ) then
				ent:Fire( "unlock", "", 0 )
				self.Owner:EmitSound( self.UnlockSound )
				self.Weapon:SetNextSecondaryFire( CurTime() + 1 )

				return true
			end
		else
			local closest = nil
			local dist = 500
			for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
				local bufdist = v:GetPos():Distance(self.Owner:GetPos())
				if bufdist < dist and self.Owner:CanManipulateDoor(v) then
					dist = bufdist
					closest = v
				end
			end
			if IsValid( closest ) then
				if not closest:GetSaveTable().VehicleLocked then return self.Owner:Notify( "The car is already unlocked!" ) end
				closest:Fire("unlock", "", 0)
				closest:EmitSound("perp2.5/car_alarm_chirp2.wav")
				closest:EmitSound("perp2.5/car_alarm_chirp2.wav")

				if closest.Owner == self.Owner then
					self.Owner:Notify( "You unlocked your vehicle." )
				else
					self.Owner:Notify( "You unlocked " .. closest.Owner:GetRPName() .. "'s vehicle." )
				end

				FlashHeadlightsUnlock( closest )

				self.Weapon:SetNextSecondaryFire( CurTime() + 1 )
			end
		end
	else
		if not IsValid( EyeTrace.Entity ) then return false end

		local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )

		if Distance > 75 and EyeTrace.Entity:IsDoor() then return false end
		if Distance > 100 and EyeTrace.Entity:IsVehicle() then return false end

		if EyeTrace.Entity:IsPlayer() then return end

		self.Weapon:SetNextSecondaryFire( CurTime() + 1 )

		if not self.Owner:CanManipulateDoor( EyeTrace.Entity ) then return false end

		EyeTrace.Entity:Fire( "unlock", "", 0 )
		EyeTrace.Entity:Fire( "open", "", 0 )
		self.Owner:EmitSound( self.UnlockSound )
	end
end
