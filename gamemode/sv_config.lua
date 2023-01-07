--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.ExperienceForCraft = 20					-- Experience given in the SKILL_CRAFTING skill when a new item is mixed.
GM.ExperienceForWoordWorking = 50			-- Experience given in the SKILL_WOODWORKING skill when a new item is mixed.

GM.JobJoin = {}
GM.JobQuit = {}
GM.JobEquips = {}
GM.JobPaydayInfo = {}
GM.DeadPlayers = {}
GM.JailedPlayers = {}
GM.HouseAlarms = {}
GM.AllowOOC = true;

TICKET_PRICE = 500
TAX_INCOME = 15
TAX_SALES = 15

SPRAY_DELAY = 2

JAIL_TIME = 150
JAIL_TIME_WARRENTED = 400
GM.CopReward_Arrest = 250
WARRENT_TIME = 600

MAX_PROPS = 30
MAX_PROPS_VIP = 50
MAX_PROPS_GOLD = 60
MAX_PROPS_ADMIN = 100
MAX_PROPS_SUPERADMIN = 300
MAX_ITEMS_FORSALE = 25

MAX_CAM = 5
MAX_SIGNS = 5

MAX_PROPERTIES = 4
MAX_PROPERTIES_VIP = 5
MAX_PROPERTIES_GOLD = 6

MAX_METH = 7
MAX_SHROOMS = 20

MAX_WEED = 4
MAX_WEED_VIP = 6
MAX_WEED_GOLD = 7

MAX_COCAINE = 4
MAX_COCAINE_VIP = 6
MAX_COCAINE_GOLD = 7


devs = { "STEAM_0:1:", "STEAM_0:0:10" }

if file.Exists( "gtaonline/economy_budget.txt", "GAME" ) then
	GM.CityBudget = tonumber( file.Read( "gtaonline/economy_budget.txt", "GAME" ) )
else
	GM.CityBudget = 0
end

local QUERIES = {} -- Why I do this? Well, I want to see which queries is being used the most

-- Account Data
QUERIES[ "CREATEACCOUNT" ]				= "INSERT INTO `perp_users` (`steamid`,`last_played`) VALUES ('%s','%i');"
QUERIES[ "SELECTACCOUNT" ] 				= "SELECT * FROM `perp_users` WHERE `steamid`='%s' AND `id`='%i';"
QUERIES[ "SELECTID" ] 					= "SELECT * FROM `perp_users` WHERE `steamid`='%s';"
QUERIES[ "SAVEACCOUNT" ] 				= "UPDATE `perp_users` SET `cash`='%d', `time_played`='%d', `last_played`='%d', `items`='%s', `skills`='%s', `genes`='%s', `formulas`='%s', `bank`='%d', `ringtone`='%d', `ammo`='%s', `last_played`='%i', `reputation`='%i' WHERE `id`='%i';"
QUERIES[ "SAVEACCOUNTITEMS" ] 			= "UPDATE `perp_users` SET `items`='%s' WHERE `id`='%i';"

QUERIES[ "UPDATEPLAYERMODEL" ]    		= "UPDATE `perp_users` SET `model`='%s' WHERE `id`='%i';"

QUERIES[ "CHECKUSERNAMEAVAILABLITY" ] 	= "SELECT `steamid` FROM `perp_users` WHERE `rp_name_first`='%s' AND `rp_name_last`='%s' LIMIT 1;"
QUERIES[ "UPDATEUSERNAME" ] 			= "UPDATE `perp_users` SET `rp_name_first`='%s', `rp_name_last`='%s' WHERE `id`='%i';"

-- Blacklist
QUERIES[ "SELECTBLACKLIST" ] 			= "SELECT * FROM `perp_blacklists` WHERE `id`='%s';"
QUERIES[ "INSERTBLACKLIST" ] 			= "INSERT INTO `perp_blacklists` (`id`, `type`, `expire`, `reason`, `adminid`) VALUES('%s', '%s', '%s', '%s', '%s');"
QUERIES[ "INSERTBLACKLIST2" ] 			= "INSERT INTO `perp_blacklists` (`id`, `type`, `expire`, `reason`, `value`, `adminid`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s');"
QUERIES[ "DELETEBLACKLIST" ] 			= "DELETE FROM `perp_blacklists` WHERE `id`='%s' AND `type`='%s';"
QUERIES[ "DELETEBLACKLIST2" ] 			= "DELETE FROM `perp_blacklists` WHERE `id`='%s' AND `type`='%s' AND `value`='%s';"

