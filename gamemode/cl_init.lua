--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

include( "sh_init.lua" )

// cinema
include( 'shared.lua' )

include( "cl_hooks.lua" )
include( "cl_player.lua" )

--include( "cl_scoreboards.lua" );

include("cl_modules/hudmaps/"..game.GetMap()..".lua")
local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/cl_modules/*.lua", "LUA" )
for _, v in pairs( Files ) do include( "cl_modules/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vgui/*.lua", "LUA" )
for _, v in pairs( Files ) do include( "vgui/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/cl_modules/scoreboard/*.lua", "LUA")
for _, v in pairs ( Files ) do include( "cl_modules/scoreboard/" .. v) end

function DollarSign()
	return "$"
end


// Fonts
surface.CreateFont("movietheater", {
	font="coalition",
	size=ScaleToWideScreen(128),
	weight=100,
	antialias=true
})

local ClientMultiRender = GetConVar( "perp2_multicore" )

//new rediredcts - USED TO SET CLIENT gmod_mcore_test 1
function GM:OnEntityCreated(entity)
	if (IsValid(entity) and entity == LocalPlayer()) then
		--timer.Simple(3, function() LocalPlayer():ConCommand("connect 74.91.113.63:27015") end)
	end
	
	if ClientMultiRender:GetInt() == 1 and (IsValid(entity) and entity == LocalPlayer()) then
		timer.Simple(1, function() 
		
			--LocalPlayer():ConCommand("gmod_mcore_test 1") //just testing!
		
			LocalPlayer():ConCommand("gmod_mcore_test 1")
			LocalPlayer():ConCommand("r_queued_ropes 1")
			LocalPlayer():ConCommand("cl_threaded_bone_setup 1")
			LocalPlayer():ConCommand("cl_threaded_client_leaf_system 1")
			LocalPlayer():ConCommand("mat_queue_mode -1")
			LocalPlayer():ConCommand("r_threaded_renderables 1")
			LocalPlayer():ConCommand("r_threaded_particles 1")
			LocalPlayer():ConCommand("M9KGasEffect 0")
			hook.Run("ReceiveTimeSyncServer")
		
		end)
	elseif ClientMultiRender:GetInt() == 0 and (IsValid(entity) and entity == LocalPlayer()) then
		timer.Simple(1, function() 
		
			--LocalPlayer():ConCommand("gmod_mcore_test 0") //just testing!
		
			LocalPlayer():ConCommand("gmod_mcore_test 0")
			LocalPlayer():ConCommand("r_queued_ropes 0")
			LocalPlayer():ConCommand("cl_threaded_bone_setup 0")
			LocalPlayer():ConCommand("cl_threaded_client_leaf_system 0")
			LocalPlayer():ConCommand("mat_queue_mode 0")
			LocalPlayer():ConCommand("r_threaded_renderables 0")
			LocalPlayer():ConCommand("r_threaded_particles 0")
			LocalPlayer():ConCommand("M9KGasEffect 1")
			hook.Run("ReceiveTimeSyncServer")
		
		end)
	end
end

-- fixes for bullshit bugs
function PLAYER:GetTool()
    return nil
end
if not ConVarExists ("dv_route_showalways") then
    CreateClientConVar("dv_route_showalways", "0", false, false)
end

function GM:NetworkEntityCreated( ent )

	--
	-- If the entity wants to use a spawn effect
	-- then create a propspawn effect if the entity was
	-- created within the last second (this function gets called
	-- on every entity when joining a server)
	--

	if ( ent:GetSpawnEffect() && ent:GetCreationTime() > ( CurTime() - 1.0 ) ) then
	
		local ed = EffectData()
		ed:SetEntity( ent )
		util.Effect( "propspawn", ed, true, true )

	end

end