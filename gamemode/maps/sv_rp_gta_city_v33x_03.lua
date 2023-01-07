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


]]--

GM.VehicleSpawnPositions = {

	{ false, Vector( 7130.341797, -5831.835938, -1804.968750 ), Angle( -0.660005, 51.220100, 0.000000 ) },
	{ false, Vector( 6829.582520, -5759.768066, -1804.968750 ), Angle( -4.180004, 49.240028, 0.000000 ) },
	{ false, Vector( 6529.582520, -5759.768066, -1804.968750 ), Angle( -4.180004, 49.240028, 0.000000 ) },
	{ false, Vector( 6329.582520, -5759.768066, -1804.968750 ), Angle( -4.180004, 49.240028, 0.000000 ) },
	{ false, Vector( 5929.582520, -5759.768066, -1804.968750 ), Angle( -4.180004, 49.240028, 0.000000 ) },	
	{ false, Vector( 1512.983765, -5474.171875, -1812.968750 ), Angle( 1.320010, 46.660301, 0.000000 ) },
	{ false, Vector( 1673.431152, -5529.902832, -1812.968750 ), Angle( 6.600021, 47.540421, 0.000000 ) },
	{ false, Vector( 2017.968018, -5510.823242, -1812.968750 ), Angle( 0.880022, 51.720436, 0.000000 ) },
	{ false, Vector( 5629.582520, -5759.768066, -1804.968750 ), Angle( 5.280020, 49.080444, 0.000000 ) },
		
    -- firetrucks 

	{ TEAM_FIREMAN, Vector( 7250.236816, -3708.373535, -1779.968750), Angle(0.000012, 90, 0.000000)},
	{ TEAM_FIREMAN, Vector( 7250.236816, -3414.373535, -1779.968750), Angle(0.000012, 90, 0.000000)},
	{ TEAM_FIREMAN, Vector( 7250.236816, -3142.373535, -1779.968750), Angle(0.000012, 90, 0.000000)},	
	{ TEAM_FIRECHIEF, Vector(6191.398926, -2682.231201, -1779.968750), Angle(0.000012, 180, 0.000000)},
	{ TEAM_FIRECHIEF, Vector(6208.081055, -2288.357178, -1779.968750), Angle(0.000012, 180, 0.000000)},	
	
		
	
	-- Cop
	{ TEAM_POLICE, Vector( 3908.427734, -4143.791992, -2060.968750 ), Angle( 11.000003, 177.900162, 0.000000 ) },
	{ TEAM_POLICE, Vector( 3896.972900, -4440.754883, -2060.968750 ), Angle( 2.420007, 177.240280, 0.000000 ) },
	{ TEAM_POLICE, Vector( 3891.549805, -4691.388184, -2060.968750 ), Angle( 3.080005, -179.459747, 0.000000 ) },
	{ TEAM_POLICE, Vector( 3256.169189, -4451.617676, -2060.968750 ), Angle( 2.640005, 0.500295, 0.000000 ) },	
	{ TEAM_POLICE, Vector( 3267.736572, -4687.250488, -2060.968750 ), Angle( 4.179999, -0.379704, 0.000000 ) },
	{ TEAM_POLICE, Vector( 3260.323975, -5243.165527, -2060.968750 ), Angle( 8.360003, 1.820306, 0.000000 ) },
	
	-- SWAT
	{ TEAM_SWAT, Vector( 3267.736572, -4687.250488, -2060.968750 ), Angle( 4.179999, -0.379704, 0.000000 ) },
	{ TEAM_SWAT, Vector( 3260.323975, -5243.165527, -2060.968750 ), Angle( 8.360003, 1.820306, 0.000000 ) }, 

	-- Medic 

	{ TEAM_MEDIC, Vector(6191.398926, -2682.231201, -1779.968750), Angle(0.000012, 180, 0.000000)},
	{ TEAM_MEDIC, Vector(6208.081055, -2288.357178, -1779.968750), Angle(0.000012, 180, 0.000000)},	
	{ TEAM_MEDIC, Vector(7713.956055, -565.952209, -1779.968750), Angle(0.000012, 180, 0.000000)},
	
	-- tow trucks 

	{ TEAM_ROADSERVICE, Vector( 2223.444092, -2708.317383, -1907.968750 ), Angle( 0.000012, 180.540154, 0.000000 ) },
	{ TEAM_ROADSERVICE, Vector( 2219.476807, -2214.879395, -1907.968750 ), Angle( 0.000012, 180.540154, 0.000000 ) },
	
	
}