-- Organisation
QUERIES[ "LOADORGANISATIONS" ] 			= "SELECT `name`, `motd`, `owner`, `perp_organization`.`id`, `rp_name_first`, `rp_name_last` FROM `perp_organization`, `perp_users` WHERE `owner` = perp_users.`id`;"
QUERIES[ "LOADORGANISATIONMEMBERS" ] 	= "SELECT `rp_name_first`, `rp_name_last`, `id` FROM `perp_users` WHERE `organization`='%i';"

QUERIES[ "CREATEORGANISATION" ] 		= "INSERT INTO `perp_organization` (`name`, `motd`, `owner`) VALUES ('New Organization', 'No Current MOTD', '%s');"
QUERIES[ "UPDATEORGANISATION" ] 		= "UPDATE `perp_organization` SET `name`='%s', `motd`='%s' WHERE `id`='%i';"
QUERIES[ "DISBANDORGANISATION" ] 		= "UPDATE `perp_users` SET `organization`='0' WHERE `organization`='%i';"
QUERIES[ "DELETEORGANISATION" ] 		= "DELETE FROM `perp_organization` WHERE `id`='%i'"

QUERIES[ "SETORGANISATION" ] 			= "UPDATE `perp_users` SET `organization`='%i' WHERE `id`='%i';"

QUERIES[ "CHECKORGNAMEAVAILABLITY" ] 	= "SELECT `id` FROM `perp_organization` WHERE `name`='%s' LIMIT 1;"

QUERIES[ "FINDORGMEMBER" ] 				= "SELECT `rp_name_first`, `rp_name_last`, `organization` FROM `perp_users` WHERE `id`='%s';"
QUERIES[ "FINDORGANISATION" ] 			= "SELECT `id` FROM `perp_organization` WHERE `owner`='%s' LIMIT 1;"

-- Warehouse
QUERIES[ "LISTWAREHOUSE" ] 				= "SELECT `itemid`, `amount` FROM `perp_warehouse` WHERE `id`='%i';"
QUERIES[ "INSERTINTOWAREHOUSE" ] 		= "INSERT INTO `perp_warehouse` (`id`, `itemid`, `amount`) VALUES ('%i', '%s', '%s') ON DUPLICATE KEY UPDATE `amount`='%s';"
QUERIES[ "DELETEFROMWAREHOUSE" ] 		= "DELETE FROM `perp_warehouse` WHERE `id`='%i' AND `itemid`='%s';"

-- Vehicles
QUERIES[ "LOADVEHICLES" ]				= "SELECT * FROM `perp_vehicles` WHERE `id`='%i';"

QUERIES[ "CREATEVEHICLE" ]				= "INSERT INTO `perp_vehicles` (`id`, `car_id`) VALUES('%i', '%s');"
QUERIES[ "DELETEVEHICLE" ]				= "DELETE FROM `perp_vehicles` WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "SELECTVEHICLEAUTOINC" ]		= "SELECT `auto_inc` FROM `perp_vehicles` WHERE `id`='%i' and `car_id`='%s' ;"
QUERIES[ "SETVEHICLELICENSEPLATE" ]		= "UPDATE `perp_vehicles` SET `license_plate`='%s' WHERE `id`='%i' and `car_id`='%s';"

QUERIES[ "VEHICLESAVEFUEL" ]			= "UPDATE `perp_vehicles` SET `fuel` ='%i' WHERE `car_id`='%s' AND `id`='%i';"

QUERIES[ "TOGGLEVEHICLE" ]				= "UPDATE `perp_vehicles` SET `disabled`='%i' WHERE `id`='%i' AND `car_id`='%s';"

