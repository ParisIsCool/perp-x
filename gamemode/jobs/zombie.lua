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

JOB.ID = 30
TEAM_ZOMBIE = JOB.ID
JOB.Name = "Zombie"
JOB.Color = Color(138, 59, 59)

JOB.CanEquipInventoryGun = false

JOB.MaxPlayers = true
JOB.Pay = 100
JOB.HP = 50
JOB.GovOfficial = false
JOB.CanUsePersonalVehicle = false
JOB.OverwriteGuns = true
JOB.Guns = {
	"roleplay_fists"
}

JOB.Spawns = {}

JOB.Spawns["rp_southside"] = {
	{Vector(2915,403,-111), Angle(0,90,0)},
	{Vector(2975,439,-111), Angle(0,90,0)},
	{Vector(3097,609,-111), Angle(0,90,0)},
	{Vector(3605,984,-103), Angle(0,-180,0)},
	{Vector(2383,2444,-98), Angle(0,90,0)},
	{Vector(4205,3091,-56), Angle(0,-90,0)},
	{Vector(4549,1109,-103), Angle(0,90,0)},
	{Vector(4321,-178,-102), Angle(0,90,0)},
	{Vector(3672,2204,-103), Angle(0,0,0)},
	{Vector(9345,5656,8), Angle(0,180,0)},
	{Vector(8002,1756,-93), Angle(0,90,0)},
	{Vector(914,-2304,-143), Angle(0,0,0)},
	{Vector(-9374,1690,0), Angle(0,90,0)},
	{Vector(-5199,1759,-49), Angle(0,-90,0)},
	{Vector(-4932,4093,-39), Angle(0,0,0)},
	{Vector(-3096,6629,48), Angle(0,-90,0)},
	{Vector(-3997,5533,48), Angle(0,0,0)},
	{Vector(-642,7628,148), Angle(0,0,0)},
	{Vector(-306,10239,128), Angle(0,90,0)},
	{Vector(-239,11590,128), Angle(0,90,0)},
	{Vector(-2674,9900,142), Angle(0,0,0)},
	{Vector(-12762,10115,248), Angle(0,-90,0)},
	{Vector(-12730,8900,248), Angle(0,90,0)},
	{Vector(-3151,7025,108), Angle(0,90,0)},
	{Vector(-2992,7519,133), Angle(0,90,0)},
	{Vector(-3275,7804,128), Angle(0,90,0)},
	{Vector(-2090,7485,128), Angle(0,90,0)},
	{Vector(-2574,6506,24), Angle(0,-90,0)},
	{Vector(-1872,6079,-343), Angle(0,-180,0)},
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/player/zombie_classic.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/zombie_fast.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/player/zombie_soldier.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/zombie_classic.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/zombie_fast.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/zombie_soldier.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/zombie_classic.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/zombie_fast.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/zombie_soldier.mdl"
 
JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/player/zombie_classic.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/player/zombie_fast.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/player/zombie_soldier.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/player/zombie_classic.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/player/zombie_fast.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/player/zombie_soldier.mdl"

GM:RegisterJob( JOB )