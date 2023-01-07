AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

function ENT:Initialize()

	self:SetModel( "models/player/christmas/santa_npc.mdl" )
    
    self.LoseTargetDist	= 200	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 200	-- How far to search for enemies

	if SERVER then
		self:SetMaxHealth(1)
		self:SetHealth(999999999)
	end
    
    --self:SetUseType( SIMPLE_USE )

end

function ENT:OnTakeDamage( dmginfo )
	self:SetHealth(999999999)
end

if SERVER then
    util.AddNetworkString("StartSantaScripts")
    local inputtime = 0
    function ENT:AcceptInput( name, activator, caller )
        if CurTime() < inputtime then return end
        if name == "Use" and IsValid( activator ) and activator:IsPlayer() then
            inputtime = CurTime() + 1
            net.Start( "StartSantaScripts" )
            net.Send( activator )
        end
    end
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

----------------------------------------------------
-- ENT:RunBehaviour()
-- This is where the meat of our AI is
----------------------------------------------------

local WalkBox = {}
WalkBox["rp_rockford_v2b"] = {
	Vector( -4946, -7516, 0 ),
	Vector( -5206, -7452, 0 )
}

function ENT:RunBehaviour()
	-- This function is called when the entity is first spawned, it acts as a giant loop that will run as long as the NPC exists
	while ( true ) do
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
		
	end

end