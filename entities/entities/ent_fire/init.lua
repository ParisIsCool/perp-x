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

local Distance = 75
local MaxFires = 35
local NumberOfFires = 0

function ENT:Initialize()
	self:SetModel( "models/props_junk/wood_pallet001a.mdl" )

	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	self:SetAngles( Angle( 0, 0, 0 ) )
	self:SetPos( self:GetPos() + Vector( 0, 0, 10 ) )
	
	self.LastSpread = CurTime()
	self.SpawnTime = CurTime()
	
	NumberOfFires = NumberOfFires + 1
	
	self.LastDamage = CurTime()
	self.ExtinguisherLeft = math.random( 70, 100 )
	self.Spores = 0
	self.HealthAdd = CurTime()
	
	self:DrawShadow( false )
	self.IsAlive = true
end

function ENT:SpreadFire()
	if NumberOfFires >= MaxFires then return false end
	-- Try 25 times to spread.	
	for i = 1, 25 do
		local RandomStart = self:GetPos() + Vector( math.Rand( -1, 1 ) * Distance, math.Rand( -1, 1 ) * Distance, 50 )
		local UsStart = self:GetPos() + Vector( 0, 0, 10 )
		
		-- trace to the random spot from us
		local Trace = {}
			Trace.start = UsStart
			Trace.endpos = RandomStart
			Trace.filter = self
			Trace.mask = MASK_OPAQUE
		
		local TR1 = util.TraceLine( Trace )
		
		-- trace back to make sure theres nothing there
		local Trace2 = {}
			Trace2.start = RandomStart
			Trace2.endpos = UsStart
			Trace2.filter = self
			Trace2.mask = MASK_OPAQUE
			
		local TR2 = util.TraceLine( Trace2 )
		
		if TR1.Hit and TR2.Hit or not TR1.Hit and not TR2.Hit then
			-- trace down to make sure it"s not a sheer cliff, or the like
			
			local TrStart = RandomStart
			local TrEnd = TrStart - Vector( 0, 0, 100 )
			
			local Trace = {}
				Trace.start = TrStart
				Trace.endpos = TrEnd
				Trace.filter = self
				
			local TraceResults = util.TraceLine( Trace )
				
			if TraceResults.HitWorld then
				if util.IsInWorld( TraceResults.HitPos ) then				
					if TraceResults.MatType == MAT_DIRT or 
						TraceResults.MatType == MAT_WOOD or
						TraceResults.MatType == MAT_COMPUTER or
						TraceResults.MatType == MAT_FOLIAGE or
						TraceResults.MatType == MAT_PLASTIC or
						TraceResults.MatType == MAT_SAND or
						TraceResults.MatType == MAT_SLOSH or
						TraceResults.MatType == MAT_TILE or
						TraceResults.MatType == MAT_VENT then

						local NearbyEnts = ents.FindInSphere( TraceResults.HitPos, Distance * .5 )
									
						local NearFire = false
						for _, v in pairs( NearbyEnts ) do
							if v:GetClass() == "ent_fire" then
								NearFire = true
								break
							end
						end
								
						if not NearFire then
							local Fire = ents.Create( "ent_fire" )
								Fire:SetPos( TraceResults.HitPos )
								Fire:Spawn()
								Fire.Starter = self.Starter
							self.Spores = self.Spores + 1
							return
						end
					end
				end
			end
		end
	end
end

function ENT:KillFire() 
	if self.IsAlive then
		NumberOfFires = NumberOfFires - 1
		self.IsAlive = false
	end
	
	self:Remove()
end

function ENT:HitByExtinguisher( ByWho, IsHose )
	if IsHose then
		self.ExtinguisherLeft = self.ExtinguisherLeft - 3
	else
		self.ExtinguisherLeft = self.ExtinguisherLeft - 1
	end
	
	if self.ExtinguisherLeft <= 0 then
		if IsValid( ByWho ) and ByWho:IsPlayer() then
			if ByWho:Team() == TEAM_FIREMAN or ByWho:Team() == TEAM_FIRECHIEF then
				if IsHose then
					ByWho:GiveCash( 5 )
					ByWho:Notify( "You've been paid $5 for putting out a fire!" )
				else
					ByWho:GiveCash( 10 )
					ByWho:Notify( "You've been paid $10 for putting out a fire!" )
				end
			end
			
			self:KillFire()
			--ByWho:AddProgress( 25, 1 )
			hook.Run("FireExtinguish", ByWho)
			return
		end

		self:KillFire()
	end
