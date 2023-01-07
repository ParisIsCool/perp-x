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

	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
else
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 82
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	
	surface.CreateFont( "CSKillIcons", { font = "csd", size = ScreenScale( 30 ), weight = 500, antialias = true, additive = true } )
	surface.CreateFont( "CSSelectIcons", { font = "csd", size = ScreenScale( 60 ), weight = 500, antialias = true, additive = true } )
end

SWEP.Author					= "Renu"
SWEP.Instructions			= "Point, click, enjoy."

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.Primary.Sound			= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.TracerRarity 			= 4
SWEP.MaxPenetration 		= 4000
SWEP.MaxPenetration_Depth 	= 25

function SWEP:Initialize()
	if SERVER then
		timer.Simple( 0, function() if IsValid( self ) then self:Holster() end end )
	end
	
	self:SetWeaponHoldType( self.HoldTypeNorm )
	
	self:SetIronsights( false )
	self.bulletNumber = 0
end

function SWEP:Reload()
	self:DefaultReload( ACT_VM_RELOAD )
	self:SetIronsights( false )
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )

	if not self:CanPrimaryAttack() then return end
	if not self.Weapon:GetGNWVar( "Ironsights" ) then return end

	self.Weapon:EmitSound( self.Primary.Sound )
	
	self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )
	
	self:TakePrimaryAmmo( 1 )
	
	if self.Owner:IsNPC() then return end
	
	self.Owner:ViewPunch( Angle( math.Rand( -0.2, -0.1 ) * self.Primary.Recoil, math.Rand( -0.1, 0.1 ) * self.Primary.Recoil, 0 ) )
end

SWEP.NextSecondaryAttack = 0
function SWEP:SecondaryAttack()
	if not self.IronSightsPos then return end
	if self.NextSecondaryAttack > CurTime() then return end
	
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	self:SetIronsights( not self.Weapon:GetGNWVar( "Ironsights", false ) )
	
	self.NextSecondaryAttack = CurTime() + 0.3
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

function SWEP:SetIronsights( b )
	if SERVER then
		self.Weapon:SetGNWVar( "Ironsights", b and b or nil )

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

function SWEP:GetIronsights()

	return self.Weapon:GetNWBool("Ironsights")
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
					if traceRes.Entity:GetModel() == "models/perrynsvehicles/bearcat_g3/bearcat_g3.mdl" then
						return
					elseif traceRes.Entity:GetModel() == "models/talonvehicles/tal_oshkosh_matv.mdl" then
						return
					elseif traceRes.Entity:GetModel() == "models/talonvehicles/tal_humvee.mdl" then
						return
					elseif traceRes.Entity:GetModel() == "models/talonvehicles/mrap_maxxpro.mdl" then
						return
					else
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
						
						if util.IsInWorld( testPos ) then
							self:CSShootBullet( dmg * .95, recoil, 1, 0, testPos, aimVector, distanceLeft - ( i * 1000 ), showTracer )
							self:CSShootBullet( dmg * .95, recoil, 1, 0, testPos + ( trueAim * 5 ), aimVector * -1, -100, showTracer )
							
							break
						end
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
end

local IRONSIGHT_TIME = 0.25
function SWEP:GetViewModelPosition( pos, ang )
	if not self.IronSightsPos then return pos, ang end

	local bIron = self.Weapon:GetGNWVar( "Ironsights", false )
	
	if bIron ~= self.bLastIron then
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if bIron then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	end
	
	local fIronTime = self.fIronTime or 0
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	local Mul = 1.0

	if not bIron and fIronTime < CurTime() - IRONSIGHT_TIME then
		if self.NormalAng then
			ang = ang * 1
			ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * Mul )
			ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * Mul )
			ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * Mul )
		end
		
		if self.NormalPos then
			pos = pos + self.NormalPos.x * Right * Mul
			pos = pos + self.NormalPos.y * Forward * Mul
			pos = pos + self.NormalPos.z * Up * Mul
		end
	
		return pos, ang
	end
	
	if fIronTime > CurTime() - IRONSIGHT_TIME then
		Mul = math.Clamp( ( CurTime() - fIronTime ) / IRONSIGHT_TIME, 0, 1 )
		
		if not bIron then Mul = 1 - Mul end
	end

	local Offset	= self.IronSightsPos
	
	if self.IronSightsAng then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	end
	
	if self.NormalAng then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * ( 1 - Mul ) )
		ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * ( 1 - Mul ) )
		ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * ( 1 - Mul ) )
	end

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul
	
	if self.NormalPos then
		pos = pos + self.NormalPos.x * Right * ( 1 - Mul )
		pos = pos + self.NormalPos.y * Forward * ( 1 - Mul )
		pos = pos + self.NormalPos.z * Up * ( 1 - Mul )
	end

	return pos, ang
end

function SWEP:DrawHUD() end

function SWEP:OnRestore()
	self.NextSecondaryAttack = 0
	self:SetIronsights( false )
end

function SWEP:Holster()
	if SERVER and self.BackHolster then
		if not IsValid( self.Owner ) then return end
		self.GunModel = ents.Create( "prop_back_gun" )
			self.GunModel:SetModel( self.WorldModel )
			self.GunModel:SetPos( self.Owner:GetPos() + self.Owner:GetForward() * 10 + self.Owner:GetUp() * 30 )
			self.GunModel:SetAngles( self.Owner:GetAngles() + Angle( 90, 0, 0 ) )
			self.GunModel:SetParent( self.Owner )
			self.GunModel:Spawn()
	end

	return true
end

--function SWEP:Deploy()
	--if SERVER and self.GunModel and IsValid( self.GunModel ) then self.GunModel:Remove() end
--end

function SWEP:Deploy()
if SERVER and self.GunModel and IsValid( self.GunModel ) then self.GunModel:Remove() end
 
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW );
	
	self:SetDeploySpeed( self.Weapon:SequenceDuration() );
	
	if ( CLIENT ) then
		local sex = "";
		
		if ( self.Owner:GetSex() == SEX_FEMALE ) then
			sex = "her";
		else
			sex = "his";
		end
		
		tosay = sex .. " " .. self.PrintName;
		
		RunConsoleCommand( "say", "/me pulls out " .. tosay );
	end	
end

function SWEP:OnRemove()
	if SERVER and self.GunModel and IsValid( self.GunModel ) then self.GunModel:Remove() end
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide / 2, y + tall * 0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
end