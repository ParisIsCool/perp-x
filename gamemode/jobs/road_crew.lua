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

JOB.ID = 220 -- ffs
TEAM_ROADSERVICE = JOB.ID
JOB.NPC = {21}
JOB.Name = "Road Crew Worker"
JOB.NamePlural = "Road Crew Workers"
JOB.Color = Color( 188, 124, 0 )

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 5
JOB.Pay = 70
JOB.GovOfficial = true
JOB.Armor = 0
JOB.RequiredTime = 1
JOB.VIP = false
JOB.CanUsePersonalVehicle = true
JOB.WelcomeMessage = "Let's get to work."
JOB.FillGunClips = false
JOB.Upkeep = 0
JOB.RefillAmmo = {}
JOB.Guns = {
    "vc_wrench",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(-3023,3152,-103), Angle(0,90,0)},
	{Vector(-3144,3152,-103), Angle(0,90,0)},
	{Vector(-3269,3151,-103), Angle(0,90,0)},
	{Vector(-3403,3145,-103), Angle(0,90,0)},
	{Vector(-3532,3147,-103), Angle(0,90,0)},
	{Vector(-3661,3144,-103), Angle(0,90,0)},
	{Vector(-3508,4281,-103), Angle(0,-90,0)},
	{Vector(-3383,4288,-103), Angle(0,-90,0)},
	{Vector(-3255,4314,-103), Angle(0,-90,0)},
	{Vector(-3150,4308,-103), Angle(0,-90,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
	{Vector(-7145,-144,8), Angle(0,90,0)},
	{Vector(-7277,-144,8), Angle(0,90,0)},
	{Vector(-7329,-45,8), Angle(0,90,0)},
	{Vector(-7233,-13,8), Angle(0,90,0)},
	{Vector(-7146,46,8), Angle(0,90,0)},
	{Vector(-7323,101,8), Angle(0,90,0)},
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
        ID = "3500TowTruck",
        Make = "Dodge",
        Model = "Ram 3500 Tow Truck",
        Nickname = "Dodge Ram 3500",
        Script = "scripts/vehicles/statetrooper/ram3500_tow.txt",
        WorldModel = "models/statetrooper/ram_tow.mdl",
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
	{Vector(-3458,4080,-111), Angle(0,90,0)},
	{Vector(-3473,3880,-111), Angle(0,90,0)},
	{Vector(-3477,3699,-111), Angle(0,90,0)},
	{Vector(-3472,3515,-111), Angle(0,90,0)},
	{Vector(-3465,3325,-111), Angle(0,90,0)},
	{Vector(-3082,3536,-111), Angle(0,180,0)},
}

JOB.VehicleNPC = {21}

JOB.MaxVehicles = 6

GM:RegisterJob( JOB )