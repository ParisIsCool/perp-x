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

JOB.ID = 3
TEAM_MEDIC = JOB.ID
JOB.NPC = {13}
JOB.Name = "Paramedic"
JOB.Color = Color( 255, 0, 255, 255 )

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 5
JOB.Pay = 100
JOB.GovOfficial = true
JOB.Armor = 100
JOB.RequiredTime = 1
JOB.VIP = false
JOB.CanUsePersonalVehicle = false
JOB.WelcomeMessage = "Welcome to the crew!"
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
}
JOB.Guns = {
    "weapon_perp_paramedic_defib",
    "weapon_perp_paramedic_health",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(7679,5274,-55), Angle(0,-90,0)},
	{Vector(7876,5204,-55), Angle(0,-90,0)},
	{Vector(7736,5066,-55), Angle(0,-90,0)},
	{Vector(7605,4929,-55), Angle(0,180,0)},
	{Vector(7211,5455,-55), Angle(0,-90,0)},
	{Vector(7298,5390,-55), Angle(0,-90,0)},
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/preytech/perp/players/jobs/m_1_medic.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/portal/male_02_medic.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/preytech/perp/players/jobs/m_3_medic.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/portal/male_04_medic.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/portal/male_05_medic.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/portal/male_06_medic.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/portal/male_07_medic.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/portal/male_08_medic.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/portal/male_09_medic.mdl"

JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/preytech/perp/players/jobs/f_1_medic.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/preytech/perp/players/jobs/f_2_medic.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/preytech/perp/players/jobs/f_3_medic.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/preytech/perp/players/jobs/f_4_medic.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/preytech/perp/players/jobs/f_6_medic.mdl"
JOB.Playermodels[SEX_FEMALE][7] = "models/preytech/perp/players/jobs/f_7_medic.mdl"

JOB.Vehicles = {
    {
        ID = "GMCc5500",
        Make = "GMC",
        Model = "c5500 Ambulance",
        Nickname = "c5500 Ambulance",
        Script = "scripts/vehicles/sentry/c5500.txt",
        WorldModel = "models/sentry/c5500_ambu.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
        PlatePos = {
            {Vector(0,-176,23.5),0.115,Angle(0,0,90)},
            {Vector(0,121,23),0.115,Angle(0,180,94)},
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
	{Vector(6776,4861,-63), Angle(0,180,0)},
	{Vector(6546,4864,-63), Angle(0,180,0)},
}

JOB.VehicleNPC = {13}

JOB.MaxVehicles = 8

GM:RegisterJob( JOB )