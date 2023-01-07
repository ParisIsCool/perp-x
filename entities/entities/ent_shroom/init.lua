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

local FullGrowthTime = 360
local MakeBrown = 720
local StartFade = 780
local FullDeath = 840
local Distance = 150

function ENT:Initialize()
	self:SetModel( "models/fungi/sta_skyboxshroom1.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self:SetUseType( SIMPLE_USE )
	self:SetAngles( Angle( 0, math.random( 1, 360 ), 0 ) )

	self.SpawnTime = CurTime() 
	self:SetGNWVar( "SpawnTime", CurTime() )

	self.Position = self:GetPos()
	self.Entity:GetTable().Tapped = false
end

function ENT:Spore()
	--if not self.Spawner or not IsValid( self.Spawner.Entity ) then return end
	if math.random( 1, 3 ) == 3 then return false end

	local NearbyMushrooms = 0
	for _, v in pairs( ents.FindInSphere( self:GetPos(), Distance ) ) do
		if v:GetClass() == "ent_shroom" then
			NearbyMushrooms = NearbyMushrooms + 1
		end
	end

	local count = 0
	for _, v in pairs( ents.FindByClass( "ent_shroom" ) ) do
		if v.Spawner == self.Spawner then
			count = count + 1
		end
	end

	if NearbyMushrooms > 15 then return end
	if count > MAX_SHROOMS then return end

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

		if ( TR1.Hit and TR2.Hit ) or ( not TR1.Hit and not TR2.Hit ) then
			local TrStart = RandomStart
			local TrEnd = TrStart - Vector( 0, 0, 100 )

			local Trace = {}
				Trace.start = TrStart
				Trace.endpos = TrEnd
				Trace.filter = self

			local TraceResults = util.TraceLine( Trace )

			if TraceResults.HitWorld then
				if util.IsInWorld( TraceResults.HitPos ) then
					if TraceResults.MatType == MAT_DIRT then

						local NearbyEnts = ents.FindInSphere( TraceResults.HitPos, 25 )

						local NearShroom = false
						for k, v in pairs( NearbyEnts ) do
							if v:GetClass() == "ent_shroom" then
								NearShroom = true
							end
						end

						if not NearShroom then
							local Trace = {}
							Trace.start = TraceResults.HitPos
							Trace.endpos = TraceResults.HitPos + Vector( 0, 0, 250 )
							Trace.mask = MASK_VISIBLE

							local TR = util.TraceLine( Trace )

							if not TR.HitWorld then
								local Shroom = ents.Create( "ent_shroom" )
									Shroom:SetPos( TraceResults.HitPos )
									Shroom:Spawn()
									Shroom.Spawner = self.Spawner

								break
							end
						end
					end
				end
			end
		end
	end
end

function ENT:Think()
	if self.SpawnTime + FullDeath < CurTime() then
		self:Remove()
		self:Remove()
	elseif not self.FirstSpore and self.SpawnTime + FullGrowthTime + ( ( MakeBrown - FullGrowthTime ) * .5 ) < CurTime() then
		self:Spore()
		self.FirstSpore = true
	elseif not self.SecondSpore and self.SpawnTime + MakeBrown < CurTime() then
		self:Spore()
		self.SecondSpore = true
	end

	self:NextThink( CurTime() + 0.5 )

	return true
end

function ENT:Use( activator, caller )
	if not activator:IsPlayer() then return false end
	if self.Entity:GetTable().Tapped then return false end
	
	--activator:PrintMessage( HUD_PRINTTALK, "[VENOM DEBUG] I've been touched!" )

	if activator:Team() == TEAM_POLICE || activator:Team() == TEAM_SWAT || activator:Team() == TEAM_CHIEF || activator:Team() == TEAM_DETECTIVE || activator:Team() == TEAM_FBI then
		self.Entity:GetTable().Tapped = true

		--activator:PrintMessage( HUD_PRINTTALK, "[VENOM DEBUG] I've been touched inside gov check!" )
		
		activator:GiveCash( 100 )
		activator:ChatPrint( "You have been rewarded $100 for destroying magic mushrooms." )

		self:Remove()
		return false
	end

	if self.SpawnTime + FullGrowthTime < CurTime() and self.SpawnTime + MakeBrown > CurTime() then
		--activator:PrintMessage( HUD_PRINTTALK, "[VENOM DEBUG] I've been touched inside the pickup!" )
	
		if not activator:CanHoldItem( 78, 1 ) then
			activator:Notify( "You don't have enough inventory room!" )
			return 
		end

		self.Entity:GetTable().Tapped = true

		activator:GiveItem( 78, 1 )
		self:Remove()
	end
end