GM.AutoLockDoors = {
	{ Vector( -6967, -12459, 135 ), "*244" },
	{ Vector( -7089, -12459, 135 ), "*245" },
	{ Vector( 4066, -4757, 142 ), "*30" },
	{ Vector( 4598, -4057, 142 ), "*29" },
	{ Vector( -7368, -9844, -372 ), "*71" },
	{Vector(3480, -4490.009765625, -2318.75), 'models/props_c17/door03_left.mdl'},
	{Vector(3744, -4016.0100097656, -2318.75), 'models/props_c17/door03_left.mdl'},
	{Vector(4054, -4103.009765625, -2318.75), 'models/props_c17/door03_left.mdl'},

}

GM.AutoUnlockDoors = {
	{ Vector( -8992, -9985, 196 ), "*116" },
	{ Vector( -8992, -9769, 196 ), "*118" },
	{ Vector( -10703, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -6758, -10521, -124.5 ), "*145" },
	{ Vector( -6768, -8986, -377.75 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -6768, -8892, -377.75 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -3909, -8232, 290 ), "*60" },
	{ Vector( -3909, -7944, 290 ), "*58" },
	{ Vector( -3909, -7656, 290 ), "*59" },
	{ Vector( -7482, -9844, -372 ), "*71" },
	{ Vector( -3992, -6411, 2552.2500 ), "models/props_c17/door1_left.mdl" },
	{Vector(4110, -4306, -1815), '*166'},
	{Vector(4110, -4188, -1815), '*167'},
	{Vector(4110, -4050, -1815), '*164'},
	{Vector(4110, -3932, -1815), '*165'},
}

GM.AutoSpawnEntities = {
	-- Nexus front doors
	//{ Type = "prop_physics", Pos = Vector( -6758, -9040, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
	//{ Type = "prop_physics", Pos = Vector( -6758, -8762, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
}

GM.AutoDeleteEntities = {
	-- Nexus doors
	--{ Vector( -6784.369141, -9089.348633, 134.001617 ), "*141" },
	--{ Vector( -6784.369141, -8992.620117, 134.001617 ), "*142" },
	--{ Vector( -6760, -8784.974609, 134.001617 ), "*63" },
	--{ Vector( -6760, -8736.994141, 134.001617 ), "*140" },

	-- Hardware store door
	--{ Vector( -6454, -10233, 127.500000 ), "*64" },

	-- Bank doors
	--{ Vector( -7092, -7757, 134.998825 ), "*171" },
	--{ Vector( -7092, -7692.999512, 134.998825 ), "*172" },

	-- Firetruck doors
	{ Vector( -3909, -8232, 290 ), "*60" },
	{ Vector( -3909, -7944, 290 ), "*58" },
	{ Vector( -3909, -7656, 290 ), "*59" },

	-- Firetruck door buttons
	{ Vector( -3904.978760, -8139, 265.218750 ), "*150" },
	{ Vector( -3904.978760, -7849, 265.218750 ), "*149" },
	{ Vector( -3904.978760, -7743, 265.218750 ), "*148" },

	-- Car dealer rolling door (exit)
	{ Vector( 4066, -4757, 142 ), "*30" },

	-- Car dealer rolling door (exit) button
	{ Vector( 4177, -4750, 122 ), "*31" },

	-- Car dealer rolling door (showroom)
	{ Vector( 4598, -4057, 142 ), "*29" },

	-- Car dealer rolling door (showroom) button
	{ Vector( 4591, -3958, 125.437500 ), "*32" },
	{ Vector( 4605, -3958, 125.437500 ), "*28" },

	-- Jail props (Police NPC)
	{ Vector( -6991.657715, -8855.500977, -415.015656 ), "models/props_wasteland/controlroom_desk001b.mdl" },
	{ Vector( -6960.001953, -8818.676758, -407.151276 ), "models/u4lab/chair_office_a.mdl" },
	{ Vector( -7023.970703, -8820.331055, -407.031006 ), "models/u4lab/chair_office_a.mdl" },

	-- Props infront of medic + jail npc
	{ Vector( -3815.947510, -6991.911621, 250.144196 ), "models/props/cs_office/computer_monitor.mdl" },
	{ Vector( -3815.947510, -7048.911621, 250.175446 ), "models/props/cs_office/computer_monitor.mdl" },
	{ Vector( -3803.984619, -7047.365234, 224.365738 ), "models/props/cs_office/chair_office.mdl" },
	{ Vector( -3803.556641, -6985.030762, 222.216553 ), "models/props/cs_office/chair_office.mdl" },

	-- Cop rolling door
	{ Vector( -6892, -10160, -88 ), "*68" },

	-- Cop rolling door (buttoned)
	{ Vector( -7906, -9204.5, 888 ), "*145" },

	-- Cop rolling door (buttons)
	{ Vector( -7744, -9204.5, 888 ), "*144" },
	{ Vector( -7912, -9204.5, 888 ), "*146" },

	-- Cop rolling door (exit/entry)
	{ Vector( -7782, -10415, -90 ), "*65" },
}

