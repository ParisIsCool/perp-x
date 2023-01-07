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
	SWEP.PrintName = "Fists"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "aSocket"
SWEP.Instructions = "Left Click: Punch, Right Click: Knock"

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

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = Model( "models/perp2/v_fists5.mdl" )
SWEP.WorldModel = Model( "models/perp2/w_fists.mdl" )
if CLIENT then SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/myicon/fists" ) end

function SWEP:Initialize()
	self:SetWeaponHoldType( "fist" )
end

function SWEP:CanPrimaryAttack() return true end

function SWEP:DrawWorldModel( flags )
	--self:DrawModel()
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
end

function SWEP:Holster()
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	return true
end

function SWEP:PrimaryAttack()
	self.ShowLeft = CurTime() + 5
	self.ActuallyHidden = false
	self.Hidden = false
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Weapon:EmitSound( "npc/vort/claw_swing" .. math.random( 1, 2 ) .. ".wav" )
	self.Owner:SetAnimation( ACT_HL2MP_GESTURE_RANGE_ATTACK )
		
	self.Weapon:SetNextPrimaryFire( CurTime() + .5 )

	local EyeTrace = self.Owner:GetEyeTrace()
	
	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
	if Distance > 75 then return false end
	
	if EyeTrace.MatType == MAT_GLASS then
		return self.Weapon:EmitSound( "physics/glass/glass_cup_break" .. math.random( 1, 2 ) .. ".wav" )
	end
	
	if EyeTrace.HitWorld then
		return self.Weapon:EmitSound( "physics/flesh/flesh_impact_hard" .. math.random( 1, 5 ) .. ".wav" )
	end
	
	if not IsValid( EyeTrace.Entity ) or not EyeTrace.HitNonWorld then return false; end
	
	if EyeTrace.MatType == MAT_FLESH then
		self.Weapon:EmitSound( "physics/flesh/flesh_impact_bullet" .. math.random( 1, 5 ) .. ".wav" )
		
		local OurEffect = EffectData()
		OurEffect:SetOrigin( EyeTrace.HitPos )
		util.Effect( "BloodImpact", OurEffect )
		
		if SERVER and (EyeTrace.Entity:IsPlayer() or EyeTrace.Entity:IsNextBot()) then
			EyeTrace.Entity:TakeDamage( GAMEMODE.FistDamage, self.Owner, self.Weapon )
			self.Owner:GiveExperience( SKILL_UNARMED_COMBAT, 2, true )
		end
		
		return false
	else
		self.Weapon:EmitSound( "physics/flesh/flesh_impact_bullet" .. math.random( 1, 5 ) .. ".wav" )
	end
end

function SWEP:SecondaryAttack()
	self.ShowLeft = CurTime() + 5
	self.ActuallyHidden = false
	self.Hidden = false
	local EyeTrace = self.Owner:GetEyeTrace()

	if not IsValid( EyeTrace.Entity ) or not EyeTrace.Entity:IsDoor() then return false end
	
	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
	
	if Distance > 75 then return false end
	
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Weapon:EmitSound( "physics/plastic/plastic_box_impact_hard" .. tostring( math.random( 1, 4 ) ) .. ".wav", 100, 100 )
	--self.Owner:RestartGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST )
	
	self.Weapon:SetNextSecondaryFire( CurTime() + .25 )
end

function SWEP:SetWeaponHoldType()
	self.ActivityTranslate = {}
	
	self.ActivityTranslate[ ACT_HL2MP_IDLE ]					= ACT_HL2MP_IDLE_FIST
	self.ActivityTranslate[ ACT_HL2MP_WALK ]					= ACT_HL2MP_IDLE_FIST + 1
	self.ActivityTranslate[ ACT_HL2MP_RUN ]						= ACT_HL2MP_IDLE_FIST + 2
	self.ActivityTranslate[ ACT_HL2MP_IDLE_CROUCH ]				= ACT_HL2MP_IDLE_FIST + 3
	self.ActivityTranslate[ ACT_HL2MP_WALK_CROUCH ]				= ACT_HL2MP_IDLE_FIST + 4
	self.ActivityTranslate[ ACT_HL2MP_GESTURE_RANGE_ATTACK ]	= ACT_HL2MP_IDLE_FIST + 5
	self.ActivityTranslate[ ACT_HL2MP_GESTURE_RELOAD ]			= ACT_HL2MP_IDLE_FIST + 6
	self.ActivityTranslate[ ACT_HL2MP_JUMP ]					= ACT_HL2MP_IDLE_FIST + 7
	self.ActivityTranslate[ ACT_RANGE_ATTACK1 ]					= ACT_HL2MP_IDLE_FIST + 8
