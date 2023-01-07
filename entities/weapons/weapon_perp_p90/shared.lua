-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("cl_init.lua")
	SWEP.BackHolster = true
end

if (CLIENT) then
	SWEP.PrintName 			= "FN P90"
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot 				= 2
	SWEP.SlotPos 			= 1
	SWEP.IconLetter 		= "m"
	SWEP.ViewModelFlip		= false		-- Should we flip the sweps?
	SWEP.ViewModelFOV		= 60
end

SWEP.Base 					= "weapon_perp_base"

SWEP.HoldType				= "ar2"
SWEP.HoldTypeNorm			= "passive"
SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= true
	
SWEP.ViewModel 				= "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel 			= "models/weapons/w_smg_p90.mdl"
	
SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.UseHands = true
SWEP.AnimPrefix	 			= "rpg"

SWEP.Primary.Sound 			= Sound("Weapon_P90.Single")
SWEP.Primary.Recoil 		= 0.4
SWEP.Primary.Damage 		= 15
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.013
SWEP.Primary.ClipSize 		= 50
SWEP.Primary.Delay 			= 0.066
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "pistol"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.IronSightsPos 			= Vector( -5.72, -9.921, 2.16 )
SWEP.IronSightsAng 			= Vector( 0, 0, 0 )
SWEP.NormalPos 				= Vector( 0, 0, 3.5 )
SWEP.NormalAng 				= Vector(  -20, 0, 0 )

SWEP.MaxPenetration			= PENETRATION_PISTOL

SWEP.GrantExperience_Skill	= SKILL_SMG_MARK
SWEP.GrantExperience_Exp	= 20

SWEP.data 				= {}
SWEP.mode 				= "auto"

SWEP.data.semi 			= {}

SWEP.data.auto 			= {}

SWEP.IronSightZoom			= 1.3 -- How much the player's FOV should zoom in ironsight mode. 
SWEP.UseScope				= true -- Use a scope instead of iron sights.
SWEP.ScopeScale 				= 0.4 -- The scale of the scope's reticle in relation to the player's screen size.
SWEP.ScopeZooms				= {2} -- The possible magnification levels of the weapon's scope.   If the scope is already activated, secondary fire will cycle through each zoom level in the table.
SWEP.DrawParabolicSights		= false -- Set to true to draw a cool parabolic sight (helps with aiming over long distances)

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() or self.Owner:WaterLevel() > 2 then return end
	if not self:GetIronsights() then return end
	-- If your gun have a problem or if you are under water, you'll not be able to fire

	self.Reloadaftershoot = CurTime() + self.Primary.Delay
	-- Set the reload after shoot to be not able to reload when firering

	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	-- Set next secondary fire after your fire delay

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	-- Set next primary fire after your fire delay

	-- Remove the Scope View
	//self:SetIronsights(false, self.Owner)

	-- Play shoot sound
	self.Weapon:EmitSound(self.Primary.Sound)

	self:RecoilPower()

	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo(1)

	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
	end
end

/*---------------------------------------------------------
	ResetVars
---------------------------------------------------------*/
function SWEP:ResetVars()

	self.NextSecondaryAttack = 0
	
	self.bLastIron = false
	self.Weapon:SetNetworkedBool("Ironsights", false)
	
	if self.UseScope then
		self.CurScopeZoom = 1
		self.fLastScopeZoom = 1
		self.bLastScope = false
		self.Weapon:SetNetworkedBool("Scope", false)
		self.Weapon:SetNetworkedBool("ScopeZoom", self.ScopeZooms[1])
	end
	
	if self.Owner then
		self.OwnerIsNPC = self.Owner:IsNPC() -- This ought to be better than getting it every time we fire
	end
	
end

-- We need to call ResetVars() on these functions so we don't whip out a weapon with scope mode or insane recoil right of the bat or whatnot
function SWEP:Holster(wep) 		self:ResetVars() return true end
function SWEP:Equip(NewOwner) 	self:ResetVars() return true end
function SWEP:OnRemove() 		self:ResetVars() return true end
function SWEP:OnDrop() 			self:ResetVars() return true end
function SWEP:OwnerChanged() 	self:ResetVars() return true end
function SWEP:OnRestore() 		self:ResetVars() return true end

