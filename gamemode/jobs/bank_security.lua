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

JOB.ID = 15
TEAM_BANK_SECURITY = JOB.ID
JOB.NPC = {1200}
JOB.Name = "Bank Security Officer"
JOB.NamePlural = "Bank Security Officers"
JOB.Color = Color( 255, 210, 85 )

JOB.MaxPlayers = 16
JOB.DefaultMaxPlayers = 5
JOB.Pay = 80
JOB.GovOfficial = true
JOB.Armor = 100
JOB.RequiredTime = 1
JOB.VIP = false
JOB.CanUsePersonalVehicle = true
JOB.WelcomeMessage = "Welcome to the team!"
JOB.FillGunClips = true
JOB.Upkeep = 0
JOB.RefillAmmo = {
    ["pistol"] = 70,
    ["smg1"] = 120,
    ["ammo_stungun"] = 20 
}
JOB.Guns = {
    "khr_p226",
    "khr_m4a4",
    "stungun",
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(-1118,3090,-103), Angle(0,-90,0)},
	{Vector(-1035,3032,-103), Angle(0,-90,0)},
	{Vector(-956,3087,-103), Angle(0,-90,0)},
	{Vector(-817,3050,-103), Angle(0,-90,0)},
	{Vector(-861,2909,-103), Angle(0,-90,0)},
	{Vector(-948,2880,-103), Angle(0,-90,0)},
	{Vector(-1169,2885,-103), Angle(0,-90,0)},
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/player/guard_pack/guard_01.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/guard_pack/guard_02.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/player/guard_pack/guard_03.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/guard_pack/guard_04.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/guard_pack/guard_05.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/guard_pack/guard_06.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/guard_pack/guard_07.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/guard_pack/guard_08.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/guard_pack/guard_09.mdl"
 
JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/player/guard_pack/guard_01.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/player/guard_pack/guard_02.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/player/guard_pack/guard_03.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/player/guard_pack/guard_04.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/player/guard_pack/guard_05.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/player/guard_pack/guard_06.mdl"

GM:RegisterJob( JOB )