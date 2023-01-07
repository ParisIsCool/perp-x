--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

--[[
███████████████████████████████████████████████████████████████████████████████████████
█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░█████████░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█
█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░█████████░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
█░░▄▀░░░░░░▄▀░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░█████████░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█
█░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░█████████
█░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░░░░░█
█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀░░█
█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░░░░░█
█░░▄▀░░█████████░░▄▀░░██░░▄▀░░█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░█████████
█░░▄▀░░█████████░░▄▀░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█
█░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
█░░░░░░█████████░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█
███████████████████████████████████████████████████████████████████████████████████████
]]
local JOB = {}

JOB.ID = 2
TEAM_POLICE = JOB.ID
JOB.NPC = {11}
JOB.Name = "Police Officer"
JOB.Color = Color( 0, 0, 255, 255 )

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 5
JOB.Pay = 100
JOB.GovOfficial = true
JOB.Armor = 100
JOB.RequiredTime = 2
JOB.VIP = false
JOB.CanUsePersonalVehicle = false
JOB.WelcomeMessage = "Welcome to the force."
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
    ["pistol"] = 70,
    ["ammo_stungun"] = 20 
}
JOB.Guns = {
    "khr_p226",
    "weapon_perp_nightstick",
    "weapon_perp_battering_ram",
    "weapon_perp_handcuffs",
    "weapon_perp_car_radar",
    "stungun",
    "weapon_perp_car_ticket_regular",
    "vc_spikestrip_wep",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(8224,8609,288), Angle(0,0,0)},
	{Vector(8455,8836,288), Angle(0,-90,0)},
	{Vector(8651,8601,288), Angle(0,180,0)},
	{Vector(8366,8128,200), Angle(0,-90,0)},
	{Vector(8718,7812,200), Angle(0,-180,0)},
	{Vector(8095,8116,200), Angle(0,-90,0)},
	{Vector(8061,8023,200), Angle(0,-90,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
    { Vector( -8855.1435546875, -5039.87890625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8785.3896484375, -5064.4799804688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8730.619140625, -5147.0434570313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8678.1005859375, -5194.3544921875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8639.3466796875, -5324.3706054688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8625.2255859375, -5430.9375, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8799.1923828125, -5372.9223632813, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8831.0693359375, -5444.6625976563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8692.033203125, -5432.4516601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8694.111328125, -5279.3466796875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8500.7822265625, -5132.7016601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8375.896484375, -5142.40625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8346.3154296875, -5257.4653320313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8472.3359375, -5246.0986328125, 8.0312538146973 ), Angle( 18.700, -83.419, 0.000 )},
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/humans/ecpdofficer/hellzone/male_01.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/humans/ecpdofficer/hellzone/male_02.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/humans/ecpdofficer/hellzone/male_03.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/humans/ecpdofficer/hellzone/male_04.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/humans/ecpdofficer/hellzone/male_05.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/humans/ecpdofficer/hellzone/male_06.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/humans/ecpdofficer/hellzone/male_07.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/humans/ecpdofficer/hellzone/male_08.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/humans/ecpdofficer/hellzone/male_09.mdl"
 
JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/humans/ecpdofficer/hellzone/female_01.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/humans/ecpdofficer/hellzone/female_02.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/humans/ecpdofficer/hellzone/female_03.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/humans/ecpdofficer/hellzone/female_04.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/humans/ecpdofficer/hellzone/female_05.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/humans/ecpdofficer/hellzone/female_06.mdl"

JOB.Vehicles = {
    {
        ID = "07CrownVic",
        Make = "Ford",
        Model = "Crown Vic Police Intercepter '07",
        Nickname = "Crown Vic Police Intercepter",
        Script = "scripts/vehicles/sentry/07crownvic.txt",
        WorldModel = "models/sentry/07crownvic_cvpi.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,130,20),0.115,Angle(0,180,90)},
            {Vector(0,-111,36.5),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "17FordF150Raptor",
        Make = "Ford",
        Model = "F-150 Raptor Police",
        Nickname = "Big F-150 Raptor",
        Script = "scripts/vehicles/sentry/17raptor.txt",
        WorldModel = "models/sentry/17raptor_cop.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        AdminOnly = true,
        PlatePos = {
            {Vector(0,134,29),0.115,Angle(0,180,90)},
            {Vector(0,-119.5,35),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "DodgeChargerRTIntecepterr",
        Make = "Dodge",
        Model = "Charger RT '15",
        Nickname = "Dodge Charger RT",
        Script = "scripts/vehicles/lwcars/dodge_charger_2015_police.txt",
        WorldModel = "models/lonewolfie/dodge_charger_2015_police.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,-127,29.5),0.115,Angle(0,0,85)},
        }
    },
    {
        ID = "ChevySuburban",
        Make = "Chevrolet",
        Model = "Suburban",
        Nickname = "Chevy Suburban",
        Script = "scripts/vehicles/lwcars/chev_suburban.txt",
        WorldModel = "models/lonewolfie/chev_suburban_pol.mdl",
        Skin = "1",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,138,23),0.115,Angle(0,180,90)},
            {Vector(0,-129.5,47),0.115,Angle(0,0,90)},
        } 
    },
}
VEHICLE_DATABASE = VEHICLE_DATABASE or {}
for k, v in pairs(JOB.Vehicles) do
    v.Name = v.Make .. " " .. v.Model
    VEHICLE_DATABASE[v.ID] = v
    util.PrecacheModel(v.WorldModel)
end

JOB.VehicleSpawns = {
    {Vector(7845,7699,-128), Angle(0,-90,0)},
	{Vector(7843,7897,-128), Angle(0,-90,0)},
	{Vector(7839,8158,-128), Angle(0,-90,0)},
	{Vector(7837,8344,-128), Angle(0,-90,0)},
	{Vector(8707,8808,-128), Angle(0,-270,0)},
	{Vector(8709,8636,-128), Angle(0,-270,0)},
	{Vector(8681,8376,-128), Angle(0,-270,0)},
	{Vector(8666,8181,-128), Angle(0,-270,0)},
}

JOB.VehicleNPC = {133}

JOB.MaxVehicles = 8

GM:RegisterJob( JOB )



--[[
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
─████████████───██████████████─██████████████─██████████████─██████████████─██████████████─██████████─██████──██████─██████████████─
─██░░░░░░░░████─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░██─██░░██──██░░██─██░░░░░░░░░░██─
─██░░████░░░░██─██░░██████████─██████░░██████─██░░██████████─██░░██████████─██████░░██████─████░░████─██░░██──██░░██─██░░██████████─
─██░░██──██░░██─██░░██─────────────██░░██─────██░░██─────────██░░██─────────────██░░██───────██░░██───██░░██──██░░██─██░░██─────────
─██░░██──██░░██─██░░██████████─────██░░██─────██░░██████████─██░░██─────────────██░░██───────██░░██───██░░██──██░░██─██░░██████████─
─██░░██──██░░██─██░░░░░░░░░░██─────██░░██─────██░░░░░░░░░░██─██░░██─────────────██░░██───────██░░██───██░░██──██░░██─██░░░░░░░░░░██─
─██░░██──██░░██─██░░██████████─────██░░██─────██░░██████████─██░░██─────────────██░░██───────██░░██───██░░██──██░░██─██░░██████████─
─██░░██──██░░██─██░░██─────────────██░░██─────██░░██─────────██░░██─────────────██░░██───────██░░██───██░░░░██░░░░██─██░░██─────────
─██░░████░░░░██─██░░██████████─────██░░██─────██░░██████████─██░░██████████─────██░░██─────████░░████─████░░░░░░████─██░░██████████─
─██░░░░░░░░████─██░░░░░░░░░░██─────██░░██─────██░░░░░░░░░░██─██░░░░░░░░░░██─────██░░██─────██░░░░░░██───████░░████───██░░░░░░░░░░██─
─████████████───██████████████─────██████─────██████████████─██████████████─────██████─────██████████─────██████─────██████████████─
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
]]


local JOB = {}

JOB.ID = 7
TEAM_DETECTIVE = JOB.ID
JOB.NPC = {11}
JOB.Name = "Detective"
JOB.Color = Color( 52, 216, 25)

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 5
JOB.Pay = 100
JOB.GovOfficial = true
JOB.Armor = 100
JOB.RequiredTime = 6
JOB.VIP = false
JOB.CanUsePersonalVehicle = true
JOB.WelcomeMessage = "Be mighty and silent!"
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
    ["pistol"] = 70,
    ["ammo_stungun"] = 20 
}
JOB.Guns = {
    "khr_p226",
    "weapon_perp_nightstick",
    "weapon_perp_battering_ram",
    "weapon_perp_handcuffs",
    "weapon_perp_car_radar",
    "stungun",
    "weapon_perp_car_ticket_regular",
    "vc_spikestrip_wep",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(8224,8609,288), Angle(0,0,0)},
	{Vector(8455,8836,288), Angle(0,-90,0)},
	{Vector(8651,8601,288), Angle(0,180,0)},
	{Vector(8366,8128,200), Angle(0,-90,0)},
	{Vector(8718,7812,200), Angle(0,-180,0)},
	{Vector(8095,8116,200), Angle(0,-90,0)},
	{Vector(8061,8023,200), Angle(0,-90,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
    { Vector( -8855.1435546875, -5039.87890625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8785.3896484375, -5064.4799804688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8730.619140625, -5147.0434570313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8678.1005859375, -5194.3544921875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8639.3466796875, -5324.3706054688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8625.2255859375, -5430.9375, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8799.1923828125, -5372.9223632813, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8831.0693359375, -5444.6625976563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8692.033203125, -5432.4516601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8694.111328125, -5279.3466796875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8500.7822265625, -5132.7016601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8375.896484375, -5142.40625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8346.3154296875, -5257.4653320313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8472.3359375, -5246.0986328125, 8.0312538146973 ), Angle( 18.700, -83.419, 0.000 )},
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/player/zelpa/male_01_extended.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/zelpa/male_02_extended.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/player/zelpa/male_03_extended.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/zelpa/male_04_extended.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/zelpa/male_05_extended.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/zelpa/male_06_extended.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/zelpa/male_07_extended.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/zelpa/male_08_extended.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/zelpa/male_09_extended.mdl"
 
JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/player/zelpa/female_01_extended.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/player/zelpa/female_02_extended.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/player/zelpa/female_03_extended.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/player/zelpa/female_04_extended.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/player/zelpa/female_07_extended.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/player/zelpa/female_06_extended.mdl"


JOB.Bodygroups = {
	[SEX_MALE] = {
		["Shirt"] = {
			ID = 1,
			Submodels = {
				{0, "Button Up 1"},
				{1, "Button Up 2"},
				{4, "Button Up 3"},
				{10, "Button Up 4"},
				{11, "Button Up 5"},
				{12, "Button Up 6"},
				{13, "Button Up 7"},
				{14, "Button Up 8"},
				{2, "Blue Sweater"},
				{3, "White Sweater"},
				{5, "Vest"},
				{6, "Vest 2"},
				{7, "Medical Vest"},
				{8, "Medical Vest 2"},
				{9, "Medical Sweater"},
				{15, "Blue Jacket"},
				{16, "Teal Jacket"},
				{17, "Red Jacket"},
				{18, "Grey Jacket"},
				{19, "Brown Jacket"},
				{20, "Tan jacket"},
			}
		},
		["Pants"] = {
			ID = 2,
			Submodels = {
				{0, "Blue Jeans"},
				{1, "Dark Jeans"},
				{2, "Worn Jeans"},
				{3, "Holster Jeans"},
				{4, "Holster Jeans 2"},
				{5, "Dirty Jeans"},
				{6, "Cowboy Jeans"},
			}
		},
		["Hands"] = {
			ID = 3,
			Submodels = {
				{0, "No Gloves"},
				{1, "Fingerless Gloves"},
				{2, "Gloves"},
			}
		},
		["Beanie"] = {
			ID = 4,
			Submodels = {
				{0, "No Beanie"},
				{1, "Blue Beanie"},
				{2, "Green Benie"},
			}
		},
		["Glasses"] = {
			ID = 5,
			Submodels = {
				{0, "No Glasses"},
				{1, "Glasses"},
			}
		},
	},
	[SEX_FEMALE] = {
		["Shirt"] = {
			ID = 1,
			Submodels = {
				{0, "Button Up 1"},
				{1, "Button Up 2"},
				{4, "Button Up 3"},
				{10, "Button Up 4"},
				{11, "Button Up 5"},
				{12, "Button Up 6"},
				{13, "Button Up 7"},
				{14, "Button Up 8"},
				{2, "Blue Sweater"},
				{3, "White Sweater"},
				{5, "Vest"},
				{6, "Vest 2"},
				{7, "Medical Vest"},
				{8, "Medical Vest 2"},
				{9, "Medical Sweater"},
				{15, "Blue Jacket"},
				{16, "Teal Jacket"},
				{17, "Red Jacket"},
			}
		},
		["Pants"] = {
			ID = 2,
			Submodels = {
				{0, "Blue Jeans"},
				{1, "Dark Jeans"},
				{2, "Worn Jeans"},
				{3, "Holster Jeans"},
				{4, "Holster Jeans 2"},
				{5, "Dirty Jeans"},
				{6, "Cowboy Jeans"},
			}
		},
		["Hands"] = {
			ID = 3,
			Submodels = {
				{0, "No Gloves"},
				{1, "Fingerless Gloves"},
				{2, "Gloves"},
			}
		},
		["Glasses"] = {
			ID = 4,
			Submodels = {
				{0, "No Glasses"},
				{1, "Glasses"},
			}
		},
	}
}

JOB.Vehicles = {
    {
        ID = "07CrownVicDet",
        Make = "Ford",
        Model = "Crown Vic Police Intercepter '07",
        Nickname = "Crown Vic Police Intercepter",
        Script = "scripts/vehicles/sentry/07crownvic.txt",
        WorldModel = "models/sentry/07crownvic_cvpi.mdl",
        Skin = 1,
        BodyGroups = {[1]=2,[2]=1},
        Color = Color(0,0,0),
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,130,20),0.115,Angle(0,180,90)},
            {Vector(0,-111,36.5),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "17FordF150RaptorDet",
        Make = "Ford",
        Model = "F-150 Raptor Police",
        Nickname = "Big F-150 Raptor",
        Script = "scripts/vehicles/sentry/17raptor.txt",
        WorldModel = "models/sentry/17raptor_cop.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        AdminOnly = true,
        PlatePos = {
            {Vector(0,134,29),0.115,Angle(0,180,90)},
            {Vector(0,-119.5,35),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "DodgeChargerRTIntecepterrDet",
        Make = "Dodge",
        Model = "Charger RT '15",
        Nickname = "Dodge Charger RT",
        Script = "scripts/vehicles/lwcars/dodge_charger_2015_police.txt",
        WorldModel = "models/lonewolfie/dodge_charger_2015_police.mdl",
        Skin = "1",
        RequiredClass = JOB.ID,
        Color = Color(22,22,22),
        PlatePos = {
            {Vector(0,-127,29.5),0.115,Angle(0,0,85)},
        }
    },
    {
        ID = "ChevyTahoeDet",
        Make = "Chevrolet",
        Model = "Tahoe",
        Nickname = "Chevy Tahoe",
        Script = "scripts/vehicles/lwcars/chev_tahoe.txt",
        WorldModel = "models/lonewolfie/chev_tahoe_police.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,115,20),0.115,Angle(0,180,95)},
            {Vector(0,-114,46.5),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "ChevySuburbanDet",
        Make = "Chevrolet",
        Model = "Suburban",
        Nickname = "Chevy Suburban",
        Script = "scripts/vehicles/lwcars/chev_suburban.txt",
        WorldModel = "models/lonewolfie/chev_suburban_pol.mdl",
        Skin = "3",
        RequiredClass = JOB.ID,
        Color = Color(11,11,11),
        PlatePos = {
            {Vector(0,138,23),0.115,Angle(0,180,90)},
            {Vector(0,-129.5,47),0.115,Angle(0,0,90)},
        } 
    },
}
VEHICLE_DATABASE = VEHICLE_DATABASE or {}
for k, v in pairs(JOB.Vehicles) do
    v.Name = v.Make .. " " .. v.Model
    VEHICLE_DATABASE[v.ID] = v
    util.PrecacheModel(v.WorldModel)
end

JOB.VehicleSpawns = {
    {Vector(7845,7699,-128), Angle(0,-90,0)},
	{Vector(7843,7897,-128), Angle(0,-90,0)},
	{Vector(7839,8158,-128), Angle(0,-90,0)},
	{Vector(7837,8344,-128), Angle(0,-90,0)},
	{Vector(8707,8808,-128), Angle(0,-270,0)},
	{Vector(8709,8636,-128), Angle(0,-270,0)},
	{Vector(8681,8376,-128), Angle(0,-270,0)},
	{Vector(8666,8181,-128), Angle(0,-270,0)},
}

JOB.VehicleNPC = {133}

JOB.MaxVehicles = 8

GM:RegisterJob( JOB )


--[[
────────────────────────────────────────────────────────────────────────
─██████████████─██████──██████─██████████─██████████████─██████████████─
─██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─
─██░░██████████─██░░██──██░░██─████░░████─██░░██████████─██░░██████████─
─██░░██─────────██░░██──██░░██───██░░██───██░░██─────────██░░██─────────
─██░░██─────────██░░██████░░██───██░░██───██░░██████████─██░░██████████─
─██░░██─────────██░░░░░░░░░░██───██░░██───██░░░░░░░░░░██─██░░░░░░░░░░██─
─██░░██─────────██░░██████░░██───██░░██───██░░██████████─██░░██████████─
─██░░██─────────██░░██──██░░██───██░░██───██░░██─────────██░░██─────────
─██░░██████████─██░░██──██░░██─████░░████─██░░██████████─██░░██─────────
─██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░██─██░░░░░░░░░░██─██░░██─────────
─██████████████─██████──██████─██████████─██████████████─██████─────────
────────────────────────────────────────────────────────────────────────
]]


local JOB = {}

JOB.ID = 6
TEAM_CHIEF = JOB.ID
JOB.NPC = {11}
JOB.Name = "Police Chief"
JOB.Color = Color( 0, 128, 255, 255 )

JOB.MaxPlayers = 1
JOB.DefaultMaxPlayers = 1
JOB.Pay = 175
JOB.GovOfficial = true
JOB.Armor = 100
JOB.RequiredTime = 12
JOB.VIP = true
JOB.CanUsePersonalVehicle = false
JOB.WelcomeMessage = "Welcome to the force, chief!"
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
    ["pistol"] = 70,
    ["buckshot"] = 20 
}
JOB.Guns = {
    "khr_p226",
    "cw_m3super90_police",
    "weapon_perp_nightstick",
    "weapon_perp_battering_ram",
    "weapon_perp_handcuffs",
    "weapon_perp_car_radar",
    "stungun",
    "weapon_perp_car_ticket_regular",
    "vc_spikestrip_wep",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(8670,8098,200),Angle(2,-179,0)},
	{Vector(8671,8027,200),Angle(2,-179,0)},
	{Vector(8673,7914,200),Angle(2,-179,0)},
	{Vector(8637,7745,200),Angle(2,-179,0)},
	{Vector(8501,7859,200),Angle(2,-179,0)},
	{Vector(8427,7740,200),Angle(2,-179,0)},
	{Vector(8383,7695,200),Angle(2,-179,0)},
	{Vector(8332,7756,200),Angle(2,-179,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
    { Vector( -8855.1435546875, -5039.87890625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8785.3896484375, -5064.4799804688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8730.619140625, -5147.0434570313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8678.1005859375, -5194.3544921875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8639.3466796875, -5324.3706054688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8625.2255859375, -5430.9375, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8799.1923828125, -5372.9223632813, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8831.0693359375, -5444.6625976563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8692.033203125, -5432.4516601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8694.111328125, -5279.3466796875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8500.7822265625, -5132.7016601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8375.896484375, -5142.40625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8346.3154296875, -5257.4653320313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8472.3359375, -5246.0986328125, 8.0312538146973 ), Angle( 18.700, -83.419, 0.000 )},    
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/humans/ecpdchief/hellzone/male_01.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/humans/ecpdchief/hellzone/male_02.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/humans/ecpdchief/hellzone/male_03.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/humans/ecpdchief/hellzone/male_04.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/humans/ecpdchief/hellzone/male_05.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/humans/ecpdchief/hellzone/male_06.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/humans/ecpdchief/hellzone/male_07.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/humans/ecpdchief/hellzone/male_08.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/humans/ecpdchief/hellzone/male_09.mdl"
 
JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/humans/ecpdchief/hellzone/female_01.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/humans/ecpdchief/hellzone/female_02.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/humans/ecpdchief/hellzone/female_03.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/humans/ecpdchief/hellzone/female_04.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/humans/ecpdchief/hellzone/female_05.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/humans/ecpdchief/hellzone/female_06.mdl"

JOB.Vehicles = {
    {
        ID = "17FordF150RaptorChief",
        Make = "Ford",
        Model = "F-150 Raptor Police",
        Nickname = "Big F-150 Raptor",
        Script = "scripts/vehicles/sentry/17raptor.txt",
        WorldModel = "models/sentry/17raptor_cop.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        AdminOnly = true,
        Color = Color(55,55,55),
        PlatePos = {
            {Vector(0,134,29),0.115,Angle(0,180,90)},
            {Vector(0,-119.5,35),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "DodgeChargerRTIntecepterrChief",
        Make = "Dodge",
        Model = "Charger RT '15",
        Nickname = "Dodge Charger RT",
        Script = "scripts/vehicles/lwcars/dodge_charger_2015_police.txt",
        WorldModel = "models/lonewolfie/dodge_charger_2015_police.mdl",
        Skin = "2",
        Color = Color(11,11,11),
        BodyGroups = {[1]=1},
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,-127,29.5),0.115,Angle(0,0,85)},
        }
    },
    {
        ID = "ChevyTahoeChief",
        Make = "Chevrolet",
        Model = "Tahoe",
        Nickname = "Chevy Tahoe",
        Script = "scripts/vehicles/lwcars/chev_tahoe.txt",
        WorldModel = "models/lonewolfie/chev_tahoe_police.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,115,20),0.115,Angle(0,180,95)},
            {Vector(0,-114,46.5),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "ChevySuburbanChief",
        Make = "Chevrolet",
        Model = "Suburban",
        Nickname = "Chevy Suburban",
        Script = "scripts/vehicles/lwcars/chev_suburban.txt",
        WorldModel = "models/lonewolfie/chev_suburban_pol.mdl",
        Skin = "1",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,138,23),0.115,Angle(0,180,90)},
            {Vector(0,-129.5,47),0.115,Angle(0,0,90)},
        } 
    },
}
VEHICLE_DATABASE = VEHICLE_DATABASE or {}
for k, v in pairs(JOB.Vehicles) do
    v.Name = v.Make .. " " .. v.Model
    VEHICLE_DATABASE[v.ID] = v
    util.PrecacheModel(v.WorldModel)
end

JOB.VehicleSpawns = {
    {Vector(7845,7699,-128), Angle(0,-90,0)},
	{Vector(7843,7897,-128), Angle(0,-90,0)},
	{Vector(7839,8158,-128), Angle(0,-90,0)},
	{Vector(7837,8344,-128), Angle(0,-90,0)},
	{Vector(8707,8808,-128), Angle(0,-270,0)},
	{Vector(8709,8636,-128), Angle(0,-270,0)},
	{Vector(8681,8376,-128), Angle(0,-270,0)},
	{Vector(8666,8181,-128), Angle(0,-270,0)},
}

JOB.VehicleNPC = {133}

JOB.MaxVehicles = 8

GM:RegisterJob( JOB )

--[[
────────────────────────────────────────────────────────────────────────
FBI, but in fancy font.
────────────────────────────────────────────────────────────────────────
]]

local JOB = {}

JOB.ID = 235
TEAM_FBI = JOB.ID
JOB.NPC = {131}
JOB.Name = "FBI Agent"
JOB.Color = Color( 201, 182, 112, 255 )

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 10
JOB.Pay = 115
JOB.GovOfficial = true
JOB.Armor = 100
JOB.RequiredTime = 25
JOB.VIP = true
JOB.CanUsePersonalVehicle = false
JOB.WelcomeMessage = "Welcome to the team."
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
    ["pistol"] = 70,
    ["smg1"] = 120,
    ["ammo_stungun"] = 20 
}
JOB.Guns = {
    "khr_p226",
    "khr_m4a4",
    "weapon_perp_nightstick",
    "weapon_perp_battering_ram",
    "weapon_perp_handcuffs",
    "weapon_perp_car_radar",
    "stungun",
    "weapon_perp_car_ticket_regular",
    "vc_spikestrip_wep",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(8670,8098,200),Angle(2,-179,0)},
	{Vector(8671,8027,200),Angle(2,-179,0)},
	{Vector(8673,7914,200),Angle(2,-179,0)},
	{Vector(8637,7745,200),Angle(2,-179,0)},
	{Vector(8501,7859,200),Angle(2,-179,0)},
	{Vector(8427,7740,200),Angle(2,-179,0)},
	{Vector(8383,7695,200),Angle(2,-179,0)},
	{Vector(8332,7756,200),Angle(2,-179,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
    { Vector( -8855.1435546875, -5039.87890625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8785.3896484375, -5064.4799804688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8730.619140625, -5147.0434570313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8678.1005859375, -5194.3544921875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8639.3466796875, -5324.3706054688, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8625.2255859375, -5430.9375, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8799.1923828125, -5372.9223632813, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8831.0693359375, -5444.6625976563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8692.033203125, -5432.4516601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8694.111328125, -5279.3466796875, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8500.7822265625, -5132.7016601563, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8375.896484375, -5142.40625, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8346.3154296875, -5257.4653320313, 8.03125 ), Angle( 18.700, -83.419, 0.000 )},
    { Vector( -8472.3359375, -5246.0986328125, 8.0312538146973 ), Angle( 18.700, -83.419, 0.000 )},
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/fbi_pack/fbi_01.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/fbi_pack/fbi_02.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/fbi_pack/fbi_03.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/fbi_pack/fbi_04.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/fbi_pack/fbi_05.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/fbi_pack/fbi_06.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/fbi_pack/fbi_07.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/fbi_pack/fbi_08.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/fbi_pack/fbi_09.mdl"
 
JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/fbi_pack/fbi_01.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/fbi_pack/fbi_02.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/fbi_pack/fbi_03.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/fbi_pack/fbi_04.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/fbi_pack/fbi_05.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/fbi_pack/fbi_06.mdl"
JOB.Playermodels[SEX_FEMALE][7] = "models/fbi_pack/fbi_07.mdl"
JOB.Playermodels[SEX_FEMALE][8] = "models/fbi_pack/fbi_08.mdl"
JOB.Playermodels[SEX_FEMALE][9] = "models/fbi_pack/fbi_09.mdl"

JOB.Vehicles = {
    {
        ID = "ChevyTahoeFBI",
        Make = "Chevrolet",
        Model = "Tahoe",
        Nickname = "Chevy Tahoe",
        Script = "scripts/vehicles/lwcars/chev_tahoe.txt",
        WorldModel = "models/lonewolfie/chev_tahoe_police.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,115,20),0.115,Angle(0,180,95)},
            {Vector(0,-114,46.5),0.115,Angle(0,0,90)},
        }
    },
    {
        ID = "ChevySuburbanFBI",
        Make = "Chevrolet",
        Model = "Suburban",
        Nickname = "Chevy Suburban",
        Script = "scripts/vehicles/lwcars/chev_suburban.txt",
        WorldModel = "models/lonewolfie/chev_suburban_pol.mdl",
        Skin = "2",
        Color = Color(0,0,0),
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,138,23),0.115,Angle(0,180,90)},
            {Vector(0,-129.5,47),0.115,Angle(0,0,90)},
        } 
    },
}

VEHICLE_DATABASE = VEHICLE_DATABASE or {}
for k, v in pairs(JOB.Vehicles) do
    v.Name = v.Make .. " " .. v.Model
    VEHICLE_DATABASE[v.ID] = v
    util.PrecacheModel(v.WorldModel)
end

JOB.VehicleSpawns = {
    {Vector(7845,7699,-128), Angle(0,-90,0)},
	{Vector(7843,7897,-128), Angle(0,-90,0)},
	{Vector(7839,8158,-128), Angle(0,-90,0)},
	{Vector(7837,8344,-128), Angle(0,-90,0)},
	{Vector(8707,8808,-128), Angle(0,-270,0)},
	{Vector(8709,8636,-128), Angle(0,-270,0)},
	{Vector(8681,8376,-128), Angle(0,-270,0)},
	{Vector(8666,8181,-128), Angle(0,-270,0)},
}

JOB.VehicleNPC = {133}

JOB.MaxVehicles = 8

GM:RegisterJob( JOB )