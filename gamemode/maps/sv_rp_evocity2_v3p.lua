--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.VehicleSpawnPositions = {
//	{Gov Only?, Vector, Angle}

	// Civies
	{nil, Vector(-3030, -3099, 70), Angle(1, 68, -1)},
	{nil, Vector(-3061, -2850, 70), Angle(1, 68, -1)},
	{nil, Vector(-3024, -2590, 70), Angle(1, 68, -1)},
	{nil, Vector(-3038, -2332, 70), Angle(1, 68, -1)},
	{nil, Vector(-3053, -2057, 70), Angle(1, 68, -1)},
	{nil, Vector(-3044, -1802, 70), Angle(1, 68, -1)},
	{nil, Vector(-3052, -1560, 70), Angle(1, 68, -1)},
	{nil, Vector(-3063, -1294, 70), Angle(1, 68, -1)},
	
	// Fire
	{TEAM_FIREMAN, Vector(-748.33648681641, -2559.3244628906, 93.936866760254), Angle(0, 90, 0)},
	{TEAM_FIREMAN, Vector(-1007.0546264648, -1563.4860839844, 92.99649810791), Angle(0, 0, 0)},
	{TEAM_FIREMAN, Vector(-460.4033203125, -875.59753417969, 92.652900695801), Angle(0, -90, 0)},       
	
	// Cop
	{TEAM_POLICE, Vector(-4.9815440177917, -1633.6932373047, -188.50511169434), Angle(0, 180, 0)},
	{TEAM_POLICE, Vector(-272.78472900391, -1634.7150878906, -184.1756439209), Angle(0, -180, 0)},
	{TEAM_POLICE, Vector(-554.06726074219, -1621.7078857422, -179.08576965332), Angle(0, -180, 0)},
	{TEAM_POLICE, Vector(-537.94927978516, -2291.5270996094, -177.77537536621), Angle(0, 0, 0)},
	{TEAM_POLICE, Vector(-270.93469238281, -2305.4006347656, -179.97804260254), Angle(0, 0, 0)},
	{TEAM_POLICE, Vector(4.4993019104004, -2313.5200195313, -182.37493896484), Angle(0, 0, 0)},
	{TEAM_POLICE, Vector(301.083984375, -2312.1616210938, -184.41957092285), Angle(0, 0, 0)},
	{TEAM_POLICE, Vector(540.65063476563, -2302.1540527344, -182.29182434082), Angle(0, 0, 0)},
	
	// SWAT
	{TEAM_SWAT, Vector(-263.81353759766, -1630.7344970703, -184.84858703613), Angle(0, -180, 0)}, 
	{TEAM_SWAT, Vector(-540.76379394531, -1623.4921875, -183.32437133789), Angle(0, -180, 0)},
	
	// Secret Service
	{TEAM_SECRET_SERVICE, Vector(-748.45178222656, -2559.3598632813, 81.039863586426), Angle(0, 90, 0)},
	
	// Medic
	{TEAM_MEDIC, Vector(-2462.1291503906, 1325.9830322266, 92.689315795898), Angle(0, 0, 0)},
	{TEAM_MEDIC, Vector(-2594.509765625, 1329.0935058594, 90.467506408691), Angle(0, 0, 0)},
	{TEAM_MEDIC, Vector(-2729.4482421875, 1325.087890625, 90.377487182617), Angle(0, 0, 0)},
	
	// Tow Truck Driver
	{TEAM_ROADCREW, Vector(8473, 13186, 82), Angle(0, -90, 0)},
	{TEAM_ROADCREW, Vector(8473, 13327, 82), Angle(0, -90, 0)},
	{TEAM_ROADCREW, Vector(8476, 13476, 82), Angle(0, -90, 0)},
	
	// Bus Driver
	//{TEAM_BUSDRIVER, Vector(-2493.056640625, -538.34521484375, 70.8310546875), Angle(0, -90, 0)}, 
	//{TEAM_BUSDRIVER, Vector(-2498.2141113281, -880.74652099609, 77.303024291992), Angle(0, -90, 0)},
}

GM.AutoLockDoors = {
	{Vector(1365, 27, 194.25), 'models/props_c17/door01_left.mdl'},
}

GM.AutoUnlockDoors = {

}

