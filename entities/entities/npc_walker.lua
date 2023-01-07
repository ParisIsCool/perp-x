AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

GRIDTEST = util.JSONToTable(file.Read("npc_walkerroutes_rp_southside.json"))
local grid = GRIDTEST

local Types = {
	[1] = "baseballtee",
	[2] = "flannel",
	[3] = "hoodie_jeans",
	[4] = "hoodie_sweatpants",
	[5] = "jacket_open",
	[6] = "jacketvneck_sweatpants",
	[7] = "leatherjacket",
}
local Types2 = {
	[1] = "baseballtee",
	[2] = "flannel",
	[3] = "hoodiejeans",
	[4] = "hoodiesweatpants",
	[5] = "jacketopen",
	[6] = "jacketvneck_sweatpants",
	[7] = "leather_jacket",
}
local Models = {
	[SEX_MALE] = "models/smalls_civilians/pack2/male/%s/male_0%i_%s_npc.mdl",
	[SEX_FEMALE] = "models/player/citizen_v2/female_0%i.mdl",
}

function ENT:Initialize()

	local r = math.random(1,#Types)
	self:SetModel( string.format(Models[SEX_MALE],Types[r],math.random(1,9),Types2[r]) )
    
    self.LoseTargetDist	= 200	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 200	-- How far to search for enemies

	if SERVER then
		self:SetMaxHealth(100)
		self:SetHealth(100)
	end
    
    --self:SetUseType( SIMPLE_USE )

end

----------------------------------------------------
-- ENT:Get/SetEnemy()
-- Simple functions used in keeping our enemy saved
----------------------------------------------------
function ENT:SetEnemy(ent)
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end

----------------------------------------------------
-- ENT:HaveEnemy()
-- Returns true if we have an enemy
----------------------------------------------------
function ENT:HaveEnemy()
	-- If our current enemy is valid
	if ( self:GetEnemy() and IsValid(self:GetEnemy()) ) then
		-- If the enemy is too far
		if ( self:GetRangeTo(self:GetEnemy():GetPos()) > self.LoseTargetDist ) then
			-- If the enemy is lost then call FindEnemy() to look for a new one
			-- FindEnemy() will return true if an enemy is found, making this function return true
			return self:FindEnemy()
		-- If the enemy is dead( we have to check if its a player before we use Alive() )
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() ) then
			return self:FindEnemy()		-- Return false if the search finds nothing
		end	
		-- The enemy is neither too far nor too dead so we can return true
		return true
	else
		-- The enemy isn't valid so lets look for a new one
		return self:FindEnemy()
	end
end

----------------------------------------------------
-- ENT:FindEnemy()
-- Returns true and sets our enemy if we find one
----------------------------------------------------
function ENT:FindEnemy()
	-- Search around us for entities
	-- This can be done any way you want eg. ents.FindInCone() to replicate eyesight
	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
	-- Here we loop through every entity the above search finds and see if it's the one we want
	for k,v in ipairs( _ents ) do
		if ( v:IsPlayer() ) then
			-- We found one so lets set it as our enemy and return true
			self:SetEnemy(v)
			return true
		end
	end	
	-- We found nothing so we will set our enemy as nil (nothing) and return false
	self:SetEnemy(nil)
	return false
end

function ENT:OnKilled( dmginfo )

	local rag = self:BecomeRagdoll( dmginfo )

	timer.Simple(10, function()
		if IsValid(rag) then rag:Remove() end
		local walker = ents.Create("npc_walker")
		walker:SetPos(table.Random(grid)[1])
		walker:Spawn()
	end)
end

if SERVER then

	function ENT:Scream()
		self.ScreamTimer = CurTime() + 10
		self:EmitSound("npc/male/screams/scream"..math.random(1,16)..".mp3", 110)
	end

	function ENT:Hurt()
		self:EmitSound("npc/male/hurt/hurt"..math.random(1,3)..".mp3", 100)
	end

	function ENT:GetScared(NoScream)
		self.ScaredTimer = CurTime()+15
		self.Scared = true
		self:StartActivity( ACT_RUN_PROTECTED )
		self.loco:SetDesiredSpeed( 200 )
		if not NoScream then
			self:Scream()
		else
			self.ScreamTimer = CurTime() + 10
		end
	end

	function ENT:OnTakeDamage( dmginfo )
		self:GetScared(true)
		self:Hurt()
	end

	function ENT:Think()
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 1000)) do
			if IsValid(v) and v:IsPlayer() and v:Alive() and IsValid(v:GetActiveWeapon()) and (string.StartWith(v:GetActiveWeapon():GetClass(),"cw") or string.StartWith(v:GetActiveWeapon():GetClass(),"khr")) then
				if self.ScreamTimer and self.ScreamTimer < CurTime() then
					self:Scream()
				end
				if not self.Scared then
					self:GetScared()
				end
				return
			end
		end
		if self.Scared then
			if self.ScreamTimer and self.ScreamTimer < CurTime() then
				self:Scream()
			end
		end
		if self.Scared and (self.ScaredTimer and self.ScaredTimer < CurTime()) then
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 80 )
			self.Scared = false
		end
	end