GM.JailLocations = {
	Vector( 3559, -5143, -2330 ),
	Vector( 3238, -5139, -2330 ),
	Vector( 3231, -5286, -2330 ),
	Vector( 3530, -5273, -2330 ),
	Vector( 3556, -5390, -2330 ),
	Vector( 3233, -5403, -2330 ),
	Vector( 3233, -5533, -2330 ),
	Vector( 3541, -5520, -2330 ),
}

GM.SpawnPoints = {}



GM.SpawnPoints[ TEAM_CITIZEN ] = {
    { Vector (3189.249756, -2137.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3159.249756, -2147.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3139.249756, -2157.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3119.249756, -2167.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3089.249756, -2187.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3069.249756, -2187.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3089.249756, -2187.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3059.249756, -2187.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3039.249756, -2187.733154, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3009.249756, -2187.733154, -1854.968750), Angle( 0, 0, 0 ) },	
	{ Vector (4376.361816, -1144.471680, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (4271.594727, -1154.577026, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (4168.736328, -1237.098511, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (4383.202148, -1398.064941, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (4388.497559, -1552.489258, -1854.968750), Angle( 0, 0, 0 ) },	
	{ Vector (4204.420410, -1605.808350, -1854.968750), Angle( 0, 0, 0 ) },
	{ Vector (3416.525879, -1044.473022, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3440.947021, -1122.782959, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3474.189453, -1229.379028, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3520.654541, -1401.291748, -1803.210938), Angle( 0, 0, 0 ) },
	{ Vector (3549.729004, -1500.223389, -1800.932983), Angle( 0, 0, 0 ) },
	{ Vector (3681.225098, -1840.078369, -1798.657471), Angle( 0, 0, 0 ) },
}

--[[
ADD MORE POINTS

]]--



GM.SpawnPoints[ TEAM_FIREMAN ] = {
	{ Vector (3189.249756, -2137.733154, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3159.249756, -2147.733154, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3169.249756, -2157.733154, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3179.249756, -2167.733154, -1804.968750), Angle( 0, 0, 0 ) },
}


GM.SpawnPoints[ TEAM_POLICE ] = {
	{ Vector (3179.133301, -4384.851563, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3255.091553, -4279.139648, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3206.375488, -4536.961914, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3419.622559, -3900.189697, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3532.517090, -3916.971191, -1804.968750), Angle( 0, 0, 0 ) },
}

GM.SpawnPoints[ TEAM_SWAT ] = GM.SpawnPoints[ TEAM_POLICE ]
GM.SpawnPoints[ TEAM_DISPATCHER ] = GM.SpawnPoints[ TEAM_POLICE ]

GM.SpawnPoints[ TEAM_ROADSERVICE ] = {
	{ Vector (3189.249756, -2137.733154, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3159.249756, -2147.733154, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3169.249756, -2157.733154, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3179.249756, -2167.733154, -1804.968750), Angle( 0, 0, 0 ) },
}



GM.SpawnPoints[ TEAM_MEDIC ] = {
	{ Vector (9335.389648, -1432.446289, -1675.526611), Angle( 0, 0, 0 ) },
	{ Vector (8923.995117, -1466.047974, -1666.534546), Angle( 0, 0, 0 ) },
	{ Vector (8440.272461, -1433.095215, -1656.681274), Angle( 0, 0, 0 ) },
	{ Vector (8006.083984, -1478.354126, -1676.116821), Angle( 0, 0, 0 ) },
}

GM.SpawnPoints[ TEAM_SECRET_SERVICE ] = {
	{ Vector (3179.133301, -4384.851563, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3255.091553, -4279.139648, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3206.375488, -4536.961914, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3419.622559, -3900.189697, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3532.517090, -3916.971191, -1804.968750), Angle( 0, 0, 0 ) },
}

StreetBlocks = {
	{pos1 = Vector(-6327, -3482, 50), pos2 = Vector(-5682, -12517, 300), name = "Main Street"},
}
	
CityBlocks = {
	{pos1 = Vector(74, 9212, 50), pos2 = Vector(-3759, 2698, 840), name = "the MTL Headquarters"},
	{pos1 = Vector(4264, 4595, 50), pos2 = Vector(2868, 3583, 666), name = "the Power Plant"},
	{pos1 = Vector(2100, 3583, 50), pos2 = Vector(436, 4607, 666), name = "the Small Depot"},
	{pos1 = Vector(-4647, -5120, 180), pos2 = Vector(-3410, -8635, 600), name = "the Upper Mainstreet Shops"},
	{pos1 = Vector(-4801, -8022, 600), pos2 = Vector(-5732, -5738, 50), name = "the Mainstreet Shops"},
	{pos1 = Vector(-6395, -7966, 260), pos2 = Vector(-8000, -7245, 50), name = "the Bank of America"},
	{pos1 = Vector(-7423, -7310, 40), pos2 = Vector(-6286, -5741, 500), name = "the BP Station"},
	{pos1 = Vector(-6333, -5116, 40), pos2 = Vector(-8318, -3473, 700), name = "Burger King"},
	{pos1 = Vector(-5721, -5148, 60), pos2 = Vector(-3655, -4352, 328), name = "the Tides Hotel"},
	{pos1 = Vector(-6297, -8566, -400000), pos2 = Vector(-8313, -10859, 500000), name = "the Government Center Block"},
	{pos1 = Vector(-8465, -7911, 50), pos2 = Vector(-9612, -12525, 815), name = "the City Park"},
	{pos1 = Vector(-9659, -12525, 790), pos2 = Vector(-10988, -7976, 50), name = "the Sidestreet Shops and City Apartments"},
	{pos1 = Vector(-8464, -11715, 800), pos2 = Vector(-5676, -14920, 50), name = "Izzie's Palace"},
	{pos1 = Vector(8680, 15265, 50), pos2 = Vector(12748, 11341, 606), name = "the Outlands BP Station"},
	{pos1 = Vector(-2480, 15127, 50), pos2 = Vector(-6620, 10439, 737), name = "the Small Suburban Houses"},
	{pos1 = Vector(-5980, 15236, 50), pos2 = Vector(-14142, 10470, 616), name = "the Lake"},
	{pos1 = Vector(2727, 5402, 50), pos2 = Vector(407, 8270, 700), name = "the Industrial Complex"},
	{pos1 = Vector(5407, 5178, 50), pos2 = Vector(2695, 9040, 700), name = "the Industrial Warehouses/Shops"},
	{pos1 = Vector(-8095, 8236, 50), pos2 = Vector(-11639, 10171, 699), name = "the Hospital"},
	{pos1 = Vector(5875, 15330, 708), pos2 = Vector(9166, 9408, 50), name = "the Suburbs Entrance Road"},
	{pos1 = Vector(5900, 9400, 723), pos2 = Vector(-796, 15245, 25), name = "the Large Suburban Houses"},
	{pos1 = Vector(2355, -8814, 50), pos2 = Vector(-1666, -4794, 635), name = "the Abandoned Inn"},
	{pos1 = Vector(-5726, -8567, 50), pos2 = Vector(-3636, -9669, 2000), name = "the Skyscraper"},
	{pos1 = Vector(7423, -6203, 50), pos2 = Vector(2404, -2769, 662), name = "Downtown Motors"},
	{pos1 = Vector(2344, -6638, 50), pos2 = Vector(8399, -8806, 700), name = "Hersch Shipping Co"},
}
	
BigBlocks = {
	{pos1 = Vector(-719, 2888, 666), pos2 = Vector(5390, 9194, 60), name = "the Industrial Zone"},
	{pos1 = Vector(-204, 2909, 65), pos2 = Vector(276, 615, 319), name = "the Industrial Zone Tunnel"},
	{pos1 = Vector(552, 619, 669), pos2 = Vector(-6566, -1398, 40), name = "the Central Exchange"},
	{pos1 = Vector(-5220, 585, 65), pos2 = Vector(-4741, 4115, 319), name = "the Lake Access Tunnel"},
	{pos1 = Vector(-3982, 4125, 668), pos2 = Vector(-12107, 10232, 40), name = "the Lake Access Road"},
	{pos1 = Vector(-727, -1379, 65), pos2 = Vector(-1207, -4766, 320), name = "the Outlands Tunnel"},
	{pos1 = Vector(8432, -703, 656), pos2 = Vector(7121, -6782, 40), name = "the Outlands Entrance Road"},
	{pos1 = Vector(-1700, -2767, 665), pos2 = Vector(6356, -8753, 40), name = "the Rural Area"},
	{pos1 = Vector(6548, 5457, 0), pos2 = Vector(12522, -596, 669), name = "the Country Area"},
	{pos1 = Vector(11808, 5469, 64), pos2 = Vector(12287, 11258, 320), name = "the Suburban Tunnel"},
	{pos1 = Vector(12882, 9400, 666), pos2 = Vector(-9538, 15325, 40), name = "the Suburban Area"},
	{pos1 = Vector(-6244, -1379, 65), pos2 = Vector(-5764, -3462, 320), name = "the City Tunnel"},
	{pos1 = Vector(-9620, -3462, 80000), pos2 = Vector(-2404, -11509, -50000), name = "the City"},
}

KeepProps = {

}

GM.NextBotMarkers = {
	{Vector(-6298.8442382813, -8587.7783203125, 72.03125)},
	{Vector(-9606.9814453125, -8582.4580078125, 72.03125)},
	{Vector(-6292.5336914063, -11813.063476563, 72.03125)},
	{Vector(-9601.015625, -11812.915039063, 72.03125)},
	{Vector(-5718.5981445313, -12488.684570313, 72.03125)},
	{Vector(-6299.3227539063, -8683.8251953125, 72.031265258789)},
}

GM.DrugDealerHangouts = {
	// Nexus walls
	{Vector(-6778.3432617188, -8603, 72.03125), Angle(0, 90, 0)},
	{Vector(-7259.8432617188, -8603, 72.03125), Angle(0, 90, 0)},
	{Vector(-7740.5932617188, -8603, 72.03125), Angle(0, 90, 0)},

	// High Rise walls
	//{Vector(-7668.3989257813, -11810.897460938, 72.031265258789), Angle(0, -90, 0)},

	// Bank
	{Vector(-7694.205078125, -7970, 72.031257629395), Angle(0, -90, 0)},

	// Shops
	{Vector(-5456, -7606, 72.03125), Angle(0, 180, 0)},
	{Vector(-5456, -7280, 72.03125), Angle(0, 180, 0)},

	// Apartments
	{Vector(-10795.793945313, -10346.462890625, 72.03125), Angle(0, -90, 0)},
	{Vector(-10519.674804688, -11094, 72.000015258789), Angle(0, -90, 0)},
}