GM.AutoSpawnEntities = {
	-- Nexus front doors
	//{ Type = "prop_physics", Pos = Vector( -6758, -9040, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
	//{ Type = "prop_physics", Pos = Vector( -6758, -8762, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
}

GM.AutoDeleteEntities = {

}

GM.JailLocations = {
	Vector(434, -2008, -376),
	Vector(568, -2012, -376),
	Vector(702, -2011, -376),
	Vector(826, -2016, -376),
	Vector(817, -2350, -376),
	Vector(681, -2348, -376),
	Vector(559, -2341, -376),
	Vector(434, -2340, -376),
}

GM.SpawnPoints = {}

GM.SpawnPoints[ TEAM_CITIZEN ] = {
	{Vector(-1946, -1203, 196), Angle(3, -1, 0)},
	{Vector(-1950, -1420, 196), Angle(3, -1, 0)},
	{Vector(-1955, -1645, 196), Angle(3, -1, 0)},
	{Vector(-1959, -1855, 196), Angle(3, -1, 0)},
	{Vector(-1962, -2027, 196), Angle(3, -1, 0)},
	{Vector(-1967, -2267, 196), Angle(3, -1, 0)},
	{Vector(-1972, -2522, 196), Angle(3, -1, 0)},
	{Vector(-1976, -2725, 196), Angle(3, -1, 0)},
	{Vector(-1982, -2890, 196), Angle(88, 2, 0)},
	{Vector(-1975, -3070, 196), Angle(88, 2, 0)},
	{Vector(-2192, -939, 211), Angle(88, 92, 0)},
	{Vector(-2312, -939, 211), Angle(88, 90, 0)},
	{Vector(-2470, -938, 211), Angle(88, 89, 0)},
	{Vector(-2657, -934, 211), Angle(88, 89, 0)},
	{Vector(-2807, -931, 211), Angle(88, 89, 0)},
	{Vector(-2052, -459, 246), Angle(76, -91, 0)},
	{Vector(-2330, -457, 246), Angle(77, -91, 0)},
	{Vector(-2555, -455, 246), Angle(77, -91, 0)},
	{Vector(-2855, -453, 246), Angle(78, -90, 0)},
	{Vector(-3373, -595, 246), Angle(77, -1, 0)},
	{Vector(-3374, -723, 246), Angle(77, -1, 0)},
	{Vector(-3377, -910, 246), Angle(77, -1, 0)},
}

GM.SpawnPoints[ TEAM_POLICE ] = {
	{Vector(-91.47955322266, -2364.287109375, 157.03125), Angle(0, 90, 0)},
	{Vector(-50.47955322266, -2364.287109375, 157.03125), Angle(0, 90, 0)},
	{Vector(-223.01998901367, -2364.287109375, 157.03125), Angle(0, 90, 0)},
	{Vector(-393.01998901367, -2364.287109375, 157.03125), Angle(0, 90, 0)},
	{Vector(-520.47955322266, -2364.287109375, 157.03125), Angle(0, 90, 0)},
	{Vector(-707.92004394531, -2364.287109375, 157.03125), Angle(0, 90, 0)},
	{Vector(-393.01998901367, -2161.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-520.47955322266, -2161.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-707.92004394531, -2161.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-393.01998901367, -1959.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-520.47955322266, -1959.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-707.92004394531, -1959.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-393.01998901367, -1757.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-520.47955322266, -1757.9272460938, 157.03125), Angle(0, 90, 0)},
	{Vector(-707.92004394531, -1757.9272460938, 157.03125), Angle(0, 90, 0)},
}

GM.SpawnPoints[ TEAM_SWAT ] = GM.SpawnPoints[ TEAM_POLICE ]
GM.SpawnPoints[ TEAM_DISPATCHER ] = GM.SpawnPoints[ TEAM_POLICE ]
GM.SpawnPoints[ TEAM_FIREMAN ] = GM.SpawnPoints[ TEAM_POLICE ]
GM.SpawnPoints[ TEAM_MAYOR ] = GM.SpawnPoints[ TEAM_POLICE ]
GM.SpawnPoints[ TEAM_SECRET_SERVICE ] = GM.SpawnPoints[ TEAM_POLICE ]

