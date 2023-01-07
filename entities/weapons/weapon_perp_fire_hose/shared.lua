AddCSLuaFile()
AddCSLuaFile( "effects/fire_hose_effect.lua" )

SWEP.PrintName = "vFire Hose"
SWEP.Author = "Milk"
SWEP.Category = "VFire - Milk's Weapons"
SWEP.Contact = "https://steamcommunity.com/profiles/76561198066661394/"
SWEP.Purpose = "To extinguish fire!"
SWEP.Instructions = "Shoot into a fire, to extinguish it."

SWEP.Slot = 3
SWEP.SlotPos = 35
SWEP.Weight = 1
SWEP.DrawAmmo = false

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.DrawWeaponInfoBox = false
SWEP.Spawnable = true
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_firehose.mdl"
SWEP.ViewModelFOV = 94
SWEP.WorldModel = "models/weapons/w_firehose.mdl"
SWEP.HoldType = "shotgun"

game.AddAmmoType( { name = "firehose_water" } )
if ( CLIENT ) then language.Add( "firehose_water_ammo", "Water Ammo" ) end

SWEP.MaxAmmo = 500

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = SWEP.MaxAmmo
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "firehose_water"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.IsInfinite = true
SWEP.Spawnable = true

SWEP.Primary.Ammo = "none"

function SWEP:Ammo1()
	return 500
end

function SWEP:SetupDataTables()
	self:NetworkVar( "Float", 0, "NextIdle" )
end

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )

	self:Idle()

	return true
end

function SWEP:Holster( weapon )
	if ( CLIENT ) then return end

	if ( self.Sound ) then
		self.Sound:Stop()
		self.Sound = nil
	end

	return true
end

function SWEP:OnDrop()
	if ( self.Sound ) then
		self.Sound:Stop()
		self.Sound = nil
	end

	-- Do not give any more extra ammo
	self.Primary.DefaultClip = 0
end

function SWEP:DoEffect( effectscale )

	local effectdata = EffectData()
	effectdata:SetAttachment( 1 )
	effectdata:SetEntity( self.Owner )
	effectdata:SetOrigin( self.Owner:GetShootPos() )
	effectdata:SetNormal( self.Owner:GetAimVector() )
	effectdata:SetScale( effectscale or 1 )
	util.Effect( "fire_hose_effect", effectdata )

end

function SWEP:DoExtinguish( pushforce, effectscale )

	if ( self:Ammo1() < 1 ) then return end

	if ( CLIENT ) then
		if ( self.Owner == LocalPlayer() ) then self:DoEffect( effectscale ) end -- FIXME
		return
	end

	if ( !self.IsInfinite ) then
		self:TakePrimaryAmmo( 1 )
	end

	effectscale = effectscale or 1
	pushforce = pushforce or 0

	local tr
	if ( self.Owner:IsNPC() ) then
		tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 16384,
			filter = self.Owner
		} )
	else
		tr = self.Owner:GetEyeTrace()
	end

	local pos = tr.HitPos

	for id, prop in pairs( ents.FindInSphere( pos, 100 ) ) do
		if ( !IsValid( prop ) or prop:GetPos():Distance( self:GetPos() ) > 256 ) then continue end
		if ( prop:IsWeapon() and IsValid( prop:GetOwner() ) ) then continue end -- Played equipped weapons
		if ( prop:GetClass():find( "viewmodel" ) ) then continue end -- View models

		if ( pushforce > 0 ) then
			local physobj = prop:GetPhysicsObject()
			if ( IsValid( physobj ) ) then
				physobj:ApplyForceOffset( self.Owner:GetAimVector() * pushforce, pos )
			end
		end

		-- Perhaps this random call should be replaced by a timer of sorts?
		if ( math.random( 0, 1000 ) > 750 ) then
			local retval = hook.Call( "ExtinguisherDoExtinguish", nil, prop )
			if ( retval == true ) then continue end

			if ( prop:IsOnFire() ) then prop:Extinguish() end

			local class = prop:GetClass()
			if ( string.find( class, "ent_minecraft_torch" ) and prop:GetWorking() ) then
				prop:SetWorking( false )
			elseif ( string.find( class, "env_fire" ) ) then -- Gas Can support. Should work in ravenholm too.
				prop:Fire( "Extinguish" )
			end
		end
	end

	self:DoEffect( effectscale )

end

