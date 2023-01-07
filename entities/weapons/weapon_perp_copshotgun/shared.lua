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

	SWEP.BackHolster 		= false
end
if CLIENT then
	SWEP.PrintName			= "Police Shotgun"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "k"
end
SWEP.Author					= "bob"
SWEP.Instructions			= "Kills people pretty well, also blows down doors.  Yay."

SWEP.HoldType				= "ar2"
SWEP.HoldTypeNorm			= "passive"

SWEP.Base					= "weapon_perp_base"

SWEP.ViewModel				= Model( "models/weapons/v_shot_m3super90.mdl" )
SWEP.WorldModel				= Model( "models/weapons/w_shot_m3super90.mdl" )

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.AnimPrefix	 			= "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_M3.Single" )
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots		= 8
SWEP.Primary.Cone			= 0.1
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.95
SWEP.Primary.DefaultClip	        = 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"
SWEP.Numbul 				= 10

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 			= Vector(5.7185, -5.8064, 3.345)
SWEP.IronSightsAng 			= Vector( 0, 0, 0 )
SWEP.NormalPos 				= Vector( 0, 0, 3.4 )
SWEP.NormalAng 				= Vector(  -19, 0, 0 )

SWEP.MaxPenetration 		= PENETRATION_SHOTGUN

SWEP.GrantExperience_Skill 	= SKILL_SHOTGUN_MARK
SWEP.GrantExperience_Exp 	= 5

function SWEP:Reload()
	self:SetIronsights( false )
	
	if self.Weapon:GetGNWVar( "reloading" ) then return end
	
	if self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
		if SERVER then self.Weapon:SetGNWVar( "reloading", true ) end
		self.Weapon:SetVar( "reloadtimer", CurTime() + 0.5 )
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	end
end

function SWEP:Think()
	if self.Weapon:GetGNWVar( "reloading" ) then
		if self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() then
			if self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
				return SERVER and self.Weapon:SetGNWVar( "reloading", nil )
			end
			
			self.Weapon:SetVar( "reloadtimer", CurTime() + 0.3 )
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
			
			if self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			end
		end
	end
end

local function randSign()
	while true do
		local rand = math.random( -1, 1 )
		
		if rand ~= 0 then
			return rand
		end
	end
end