end

function SWEP:Think()
	--[[local inrange = self.Owner:GetPos():DistToSqr(self.Owner:GetEyeTrace().HitPos) < (200^2)
	if not self.Hidden and not inrange then
		// hide it
		if (self.ShowLeft or 0) > CurTime() then return end
		self.Hidden = true
		timer.Create("ChangeHiddenFist",0.45,1,function()
			self.ActuallyHidden = true
		end)
		self.Weapon:SendWeaponAnim( ACT_VM_RELEASE )
	elseif self.Hidden and inrange then
		//show it
		self.Hidden = false
		self.ActuallyHidden = false
		timer.Destroy("ChangeHiddenFist")
		self.Weapon:SendWeaponAnim( ACT_VM_PICKUP )
		self.ShowLeft = CurTime() + 5
	end]]
end
if CLIENT then
	--[[hook.Add("PreDrawViewModel","FistHideAway", function(ent, ply, wep)
		if ent:GetModel() == "models/perp2/v_fists5.mdl" then
			return wep.ActuallyHidden
		end
	end)]]
end

-- AddCSLuaFile()

-- SWEP.PrintName = "#GMOD_Fists"
-- SWEP.Author = "Kilburn, robotboy655, MaxOfS2D & Tenrys"
-- SWEP.Purpose = "Well we sure as hell didn't use guns! We would just wrestle Hunters to the ground with our bare hands! I used to kill ten, twenty a day, just using my fists."

-- SWEP.Slot = 1
-- SWEP.SlotPos = 1

-- SWEP.Spawnable = true

-- SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
-- SWEP.WorldModel = ""
-- SWEP.ViewModelFOV = 54
-- SWEP.UseHands = true

-- SWEP.Primary.ClipSize = -1
-- SWEP.Primary.DefaultClip = -1
-- SWEP.Primary.Automatic = true
-- SWEP.Primary.Ammo = "none"

-- SWEP.Secondary.ClipSize = -1
-- SWEP.Secondary.DefaultClip = -1
-- SWEP.Secondary.Automatic = true
-- SWEP.Secondary.Ammo = "none"

-- SWEP.DrawAmmo = false

-- SWEP.HitDistance = 48

-- local SwingSound = Sound( "WeaponFrag.Throw" )
-- local HitSound = Sound( "Flesh.ImpactHard" )

-- function SWEP:Initialize()

-- 	self:SetHoldType( "none" )

-- end

-- function SWEP:SetupDataTables()

-- 	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
-- 	self:NetworkVar( "Float", 1, "NextIdle" )
-- 	self:NetworkVar( "Int", 2, "Combo" )

-- end

-- function SWEP:UpdateNextIdle()

-- 	local vm = self.Owner:GetViewModel()
-- 	self:SetNextIdle( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )

-- end

-- function SWEP:PrimaryAttack( right )

-- 	self.Owner:SetAnimation( PLAYER_ATTACK1 )

-- 	local anim = "fists_left"
-- 	if ( right ) then anim = "fists_right" end
-- 	if ( self:GetCombo() >= 2 ) then
-- 		anim = "fists_uppercut"
-- 	end

-- 	local vm = self.Owner:GetViewModel()
-- 	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

-- 	self:EmitSound( SwingSound )

-- 	self:UpdateNextIdle()
-- 	self:SetNextMeleeAttack( CurTime() + 0.2 )

-- 	self:SetNextPrimaryFire( CurTime() + 0.9 )
-- 	self:SetNextSecondaryFire( CurTime() + 0.9 )

-- end

-- function SWEP:SecondaryAttack()

-- 	self:PrimaryAttack( true )

-- end

-- local phys_pushscale = GetConVar( "phys_pushscale" )

-- function SWEP:DealDamage()

-- 	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())