end

function ENT:Think()
	if self.Spores >= 61 then return self:KillFire() end
	if self:WaterLevel() > 0 then return self:KillFire() end
	
	--if (string.lower(game.GetMap()) == "rp_rockford_v2b") or (string.lower(game.GetMap()) == "rp_paralake_city_v4") then do end	
	--else
		--below only used if PE style rain used WEATHER_RAIN
	--local IsRaining = daynight:GetWeather() == WEATHER_RAIN
	
	--local IsStorming = GAMEMODE.CloudCondition == CLOUDS_STORMY || GAMEMODE.CloudCondition == CLOUDS_STORMY_SEVERE
	--local IsRaining = IsStorming || GAMEMODE.CloudCondition == CLOUDS_STORMY_LIGHT

	local Trace = {}
		Trace.start = self:GetPos()
		Trace.endpos = self:GetPos() + Vector( 0, 0, 500 )
		Trace.mask = MASK_VISIBLE
		Trace.filter = self
	
	local TR = util.TraceLine( Trace )
	local IsOutdoors = TR.HitPos == Trace.endpos
		
	if IsRaining and IsOutdoors then
		self:HitByExtinguisher()
	else
		if self.HealthAdd + 10 < CurTime() and not ( IsRaining or IsOutdoors ) then 
			self.HealthAdd = CurTime() 
			self.ExtinguisherLeft = math.Clamp( self.ExtinguisherLeft + 1, 0, 120 ) 
		end

		if self.LastSpread + 10 < CurTime() and ( IsRaining or not IsOutdoors ) or ( self.LastSpread + 60 < CurTime() and ( IsRaining and IsOutdoors ) ) then
			self.Spores = self.Spores + 1
			self:SpreadFire()
			
			self.LastSpread = CurTime()
		end
	end
	
	if self.LastDamage + .1 < CurTime() then
		local CloseEnts = ents.FindInSphere(self:GetPos(), 70)

		self.LastDamage = CurTime()
		
		for _, v in pairs( CloseEnts ) do
			if ( v:GetClass() == "prop_physics" or v:GetClass() == "ent_item" or v:GetClass() == "ent_prop_item" or v:GetClass() == "prop_clock" or v:GetClass() == "ent_weed" or v:GetClass() == "ent_cocaine" or v:GetClass() == "ent_meth" ) and not v.UnBurnable then
				v.FireDamage = v.FireDamage or 60
				v.FireDamage = v.FireDamage - 1
				
				if v.FireDamage == 0 then
					if v:GetModel() == "models/props_junk/propanecanister001a.mdl" then
						sound.Play( Sound( "ambient/explosions/explode_" .. math.random( 1, 7 ) .. ".wav" ), v:GetPos(), 150, 255 )
						
						for i = 1, 10 do
							self:SpreadFire()
						end
					end
					
					v:Remove()
				else
					if not v:IsOnFire() then
						v:Ignite( 60, 100 )
					end
					
					local C = ( v.FireDamage / 60 ) * 255
					v:SetColor( Color( C, C, C, 255 ) )
				end
			elseif v:IsPlayer() and v:Alive() and v:GetPos():Distance( self:GetPos() ) < 70 then
				local Vehicle = v:GetVehicle()

				if v:Team() ~= TEAM_FIREMAN then
					if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
						Vehicle:TakeDamage( 2, self.Starter, self )
					else
						v:TakeDamage( 2, self.Starter, self )
					end
					
					if v:GetPos():Distance( self:GetPos() ) < 50 and v:Team() ~= TEAM_FIREMAN then
						if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
							Vehicle:TakeDamage( 15, self.Starter, self )
						else
							v:TakeDamage( 15, self.Starter, self )
						end
					end
				else
					v.LastFireDamage = v.LastFireDamage or 0
					
					if v.LastFireDamage + 1 < CurTime() then
						if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
							Vehicle:TakeDamage( 1, self.Starter, self )
						else
							v:TakeDamage( 1, self.Starter, self )
						end

						v.LastFireDamage = CurTime()
					end
				end
			end
		end
	end
	
	self:NextThink( CurTime() + 0.1 )
	
	return true
end