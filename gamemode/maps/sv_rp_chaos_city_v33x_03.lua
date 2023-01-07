--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

//To any and all people who touch this, ROUND YOUR VECTOR POINTS! OR I WILL KILL YOU!
//Signed the guy who fixed all of the vector locations

GM.VehicleSpawnPositions = {
//Car Spawn points
//Parking Garage
	{ false, Vector( 5733, -5700, -1875 ), Angle( 0, 0, 0) },
	{ false, Vector( 6829, -5700, -1875 ), Angle( 0, 0, 0 ) },
	{ false, Vector( 6529, -5700, -1875 ), Angle( 0, 0, 0 ) },
	{ false, Vector( 6329, -5700, -1875 ), Angle( 0, 0, 0 ) },
	{ false, Vector( 5929, -5700, -1875 ), Angle( 0, 0, 0 ) },
	//Dealer - Dealer wall side
	{ false, Vector( 1841, -5531, -1875 ), Angle( 0, 0, 0 ) },
	{ false, Vector( 1675, -5531, -1875 ), Angle( 0, 0, 0 ) },
	{ false, Vector( 1503, -5531, -1875 ), Angle( 0, 0, 0 ) },
	//Dealer- Appartment side
	{ false, Vector( 2003, -4727, -1875 ), Angle( 0, -180, 0 ) },
	{ false, Vector( 2169, -4727, -1875 ), Angle( 0, -180, 0 ) },
	{ false, Vector( 1842, -4727, -1875 ), Angle( 0, -180, 0 ) },

//Firetruck
	{ TEAM_FIREMAN, Vector( 7250, -3708, -1780), Angle(0, 90, 0)},
	{ TEAM_FIREMAN, Vector( 7250, -3414, -1780), Angle(0, 90, 0)},
	{ TEAM_FIREMAN, Vector( 7250, -3142, -1780), Angle(0, 90, 0)},
	{ TEAM_FIRECHIEF, Vector( 6191, -2682, -1780), Angle(0, 180, 0)},
	{ TEAM_FIRECHIEF, Vector( 6208, -2288, -1780), Angle(0, 180, 0)},

//Police
	{ TEAM_POLICE, Vector( 3908, -4143, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_POLICE, Vector( 3896, -4440, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_POLICE, Vector( 3891, -4691, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_POLICE, Vector( 3256, -4451, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_POLICE, Vector( 3267, -4687, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_POLICE, Vector( 3260, -5243, -2060 ), Angle( 0, -90, 0 ) },

//Police Chief
	{ TEAM_CHIEF, Vector( 3908, -4143, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_CHIEF, Vector( 3896, -4440, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_CHIEF, Vector( 3891, -4691, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_CHIEF, Vector( 3256, -4451, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_CHIEF, Vector( 3267, -4687, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_CHIEF, Vector( 3260, -5243, -2060 ), Angle( 0, -90, 0 ) },

//Detective
	{ TEAM_DETECTIVE, Vector( 3908, -4143, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_DETECTIVE, Vector( 3896, -4440, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_DETECTIVE, Vector( 3891, -4691, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_DETECTIVE, Vector( 3256, -4451, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_DETECTIVE, Vector( 3267, -4687, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_DETECTIVE, Vector( 3260, -5243, -2060 ), Angle( 0, -90, 0 ) },

//SWAT
	{ TEAM_SWAT, Vector( 3908, -4143, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_SWAT, Vector( 3896, -4440, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_SWAT, Vector( 3891, -4691, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_SWAT, Vector( 3256, -4451, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_SWAT, Vector( 3267, -4687, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_SWAT, Vector( 3260, -5243, -2060 ), Angle( 0, -90, 0 ) },

//FBI
	{ TEAM_FBI, Vector( 3908, -4143, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_FBI, Vector( 3896, -4440, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_FBI, Vector( 3891, -4691, -2060 ), Angle( 0, 90, 0 ) },
	{ TEAM_FBI, Vector( 3256, -4451, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_FBI, Vector( 3267, -4687, -2060 ), Angle( 0, -90, 0 ) },
	{ TEAM_FBI, Vector( 3260, -5243, -2060 ), Angle( 0, -90, 0 ) },

//Medic
	{ TEAM_MEDIC, Vector(7710, -501, -1757), Angle(0, 180, 0)},
	{ TEAM_MEDIC, Vector(7713, -1112, -1757), Angle(0, 0, 0)},
	{ TEAM_MEDIC, Vector(7148, -1350, -1757), Angle(0, -90, 0)},

//Tow Truck
	{ TEAM_ROADSERVICE, Vector( -10426, 14784, -1489 ), Angle( 0, 180, 0 ) },
	{ TEAM_ROADSERVICE, Vector( -10076, 14318, -1489 ), Angle( 0, 90, 0 ) },

	{ TEAM_BUSDRIVER, Vector( -9672, 6947, -1490 ), Angle( 0, 180, 0 ) },
	{ TEAM_BUSDRIVER, Vector( -9267, 6947, -1490 ), Angle( 0, 180, 0 )},
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
	{Vector(5341, 883.98999023438, -1814.75), 'models/props_c17/door01_left.mdl'},
	{Vector(4101, -4204.009765625, -2318.75), 'models/props_c17/door03_left.mdl'}, //PD
	{Vector(4101, -4110.009765625, -2318.75), 'models/props_c17/door03_left.mdl'}, //PD
}

GM.AutoSpawnEntities = {
	-- Nexus front doors
	//{ Type = "prop_physics", Pos = Vector( -6758, -9040, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
	//{ Type = "prop_physics", Pos = Vector( -6758, -8762, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
	--{ Model = Model( "models/props_wasteland/interior_fence002e.mdl" ), Pos = Vector( 3830.8037109375, -4022.1125488281, -1804.4616699219 ), Angle = Angle( 0.88046932220459, 179.99945068359, -0.39553833007812) },
	--{ Model = Model( "models/props_wasteland/interior_fence002e.mdl" ), Pos = Vector( 3830.5859375, -4275.1694335938, -1802.0816650391 ), Angle = Angle( 1.7611531019211, 179.4395904541, 0.04779052734375) },
		--{ Model = Model( "models/MLD/xmasstocking.mdl" ), Pos = Vector( 4191.7729492188, -3382.2092285156, -1751.96875 ), Angle = Angle( 0, 179.4395904541, 0) },
//General Store
	{ Type = "prop_physics", Model = Model( "models/props_bank/prop_bank_counter.mdl" ), Pos = Vector( 5551, 1240, -1868 ), Angle = Angle( 0, -180, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_bank/prop_bank_counter.mdl" ), Pos = Vector( 5834, 1245, -1868 ), Angle = Angle( 0, 90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_bank/prop_bank_counter.mdl" ), Pos = Vector( 5835, 1054, -1868 ), Angle = Angle( 0, 90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_office/file_cabinet_03.mdl" ), Pos = Vector( 5902, 851, -1868 ), Angle = Angle( 0, -180, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_interiors/shelvinggrocery01.mdl" ), Pos = Vector( 5772, 848, -1868 ), Angle = Angle( 0, 90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_interiors/shelvinggrocery01.mdl" ), Pos = Vector( 5669, 848, -1868 ), Angle = Angle( 0, 90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_interiors/shelvinggrocery01.mdl" ), Pos = Vector( 5557, 848, -1868 ), Angle = Angle( 0, 90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_interiors/shelvinggrocery01.mdl" ), Pos = Vector( 5559, 1037, -1868 ), Angle = Angle( 0, -90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_interiors/shelvinggrocery01.mdl" ), Pos = Vector( 5630, 1037, -1868 ), Angle = Angle( 0, -90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_interiors/shelvinggrocery01.mdl" ), Pos = Vector( 5630, 1073, -1868 ), Angle = Angle( 0, 90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_interiors/shelvinggrocery01.mdl" ), Pos = Vector( 5559, 1073, -1868 ), Angle = Angle( 0, 90, 0) },
	{ Type = "prop_physics", Model = Model( "models/props_wasteland/controlroom_desk001a.mdl" ), Pos = Vector( 5366, 1061, -1852 ), Angle = Angle( 0, 0, 0) },
//City Gas Station
	{ Type = "prop_physics", Model = Model( "models/props_urban/ice_machine001.mdl" ), Pos = Vector( 3435, 325, -1869 ), Angle = Angle( 0, -90, 0) },
//City hall No-Parking
	{ Type = "prop_physics", Model = Model( "models/props/cs_assault/NoStopsSign.mdl" ), Pos = Vector( 3607, -3820, -1868 ), Angle = Angle( 0, 45, 0) },
	{ Type = "prop_physics", Model = Model( "models/props/cs_assault/NoStopsSign.mdl" ), Pos = Vector( 4089, -3820, -1868 ), Angle = Angle( 0, 45, 0) },
	{ Type = "prop_physics", Model = Model( "models/props/cs_assault/NoStopsSign.mdl" ), Pos = Vector( 3141, -3820, -1868 ), Angle = Angle( 0, 45, 0) },

	//Metal Detectors
	{ Type = "prop_metal_detector_venom", Model = Model( "models/props_wasteland/interior_fence002e.mdl" ), Pos = Vector( 3828, -4022.7, -1820 ), Angle( 0, 180, 0 ) },
	{ Type = "prop_metal_detector_venom", Model = Model( "models/props_wasteland/interior_fence002e.mdl" ), Pos = Vector( 3828, -4275.7, -1820 ), Angle( 0, 180, 0 ) },
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

	-- PD desk
	{ Vector( 3877, -4078.0100097656, -2356.1999511719 ), "models/props_wasteland/controlroom_desk001b.mdl" },

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
	Vector( 3229, -5139, -2370 ),
	Vector( 3229, -5281, -2370 ),
	Vector( 3229, -5286, -2370 ),
	Vector( 3229, -5273, -2370 ),
	Vector( 3543, -5515, -2370 ),
	Vector( 3543, -5390, -2370 ),
	Vector( 3543, -5269, -2370 ),
	Vector( 3543, -5127, -2370 ),
}

GM.SpawnPoints = {}

GM.SpawnPoints[ TEAM_CITIZEN ] = {
	{ Vector (4143, -2188, -1869), Angle( 0, 177, 0)},
	{ Vector (4147, -2107, -1867), Angle( 0, 177, 0)},
	{ Vector (4155, -1957, -1860), Angle( 0, 177, 0)},
	{ Vector (4161, -1844, -1856), Angle( 0, 177, 0)},
	{ Vector (4168, -1720, -1864), Angle( 0, 178, 0)},
	{ Vector (4143, -1568, -1868), Angle( 0, 178, 0)},
	{ Vector (4297, -1636, -1859), Angle( 0, -177, 0)},
	{ Vector (4375, -1639, -1855), Angle( 0, -171, 0)},
	{ Vector (4448, -1683, -1857), Angle( 0, -172, 0)},
	{ Vector (4404, -1764, -1851), Angle( 0, -172, 0)},
	{ Vector (4254, -1803, -1848), Angle( 0, -174, 0)},
	{ Vector (4288, -1914, -1844), Angle( 0, -174, 0)},
	{ Vector (4293, -1980, -1844), Angle( 0, -176, 0)},
	{ Vector (4378, -2036, -1859), Angle( 0, -177, 0)},
	{ Vector (4469, -1973, -1866), Angle( 0, -178, 0)},
	{ Vector (4489, -1873, -1859), Angle( 0, -178, 0)},
	{ Vector (4484, -1779, -1860), Angle( 0, -178, 0)},
	{ Vector (4497, -2139, -1868), Angle( 0, 176, 0)},
	{ Vector (4379, -2152, -1868), Angle( 0, 176, 0)},
	{ Vector (4262, -2163, -1869), Angle( 0, 176, 0)},
	{ Vector (4269, -2258, -1869), Angle( 0, 178, 0)},
	{ Vector (3898, -2266, -1869), Angle( 0, 177, 0)},
	{ Vector (3888, -2099, -1867), Angle( 0, 177, 0)},
	{ Vector (3893, -1949, -1865), Angle( 0, 177, 0)},
	{ Vector (3898, -1824, -1867), Angle( 0, 177, 0)},
	{ Vector (3883, -1714, -1860), Angle( 0, 178, 0)},
	{ Vector (3896, -1486, -1861), Angle( 0, 174, 0)},
	{ Vector (3855, -1384, -1850), Angle( 0, -40, 0)},
	{ Vector (3776, -1277, -1833), Angle( 0, 10, 0)},
	{ Vector (3676, -1148, -1841), Angle( 0, -4, 0)},
	{ Vector (3570, -1195, -1858), Angle( 0, -30, 0)},
	{ Vector (3607, -1375, -1859), Angle( 0, -38, 0)},
	{ Vector (3583, -1576, -1868), Angle( 0, -9, 0)},
	{ Vector (3641, -1711, -1857), Angle( 0, -30, 0)},
	{ Vector (3555, -1791, -1864), Angle( 0, -16, 0)},
	{ Vector (3606, -1916, -1865), Angle( 0, -9, 0)},
	{ Vector (3761, -1956, -1866), Angle( 0, -7, 0)},
	{ Vector (3747, -2057, -1867), Angle( 0, -7, 0)},
	{ Vector (3653, -2074, -1866), Angle( 0, -7, 0)},
	{ Vector (3598, -2118, -1867), Angle( 0, -8, 0)},
	{ Vector (3599, -2210, -1869), Angle( 0, -18, 0)},
	{ Vector (3724, -2243, -1869), Angle( 0, -13, 0)},
	{ Vector (3673, -2338, -1869), Angle( 0, -6, 0)},
	{ Vector (3590, -2472, -1869), Angle( 0, -36, 0)},
	{ Vector (3404, -2209, -1871), Angle( 0, 5, 0)},
	{ Vector (3457, -2066, -1869), Angle( 0, 8, 0)},
	{ Vector (3459, -1979, -1869), Angle( 0, 7, 0)},
	{ Vector (3478, -1883, -1869), Angle( 0, 7, 0)},
	{ Vector (3263, -2109, -1869), Angle( 0, -8, 0)},
	{ Vector (3157, -2111, -1869), Angle( 0, -7, 0)},
	{ Vector (3032, -2109, -1869), Angle( 0, -3, 0)},
	{ Vector (2943, -2172, -1869), Angle( 0, -3, 0)},
	{ Vector (3063, -2218, -1869), Angle( 0, -3, 0)},
	{ Vector (3285, -2214, -1869), Angle( 0, -3, 0)},
	{ Vector (3269, -2327, -1870), Angle( 0, -3, 0)},
	{ Vector (3144, -2320, -1874), Angle( 0, -3, 0)},
	{ Vector (3063, -2316, -1869), Angle( 0, -3, 0)},
	{ Vector (2963, -2311, -1869), Angle( 0, -4, 0)},
	{ Vector (2968, -2522, -1869), Angle( 0, -29, 0)},
	{ Vector (3110, -2549, -1877), Angle( 0, -12, 0)},
	{ Vector (3239, -2645, -1867), Angle( 0, -6, 0)},
	{ Vector (3221, -2756, -1867), Angle( 0, -14, 0)},
	{ Vector (3059, -2787, -1870), Angle( 0, -33, 0)},
	{ Vector (3009, -2953, -1857), Angle( 0, -9, 0)},
	{ Vector (3077, -3052, -1859), Angle( 0, 4, 0)},
	{ Vector (3223, -3067, -1864), Angle( 0, 3, 0)},
	{ Vector (3321, -2968, -1862), Angle( 0, 24, 0)},
	{ Vector (3433, -2764, -1868), Angle( 0, 7, 0)},
	{ Vector (3543, -3005, -1869), Angle( 0, 94, 0)},

}

GM.SpawnPoints[ TEAM_FIREMAN ] = {
	{ Vector (7194, -2482, -1742 ), Angle( 0, 180, 0) },
	{ Vector (7193, -2567, -1742 ), Angle( 0, 180, 0) },
	{ Vector (7280, -2570, -1742 ), Angle( 0, 180, 0) },
	{ Vector (7283, -2486, -1742 ), Angle( 0, 180, 0) },
	{ Vector (7355, -2488, -1742 ), Angle( 0, 180, 0) },
	{ Vector (7415, -2487, -1742 ), Angle( 0, 180, 0) },
	{ Vector (7412, -2564, -1742 ), Angle( 0, 180, 0) },
}

GM.SpawnPoints[ TEAM_POLICE ] = {
	//{ Vector (3179.133301, -4384.851563, -1804.968750), Angle( 0, 0, 0 ) },
	//{ Vector (3255.091553, -4279.139648, -1804.968750), Angle( 0, 0, 0 ) },
	//{ Vector (3206.375488, -4536.961914, -1804.968750), Angle( 0, 0, 0 ) },
	//{ Vector (3419.622559, -3900.189697, -1804.968750), Angle( 0, 0, 0 ) },
	//{ Vector (3532.517090, -3916.971191, -1804.968750), Angle( 0, 0, 0 ) },

	{ Vector( 3561, -4326, -1868 ), Angle( 0, 0, 0 ) },
	{ Vector( 3563, -4188, -1868 ), Angle( 0, 0, 0 ) },
	{ Vector( 3557, -4036, -1868 ), Angle( 0, 0, 0 ) },
	{ Vector( 3555, -3892, -1868 ), Angle( 0, 0, 0 ) },
	{ Vector( 3405, -3904, -1868 ), Angle( 0, 0, 0 ) },
	{ Vector( 3411, -4061, -1868 ), Angle( 0, 0, 0 ) },
	{ Vector( 3423, -4192, -1868 ), Angle( 0, 0, 0 ) },
	{ Vector( 3419, -4336, -1868 ), Angle( 0, 0, 0 ) },
}

GM.SpawnPoints[ TEAM_SWAT ] = GM.SpawnPoints[ TEAM_POLICE ]
GM.SpawnPoints[ TEAM_DISPATCHER ] = GM.SpawnPoints[ TEAM_POLICE ]

GM.SpawnPoints[ TEAM_ROADSERVICE ] = {
	{ Vector (-10268, 14790, -1481), Angle( 0, 180, 0 ) },
	{ Vector (-10280, 14721, -1481), Angle( 0, 180, 0 ) },
	{ Vector (-10266, 14617, -1481), Angle( 0, 180, 0 ) },
	{ Vector (-10268, 14553, -1481), Angle( 0, 180, 0 ) },
}

GM.SpawnPoints[ TEAM_MEDIC ] = {
	{ Vector (8316, -1232, -1742), Angle( 0, 90, 0 ) },
	{ Vector (8254, -1218, -1743), Angle( 0, 90, 0 ) },
	{ Vector (8000, -1231, -1743), Angle( 0, 90, 0 ) },
	{ Vector (8106, -1036, -1743), Angle( 0, 90, 0 ) },
	{ Vector (8263, -1044, -1743), Angle( 0, 90, 0 ) },
	{ Vector (7968, -1010, -1742), Angle( 0, 0, 0 ) },
}

GM.SpawnPoints[ TEAM_SECRET_SERVICE ] = {
	{ Vector (3179.133301, -4384.851563, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3255.091553, -4279.139648, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3206.375488, -4536.961914, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3419.622559, -3900.189697, -1804.968750), Angle( 0, 0, 0 ) },
	{ Vector (3532.517090, -3916.971191, -1804.968750), Angle( 0, 0, 0 ) },
}


//Broken not sure if its vector points
StreetBlocks = {

}

CityBlocks = {
	//Big Block: City [FULLY COMPLETE]
	{ pos1 = Vector( 4536, -3832, -1869 ), pos2 = Vector( 3097, -5902, 3000 ), name = "Nexus" },
	{ pos1 = Vector( 4492, -5851, -1881 ), pos2 = Vector( 2749, -3819, -2911 ), name = "Police Department" },
	{ pos1 = Vector( 5193, -3831, -1869 ), pos2 = Vector( 7240, -5143, 0 ), name = "Sky Scraper" },
	{ pos1 = Vector( 2901, -3183, -2200 ), pos2 = Vector( 4546, -988, 1280 ), name = "City Park" },
	{ pos1 = Vector( 2188, -339, -1869 ), pos2 = Vector( -950, -3175, 695 ), name = "Bank" },
	{ pos1 = Vector( 5811, -2530, -1885 ), pos2 = Vector( 5426, -2152, 422 ), name = "Small Shops" },
	{ pos1 = Vector( 5811, -2530, -1869 ), pos2 = Vector( 5420, -3173, 422 ), name = "Large Shops" },
	{ pos1 = Vector( 5193, -5183, -1869 ), pos2 = Vector( 7225, -5944, -1294 ), name = "City Parking Garage" },
	{ pos1 = Vector( 6881, -1566, -1743 ), pos2 = Vector( 10285, 92, 808 ), name = "Hospital" },
	{ pos1 = Vector( 6855, -2419, -1742 ), pos2 = Vector( 7468, -3861, -618 ), name = "Fire Station"},
	{ pos1 = Vector( 3178, -7744, -1869 ), pos2 = Vector( 4501, -10265, -235 ), name = "Izzies Palace" },
	{ pos1 = Vector( 2251, -6903, -1869 ), pos2 = Vector( 1294, -5667, 89 ), name = "Downtown Motors" },
	{ pos1 = Vector( 5433, -1698, -1869 ), pos2 = Vector( 6034, -993, 356 ), name = "Facial and Clothing Store" },
	{ pos1 = Vector( 5315, 824, -1869 ), pos2 = Vector( 5936, 1335, -983 ), name = "General Store" },
	{ pos1 = Vector( 5315, 586, -1869 ), pos2 = Vector( 5936, 820, -983 ), name = "Store 1" },
	{ pos1 = Vector( 5315, 170, -1869 ), pos2 = Vector( 5936, 586, -983 ), name = "Store 2" },
	{ pos1 = Vector( 5315, -330, -1869 ), pos2 = Vector( 5936, 166, -983 ), name = "Store 3" },
	{ pos1 = Vector( 2064, -3832, -1869 ), pos2 = Vector( 1298, -4582, 1470 ), name = "Nice Apartments" },
	{ pos1 = Vector( 585, -7031, -1869 ), pos2 = Vector( -711, -3761, -315 ), name = "Apartments" },

	//Big Block: N/A [FULLY COMPLETE]
	{ pos1 = Vector( 3179, 10421, -1869 ), pos2 = Vector( 203, 12135, -1152 ), name = "Burger King" },

	//Big Block: Industrial [FULLY COMPLETE]
	{ pos1 = Vector( 4537, 1354, -1869 ), pos2 = Vector( 1614, -330, 25 ), name = "City BP Gas Station" },
	{ pos1 = Vector( -6658, 6015, -1490 ), pos2 = Vector( -8960, 4090, -646 ), name = "Outter BP Gas Station" },
	{ pos1 = Vector( -6798, 6634, -1482 ), pos2 = Vector( -12618, 13607, -50 ), name = "MTL HQ" },
	{ pos1 = Vector( -2978, 11943, -1662 ), pos2 = Vector( -4817, 9385, 83 ), name = "Power Plant" },
	{ pos1 = Vector( -3501, 6195, -1490 ), pos2 = Vector( -4022, 7085, 249 ), name = "Material Plant" },
	{ pos1 = Vector( -4969, 14952, -1481 ), pos2 = Vector( -5652, 14471, 999 ), name = "Industrial Bunker" },
	{ pos1 = Vector( -7934, 14512, -1482 ), pos2 = Vector( -8310, 15278, 72 ), name = "Shop A" },
	{ pos1 = Vector( -8318, 14512, -1482 ), pos2 = Vector( -8699, 15143, 72 ), name = "Shop B" },
	{ pos1 = Vector( -8702, 14512, -1480 ), pos2 = Vector( -10363, 15281, 576 ), name = "Chop Shop" },
	{ pos1 = Vector( -11861, 15130, -1490 ), pos2 = Vector( -13154, 14482, 576 ), name = "Hersh Storage" },
	{ pos1 = Vector( -14987, 12359, -1489 ), pos2 = Vector( -13820, 15135, 756 ), name = "Hersh Shipping Co" },

	//Big Block: Suburbs
	{ pos1 = Vector( -7782, -14866, -2167 ), pos2 = Vector( -8546, -15263, -872 ), name = "Suburbs Lake House #1" },
	{ pos1 = Vector( -12722, -14343, -2166 ), pos2 = Vector( -13484, -14740, -872 ), name = "Suburbs Lake House #2" },
	{ pos1 = Vector( -14529, -13199, -2161 ), pos2 = Vector( -14933, -12440, -872 ), name = "Suburbs Lake House #3" },
	{ pos1 = Vector( -13760, -11540, -2152 ), pos2 = Vector( -12721, -11568, -872 ), name = "Suburbs Lake House #4" }, --Needs to be fixed, has issues.
}

BigBlocks = {
	{ pos1 = Vector( -716, 1492, 3053 ), pos2 = Vector( 11400, -10100, -2500 ), name = "City" },
	{ pos1 = Vector( -1965, 2525, -2270 ), pos2 = Vector( -16228, 15884, 471 ), name = "Industrial Area" },
	{ pos1 = Vector( -724, -5538, -2700 ), pos2 = Vector( -4999, -14001, 420 ), name = "Suburbs Forest Road" },
	{ pos1 = Vector( -4990, -16168, -2360 ), pos2 = Vector( -16010, -10446, 2600 ), name = "Suburbs" },
	{ pos1 = Vector( 5560, 1521, -2085 ), pos2 = Vector( -1965, 10428, 114 ), name = "Main Street Trail" },
	{ pos1 = Vector( -13141, -3094, -2255 ), pos2 = Vector( -7094, -10464, -86 ), name = "Lake" },
	{ pos1 = Vector( -8050, -3127, -3000 ), pos2 = Vector( -13982, 2615, 614 ), name = "Tides" },
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