/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
local sndZoomIn = Sound("Weapon_AR2.Special1")
local sndZoomOut = Sound("Weapon_AR2.Special2")
local sndCycleZoom = Sound("Default.Zoom")

function SWEP:Initialize()
	if SERVER then
		timer.Simple( 0, function() if IsValid( self ) then self:Holster() end end )
	end
	
	self:SetWeaponHoldType( self.HoldTypeNorm )
	
	self:SetIronsights( false )
	self.bulletNumber = 0

	if CLIENT then
	
		-- We need to get these so we can scale everything to the player's current resolution.
		local iScreenWidth = surface.ScreenWidth()
		local iScreenHeight = surface.ScreenHeight()
		
		-- The following code is only slightly riped off from Night Eagle
		-- These tables are used to draw things like scopes and crosshairs to the HUD.
		self.ScopeTable = {}
		self.ScopeTable.l = iScreenHeight*self.ScopeScale
		self.ScopeTable.x1 = 0.5*(iScreenWidth + self.ScopeTable.l)
		self.ScopeTable.y1 = 0.5*(iScreenHeight - self.ScopeTable.l)
		self.ScopeTable.x2 = self.ScopeTable.x1
		self.ScopeTable.y2 = 0.5*(iScreenHeight + self.ScopeTable.l)
		self.ScopeTable.x3 = 0.5*(iScreenWidth - self.ScopeTable.l)
		self.ScopeTable.y3 = self.ScopeTable.y2
		self.ScopeTable.x4 = self.ScopeTable.x3
		self.ScopeTable.y4 = self.ScopeTable.y1
				
		self.ParaScopeTable = {}
		self.ParaScopeTable.x = 0.5*iScreenWidth - self.ScopeTable.l
		self.ParaScopeTable.y = 0.5*iScreenHeight - self.ScopeTable.l
		self.ParaScopeTable.w = 2*self.ScopeTable.l
		self.ParaScopeTable.h = 2*self.ScopeTable.l
		
		self.ScopeTable.l = (iScreenHeight + 1)*self.ScopeScale -- I don't know why this works, but it does.

		self.QuadTable = {}
		self.QuadTable.x1 = 0
		self.QuadTable.y1 = 0
		self.QuadTable.w1 = iScreenWidth
		self.QuadTable.h1 = 0.5*iScreenHeight - self.ScopeTable.l
		self.QuadTable.x2 = 0
		self.QuadTable.y2 = 0.5*iScreenHeight + self.ScopeTable.l
		self.QuadTable.w2 = self.QuadTable.w1
		self.QuadTable.h2 = self.QuadTable.h1
		self.QuadTable.x3 = 0
		self.QuadTable.y3 = 0
		self.QuadTable.w3 = 0.5*iScreenWidth - self.ScopeTable.l
		self.QuadTable.h3 = iScreenHeight
		self.QuadTable.x4 = 0.5*iScreenWidth + self.ScopeTable.l
		self.QuadTable.y4 = 0
		self.QuadTable.w4 = self.QuadTable.w3
		self.QuadTable.h4 = self.QuadTable.h3

		self.LensTable = {}
		self.LensTable.x = self.QuadTable.w3
		self.LensTable.y = self.QuadTable.h1
		self.LensTable.w = 2*self.ScopeTable.l
		self.LensTable.h = 2*self.ScopeTable.l

		self.CrossHairTable = {}
		self.CrossHairTable.x11 = 0
		self.CrossHairTable.y11 = 0.5*iScreenHeight
		self.CrossHairTable.x12 = iScreenWidth
		self.CrossHairTable.y12 = self.CrossHairTable.y11
		self.CrossHairTable.x21 = 0.5*iScreenWidth
		self.CrossHairTable.y21 = 0
		self.CrossHairTable.x22 = 0.5*iScreenWidth
		self.CrossHairTable.y22 = iScreenHeight
		
	end

	self.ScopeZooms 		= self.ScopeZooms or {5}
	if self.UseScope then
		self.CurScopeZoom	= 1 -- Another index, this time for ScopeZooms
	end

	self:ResetVars()
	self.Weapon:SetNetworkedBool("Ironsights", false)
	self.Reloadaftershoot = 0

	//self.data[self.mode].Init(self)
end

SWEP.NextSecondaryAttack = 0
function SWEP:SecondaryAttack()
	if not self.IronSightsPos then return end
	if self.NextSecondaryAttack > CurTime() then return end
	
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	self:SetIronsights( not self.Weapon:GetGNWVar( "Ironsights", false ) )
	
	self.NextSecondaryAttack = CurTime() + 0.3
