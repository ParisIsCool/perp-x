--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


--[[ notes
        1 = , 2 = , 3 = up-down - Angle 1 = 2 = point north 90  3 = .
{ TEAM_FIREMAN, Vector( 6207.122559, -2511.799561, -1779.968750), Angle(0.000012, 90, 0.000000)},

{Vector(-7080, -1824.516724, 500.031250), Angle(1.760002, 89.256393, 0.000000)},
]]--



GM.VehicleSpawnPositions = {

	{ false, Vector(-6838, 1245, -40), Angle(0, 90, 0)},
	{ false, Vector(-6853, 1068, -41), Angle(0, 90, 0)},
	{ false, Vector(-6863, 878, -41), Angle(0, 90, 0)},
	{ false, Vector(-7485, 1249, -41), Angle(0, -90, 0)},
	{ false, Vector(-7478, 1065, -41), Angle(0, -90, 0)},
	{ false, Vector(-7489, 882, -41), Angle(0, -90, 0)},
	{ false, Vector(-7473, 129, -41), Angle(0, 0, 0)},
	{ false, Vector(-7274, 138, -41), Angle(0, 0, 0)},
	{ false, Vector(-7071, 138, -41), Angle(0, 0, 0)},
	{ false, Vector(-6757, 139, -41), Angle(0, 0, 0)},
	{ false, Vector(-6558, 150, -41), Angle(0, 0, 0)},
	{ false, Vector(-6357, 146, -41), Angle(0, 0, 0)},
	{ false, Vector(4984, 4235, -65), Angle(0, 91, 0)},
	{ false, Vector(4598, 4225, -65), Angle(0, 90, 0)},
	{ false, Vector(4192, 4213, -65), Angle(0, 89, 0)},
	{ false, Vector(4038, 3569, -65), Angle(0, -91, 0)},
	{ false, Vector(4365, 3570, -65), Angle(0, -92, 0)},
	--{ false, Vector(4684, 3571, -65), Angle(0, -92, 0)},
	--{ false, Vector(4965, 3574, -65), Angle(0, -92, 0)},
    
	-- Tunnel Garage.
    {false,Vector(-12031,9023,248), Angle(0,180,0)},
	{false,Vector(-12229,9033,248), Angle(0,180,0)},
	{false,Vector(-12420,9046,248), Angle(0,180,0)},
	{false,Vector(-12410,10053,248), Angle(0,0,0)},
	{false,Vector(-12206,10039,248), Angle(0,0,0)},
	{false,Vector(-12009,10056,248), Angle(0,0,0)},




}

GM.DemoRespawn = {
    Vector(-6753,1605,-31),
	Vector(-6751,1471,-31),
	Vector(-6863,1398,-31),
	Vector(-6830,1767,-29),
}

GM.AutoLockDoors = {

}

GM.AutoUnlockDoors = {
    {Vector(7690,7955,252),"*375"},
    {Vector(7690,7853,252),"*374"},
    {Vector(7866,7768,256),"*377"},
    {Vector(7974,7768,256),"*376"},
    {Vector(8714,7640,256),"*380"},
    {Vector(8606,7640,256),"*381"},
    {Vector(4740,5416,4),"*116"},
    {Vector(4740,4840,4),"*42"},
    {Vector(3896,6276,68),"*118"},
    {Vector(5324,5578,4),"*257"},
    {Vector(5324,4726,4),"*256"},
    {Vector(3786,6860,68),"*258"},
    {Vector(-1523.96875,10408,188),"*313"},
    {Vector(5603.96875,5001.96875,4),"*254"},
    {Vector(5603.96875,5353.96875,4),"*255"},
    {Vector(3478,7163.96875,72),"*127"},
}