function SWEP:PrimaryAttack()
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
	
	local NearbyFireTruck = false;
	local NearbyHydrant = false;

	for k, v in pairs(ents.FindByClass('prop_vehicle_jeep')) do
		if v:GetPos():Distance(self.Owner:GetPos()) < 1350 then
			if v:GetModel() == 'models/perrynsvehicles/pierce_pumper/pierce_pumper.mdl' or v:GetModel() == 'models/pierce_pumper.mdl' then --pierce pumper
				NearbyFireTruck = true;
				break;
			elseif v:GetModel() == 'models/sentry/fireengine.mdl' or v:GetModel() == 'models/fireengine.mdl' then --rescue truck
				NearbyFireTruck = true;
				break;
			elseif v:GetModel() == 'models/sentry/fireladder.mdl' or v:GetModel() == 'models/fireladder.mdl' then --ladder truck
				NearbyFireTruck = true;
				break;
			elseif v:GetModel() == 'models/sentry/firerescue.mdl' or v:GetModel() == 'models/firerescue.mdl' then --gtav truck
				NearbyFireTruck = true;
				break;
			end
		end
	end
	
	for k, v in pairs(ents.FindByClass('prop_physics')) do
		if v:GetPos():Distance(self.Owner:GetPos()) < 500 and string.find(v:GetModel(), "fire") then
			NearbyHydrant = true;
			break;
		end
	end
		
	if (!NearbyFireTruck && !NearbyHydrant) then
		if CLIENT then
			self.Owner.LastWaterHoseNotify = self.Owner.LastWaterHoseNotify or 0
			
			if self.Owner.LastWaterHoseNotify + 1 < CurTime() then
				self.Owner:Notify( "You must be near a fire truck or a fire hydrant to use this!" )
				self.Owner.LastWaterHoseNotify = CurTime()
			end
		end
	
		return
	end


	if ( IsFirstTimePredicted() ) then

		self:DoExtinguish( 196, 1 )

		if ( SERVER ) then

			if SERVER then
				local Trace2 = {}
				Trace2.start = self.Owner:GetShootPos()
				Trace2.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 200
				Trace2.filter = self.Owner
			
				local Trace = util.TraceLine( Trace2 )
						
				local CloseEnts = ents.FindInSphere( Trace.HitPos, 75 )
				
				for _, v in pairs( CloseEnts ) do
					if v:GetClass() == "ent_fire" then
						if math.random(1,30) < 15 then
							v:HitByExtinguisher( self.Owner, true )
						end
					end
					
					if v:IsOnFire() then v:Extinguish() end
				end
			end

			--[[if ( self.Owner:KeyPressed( IN_ATTACK ) or !self.Sound ) then
				self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

				self.Sound = CreateSound( self.Owner, Sound( "weapons/extinguisher/fire1.wav" ) )

				self:Idle()
			end

			if ( self:Ammo1() > 0 and self.Sound ) then self.Sound:Play() end]]

		end
	end

	self:SetNextPrimaryFire( CurTime() + 0.05 )
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:PlaySound()
	self:EmitSound( "weapons/extinguisher/release1.wav", 100, math.random( 95, 110 ) )
end

function SWEP:Think()

	if ( self:GetNextIdle() > 0 and CurTime() > self:GetNextIdle() ) then

		self:DoIdleAnimation()
		self:Idle()

	end

	if ( self:GetNextSecondaryFire() > CurTime() or CLIENT ) then return end

	if ( ( self.NextAmmoReplenish or 0 ) < CurTime() and self.Owner:WaterLevel() > 1 ) then
		if ( !self.IsInfinite && self:Ammo1() < self.MaxAmmo * 2 ) then
			self.Owner:SetAmmo( math.min( self:Ammo1() + 25, self.MaxAmmo * 2 ), self:GetPrimaryAmmoType() )
		end
		self.NextAmmoReplenish = CurTime() + 0.1
	end

	if ( self.Sound and self.Sound:IsPlaying() and self:Ammo1() < 1 ) then
		self.Sound:Stop()
		self.Sound = nil
		self:PlaySound()
		self:DoIdleAnimation()
		self:Idle()
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) or ( !self.Owner:KeyDown( IN_ATTACK ) and self.Sound ) ) then

		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

		if ( self.Sound ) then
			self.Sound:Stop()
			self.Sound = nil
			if ( self:Ammo1() > 0 ) then
				self:PlaySound()
				if ( !game.SinglePlayer() ) then self:CallOnClient( "PlaySound", "" ) end
			end
		end

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() )

		self:Idle()

	end
end

function SWEP:DoIdleAnimation()
	if ( self.Owner:KeyDown( IN_ATTACK ) and self:Ammo1() > 0 ) then self:SendWeaponAnim( ACT_VM_IDLE_1 ) return end
	if ( self.Owner:KeyDown( IN_ATTACK ) and self:Ammo1() < 1 ) then self:SendWeaponAnim( ACT_VM_IDLE_EMPTY ) return end
	self:SendWeaponAnim( ACT_VM_IDLE )
end

function SWEP:Idle()

	self:SetNextIdle( CurTime() + self:GetAnimationTime() )

end

function SWEP:GetAnimationTime()
	local time = self:SequenceDuration()
	if ( time == 0 and IsValid( self.Owner ) and !self.Owner:IsNPC() and IsValid( self.Owner:GetViewModel() ) ) then time = self.Owner:GetViewModel():SequenceDuration() end
	return time
end

if ( SERVER ) then return end

if CLIENT then SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/myicon/firehose" ) end