end

----------------------------------------------------
-- ENT:RunBehaviour()
-- This is where the meat of our AI is
----------------------------------------------------

if SERVER then
	concommand.Add("clearnpcs", function(ply)
		if not ply:IsAdmin() then return end
		for k, v in pairs(ents.FindByClass("npc_walker")) do
			v:Remove()
		end
	end)
end

if SERVER then
	hook.Add("InitPostEntity", "SpawnNPCs", function()
		for i = 0,1,-1 do
			local p = table.Random(grid)[1]
			local w = ents.Create("npc_walker")
			w:SetPos(p)
			w:Spawn()
		end
	end)
end

if CLIENT then
	local col = Color( 255, 0, 0, 100)
	hook.Add( "PostDrawTranslucentRenderables", "WatchNPCBehavior", function()

		for k, v in pairs(ents.FindByClass("npc_walker")) do
			if not v:GetNWInt("NextPoint") or v:GetNWInt("NextPoint") == 0 then return end
			if not grid[v:GetNWInt("NextPoint")] then continue end
			render.DrawSphere( grid[v:GetNWInt("NextPoint")][1], 50, 30, 30, col )
			render.DrawLine( grid[v:GetNWInt("NextPoint")][1], v:GetPos(), col )
		end

	end )
end

function ENT:RunBehaviour()
	-- This function is called when the entity is first spawned, it acts as a giant loop that will run as long as the NPC exists

	if SERVER then

		while ( true ) do

			if not self.NextPoint then
				local closest, dist
				local pos = self:GetPos()
				for k, v in pairs(grid) do
					local d = pos:Distance(v[1])
					if d < (dist or 99999) then
						closest = k
						dist = d
					end
				end
				if closest then self.NextPoint = closest self.LastPoint = self.NextPoint self:SetNWInt("NextPoint", self.NextPoint) end
			end

			if self.AtPoint then
				self.AtPoint = false
				--self:StartActivity( ACT_IDLE )
				//coroutine.wait(0.5)
			elseif (grid[self.NextPoint] and grid[self.NextPoint][1] and self:GetPos():Distance(grid[self.NextPoint][1])<50) then --or self.WasStuck then
				self.WasStuck = false
				--self:StartActivity( ACT_IDLE )
				self.AtPoint = true
				local BestChoices = table.Copy(grid[self.NextPoint][2])
				if self.LastPoint and #BestChoices > 1 then -- cant go back to original point / go backwards
					table.RemoveByValue(BestChoices,self.LastPoint)
				end
				local nextIs = table.Random(BestChoices)
				self.LastPoint = self.NextPoint
				self.NextPoint = nextIs
				self:SetNWInt("NextPoint", self.NextPoint)
				//coroutine.wait(0.5)
			else
				if not self.Scared then
					self:StartActivity( ACT_WALK )
					self.loco:SetDesiredSpeed( 80 )
				end
				self.Status = self:MoveToPos(grid[self.NextPoint][1])
			end

			if self.Status == "stuck" then
				local BestChoices = table.Copy(grid[self.LastPoint][2])
				BestChoices[self.LastPoint] = nil
				self.NextPoint = table.Random(BestChoices)
				self:SetNWInt("NextPoint", self.NextPoint)
				self.Status = self:MoveToPos(grid[self.NextPoint][1])
			end

			--if self.loco:IsStuck() and not self.WasStuck then self:HandleStuck() self.WasStuck = true end
			--if not self.loco:IsStuck() then self.WasStuck = false end

		end

	end

	--[[while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards(self:GetEnemy():GetPos())	-- Face our enemy
            coroutine.wait(0.1)
        else
            self:StartActivity( ACT_WALK )			-- Walk animation
			self.loco:SetDesiredSpeed( 50 )		-- Walk speed
			if WalkBox[game.GetMap()] then
				local wb1, wb2 = WalkBox[game.GetMap()][1], WalkBox[game.GetMap()][2]
				self:MoveToPos(Vector(math.random(wb1.x,wb2.x),math.random(wb1.y,wb2.y),math.random(wb1.z,wb2.z)))
			end
            self:StartActivity( ACT_IDLE )			-- Idle animation
            coroutine.wait(5)						-- Pause for 2 seconds
    
            coroutine.yield()
            -- The function is done here, but will start back at the top of the loop and make the bot walk somewhere else
		end
		
	end]]

end