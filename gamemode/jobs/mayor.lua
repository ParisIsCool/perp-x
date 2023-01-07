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

JOB.ID = 5
TEAM_MAYOR = JOB.ID
JOB.NPC = {1}
JOB.Name = "Mayor"
JOB.NamePlural = "Mayors"
JOB.Color = Color( 255, 0, 0, 255 )

JOB.CanEquipInventoryGun = true

JOB.MaxPlayers = true
JOB.Pay = 200
JOB.GovOfficial = true
JOB.Armor = 50
JOB.RequiredTime = 0
JOB.VIP = false
JOB.CanUsePersonalVehicle = true
JOB.WelcomeMessage = "Welcome to the city Mayor!"
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
}
JOB.Guns = {
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(-2057,2175,544), Angle(0,0,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
	{ Vector(-4598, -5079, 64), Angle(-1, 1, 0) },
    { Vector(-4599, -4948, 64), Angle(0, 0, 0) },
    { Vector(-4504, -5060, 64), Angle(0, 0, 0) },
    { Vector(-4586, -4739, 64), Angle(0, 2, 0) },
    { Vector(-4589, -4645, 64), Angle(0, 2, 0) },
    { Vector(-4482, -4642, 64), Angle(0, 2, 0) },
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/nsaagentpm.mdl"

JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/player/nsaagentpm.mdl"

JOB.Vehicles = {
    {
        ID = "ChevyTahoeMayor",
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
        ID = "LimoMayor",
        Make = "Mayors",
        Model = "Limo",
        Nickname = "Mayors Limo",
        Script = "scripts/vehicles/sentry/towncarlimo.txt",
        WorldModel = 'models/sentry/static/lincolntclimo.mdl',
        Skin = "0",
        RequiredClass = JOB.ID,
        Color =  Color (0,0,0),
        PlatePos = {
            {Vector(0,172,20),0.115,Angle(0,180,95)},
            {Vector(0,-165,37),0.115,Angle(0,0,90)},
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

JOB.VehicleNPC = {1}

JOB.MaxVehicles = 4

GM:RegisterJob( JOB )


local JOB = {}

JOB.ID = 22
TEAM_SS = JOB.ID
JOB.NPC = {1}
JOB.Name = "Secret Service"
JOB.NamePlural = "Secret Service Members"
JOB.Color = Color(100, 0, 200, 255)

JOB.CanEquipInventoryGun = false

JOB.MaxPlayers = 15
JOB.Pay = 160
JOB.GovOfficial = true
JOB.Armor = 100
JOB.RequiredTime = 20
JOB.RequiredTeamOn = TEAM_MAYOR
JOB.VIP = false
JOB.CanUsePersonalVehicle = true
JOB.WelcomeMessage = "Protect the mayor at all costs!"
JOB.FillGunClips = true
JOB.Upkeep = 50
JOB.RefillAmmo = {
    ["pistol"] = 70,
    ["smg1"] = 200,
}
JOB.Guns = {
    "khr_p226",
    "khr_m4a4",
    "khr_mp5_kry",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
    {Vector(3197,4934,224), Angle(0,0,0)},
	{Vector(3228,5027,224), Angle(0,0,0)},
	{Vector(3225,5105,224), Angle(0,0,0)},
	{Vector(3263,5163,224), Angle(0,0,0)},
	{Vector(3358,5147,224), Angle(0,0,0)},
	{Vector(3411,5068,224), Angle(0,0,0)},
	{Vector(3395,4976,224), Angle(0,0,0)},
	{Vector(3282,4935,224), Angle(0,0,0)},
}

JOB.Spawns["rp_rockford_v2b"] = {
	{ Vector(-4598, -5079, 64), Angle(-1, 1, 0) },
    { Vector(-4599, -4948, 64), Angle(0, 0, 0) },
    { Vector(-4504, -5060, 64), Angle(0, 0, 0) },
    { Vector(-4586, -4739, 64), Angle(0, 2, 0) },
    { Vector(-4589, -4645, 64), Angle(0, 2, 0) },
    { Vector(-4482, -4642, 64), Angle(0, 2, 0) },
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/nsaagentpm.mdl"

JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/player/nsaagentpm.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/player/nsaagentpm.mdl"

JOB.Vehicles = {
    {
        ID = "ChevyTahoeSS",
        Make = "Chevrolet",
        Model = "Tahoe",
        Nickname = "Chevy Tahoe",
        Script = "scripts/vehicles/lwcars/chev_tahoe.txt",
        WorldModel = "models/lonewolfie/chev_tahoe_police.mdl",
        Skin = "0",
        RequiredClass = JOB.ID,
    },
    {
        ID = "LimoMayorSS",
        Make = "Mayors",
        Model = "Limo",
        Nickname = "Mayors Limo",
        Script = "scripts/vehicles/sentry/towncarlimo.txt",
        WorldModel = 'models/sentry/static/lincolntclimo.mdl',
        Skin = "0",
        RequiredClass = JOB.ID,
        Color =  Color (0,0,0),
        PlatePos = {
            {Vector(0,172,20),0.115,Angle(0,180,95)},
            {Vector(0,-165,37),0.115,Angle(0,0,90)},
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

JOB.VehicleNPC = {1}

JOB.MaxVehicles = 4

GM:RegisterJob( JOB )