GM.AutoSpawnEntities = {
	-- Nexus front doors
	--{ Type = "prop_physics", Pos = Vector( -6758, -9040, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
	--{ Type = "prop_physics", Pos = Vector( -6758, -8762, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
}

GM.AutoDeleteEntities = {

}

local AutoOpenDoors =	{
}


GM.JailLocations = {
}

GM.SpawnPoints = {}



GM.SpawnPoints[ TEAM_CITIZEN ] = {
	{ Vector(2839, 5327, 0), Angle(1, -91, 0)},
	{ Vector(2622, 5161, 0), Angle(1, 1, 0)},
	{ Vector(2623, 5059, 0), Angle(1, 1, 0)},
	{ Vector(2625, 4945, 0), Angle(1, 1, 0)},
	{ Vector(2768, 4947, 0), Angle(1, 1, 0)},
	{ Vector(2767, 5051, 0), Angle(1, 1, 0)},
	{ Vector(2766, 5163, 0), Angle(1, 1, 0)},
	{ Vector(2821, 4806, 0), Angle(2, 90, 0)},
	{ Vector(2352, 4808, 224), Angle(1, 0, 0)},
	{ Vector(2575, 4633, 224), Angle(1, 92, 0)},
	{ Vector(2785, 4638, 224), Angle(1, 90, 0)},
	{ Vector(3014, 4861, 224), Angle(0, -180, 0)},
	{ Vector(3013, 5054, 224), Angle(0, -180, 0)},
	{ Vector(3013, 5270, 224), Angle(0, -180, 0)},
	{ Vector(2821, 5486, 224), Angle(0, -91, 0)},
	{ Vector(2551, 5481, 224), Angle(0, -90, 0)},
	{ Vector(2288, 5314, 224), Angle(1, 1, 0)},
	{ Vector(2515, 5464, 0), Angle(1, -1, 0)},
	{ Vector(2561, 4659, 0), Angle(1, -2, 0)},
	{ Vector(3066, 4640, 0), Angle(1, 90, 0)},
	{ Vector(3066, 4844, 0), Angle(1, 90, 0)},
	{ Vector(3056, 5254, 0), Angle(0, -91, 0)},
	{ Vector(3061, 5449, 0), Angle(0, -89, 0)},
	{ Vector(3333, 5249, 0), Angle(2, 179, 0)},
	{ Vector(3334, 5354, 0), Angle(2, 179, 0)},
	{ Vector(3319, 4858, 0), Angle(1, 179, 0)},
	{ Vector(3316, 4720, 0), Angle(1, 179, 0)},
	{ Vector(2476, 5180, 0), Angle(3, 0, 0)},
	{ Vector(2489, 4927, 0), Angle(1, 0, 0)},
	{ Vector(3184, 4624, 0), Angle(1, 92, 0)},
	{ Vector(3179, 4782, 0), Angle(1, 92, 0)},
	{ Vector(3181, 5482, 0), Angle(1, -91, 0)},
	{ Vector(3179, 5335, 0), Angle(1, -91, 0)},
	{ Vector(2465, 4986, 0), Angle(0, 0, 0)},
	{ Vector(2464, 5105, 0), Angle(0, 0, 0)},
	{ Vector(3026, 5520, 0), Angle(2, -90, 0)},
	{ Vector(3027, 4592, 0), Angle(1, 90, 0)},
	{ Vector(3179, 5136, 0), Angle(2, -32, 0)},
	{ Vector(3279, 5136, 0), Angle(2, -32, 0)},
	{ Vector(3381, 5136, 0), Angle(3, -91, 0)},
	{ Vector(3387, 4976, 0), Angle(2, 90, 0)},
	{ Vector(3290, 4982, 24), Angle(5, 92, 0)},
	{ Vector(3202, 4976, 0), Angle(2, 17, 0)},
	{ Vector(3136, 4920, 224), Angle(2, 89, 0)},
	{ Vector(3210, 4952, 224), Angle(2, 89, 0)},
	{ Vector(3269, 4923, 224), Angle(2, 89, 0)},
	{ Vector(3348, 4976, 224), Angle(2, 89, 0)},
	{ Vector(3419, 5032, 224), Angle(0, -180, 0)},
	{ Vector(3418, 5122, 224), Angle(0, -180, 0)},
	{ Vector(3339, 5202, 224), Angle(1, -90, 0)},
	{ Vector(3243, 5182, 224), Angle(1, -90, 0)},
	{ Vector(3136, 5183, 224), Angle(1, -90, 0)},
	{ Vector(3274, 5048, 224), Angle(1, 179, 0)},
	{ Vector(3193, 5050, 224), Angle(1, 179, 0)},
}


--GM.SpawnPoints[ TEAM_FIREMAN ] = GM.SpawnPoints[ TEAM_CITIZEN ]

--GM.SpawnPoints[ TEAM_FIRECHIEF ] = GM.SpawnPoints[ TEAM_CITIZEN ]

GM.SpawnPoints[ TEAM_POLICE ] = {

}

--GM.SpawnPoints[ TEAM_CHIEF ] = GM.SpawnPoints[ TEAM_CITIZEN ]

--GM.SpawnPoints[ TEAM_FBI ] = GM.SpawnPoints[ TEAM_CITIZEN ]

--GM.SpawnPoints[ TEAM_DETECTIVE ] = GM.SpawnPoints[ TEAM_CITIZEN ]

--GM.SpawnPoints[ TEAM_SWAT ] = GM.SpawnPoints[ TEAM_CITIZEN ]

--GM.SpawnPoints[ TEAM_DISPATCHER ] = GM.SpawnPoints[ TEAM_CITIZEN ]


--GM.SpawnPoints[ TEAM_ROADSERVICE ] = GM.SpawnPoints[ TEAM_CITIZEN ]

--GM.SpawnPoints[ TEAM_MEDIC ] = GM.SpawnPoints[ TEAM_CITIZEN ]

--GM.SpawnPoints[ TEAM_SECRET_SERVICE ] = GM.SpawnPoints[ TEAM_CITIZEN ]

KeepProps = {
}

GM.NextBotMarkers = {
}

GM.DrugDealerHangouts = {
}


local FireHydrants = {
}

local function SpawnHydrants ( )
	for k, v in pairs(FireHydrants) do
		Hydrant = ents.Create("prop_physics");
		Hydrant:SetModel("models/props/cs_assault/FireHydrant.mdl");
		Hydrant:SetPos(v);
		Hydrant:Spawn();
		Hydrant:GetPhysicsObject():EnableMotion(false);
	end;
end;
timer.Simple(1, SpawnHydrants);
