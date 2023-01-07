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

	//Civilian Spawns / Extra Spawns for TEAMS
	//Town Hall
	{ false, Vector(-3591, -6332, 0), Angle(1, 89, 0) },
	{ false, Vector(-3605, -5958, 0), Angle(1, 91, 0) },
	{ false, Vector(-3605, -5814, 0), Angle(1, 90, 0) },
	{ false, Vector(-3605, -5657, 0), Angle(1, 90, 0) },
	{ false, Vector(-3595, -5482, 0), Angle(0, -91, 0) },
	{ false, Vector(-2916, -5700, 0), Angle(3, -92, 0) },
	{ false, Vector(-2920, -5893, 0), Angle(1, -91, 0) },
	{ false, Vector(-2921, -6026, 0), Angle(1, -91, 0) },
	{ false, Vector(-2923, -6195, 0), Angle(0, -91, 0) },
	{ false, Vector(-2925, -6370, 0), Angle(0, 90, 0) },

	//Car Dealer
	{ false, Vector(-4917, -1310, 0), Angle(-1, 179, 0) },
	{ false, Vector(-4717, -1314, 0), Angle(-1, 180, 0) },
	{ false, Vector(-4585, -1317, 0), Angle(0, 180, 0) },
	{ false, Vector(-4388, -1320, 0), Angle(1, -1, 0) },
	{ false, Vector(-3748, -1320, 0), Angle(0, 0, 0) },
	{ false, Vector(-3567, -1319, 0), Angle(0, 0, 0) },
	{ false, Vector(-3371, -1318, 0), Angle(0, 0, 0) },
	{ false, Vector(-3155, -1318, 0), Angle(0, 0, 0) },
	{ false, Vector(-2969, -1316, 0), Angle(0, 0, 0) },

	//Underground Parking
	{ false, Vector( -11056.426757812, -4038.0910644531, -207.96875 ), Angle( 2.0118589401245, -1.4114866256714, 0)    },
	{ false, Vector( -11056.426757812, -4038.0910644531, -207.96875 ), Angle( 0.55985927581787, -83.647453308105, 0)   },
	{ false, Vector( -11056.426757812, -4038.0910644531, -207.96875 ), Angle( 5.7078585624695, -176.31146240234, 0)    },
	{ false, Vector( -11056.426757812, -4038.0910644531, -207.96875 ), Angle( 0.82388454675674, -0.22347883880138, 0)  },
	{ false, Vector( -10912.22265625, -4036.2744140625, -207.96875 ), Angle( 0.82388454675674, 1.6245208978653, 0)     },
	{ false, Vector( -10755.53125, -4033.5053710938, -207.96875 ), Angle( -1.1561160087585, -179.34762573242, 0)       },
	{ false, Vector( -10698.658203125, -4680.6821289062, -207.96875 ), Angle( -1.0241149663925, 179.59594726562, 0)    },
	{ false, Vector( -10867.876953125, -4679.66015625, -207.96875 ), Angle( -1.0241149663925, 179.72793579102, 0)      },
	{ false, Vector( -11221.859375, -4669.02734375, -207.96875 ), Angle( 0.4278849363327, -0.48804080486298, 0)        },

	//TEAM VEHICLE SPAWN POINTS

	//POLICE	
	{ TEAM_POLICE, Vector(-7917, -5527, 0), Angle(0, 179, 0) },
	{ TEAM_POLICE, Vector(-8049, -5521, 0), Angle(0, 177, 0) },
	{ TEAM_POLICE, Vector(-8227, -5513, 0), Angle(0, 177, 0) },
	{ TEAM_POLICE, Vector(-8415, -5505, 0), Angle(0, 178, 0) },
	{ TEAM_POLICE, Vector(-8503, -6078, 0), Angle(4, 90, 0) },
	{ TEAM_POLICE, Vector(-8497, -6252, 0), Angle(1, -92, 0) },
	{ TEAM_POLICE, Vector(-8227, -6354, 0), Angle(1, -90, 0) },
	{ TEAM_POLICE, Vector(-8338, -5866, 0), Angle(-1, 180, 0) },

	//DETECTIVE
	{ TEAM_DETECTIVE, Vector(-7917, -5527, 0), Angle(0, 179, 0) },
	{ TEAM_DETECTIVE, Vector(-8049, -5521, 0), Angle(0, 177, 0) },
	{ TEAM_DETECTIVE, Vector(-8227, -5513, 0), Angle(0, 177, 0) },
	{ TEAM_DETECTIVE, Vector(-8415, -5505, 0), Angle(0, 178, 0) },
	{ TEAM_DETECTIVE, Vector(-8503, -6078, 0), Angle(4, 90, 0) },
	{ TEAM_DETECTIVE, Vector(-8497, -6252, 0), Angle(1, -92, 0) },
	{ TEAM_DETECTIVE, Vector(-8227, -6354, 0), Angle(1, -90, 0) },
	{ TEAM_DETECTIVE, Vector(-8338, -5866, 0), Angle(-1, 180, 0) },

	//FBI
	{ TEAM_FBI, Vector(-8499.166992, -6085.135742, 64.031250), Angle(10.042877, -90.492844, 0.000000)},
	{ TEAM_FBI, Vector(-8241.208008, -5544.228027, 64.031250), Angle(13.099924, 179.979858, 0.000000)},
	{ TEAM_FBI, Vector(-8086.456055, -5568.869629, 64.031250), Angle(13.099924, 179.979858, 0.000000)},

	//CHIEF
	{ TEAM_CHIEF, Vector(-8499.166992, -6085.135742, 64.031250), Angle(10.042877, -90.492844, 0.000000)},
	{ TEAM_CHIEF, Vector(-8241.208008, -5544.228027, 64.031250), Angle(13.099924, 179.979858, 0.000000)},
	{ TEAM_CHIEF, Vector(-8086.456055, -5568.869629, 64.031250), Angle(13.099924, 179.979858, 0.000000)},
	
	//SWAT
	{ TEAM_SWAT, Vector(-7345, -5929, 8), Angle(1, 91, 0) },

	//NATIONAL GUARD - TOWN HALL PARKING LOT
	{ TEAM_NATIONAL, Vector(-3331, -5667, 0), Angle(1, 179, 0) },
	{ TEAM_NATIONAL, Vector(-3335, -5986, 0), Angle(1, 179, 0) },
	{ TEAM_NATIONAL, Vector(-3340, -6343, 0), Angle(1, 179, 0) },
	{ TEAM_NATIONAL, Vector(-3141, -6345, 0), Angle(1, 179, 0) },
	{ TEAM_NATIONAL, Vector(-3135, -5926, 0), Angle(1, 179, 0) },
	{ TEAM_NATIONAL, Vector(-3132, -5626, 0), Angle(1, 179, 0) },
	{ TEAM_NATIONAL, Vector(-2922, -5713, 0), Angle(-1, -91, 0) },
	{ TEAM_NATIONAL, Vector(-2922, -5870, 0), Angle(0, -90, 0) },
	{ TEAM_NATIONAL, Vector(-2921, -6039, 0), Angle(0, -90, 0) },
	{ TEAM_NATIONAL, Vector(-2922, -6181, 0), Angle(0, -90, 0) },
	{ TEAM_NATIONAL, Vector(-2922, -6353, 0), Angle(0, -90, 0) },


	//Medic
	//HOSPITAL
	{ TEAM_MEDIC, Vector(-1295, -5621, 0), Angle(-2, -92, 0) },
	{ TEAM_MEDIC, Vector(-1371, -6107, 0), Angle(-1, 179, 0) },
	{ TEAM_MEDIC, Vector(-1541, -6104, 0), Angle(0, -180, 0) },
	{ TEAM_MEDIC, Vector(-1710, -6104, 0), Angle(1, 180, 0) },
	
	//Fire Department
	//FIRE STATION
	{ TEAM_MEDIC, Vector(-5510, -3285, 8), Angle(1, 0, 0) },
	{ TEAM_MEDIC, Vector(-5273, -3275, 8), Angle(-1, 0, 0) },
	{ TEAM_MEDIC, Vector(-4982, -3279, 8), Angle(-2, 0, 0) },
	{ TEAM_MEDIC, Vector(-4750, -3293, 8), Angle(0, 0, 0) },
	{ TEAM_FIREMAN, Vector(-5510, -3285, 8), Angle(1, 0, 0) },
	{ TEAM_FIREMAN, Vector(-5273, -3275, 8), Angle(-1, 0, 0) },
	{ TEAM_FIREMAN, Vector(-4982, -3279, 8), Angle(-2, 0, 0) },
	{ TEAM_FIREMAN, Vector(-4750, -3293, 8), Angle(0, 0, 0) },
	{ TEAM_FIRECHIEF, Vector(-5510, -3285, 8), Angle(1, 0, 0) },
	{ TEAM_FIRECHIEF, Vector(-5273, -3275, 8), Angle(-1, 0, 0) },
	{ TEAM_FIRECHIEF, Vector(-4982, -3279, 8), Angle(-2, 0, 0) },
	{ TEAM_FIRECHIEF, Vector(-4750, -3293, 8), Angle(0, 0, 0) },

	//Tow Yard
	{ TEAM_ROADSERVICE, Vector(-7538, 1455, -1), Angle(1, -179, 0) },
	{ TEAM_ROADSERVICE, Vector(-7208, 1469, 0), Angle(3, 0, 0) },
	{ TEAM_ROADSERVICE, Vector(-7518, 734, 4), Angle(2, -180, 0) },
	
	//Bus
	{ TEAM_BUSDRIVER, Vector(-2036, 4142, 536), Angle(2, -1, 0) },
	{ TEAM_BUSDRIVER, Vector(-1434, 4463, 536), Angle(2, -91, 0) },

	//Taxi
	{ TEAM_TAXI, Vector(-2926, -5521, 0), Angle(4, 89, 0) },
	{ TEAM_TAXI, Vector(-2941, -5714, 0), Angle(-1, -90, 0) },


}

