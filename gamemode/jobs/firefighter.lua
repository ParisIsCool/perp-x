--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local JOB = {}

JOB.ID = 4
TEAM_FIREMAN = JOB.ID
JOB.NPC = {12}
JOB.Name = "Firefighter"
JOB.Color = Color( 255, 165, 0, 255 )

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 5
JOB.Pay = 100
JOB.GovOfficial = true
JOB.Armor = 0
JOB.RequiredTime = 2
JOB.VIP = false
JOB.CanUsePersonalVehicle = false
JOB.WelcomeMessage = "Welcome to the firecrew!"
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
}
JOB.Guns = {
    "weapon_perp_fire_axe",
    "weapon_perp_fire_hose",
    "weapon_perp_fire_extinguisher",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(9802,1230,-103), Angle(0,-180,0)},
	{Vector(9854,1283,-103), Angle(0,-180,0)},
	{Vector(9857,1386,-103), Angle(0,-180,0)},
	{Vector(9888,1485,-103), Angle(0,-180,0)},
	{Vector(9775,1697,-103), Angle(0,-180,0)},
	{Vector(9760,1538,-103), Angle(0,-180,0)},
	{Vector(9600,1535,-103), Angle(0,90,0)},
	{Vector(9489,1555,-103), Angle(0,-90,0)},
	{Vector(9915,1549,96), Angle(0,180,0)},
	{Vector(9857,1393,96), Angle(0,-180,0)},
	{Vector(9811,1172,96), Angle(0,0,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
    { Vector( -4710.3828125, -3317.1682128906, 272.03125 ), Angle( -0.26400595903397, -179.42436218262, 0) },
    { Vector( -4889.2817382812, -3318.9643554688, 272.03125 ), Angle( -0.26400595903397, -179.42436218262, -0) },
    { Vector( -5035.8774414062, -3320.4362792969, 272.03125 ), Angle( -0.26400595903397, -179.42436218262, -0) },
    { Vector( -5037.41796875, -3213.7280273438, 272.03125 ), Angle( -0.26400595903397, -179.42436218262, 0) },
    { Vector( -4905.7045898438, -3212.4057617188, 272.03125 ), Angle( -0.26400595903397, -179.42436218262, 0) },
    { Vector( -4764.3041992188, -3210.9860839844, 272.03125 ), Angle( -0.26400595903397, -179.42436218262, 0) },
}


JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/portal/male_09_fireman.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/portal/male_09_fireman.mdl"

JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/preytech/perp/players/jobs/f_1_firefighter.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/preytech/perp/players/jobs/f_2_firefighter.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/preytech/perp/players/jobs/f_3_firefighter.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/preytech/perp/players/jobs/f_4_firefighter.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/preytech/perp/players/jobs/f_5_firefighter.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/preytech/perp/players/jobs/f_6_firefighter.mdl"

JOB.Vehicles = {
    {
        ID = "PierceFireEngine",
        Make = "Pierce",
        Model = "Fire Engine",
        Nickname = "Pierce Fire Engine",
        Script = "scripts/vehicles/sentry/fireengine.txt",
        WorldModel = 'models/sentry/fireengine.mdl',
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(29,-191,45),0.115,Angle(0,0,90)},
            {Vector(27.4,236,34),0.115,Angle(0,180,90)},
        }
    },
    {
        ID = "PierceFireLadder",
        Make = "Pierce",
        Model = "Fire Ladder Engine",
        Nickname = "Pierce Ladder Engine",
        Script = "scripts/vehicles/sentry/fireengine.txt",
        WorldModel = 'models/sentry/fireladder.mdl',
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,-266,35),0.115,Angle(0,0,90)},
            {Vector(27.4,222,31.8),0.115,Angle(0,180,90)},
        }
    },
    {
        ID = "PierceRescue",
        Make = "Pierce",
        Model = "Rescue Engine",
        Nickname = "Pierce Rescue Engine",
        Script = "scripts/vehicles/sentry/fireengine.txt",
        WorldModel = 'models/sentry/firerescue.mdl',
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(-32,-222,88),0.115,Angle(0,0,90)},
            {Vector(27.4,236,34),0.115,Angle(0,180,90)},
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
	{Vector(9411,1287,-103), Angle(0,90,0)},
	{Vector(9406,1791,-103), Angle(0,90,0)},
}

JOB.VehicleNPC = {12}

JOB.MaxVehicles = 4

GM:RegisterJob( JOB )