function SWEP:CSShootBullet( dmg, recoil, numbul, cone, fireFrom, aimVector, distanceLeft, showTracerOverride )
	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01
	distanceLeft = distanceLeft or self.MaxPenetration
	fireFrom = fireFrom or self.Owner:GetShootPos()
	aimVector = aimVector or self.Owner:GetAimVector()

	for i = 1, numbul do
		local showTracer = showTracerOverride or 0
		
		if not showTracerOverride then
			self.bulletNumber = self.bulletNumber + 1
			
			if self.bulletNumber == self.TracerRarity then
				self.bulletNumber = 0
				showTracer = 1
			end
		end
		
		local realSpread = Vector( 0, 0, 0 )
		
		if cone ~= 0 then
			realSpread = Vector( math.random() * cone * randSign(), math.random() * cone * randSign(), math.random() * cone * randSign() )
		end
		
		local trueAim = aimVector + realSpread
		local trace = {}
			trace.start = fireFrom
			trace.endpos = trace.start + ( trueAim * 1000000 )
			trace.filter = self.Owner
			trace.mask = MASK_SHOT

		local traceRes = util.TraceLine( trace )
		local dir = traceRes.HitPos - trace.start
		dir:Normalize()

		local hitPosition = traceRes.HitPos
		
		local bullet = {}
			bullet.Num 		= 1
			bullet.Src 		= fireFrom				-- Source
			bullet.Dir 		= dir					-- Dir of bullet
			bullet.Spread 	= Vector( 0, 0, 0 )		-- Aim Cone
			bullet.Tracer	= showTracer			-- Show a tracer on every x bullets 
			bullet.Force	= 5						-- Amount of force to give to phys objects
			bullet.Damage	= dmg
		
		self.Owner:FireBullets( bullet )

		if IsValid( traceRes.Entity ) and ( traceRes.Entity:IsPlayer() or traceRes.Entity:GetClass() == "prop_vehicle_jeep" ) then
			if SERVER then
				if traceRes.Entity:IsPlayer() then
					if self.GrantExperience_Skill and not ( traceRes.Entity:Team() == TEAM_MAYOR and self.Owner:Team() ~= TEAM_CITIZEN ) then
						self.Owner:GiveExperience( self.GrantExperience_Skill, self.GrantExperience_Exp )
					end
				end

				if traceRes.Entity:GetClass() == "prop_vehicle_jeep" and traceRes.Entity.CarDamage then
					if traceRes.Entity:GetModel() ~= "models/swatvan2.mdl" then
						traceRes.Entity.CarDamage = traceRes.Entity.CarDamage - ( dmg * .5 )
							
						if traceRes.Entity.CarDamage <= 0 then
							--traceRes.Entity:DisableVehicle()
						end
							
						local Driver = traceRes.Entity:GetDriver()
							
						if Driver and Driver:IsValid() and Driver:IsPlayer() then
							local NewHealth = Driver:Health() - ( dmg * .4 )
								
							if NewHealth <= 0 then
								Driver:Kill()
							else
								Driver:SetHealth( NewHealth )
								Driver.OnEnteredHealth = NewHealth
							end
						end
					end
				end
			end
		else
			distanceLeft = distanceLeft - hitPosition:Distance( fireFrom )
			
			if distanceLeft > 0 and not traceRes.Entity or not IsValid( traceRes.Entity ) or not traceRes.Entity:IsPlayer() then
				for i = 1, self.MaxPenetration_Depth do
					if distanceLeft < ( i * 1000 ) then break else
						local testPos = hitPosition + ( trueAim * i * 5 )
						/*
						if util.IsInWorld( testPos ) then
							self:CSShootBullet( dmg * .75, recoil, 1, 0, testPos, aimVector, distanceLeft - ( i * 1000 ), showTracer )
							self:CSShootBullet( dmg * .75, recoil, 1, 0, testPos + ( trueAim * 5 ), aimVector * -1, -100, showTracer )
							
							break
						end
						*/
					end
				end
			end
		end
	end

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 		-- View model animation
	self.Owner:MuzzleFlash()								-- Crappy muzzle light
	self.Owner:SetAnimation( PLAYER_ATTACK1 )				-- 3rd Person Animation

	if self.Owner:IsNPC() then return end

	if not showTracerOverride and CLIENT and IsFirstTimePredicted() then
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - recoil
		self.Owner:SetEyeAngles( eyeang )
	end
	
 	local trace = self.Owner:GetEyeTrace();
	local item = trace.Entity
	if trace.HitPos:Distance(self.Owner:GetShootPos()) > 250 or self.DestroyDoor == 0 then return end

	if item:GetClass() == "prop_door_rotating" and (SERVER) then
		
		item:Fire("open", "", 0.001)
		item:Fire("unlock", "", 0.001)

		local pos = item:GetPos()
		local ang = item:GetAngles()
		local model = item:GetModel()
		local skin = item:GetSkin()

		--[[
		local smoke = EffectData()
			smoke:SetOrigin(pos)
			util.Effect("effect_smokedoor", smoke)
		]]--
			
		item:SetNotSolid(true)
		item:SetNoDraw(true)

		local function ResetDoor( door )
			if IsValid(door) then
				door:SetNotSolid(false)
				door:SetNoDraw(false)
			end
		end
		local function ResetFakeDoor( fakedoor )
			if IsValid(fakedoor) then
				fakedoor:Remove()
			end
		end

		local norm = (pos - self.Owner:GetPos())
		norm:Normalize()
		local push = 1000 * norm
		local ent = ents.Create("prop_physics")

		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:SetModel(model)
		//ent:SetCollisionGroup( 11 )
		if(skin) then
			ent:SetSkin(skin)
		end

		ent:Spawn()

		timer.Simple(0.001, function() if ent and push then ent:GetPhysicsObject():SetVelocity(push) end end)              
		//timer.Simple(0.01, function() if ent and push then ent:GetPhysicsObject():SetVelocity(push) end end)
		timer.Simple(15, function() ResetFakeDoor( ent, 10) end )
		timer.Simple(16, function() ResetDoor( item, 10) end )
	end
end