GM.SpawnPoints[ TEAM_MEDIC ] = {
	{Vector(-2032.2727050781, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-2174.7543945313, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-2315.7543945313, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-2456.7543945313, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-2597.7543945313, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-2738.7543945313, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-2879.7543945313, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-2948.3356933594, 1696.2318115234, 157.03125), Angle(0, 90, 0)},
	{Vector(-1972.4066162109, 1470.1279296875, 157.03125), Angle(0, 0, 0)},
	{Vector(-1972.4066162109, 1349.1279296875, 157.03125), Angle(0, 0, 0)},
	{Vector(-1972.4066162109, 1228.1279296875, 157.03125), Angle(0, 0, 0)},
	{Vector(-1972.4066162109, 1107.1279296875, 157.03125), Angle(0, 0, 0)},
}

/*
GM.SpawnPoints[TEAM_BUSDRIVER] = {
    {Vector(-1993.2962646484, 113.35990905762, 157.03125), Angle(0, 0, 0)},
    {Vector(-1993.2962646484, 234.35990905762, 157.03125), Angle(0, 0, 0)},
}
*/

GM.SpawnPoints[ TEAM_ROADSERVICE ] = {
	{Vector(7782, 12751, 215), Angle(75, -91, 0)},
	{Vector(7917, 12748, 215), Angle(75, -91, 0)},
	{Vector(8082, 12744, 215), Angle(75, -91, 0)},
	{Vector(8300, 12738, 215), Angle(75, -91, 0)},
	{Vector(8592, 12731, 215), Angle(75, -91, 0)},
	{Vector(8855, 12724, 215), Angle(78, -91, 0)},
}

// Todo: Finish life alert zones

StreetBlocks = {
	{pos1 = Vector(-6553, 7468, 422), pos2 = Vector(-6937, 3276, 117), name = 'the Industrial-Junction tunnel'},
	{pos1 = Vector(-6553, -750, 422), pos2 = Vector(-6937, -5876, 106), name = 'the Lake-Junction tunnel'},
	{pos1 = Vector(-5785, 2176, 388), pos2 = Vector(-3555, 1792, 68), name = 'the City-Junction tunnel'},
	{pos1 = Vector(614, 5004, 324), pos2 = Vector(3687, 4620, 68), name = 'the City-Industrial tunnel'},
	{pos1 = Vector(7119, -6901, -1504), pos2 = Vector(7503, 268, -1823), name = 'the Lake-Suburbs tunnel'},
	{pos1 = Vector(11227, 268, -1823), pos2 = Vector(10843, -1478, -1505), name = 'the Suburbs-Farms tunnel'},
}
	
CityBlocks = {
	{pos1 = Vector(12796, 318, -708), pos2 = Vector(10944, 2060, -1824), name = 'Malonesky Transportation LLC'},
	{pos1 = Vector(9037, 6614, -1823), pos2 = Vector(12348, 10944, -708), name = 'Arrowhead Trailer Villas'},
	{pos1 = Vector(9040, 6532, -1823), pos2 = Vector(4282, 11644, -708), name = 'the Large Suburbs'},
	{pos1 = Vector(6588, 3924, 797), pos2 = Vector(9721, 9492, -97), name = 'Cub Foods'},
}
	
BigBlocks = {
	{pos1 = Vector(4849, -3722, 1647), pos2 = Vector(-3546, 5550, -163), name = 'the City'},
	{pos1 = Vector(9808, 14882, 1634), pos2 = Vector(3700, 3361, -491), name = 'Industrial'},
	{pos1 = Vector(-8255, 7443, 1641), pos2 = Vector(9738, 14898, -491), name = 'Industrial'},
	{pos1 = Vector(-5404, 3334, 1648), pos2 = Vector(-8227, -1081, -18), name = 'the Junction'},
	{pos1 = Vector(-7657, -5886, 1680), pos2 = Vector(7850, -11756, -2400), name = 'the Lake'},
	{pos1 = Vector(12845, 269, -800), pos2 = Vector(3643, 11702, -1743), name = 'the Suburbs'},
	{pos1 = Vector(3704, 5492, -1632), pos2 = Vector(2084, 47, -1665), name = 'Suburb Train Tunnels'},
	{pos1 = Vector(8695, -1414, -917), pos2 = Vector(14258, -14537, -1716), name = 'the Farms'},
}

KeepProps = {
	"models/props_wasteland/cargo_container01.mdl",
	"models/props_wasteland/cargo_container01b.mdl",
}