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

JOB.ID = 230
TEAM_BUSDRIVER = JOB.ID
JOB.NPC = {22}
JOB.Name = "Bus Driver"
JOB.NamePlural = "Bus Drivers"
JOB.Color = Color( 194, 128, 255 )


JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 3
JOB.Pay = 70
JOB.GovOfficial = true
JOB.Armor = 0
JOB.RequiredTime = 0
JOB.VIP = false
JOB.CanUsePersonalVehicle = false
JOB.WelcomeMessage = "Pick 'em up!"
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
    { Vector(-1121, 4008, 544), Angle(4, 91, 0) },
    { Vector(-1122, 4088, 544), Angle(4, 91, 0) },
    { Vector(-1766, 3956, 544), Angle(0, 89, 0) },
    { Vector(-1764, 4078, 544), Angle(0, 90, 0) },
    { Vector(-1645, 4078, 544), Angle(0, 90, 0) },
    { Vector(-1645, 3946, 544), Angle(0, 90, 0) },
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
        ID = "BusPepper",
        Make = "City",
        Model = "Bus",
        Nickname = "Bus",
        Script = "scripts/vehicles/tdmcars/bus.txt",
        WorldModel = "models/tdmcars/bus.mdl",
        Skin = "11",
        RequiredClass = JOB.ID,
        Color = Color(255,255,255),
        PlatePos = {
            {Vector(26.5,-268,45),0.115,Angle(0,0,90)},
            {Vector(-38,263,64),0.115,Angle(0,180,90)},
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
	{Vector(4758,3584,-63), Angle(0,-90,0)},
	{Vector(4875,4249,-63), Angle(0,90,0)},
}

JOB.VehicleNPC = {22}

JOB.MaxVehicles = 6

GM:RegisterJob( JOB )