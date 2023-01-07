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

function ENT:Initialize()
	//self:SetModel( "models/preytech/perp/players/npcs/perp_cop.mdl" )
end

function ENT:BehaveAct()
end

function ENT:RunBehaviour()
    self:ActualRun()
end
/*
function ENT:MoveToPos( pos, options )
    local options = options or {}
    local path = Path( "Follow" )
    path:SetMinLookAheadDistance( options.lookahead or 300 )
    path:SetGoalTolerance( options.tolerance or 20 )
    path:Compute( self, pos )

    if ( !path:IsValid() ) then print("FAILED PATH") return "failed" end
    while ( path:IsValid() ) do
        path:Update( self )
        -- Draw the path (only visible on listen servers or single player)
        //if ( options.draw ) then
            path:Draw()
        //end
        
        -- If we're stuck then call the HandleStuck function and abandon
        if ( self.loco:IsStuck() ) then
            self:HandleStuck()
            return "stuck"
        end
        --
        -- If they set maxage on options then make sure the path is younger than it
        --
        if ( options.maxage ) then
            if ( path:GetAge() > options.maxage ) then print("TIMEDOUT") return "timeout" end
        end
        --
        -- If they set repath then rebuild the path every x seconds
        --
        if ( options.repath ) then
            if ( path:GetAge() > options.repath ) then print("REPATH") path:Compute( self, pos ) end
        end
        coroutine.yield()
    end
    return "ok"
end
*/

/*
function ENT:RunBehaviour()
    while ( true ) do
        -- walk somewhere random
        self:StartActivity( ACT_WALK )                            -- walk anims
        self.loco:SetDesiredSpeed( 100 )                        -- walk speeds
        self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 200 ) -- walk to a random place within about 200 units (yielding)


        self:StartActivity( ACT_IDLE )        -- revert to idle activity


        self:PlaySequenceAndWait( "idle_to_sit_ground" )                            -- Sit on the floor
        self:SetSequence( "sit_ground" )                                            -- Stay sitting
        coroutine.wait( self:PlayScene( "scenes/eli_lab/mo_gowithalyx01.vcd" ) )    -- play a scene and wait for it to finish before progressing
        self:PlaySequenceAndWait( "sit_ground_to_idle" )                            -- Get up


        -- find the furthest away hiding spot
        local pos = self:FindSpot( "random", { type = 'hiding', radius = 5000 } )


        -- if the position is valid
        if ( pos ) then
            self:StartActivity( ACT_RUN )                                            -- run anim
            self.loco:SetDesiredSpeed( 200 )                                        -- run speed
            self:PlayScene( "scenes/npc/female01/watchout.vcd" )                    -- shout something while we run just for a laugh
            self:MoveToPos( pos )                                                    -- move to position (yielding)
            self:PlaySequenceAndWait( "fear_reaction" )                                -- play a fear animation
            self:StartActivity( ACT_IDLE )                                            -- when we finished, go into the idle anim
        else
            -- some activity to signify that we didn't find shit
        end
        coroutine.yield()
    end
end
*/

// My hacky way to prevent them from being killed =\
function ENT:OnInjured()
    self:SetHealth(100)
end

function ENT:MakeChatBubble()
    self.Bubble = ents.Create( "npc_bubble" )
    self.Bubble:SetPos( self:GetPos() + Vector( 0, 0, 90 ) )
    self.Bubble:Spawn()
	
	if os.date( "%m" ) == "12" then
		if self.Hat and IsValid(self.Hat) then
			self.Hat:Remove()
			self.Hat = nil
		end
		local attach = self:GetAttachment(self:LookupAttachment("eyes"))
		pos = attach.Pos
		ang = attach.Ang
		ang:RotateAroundAxis(ang:Right(), 0)
		pos = pos + (ang:Forward() * -5.5)
		
		self.Hat = ents.Create( "ent_xmashat" )
		self.Hat:SetPos( pos + Vector( 2, 0, -2 ) )
		self.Hat:SetAngles( ang + Angle( 180, 90, -100 ) )
		self.Hat:Spawn()
	end
end

function ENT:RemoveChatBubble()
    if self.Bubble and IsValid(self.Bubble) then
        self.Bubble:Remove()
        self.Bubble = nil
    end
	
    if self.Hat and IsValid(self.Hat) then
        self.Hat:Remove()
        self.Hat = nil
    end
end

hook.Add( "KeyPress", "NPCUseKeyPress2", function( objPl, key )
	if key == IN_USE then
		local TTable = {}
		TTable.start = objPl:GetShootPos()
		TTable.endpos = TTable.start + objPl:GetAimVector() * 150
		TTable.filter = objPl
		TTable.mask = MASK_OPAQUE_AND_NPCS
		
		local Tr = util.TraceLine( TTable )

		if IsValid( Tr.Entity ) and Tr.Entity:GetClass() == "npc_nextbot" and Tr.Entity.NPCID then
            if Tr.Entity.Walking then
                objPl.LastNotBuddiesWarning = objPl.LastNotBuddiesWarning or 0
        
                if objPl.LastNotBuddiesWarning + 2 < CurTime() then
                    objPl.LastNotBuddiesWarning = CurTime()
                    return objPl:ChatPrint( "The citizen ignores you and keeps walking." )
                end
            end

			GAMEMODE.NPCUsed( objPl, Tr.Entity.NPCID )
		end
	end
end )