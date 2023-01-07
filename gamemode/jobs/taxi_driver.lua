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

JOB.ID = 225
TEAM_TAXI_DRIVER = JOB.ID
JOB.NPC = {101}
JOB.Name = "Taxi Driver"
JOB.NamePlural = "Taxi Drivers"
JOB.Color = Color( 254, 222, 75 )

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 5
JOB.Pay = 60
JOB.GovOfficial = false
JOB.Armor = 0
JOB.RequiredTime = 0
JOB.VIP = false
JOB.CanUsePersonalVehicle = false
JOB.WelcomeMessage = "Now start driving!"
JOB.FillGunClips = false
JOB.Upkeep = 0
JOB.RefillAmmo = {}
JOB.Guns = {}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(1184,40,-103), Angle(0,-90,0)},
	{Vector(2518,4623,224), Angle(0,90,0)},
	{Vector(2744,4620,224), Angle(0,90,0)},
	{Vector(3035,4780,224), Angle(0,180,0)},
	{Vector(3038,5297,224), Angle(0,-180,0)},
	{Vector(2816,5478,224), Angle(0,-90,0)},
	{Vector(2531,5496,224), Angle(0,-90,0)},
	{Vector(2841,5436,0), Angle(0,-90,0)},
	{Vector(2841,4653,0), Angle(0,90,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
    { Vector(-2829, -5121, 64), Angle(3, 178, 0) },
    { Vector(-2933, -5118, 64), Angle(3, 179, 0) },
    { Vector(-3030, -5116, 64), Angle(3, 180, 0) },
    { Vector(-3112, -5116, 64), Angle(3, -180, 0) },
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

JOB.Vehicles = {
    {
        ID = "FordTaxi",
        Make = "Ford",
        Model = "Taxi",
        Nickname = "Taxi",
        Script = "scripts/vehicles/tdmcars/for_crownvic_fh3.txt",
        WorldModel = "models/tdmcars/crownvic_taxi.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
    },
}

VEHICLE_DATABASE = VEHICLE_DATABASE or {}
for k, v in pairs(JOB.Vehicles) do
    v.Name = v.Make .. " " .. v.Model
    VEHICLE_DATABASE[v.ID] = v
    util.PrecacheModel(v.WorldModel)
end

JOB.VehicleSpawns = {
	{Vector(2208,-254,-111), Angle(0,90,0)},
	{Vector(1764,-265,-111), Angle(0,90,0)},
	{Vector(1420,-273,-111), Angle(0,90,0)},
	{Vector(1122,-273,-111), Angle(0,90,0)},
}

JOB.VehicleNPC = {101}

JOB.MaxVehicles = 6

GM:RegisterJob( JOB )