end

/*---------------------------------------------------------
IronSight
---------------------------------------------------------*/
function SWEP:IronSight()

	if !self.Owner:KeyDown(IN_USE) then
	-- If the key E (Use Key) is not pressed, then

		if self.Owner:KeyPressed(IN_ATTACK2) then
		-- When the right click is pressed, then

			self:SetIronsights(true, self.Owner)

			if CLIENT then return end
 		end
	end

	if !self.Owner:KeyDown(IN_ATTACK2) then
	-- If the right click is released, then

		self:SetIronsights(false, self.Owner)

		if CLIENT then return end
	end
end

/*---------------------------------------------------------
Think
---------------------------------------------------------*/
function SWEP:Think()

	if CLIENT and self.Weapon:GetNetworkedBool("Scope") then
		self.MouseSensitivity = self.Owner:GetFOV() / 60 -- scale sensitivity
	else
		self.MouseSensitivity = 1
	end

	if not CLIENT and self.Weapon:GetNetworkedBool("Scope") and self.Owner:KeyDown(IN_ATTACK2) and (self:GetIronsights() == true) then

		self.Owner:DrawViewModel(false)
	elseif not CLIENT then

		self.Owner:DrawViewModel(true)
	end

	self:IronSight()
end

/*---------------------------------------------------------
Sensibility
---------------------------------------------------------*/
local LastViewAng = false

local function SimilarizeAngles (ang1, ang2) --this function makes angle-play a little easier on the mind, damn the overhead I say

	ang1.y = math.fmod (ang1.y, 360)
	ang2.y = math.fmod (ang2.y, 360)

	if math.abs (ang1.y - ang2.y) > 180 then
		if ang1.y - ang2.y < 0 then
			ang1.y = ang1.y + 360
		else
			ang1.y = ang1.y - 360
		end
	end
end

local function ReduceScopeSensitivity (uCmd)

	if LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() then
		local newAng = uCmd:GetViewAngles()
			if LastViewAng then
				SimilarizeAngles (LastViewAng, newAng)

				local diff = newAng - LastViewAng

				diff = diff * (LocalPlayer():GetActiveWeapon().MouseSensitivity or 1)
				uCmd:SetViewAngles (LastViewAng + diff)
			end
	end
	LastViewAng = uCmd:GetViewAngles()
end
 
hook.Add ("CreateMove", "RSS", ReduceScopeSensitivity)

/*---------------------------------------------------------
Reload
---------------------------------------------------------*/
function SWEP:Reload()

	if ( self.Reloadaftershoot > CurTime() ) then return end 
	-- If you're firering, you can't reload

	self.Weapon:DefaultReload(ACT_VM_RELOAD);

	if ( self.Weapon:Clip1() < self.Primary.ClipSize ) and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then

		self:SetIronsights(false, self.Owner)
		-- Set the ironsight to false

		self:SetScope(false, self.Owner)

		self.MouseSensitivity = 1

		if not CLIENT then
			self.Owner:DrawViewModel(true)
		end
	end

	return true
end

/*---------------------------------------------------------
Deploy
---------------------------------------------------------*/
function SWEP:Deploy()

	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self:SetIronsights(false, self.Owner)
	self.Reloadaftershoot = CurTime() + 1

	return true
end

if SERVER then
	util.AddNetworkString("perp_wep_sethold")
end

net.Receive( "perp_wep_sethold", function()
	local ent = net.ReadEntity()
	local holdType = net.ReadString()
	
	if not ent or not ent:IsValid() or not ent.SetWeaponHoldType then return end
	
	ent:SetWeaponHoldType( holdType )
end )

/*---------------------------------------------------------
SetIronsights
---------------------------------------------------------*/
local IRONSIGHT_TIME = 0.15 -- How long it takes to raise our rifle

function SWEP:SetIronsights(b, player)

