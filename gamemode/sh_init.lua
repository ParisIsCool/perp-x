--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

PLAYER = debug.getregistry().Player
ENTITY = debug.getregistry().Entity
VIEW_LOCK = 999

include( "sh_config.lua" ) 
include( "sh_player.lua" )

function ENTITY:CanBeSold()
	return self:GetClass() == "ent_item"
end

function util.FormatNumber( n )
	if not n or type( n ) ~= "number" then return 0 end

	if n >= 1e14 then return tostring( n ) end
	n = tostring( n )
	sep = sep or ","
	local dp = string.find( n, "%." ) or #n + 1
	for i = dp - 4, 1, -3 do
		n = n:sub( 1, i ) .. sep .. n:sub( i + 1 )
	end

	return n
end

print("Loading Job Modules...")
include( "sh_jobs.lua" )
AddCSLuaFile( "sh_jobs.lua" )
local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/jobs/*.lua", "LUA" )
for _, v in pairs( Files ) do include( "jobs/" .. v ) AddCSLuaFile( "jobs/" .. v ) end

Msg( "Loading Shared Modules...\n" )

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/sh_modules/*.lua", "LUA" )
for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/sh_modules/" .. v ) end

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/sh_modules/achievements/*.lua", "LUA" )
for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/sh_modules/achievements/" .. v ) end

Msg( "Loading Map Data...\n" )

local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/maps/*.lua", "LUA" )
for _, v in pairs( Files ) do
	if v:lower():find( game.GetMap():lower() ) then
		if SERVER then
			if string.Left( v, 3 ) == "sv_" then
				include( FOLDER_NAME .. "/gamemode/maps/" .. v )
			elseif string.Left( v, 3 ) == "cl_" then
				AddCSLuaFile( FOLDER_NAME .. "/gamemode/maps/" .. v )
			else
				include( FOLDER_NAME .. "/gamemode/maps/" .. v )
				AddCSLuaFile( FOLDER_NAME .. "/gamemode/maps/" .. v )
			end
		else
			include( FOLDER_NAME .. "/gamemode/maps/" .. v )
		end
	end
end

local function LoadEverything()
	Msg( "Loading Items...\n" )

	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/items/*", "LUA" )
	for _, v in pairs( Folders ) do
		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/items/" .. v .. "/*.lua", "LUA" )
		for _, i in pairs( Files ) do
			if SERVER then
				if string.Left( i, 3 ) ~= "cl_" then
					include( FOLDER_NAME .. "/gamemode/items/" .. v .. "/" .. i )
					if string.Left( i, 3 ) == "sh_" then
						AddCSLuaFile( FOLDER_NAME .. "/gamemode/items/" .. v .. "/" .. i )
					end
				end
			else
				if string.Left( i, 3 ) ~= "sv_" then
					include( FOLDER_NAME .. "/gamemode/items/" .. v .. "/" .. i )
				end
			end

		end
	end

	Msg( "Loading Shops...\n" )
	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/shops/*.lua", "LUA" )
	for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/shops/" .. v ) end

	Msg( "Loading Mixtures...\n" )
	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/mixtures/*.lua", "LUA" )
	for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/mixtures/" .. v ) end

	Msg( "Loading Vehicles...\n" )
	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vehicles/*.lua", "LUA" )
	for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/vehicles/" .. v ) end

	Msg( "Loading VIP Vehicles...\n" )
	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vehicles/vip/*.lua", "LUA" )
	for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/vehicles/vip/" .. v ) end

	Msg( "Loading Properties...\n" )
	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/properties/" .. game.GetMap():lower() .. "/*.lua", "LUA" )
	for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/properties/" .. game.GetMap():lower() .. "/" .. v ) end

	Msg( "Loading NPCs...\n" )
	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/npcs/*.lua", "LUA" )
	for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/npcs/" .. v ) end
end

concommand.Add("perp_reload_vehicles_cl", function(ply)
	Msg( "Reloading Vehicles...\n" )
	local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vehicles/*.lua", "LUA" )
	for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/vehicles/" .. v ) end
end)

concommand.Add("perp_reload_clientside_scripts", function(ply)
	if CLIENT then
		Msg( "Reloading Clientside Modules...\n" )
		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/cl_modules/*.lua", "LUA" )
		for _, v in pairs( Files ) do include( "cl_modules/" .. v ) end

		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vgui/*.lua", "LUA" )
		for _, v in pairs( Files ) do include( "vgui/" .. v ) end

		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/cl_modules/scoreboard/*.lua", "LUA")
		for _, v in pairs ( Files ) do include( "cl_modules/scoreboard/" .. v) end

		Msg( "Reloading Vehicles...\n" )
		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vehicles/*.lua", "LUA" )
		for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/vehicles/" .. v ) end

		Msg( "Reloading Shared Modules...\n" )
		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/sh_modules/*.lua", "LUA" )
		for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/sh_modules/" .. v ) end

		LoadEverything()
	end
end)

// Remove map entities

for k, ent in pairs(ents.FindByClass("env_soundscape")) do ent:Remove() end

hook.Add( "InitPostEntity", "LoadEverything", function() timer.Simple( 0, LoadEverything ) end )
hook.Add( "OnReloaded", "LoadEverythingDelay", function() timer.Simple( 0, LoadEverything ) end ) -- one frame later, let all stuff be cleared up first.

function string.FormattedTime( seconds, Format )
    if not seconds then seconds = 0 end
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds / 60) % 60)
    local millisecs = ( seconds - math.floor( seconds ) ) * 100
    seconds = seconds % 60

    if Format then
        return string.format( Format, minutes, seconds, millisecs )
    else
        return { h=hours, m=minutes, s=seconds, ms=millisecs }
    end
end