-- 	self.Owner:LagCompensation( true )

-- 	local tr = util.TraceLine( {
-- 		start = self.Owner:GetShootPos(),
-- 		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
-- 		filter = self.Owner,
-- 		mask = MASK_SHOT_HULL
-- 	} )

-- 	if ( !IsValid( tr.Entity ) ) then
-- 		tr = util.TraceHull( {
-- 			start = self.Owner:GetShootPos(),
-- 			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
-- 			filter = self.Owner,
-- 			mins = Vector( -10, -10, -8 ),
-- 			maxs = Vector( 10, 10, 8 ),
-- 			mask = MASK_SHOT_HULL
-- 		} )
-- 	end

-- 	-- We need the second part for single player because SWEP:Think is ran shared in SP
-- 	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
-- 		self:EmitSound( HitSound )
-- 	end

-- 	local hit = false
-- 	local scale = phys_pushscale:GetFloat()

-- 	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
-- 		local dmginfo = DamageInfo()

-- 		local attacker = self.Owner
-- 		if ( !IsValid( attacker ) ) then attacker = self end
-- 		dmginfo:SetAttacker( attacker )

-- 		dmginfo:SetInflictor( self )
-- 		dmginfo:SetDamage( math.random( 8, 12 ) )

-- 		if ( anim == "fists_left" ) then
-- 			dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 * scale + self.Owner:GetForward() * 9998 * scale ) -- Yes we need those specific numbers
-- 		elseif ( anim == "fists_right" ) then
-- 			dmginfo:SetDamageForce( self.Owner:GetRight() * -4912 * scale + self.Owner:GetForward() * 9989 * scale )
-- 		elseif ( anim == "fists_uppercut" ) then
-- 			dmginfo:SetDamageForce( self.Owner:GetUp() * 5158 * scale + self.Owner:GetForward() * 10012 * scale )
-- 			dmginfo:SetDamage( math.random( 12, 24 ) )
-- 		end

-- 		SuppressHostEvents( NULL ) -- Let the breakable gibs spawn in multiplayer on client
-- 		tr.Entity:TakeDamageInfo( dmginfo )
-- 		SuppressHostEvents( self.Owner )

-- 		hit = true

-- 	end

-- 	if ( IsValid( tr.Entity ) ) then
-- 		local phys = tr.Entity:GetPhysicsObject()
-- 		if ( IsValid( phys ) ) then
-- 			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos )
-- 		end
-- 	end

-- 	if ( SERVER ) then
-- 		if ( hit && anim != "fists_uppercut" ) then
-- 			self:SetCombo( self:GetCombo() + 1 )
-- 		else
-- 			self:SetCombo( 0 )
-- 		end
-- 	end

-- 	self.Owner:LagCompensation( false )

-- end

-- function SWEP:OnDrop()

-- 	self:Remove() -- You can't drop fists

-- end

-- function SWEP:Deploy()

-- 	local speed = GetConVarNumber( "sv_defaultdeployspeed" )

-- 	local vm = self.Owner:GetViewModel()
-- 	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
-- 	vm:SetPlaybackRate( speed )

-- 	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() / speed )
-- 	self:SetNextSecondaryFire( CurTime() + vm:SequenceDuration() / speed )
-- 	self:UpdateNextIdle()

-- 	if ( SERVER ) then
-- 		self:SetCombo( 0 )
-- 	end

-- 	return true

-- end

-- function SWEP:Holster()

-- 	self:SetNextMeleeAttack( 0 )

-- 	return true

-- end

-- function SWEP:Think()

-- 	local vm = self.Owner:GetViewModel()
-- 	local curtime = CurTime()
-- 	local idletime = self:GetNextIdle()

-- 	if ( idletime > 0 && CurTime() > idletime ) then

-- 		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )

-- 		self:UpdateNextIdle()

-- 	end

-- 	local meleetime = self:GetNextMeleeAttack()

-- 	if ( meleetime > 0 && CurTime() > meleetime ) then

-- 		self:DealDamage()

-- 		self:SetNextMeleeAttack( 0 )

-- 	end

-- 	if ( SERVER && CurTime() > self:GetNextPrimaryFire() + 0.1 ) then

-- 		self:SetCombo( 0 )

-- 	end

-- end