QUERIES[ "CHANGEVEHICLESKIN" ]			= "UPDATE `perp_vehicles` SET `paint_id`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLEHORN" ]			= "UPDATE `perp_vehicles` SET `custom_horn`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLELIGHTS" ]		= "UPDATE `perp_vehicles` SET `headlight_id`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLEHYDRAULICS" ]	= "UPDATE `perp_vehicles` SET `hydraulics`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLEANTITHEFT" ]		= "UPDATE `perp_vehicles` SET `anti-theft`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLEUNDERGLOW" ]		= "UPDATE `perp_vehicles` SET `underglow`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLETURBO" ]			= "UPDATE `perp_vehicles` SET `turbo`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLELPLATE" ]		= "UPDATE `perp_vehicles` SET `license_plate`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLERGBBODYGROUP" ]	= "UPDATE `perp_vehicles` SET `rgb_colour`='%s', `bodygroups`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLERGB" ]			= "UPDATE `perp_vehicles` SET `rgb_colour`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLEHLRGB" ]			= "UPDATE `perp_vehicles` SET `headlight`='%s' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "CHANGEVEHICLEENGINE" ]		= "UPDATE `perp_vehicles` SET `engine`='%i' WHERE `id`='%i' AND `car_id`='%s';"
QUERIES[ "LOADPHYSCOLORS" ]				= "SELECT `physgun_col` FROM `perp_users` WHERE `id`='%s';"
QUERIES[ "SAVEPHYSCOLORS" ]				= "UPDATE `perp_users` SET `physgun_col`='%s' WHERE `id`='%s';"

-- Achievements
QUERIES[ "SELECT_ACHIEVEMENTS" ] 		= "SELECT `data` FROM `perp_achievements` WHERE `perpid`='%i';"

QUERIES_COUNT = QUERIES_COUNT or {}

function Query( Name )
	if not QUERIES[ Name ] then Error( "Query: " .. Name .. " does not exist!\n" ) end

	QUERIES_COUNT[ Name ] = ( QUERIES_COUNT[ Name ] or 0 ) + 1

	--Msg( "Query: " .. Name .. " is being run.\n" )

	return QUERIES[ Name ] or ""
end

// Default NPC behaviour configs
function NPC_HOVER(NPCEnt)
	while ( true ) do
		-- walk somewhere random
		NPCEnt:StartActivity( ACT_WALK )	-- walk anims
		NPCEnt.loco:SetDesiredSpeed( 75 )	-- walk speeds
		NPCEnt:MoveToPos( NPCEnt.OriginalPos + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 75 )

		NPCEnt:StartActivity( ACT_IDLE )
		NPCEnt:MakeChatBubble()
		coroutine.wait(math.random( 100, 300 ))

		NPCEnt:RemoveChatBubble()

		coroutine.yield()
	end
end

function NPC_IDLE(NPCEnt)
	NPCEnt:MakeChatBubble()

	while ( true ) do
		NPCEnt.loco:SetDesiredSpeed( 75 )	-- walk speeds

		NPCEnt:StartActivity( ACT_IDLE )

		coroutine.yield()
	end
end

// Used for atms,
function NPC_FAKE(NPCEnt)
	while ( true ) do
		NPCEnt.loco:SetDesiredSpeed( 75 )	-- walk speeds

		NPCEnt:StartActivity( ACT_IDLE )

		coroutine.yield()
	end
end

function NPC_DRUGGY(NPCEnt)
    while ( true ) do
    	NPCEnt.Walking = NPCEnt.Walking or true

        -- walk somewhere random
        NPCEnt:StartActivity( ACT_WALK )                            -- walk anims
        NPCEnt.loco:SetDesiredSpeed( 75 )                        -- walk speeds

        // Figure out where the heck we want to go
        local DesiredWalkToID = math.random(1, #GAMEMODE.DrugDealerHangouts)
		local DesiredWalkTo = GAMEMODE.DrugDealerHangouts[DesiredWalkToID][1]

		// We got the same marker as where we were previously? Try until we get a new one.
		while (DesiredWalkTo == NPCEnt.CurrentMarker) do
			DesiredWalkTo = GAMEMODE.DrugDealerHangouts[math.random(1, #GAMEMODE.DrugDealerHangouts)][1]
		end

		// Setup our values
		NPCEnt.CurrentMarker = DesiredWalkTo

		NPCEnt:MoveToPos( NPCEnt.CurrentMarker, {repath = 4})
		NPCEnt:StartActivity( ACT_IDLE )

		NPCEnt:SetPos(GAMEMODE.DrugDealerHangouts[DesiredWalkToID][1])
		NPCEnt:SetAngles(GAMEMODE.DrugDealerHangouts[DesiredWalkToID][2])
		NPCEnt:MakeChatBubble()

		NPCEnt:PlaySequenceAndWait( "Idle_to_Lean_Back" )
		NPCEnt.Walking = false

		coroutine.wait(math.random( 300, 600 ))

		NPCEnt:RemoveChatBubble()
		NPCEnt:PlaySequenceAndWait( "lean_back_to_idle" )
		NPCEnt.Walking = true

        coroutine.yield()
    end
end