GM.DemoRespawn = {
	Vector(-4904,-1007,0),
	Vector(-4782,-893,0),
	Vector(-4658,-1005,0),
	Vector(-4506,-862,0),
}

GM.AutoLockDoors = {
	{Vector(4571, 13817, 144), 'models/props_c17/door01_left.mdl'},
	{Vector(-6967, -12459, 135), '*244'},
	{Vector(-7089, -12459, 135), '*245'}
}

GM.AutoUnlockDoors = {
	{Vector(-8892, -5786, 60.25), 'models/props/storedoor1.mdl'},
	{Vector(-8892, -5878, 60.25), 'models/props/storedoor1.mdl'},
	{Vector(-7804, -5654, 60), 'models/props/storedoor1.mdl'},
	{Vector(-7804, -5746, 60), 'models/props/storedoor1.mdl'},
}

GM.AutoSpawnEntities = {
	--{ Type = "prop_physics", Pos = Vector( -6758, -9040, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
	--{ Type = "prop_physics", Pos = Vector( -6758, -8762, 72 ), Angle = Angle( 0, 0, 0 ), Model = "models/props_trainstation/trainstation_post001.mdl" },
}

GM.AutoDeleteEntities = {

}

local AutoOpenDoors =	{
	{Vector(-7050, -6424, 52), '*116'},
}


GM.JailLocations = {
	Vector( -7423.96875, -5267.81640625, 8.03125 ),
	Vector( -7181.7866210938, -5267.5947265625, 14 ),
	Vector( -7178.0517578125, -5160.6953125, 14 ),
	Vector( -7380.8950195313, -5169.2700195313, 14 ),
	Vector( -7154.8740234375, -5051.5576171875, 14 ),
	Vector( -7396.3076171875, -5072.23046875, 14 ),
}


--WORKING LIFE ALERT AREAS - PUT THEM HERE (BELOW) - DO NOT PUT IN LIFEALERt.LUA AS IT WONT WORK! 

StreetBlocks = {
	{pos1 = Vector(-46, 286, 544), pos2 = Vector(-647, 5464, 2816), name = "Waverly St."},
	{pos1 = Vector(-2742, -2105, 8), pos2 = Vector(-38, 541, 2816), name = "Waverly St. (At Car Dealer)"},
	{pos1 = Vector(-2678, -1991, 7), pos2 = Vector(-2145, -11675, 1792), name = "Waverly St. (Hospital Street)"},
	{pos1 = Vector(3218, 538, 546), pos2 = Vector(-81, 1139, 2816), name ="Grif Rd. (At Taco Bell)"},
	{pos1 = Vector(-2355, 7495, 536), pos2 = Vector(3283, 6886, 2816), name ="Grif Rd."},
	{pos1 = Vector(-2822, 4719, 542), pos2 = Vector(-2349, 15360, 1619), name ="Century Ave."},
	{pos1 = Vector(3941, 4680, 536), pos2 = Vector(7636, 10395, 35617), name ="Suburbs Access Road (Subs Hill)"},
	{pos1 = Vector(-9481, 4657, 8), pos2 = Vector(3723, 5231, 2816), name ="Grant Ave. (RTA Street)"},
	{pos1 = Vector(-9595, 10111, 17), pos2 = Vector(-8899, -7207, 1792), name ="Cosmos St.(Shop A & B Street)"},
	{pos1 = Vector(-12874, -2679, 2), pos2 = Vector(-2077, -2076, 1792), name ="BroadWay (Fire & EMS Street)"},
	{pos1 = Vector(4139, -15183, -512), pos2 = Vector(-15232, -10701, 983), name ="South Country Road (Country House)"},
	{pos1 = Vector(-2623, -7163, 0), pos2 = Vector(-10567, -6435, 1792), name ="Cosmos St. (Town Hall Street)"},
	{pos1 = Vector(-7071, -7552, 10), pos2 = Vector(-6417, 10107, 1792), name ="Main St.(General Store Street)"},
	{pos1 = Vector(-12514, -15232, -460), pos2 = Vector(-15207, 15341, 1792), name ="West Country Road (Outer Shell Street)"},
	{pos1 = Vector(-15232, 12591, 360), pos2 = Vector(15360, 15358, 1423), name ="North Country Road (Ravine)"},
	{pos1 = Vector(13283, 15360, 1847), pos2 = Vector(15358, -3010, 28), name ="East Country Road (Lake Area)"},
}

CityBlocks = {
	{pos1 = Vector(1372, 1104, 544), pos2 = Vector(2701, 4592, 2816), name = "Casino / Shops 200"},
	{pos1 = Vector(-2243, 4751, 536), pos2 = Vector(-761, 3754, 2816), name = "Rockford Transit Authority"},				
	{pos1 = Vector(2177, 7424, 539), pos2 = Vector(-2306, 10158, 2816), name = "Mesa Apartments"},
	{pos1 = Vector(-572, 6976, 536), pos2 = Vector(2755, 5328, 2816), name = "Grocery Store"},
	{pos1 = Vector(-713, 5260, 536), pos2 = Vector(-2286, 6896, 2816), name = "Tavern / Realtor"},
	{pos1 = Vector(-2752, -2752, 8), pos2 = Vector(-3986, -3698, 1792), name = "Bank of America"},
	{pos1 = Vector(-3975, -2752, 0), pos2 = Vector(-6285, -4330, 1792), name = "Fire Department / Paramedic Building"},
	{pos1 = Vector(-7251, -3439, 8), pos2 = Vector(-7691, -2879, 1792), name = "General Store"},
	{pos1 = Vector(-8700, -2722, 8), pos2 = Vector(-7838, -4339, 1792), name = "Shop A & B"},
	{pos1 = Vector(-6375, -2029, 8), pos2 = Vector(-2660, -61, 1792), name = "General Motors / Car Dealer"},
	{pos1 = Vector(-2100, -4524, 0), pos2 = Vector(666, -7674, 1792), name = "General Hospital"},
	{pos1 = Vector(-2132, -4519, 0), pos2 = Vector(2400, -1140, 1792), name = "Waverly @ Hospital"},
	{pos1 = Vector(-6996, -534, 0), pos2 = Vector(-8914, -2010, 1792), name = "Parking Garage"},
	{pos1 = Vector(-6996, -561, 0), pos2 = Vector(-7683, 1363, 1792), name = "Tow Yard"},
	{pos1 = Vector(-8896, -551, 8), pos2 = Vector(-7804, 1845, 1792), name = "Shop C, D, E (Behind Tow Yard)"},
	{pos1 = Vector(-9566, -2018, -512), pos2 = Vector(-11301, 561, 33948), name = "Club Catalyst"},
	{pos1 = Vector(-30, 1062, 544), pos2 = Vector(1290, 2954, 2816), name = "Taco Bell"},
	{pos1 = Vector(1188, 2973, 544), pos2 = Vector(69, 4600, 2816), name = "Suburbs Shell"},
	{pos1 = Vector(-6992, 5328, 8), pos2 = Vector(-8963, 8828, 1792), name = "Industrial Area"},
	{pos1 = Vector(15355, -1432, 132), pos2 = Vector(4123, -15232, 1707), name = "Lake Area"},
	{pos1 = Vector(-5504, -6466, 8), pos2 = Vector(-2737, -4525, 1792), name = "Town Hall"},
	{pos1 = Vector(-4485, -7163, 8), pos2 = Vector(-2630, -8082, 1792), name = "Slums Apartments"},
	{pos1 = Vector(-7112, -6456, 0), pos2 = Vector(-8908, -4912, 1792), name = 'Police Department'},
	{pos1 = Vector(-544, 1040, 536), pos2 = Vector(-674, 978, 571), name = 'Movie Theater'},


}

BigBlocks = {
	{pos1 = Vector(-10351, 3442, 1792), pos2 = Vector(1640, -8399, -512), name = "City Area"},
	{pos1 = Vector(-4290, 2026, 1792), pos2 = Vector(-10312, 9984, -512), name = "Industrial Area"},
	{pos1 = Vector(-3746, 969, -512), pos2 = Vector(4643, 10807, 2816), name = "Upper City Area (7/11, Taco Bell)"},
	{pos1 = Vector(-15200, 13677, -512), pos2 = Vector(15291, 14500, 2816), name = "Ravine"},
	{pos1 = Vector(7283, 710, 1544), pos2 = Vector(11808, 8591, 2444), name = "Suburbs"},
	{pos1 = Vector(2177, 7424, 539), pos2 = Vector(-2306, 10158, 2816), name = "Mesa Apartments"},
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
	{Vector( -4564.7114257813, -8111.96875, 8.03125 ), Angle( 0, 90, 0 )},
	{Vector( -3658.9763183594, -8111.96875, 0.03125 ), Angle( 0, 88.856506347656, 0)},
	{Vector( -3959.96875, -3717.4064941406, 0.025306701660156 ), Angle( 0, 0, 0)},
	{Vector( -8015.96875, -3573.6982421875, 8.03125 ), Angle( 0, 0, 0)},
	{Vector( -10082.6015625, -1825.6646728516, 8.03125 ), Angle( 0, -37.043556213379, 0)},
	{Vector( -7972.8305664063, -480.03125, 0.03125 ), Angle( 0, -90, 0)},

}