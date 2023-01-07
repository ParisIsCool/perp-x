--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

VEHICLE_DATABASE = VEHICLE_DATABASE or {}
local numberLoaded = 0
local totalNumber = 0

function GM:RegisterVehicle( VehicleTable )

	totalNumber = totalNumber+1

	if not VEHICLE_DATABASE[ VehicleTable.ID ] then
		--Msg( "\t-> Loaded " .. VehicleTable.Name .. " - Number: " .. totalNumber .. "\n" )
	end

	if VEHICLE_DATABASE[ VehicleTable.ID ] then VEHICLE_DATABASE[ VehicleTable.ID ] = nil end

	if not VehicleTable.Name then VehicleTable.Name = VehicleTable.Make .. " " .. VehicleTable.Model end
	
	if VehicleTable.WorldModel then
		util.PrecacheModel(VehicleTable.WorldModel)
	end
	
	VEHICLE_DATABASE[ VehicleTable.ID ] = VehicleTable
	
	table.SortByMember( VEHICLE_DATABASE, "Cost", function( a, b ) return a > b end )
end

function ENTITY:GetHeadlightColors()
	//local realColor = HEADLIGHT_COLORS[ self.headLightColor ][1]
	local realColor = self:GetNWString( "hlight_color" )
	if realColor then lightColor = realColor else lightColor = "255 255 225" end
	return lightColor
end

function PLAYER:HasVehicle( VehicleID )
	local PlayerTable
	
	if SERVER then PlayerTable = self.Vehicles else PlayerTable = GAMEMODE.Vehicles end
	
	if PlayerTable[ VehicleID ] then return true end
end

function GM.GetInnerCitySpeedLimit()
	return GetGNWVar( "innercity_speedlimit_i", 35 )
end

function GM.GetOutterCitySpeedLimit()
	return GetGNWVar( "innercity_speedlimit_o", 55 )
end

if SERVER then
	if file.Exists( "perp/bodygroupcache.txt", "DATA" ) then
		GM.BodyGroupsCache = util.JSONToTable( file.Read( "perp/bodygroupcache.txt" ) )
	else
		GM.BodyGroupsCache = {}
	end
else
	GM.BodyGroupsCache = GM.BodyGroupsCache or {}
end

local WhitelistedBG = { "frontbumper", "rearbumper", "skirts", "skirt", "hood", "wing", "wheel", "headlight", "rearlight", "spoiler" }
local BGCorrection = { skirts = "skirt", spoiler = "wing" } -- Thanks TDM you cunt, couldn't fucking keep it as one name, sets to two...
function ENTITY:GetSortedBodyGroups()
	-- Cache to prevent having to call these functions again, I don't know how much resources they use, could be little, could be alot.
	local VehName = self.vehicleTable and self.vehicleTable.ID or nil
	if VehName and GAMEMODE.BodyGroupsCache[ VehName ] then
		return GAMEMODE.BodyGroupsCache[ VehName ]
	end

	local BodyGroups = self:GetBodyGroups()

	local NewBodyGroups = {}
	for _, v in pairs( BodyGroups ) do
		if table.HasValue( WhitelistedBG, v.name ) and v.num - 1 >= 1 then
			local ID 	= v.id
			local Max 	= v.num - 1
			local Name 	= BGCorrection[ v.name ] or v.name

			NewBodyGroups[ Name ] = { ID = ID, Values = Max }
		end
	end

	if VehName then
		GAMEMODE.BodyGroupsCache[ VehName ] = NewBodyGroups
		if SERVER then
			file.Write( "perp/bodygroupcache.txt", util.TableToJSON( GAMEMODE.BodyGroupsCache ) )
		end
	end

	return NewBodyGroups
end

function ENTITY:IsInInnerCity()
	if not InnerCity then return false end
	
	for k, v in pairs( InnerCity ) do
		if table.HasValue( ents.FindInBox( v[1], v[2] ), self ) then
			return true
		end
	end
	return false
end

function ENTITY:IsGovernmentVehicle()
	return self.vehicleTable and self.vehicleTable.RequiredClass and self.vehicleTable.RequiredClass ~= TEAM_ROADSERVICE
end