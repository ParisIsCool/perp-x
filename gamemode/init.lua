--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local hostnames = {
    "PERP X - Modern Roleplay | Free Physgun - aSocket.net/discord",
    "PERP X - Modern Roleplay | Free Physgun | Summer Showdown - aSocket.net/discord",
}
local curhostname = 1
timer.Create("Hostname_Changer", 10, 0, function()
	curhostname = curhostname + 1
	if not hostnames[curhostname] then curhostname = 1 end
	RunConsoleCommand("hostname", hostnames[curhostname])
end)

RunConsoleCommand("cw_disable_all_attachments_on_spawn")

local function MessageAll(message)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint(message)
		v:Notify(message)
	end
end

local function RestartCountdown(Text)
	local n = 15
	timer.Create("MapChangerThink", 1, 15, function()
		MessageAll(Text .. n .. " seconds!")
		n = n - 1
	end)
end

local MapChange = {}
MapChange["4:0:0"] = {Text="The server will be restarting in 1 hour and will switch to the day map!",DoHUD=false}
MapChange["4:15:0"] = {Text="The server will be restarting in 45 minutes and will switch to the day map!",DoHUD=false}
MapChange["4:30:0"] = {Text="The server will be restarting in 30 minutes and will switch to the day map!",DoHUD=true}
MapChange["4:45:0"] = {Text="The server will be restarting in 15 minutes and will switch to the day map!",DoHUD=true}
MapChange["4:55:0"] = {Text="The server will be restarting in 5 minutes and will switch to the day map!",DoHUD=true}
MapChange["4:59:0"] = {Text="The server will be restarting in 1 minute and will switch to the day map!",DoHUD=true}
MapChange["4:59:43"] = {CountdownText="The server will restart in ",DoCountdown=true,Retry=true}
MapChange["17:30:0"] = {Text="The server will changing to the night map in 1 hour!",DoHUD=false}
MapChange["17:45:0"] = {Text="The server will changing to the night map in 45 minutes!",DoHUD=false}
MapChange["18:0:0"] = {Text="The server will changing to the night map in 30 minutes!",DoHUD=true}
MapChange["18:15:0"] = {Text="The server will changing to the night map in 15 minutes!",DoHUD=true}
MapChange["18:25:0"] = {Text="The server will changing to the night map in 5 minutes!",DoHUD=true}
MapChange["18:29:0"] = {Text="The server will changing to the night map in 1 minute!",DoHUD=true}
MapChange["18:29:43"] = {CountdownText="The server will change levels in ",DoCountdown=true,Retry=false,MapChange="rp_southside"}

-- Ensure folders are available, thanks garry for removing automatic folder creation...
-- More checks in system_misc.lua
if not file.IsDir( "perp", "DATA" ) then file.CreateDir( "perp" ) end
if not file.IsDir( "perp_logs", "DATA" ) then file.CreateDir( "perp_logs" ) end
if not file.IsDir( "gtaonline", "DATA" ) then file.CreateDir( "gtaonline" ) end
if not file.IsDir( "gtaonline_logs", "DATA" ) then file.CreateDir( "gtaonline_logs" ) end

timer.Create("MapChangerThink", 1, 0, function()
	local Timestamp = os.time()
	local time = tonumber(os.date( "%H:%M:%S", Timestamp ))

	if MapChange[time] then
		if MapChange[time].Text then
			MessageAll(MapChange[time].Text)
		end
		if MapChange[time].DoHUD then
			net.Start( "restartin" )
			net.WriteBool(true)
			local RestartIn = os.time() + 30 * 60
			net.WriteInt( ( RestartIn - os.time() ), 32 )
			net.Broadcast()
		end
		if MapChange[time].DoCountdown then
			RestartCountdown(MapChange[time].CountdownText)
			timer.Simple(14, function()
				for k, v in pairs(player.GetAll()) do
					if MapChange[time].Retry then
						v:ConCommand("retry")
					end
					if MapChange[time].MapChange then
						RunConsoleCommand("changelevel", MapChange[time].MapChange)
					end
				end
			end)
		end
	end
end)

-- BEFORE LOADING, WE CAN CANCELL IF ON THE WRONG MAP
local Timestamp = os.time()
local hour = tonumber(os.date( "%H", Timestamp ))
local minute = tonumber(os.date( "%M", Timestamp ))
if not StartedGamemodeOnce and game.oldGetMap() == "rp_southside_day" and (hour >= 18 or hour < 5) then
	if hour == 18 and minute < 30 then goto skip end
	-- restart to night map
	print("RESTARTING SERVER > > > GAME STARTED ON DAY MAP DURING THE NIGHT")
	RunConsoleCommand("changelevel", "rp_southside")
	hook.Add("Think", "FUCKINGRESTARTPLS", function()
		print("Restarting to proper map.")
		RunConsoleCommand("changelevel", "rp_southside")
	end)
	return
end
::skip::
StartedGamemodeOnce = true

include( "sh_init.lua" )
include( "sv_config.lua" )
include( "mysql.lua" )
include( "sv_hooks.lua" )
include( "sv_player.lua" )

function DollarSign()
	return "$"
end

print("Loading Serverside Modules...")
local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/sv_modules/*.lua", "LUA" )
for _, v in pairs( Files ) do if v != "sv_hooks.lua" then include( "sv_modules/" .. v ) end end

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_player.lua" )
AddCSLuaFile( "cl_hooks.lua" )
AddCSLuaFile( "sh_init.lua" )
AddCSLuaFile( "sh_player.lua" )
AddCSLuaFile( "sh_config.lua" )

// cinema
include( 'shared.lua' )

AddCSLuaFile( 'sh_load.lua' )
AddCSLuaFile( 'shared.lua' )

AddCSLuaFile("cl_modules/hudmaps/"..game.GetMap()..".lua")
local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/cl_modules/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "cl_modules/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/cl_modules/scoreboard/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "cl_modules/scoreboard/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/sh_modules/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "sh_modules/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/sh_modules/achievements/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "sh_modules/achievements/" .. v ) end


local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/sh_modules/weather/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "sh_modules/weather/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vgui/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "vgui/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/items/*", "LUA" )
for _, v in pairs( Folders ) do
	if not v:find( "[.]" ) then
		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/items/" .. v .. "/*.lua", "LUA" )
		for _, i in pairs( Files ) do
			if string.Left( i, 3 ) ~= "sv_" then
				AddCSLuaFile( "items/" .. v .. "/" .. i )
			end
		end
	end
end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/npcs/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "npcs/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/shops/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "shops/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/mixtures/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "mixtures/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/properties/" .. game.GetMap():lower() .. "/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "properties/" .. game.GetMap():lower() .. "/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vehicles/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "vehicles/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vehicles/vip/*.lua", "LUA" )
for _, v in pairs( Files ) do AddCSLuaFile( "vehicles/vip/" .. v ) end

include("postload.lua")