if CLIENT then return end

	-- Send the ironsight state to the client, so it can adjust the player's FOV/Viewmodel pos accordingly
	self.Weapon:SetNetworkedBool("Ironsights", b)
	
	if self.UseScope then -- If we have a scope, use that instead of ironsights
		if b then
			--Activate the scope after we raise the rifle
			timer.Simple(IRONSIGHT_TIME, function() if (!self and !IsValid(self)) then return end self:SetScope(true, player) end)
		else
			self:SetScope(false, player)
		end
		

		if b then
			self:SetWeaponHoldType( self.HoldType )
			
			net.Start( "perp_wep_sethold" )
				net.WriteEntity( self )
				net.WriteString( self.HoldType )
			net.Broadcast()
		else
			self:SetWeaponHoldType( self.HoldTypeNorm )
			
			net.Start( "perp_wep_sethold" )
				net.WriteEntity( self )
				net.WriteString( self.HoldTypeNorm )
			net.Broadcast()
		end
	end
end

/*---------------------------------------------------------
SetScope
---------------------------------------------------------*/
function SWEP:SetScope(b, player)

if CLIENT then return end

	local PlaySound = b ~= self.Weapon:GetNetworkedBool("Scope", not b) -- Only play zoom sounds when chaning in/out of scope mode
	self.CurScopeZoom = 1 -- Just in case...
	self.Weapon:SetNetworkedFloat("ScopeZoom", self.ScopeZooms[self.CurScopeZoom])

	if b then 
--		player:DrawViewModel(false)
		if PlaySound then
			self.Weapon:EmitSound(sndZoomIn)
		end
	else
--		player:DrawViewModel(true)
		if PlaySound then
			self.Weapon:EmitSound(sndZoomOut)
		end
	end
	
	-- Send the scope state to the client, so it can adjust the player's fov/HUD accordingly
	self.Weapon:SetNetworkedBool("Scope", b) 
end

/*---------------------------------------------------------
RecoilPower
---------------------------------------------------------*/
function SWEP:RecoilPower()
	if !IsValid(self.Owner) then return end

	if not self.Owner:IsOnGround() then
		if (self:GetIronsights() == true) then
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
			-- Put normal recoil when you're in ironsight mod

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil / 2), math.Rand(-1,1) * (self.Primary.Recoil / 2), 0))
			-- Punch the screen 2x less hard when you're in ironsigh mod
		else
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil * 2.5, self.Primary.NumShots, self.Primary.Cone)
			-- Recoil * 2.5

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil * 2.5), math.Rand(-1,1) * (self.Primary.Recoil * 2.5), 0))
			-- Punch the screen * 2.5
		end

	elseif self.Owner:KeyDown(bit.bor(IN_FORWARD, IN_BACK, IN_MOVELEFT, IN_MOVERIGHT)) then
		if (self:GetIronsights() == true) then
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil / 2, self.Primary.NumShots, self.Primary.Cone)
			-- Put recoil / 2 when you're in ironsight mod

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil / 5), math.Rand(-1,1) * (self.Primary.Recoil / 5), 0))
			-- Punch the screen 5x less hard when you're in ironsigh mod
		else
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil * 1.5, self.Primary.NumShots, self.Primary.Cone)
			-- Recoil * 1.5

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil * 1.5), math.Rand(-1,1) * (self.Primary.Recoil * 1.5), 0))
			-- Punch the screen * 1.5
		end

	elseif self.Owner:Crouching() then
		if (self:GetIronsights() == true) then
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil / 10, self.Primary.NumShots, self.Primary.Cone)
			-- Put 0 recoil when you're in ironsight mod

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil / 10), math.Rand(-1,1) * (self.Primary.Recoil / 10), 0))
			-- Punch the screen 10x less hard when you're in ironsigh mod
		else
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil / 2, self.Primary.NumShots, self.Primary.Cone)
			-- Recoil / 2

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil / 2), math.Rand(-1,1) * (self.Primary.Recoil / 2), 0))
			-- Punch the screen / 2
		end
	else
		if (self:GetIronsights() == true) then
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil / 6, self.Primary.NumShots, self.Primary.Cone)
			-- Put recoil / 4 when you're in ironsight mod

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * (self.Primary.Recoil / 6), math.Rand(-1,1) * (self.Primary.Recoil / 6), 0))
			-- Punch the screen 6x less hard when you're in ironsigh mod
		else
			self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
			-- Put normal recoil when you're not in ironsight mod

			self.Owner:ViewPunch(Angle(math.Rand(-0.5,-2.5) * self.Primary.Recoil, math.Rand(-1,1) *self.Primary.Recoil, 0))
			-- Punch the screen
		end
	end
end