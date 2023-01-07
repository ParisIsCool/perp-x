--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


if CLIENT then
	Material( "tools/toolsblack" ):SetInt( "$alpha", 0 )
end

InnerCity = {
}

policeDoors = {
    { Vector( 8781.96875, 7930, -385 ), '*396' },
    { Vector( 9099, 9096, 250 ), '*411' },
    { Vector( 8366, 8554, 344 ), '*434' },
    { Vector( 8782, 7877.78125, -65 ), '*395' },
    { Vector( 7690, 7853, 252 ), '*374' },
    { Vector( 8514, 8976, -48 ), '*401' },
    { Vector( 9118, 7206, 256 ), '*388' },
    { Vector( 9030, 8140, 252 ), '*393' },
    { Vector( 8756, 7494, 256 ), '*423' },
    { Vector( 8786.03125, 7830.28125, 255.5 ), '*426' },
    { Vector( 8518, 7140, 248.28125 ), '*811' },
    { Vector( 8612, 6886, 248.28125 ), '*389' },
    { Vector( 8917, 8180, 256 ), '*400' },
    { Vector( 8781.96875, 7930.15625, -65 ), '*394' },
    { Vector( 9237, 8864, 250 ), '*414' },
    { Vector( 8562, 8554, 344 ), '*431' },
    { Vector( 8782, 7878, -385 ), '*397' },
    { Vector( 9237, 9096, 250 ), '*415' },
    { Vector( 8730, 7532, -68 ), '*384' },
    { Vector( 9080, 8510, 256 ), '*402' },
    { Vector( 8782, 7830.1875, 255 ), '*379' },
    { Vector( 8230, 7636, 252 ), '*392' },
    { Vector( 8938, 7464, -388 ), '*391' },
    { Vector( 8678, 7384, -388 ), '*390' },
    { Vector( 9099, 9328, 250 ), '*412' },
    { Vector( 8366, 8662, 344 ), '*433' },
    { Vector( 8781.96875, 7977.8125, 255 ), '*378' },
    { Vector( 8438, 8868, 344 ), '*382' },
    { Vector( 8714, 7640, 256 ), '*380' },
    { Vector( 8029.96875, 8976, -48 ), '*398' },
    { Vector( 8767, 8961, -24 ), '*417' },
    { Vector( 8440, 7742, -68 ), '*385' },
    { Vector( 9312, 8510, 256 ), '*403' },
    { Vector( 8562, 8662, 344 ), '*432' },
    { Vector( 8606, 7640, 256 ), '*381' },
    { Vector( 7690, 7955, 252 ), '*375' },
    { Vector( 8440, 7634, -68 ), '*386' },
    { Vector( 8786, 7977.8125, 255.5 ), '*425' },
    { Vector( 9062, 8264, -68 ), '*418' },
    { Vector( 7866, 7768, 256 ), '*377' },
    { Vector( 7974, 7768, 256 ), '*376' },
    { Vector( 9099, 8864, 250 ), '*410' },
    { Vector( 9237, 9328, 250 ), '*413' },
    { Vector( 8794, 7142, 256 ), '*387' },
    {Vector(-2982,3840,-38),"*111"},
}

fireDoors = {
    {Vector(9312,8510,256), "*403"},
	{Vector(9312,8510,256), "*403"},
	{Vector(9312,8510,256), "*403"},
	{Vector(9132,1590,-52), "*189"},
	{Vector(9132,1590,-52), "*189"},
	{Vector(9132,1481,-52), "*188"},
	{Vector(9128,1288,-3), "*182"},
    {Vector(9128,1791,-3), "*183"},
}

emptyDoor = {
    {Vector(-2410,5928,101), "*159"},
	{Vector(-2496,1064,-111), "models/unioncity2/propper/manholecover.mdl"},
	{Vector(-3176,6024,49), "models/unioncity2/propper/manholecover.mdl"},
	{Vector(1096,8152,97), "models/unioncity2/propper/manholecover.mdl"},
	{Vector(4216,7064,129), "models/unioncity2/propper/manholecover.mdl"},
	{Vector(3479,7351,219), "models/unioncity2/props_street/alley_dumpsterlid.mdl"},
	{Vector(4168,1992,-103), "models/unioncity2/propper/manholecover.mdl"},
	{Vector(4712,1917,-11), "*162"},
    {Vector(3478,7348,221), "*161"},
	{Vector(4216,7064,129), "models/unioncity2/propper/manholecover.mdl"},
    {Vector(-98,7390,221), "*160"},
	{Vector(594,8281,192), "*771"},

}

civilDoors = {
	{ Vector( 3148, 5222, 56 ), '*470' },
    { Vector( 3112, 5113.84375, 280 ), '*471' },
    { Vector( 3112, 4998.125, 280 ), '*472' },
    { Vector( 3432, 5113.84375, 56 ), '*467' },
    { Vector( 3432, 4998.125, 56 ), '*468' },
    { Vector( 3148, 4890, 56 ), '*469' },
}

clubDoors = {
}

BankDoor = {
    {Vector(-1583,2178,-44),"*558"},
	{Vector(-1489,2178,-44),"*559"},
    { Vector( -383, 2481, -8 ), '*549' },
    { Vector( -473, 3369, -8 ), '*561' },
    { Vector( -624, 2440, -36 ), '*518' },
    { Vector( -694, 2780, -48 ), '*519' },
    { Vector( -901, 3040, -48 ), '*520' },
    { Vector( -624, 2520, -36 ), '*517' },
}

CinemaDoors = {
}

RealtorOfficeDoors = {
}

BPShopDoors = {
    {Vector(618,13838,191),"*335"},
	{Vector(726,13838,191),"*336"},
	{Vector(432,14199,191.25),"*325"},
	{Vector(504,14199,191.25),"*326"},
	{Vector(726,13838,191),"*336"},
	{Vector(618,13838,191),"*335"},
	{Vector(348,14110,188),"*327"},
	{Vector(76,14086,188),"*324"},
	{Vector(181.84375,14380,189),"*328"},
	{Vector(182,14632,189),"*329"},
}

GasShopDoor = {
    { Vector( -6038, 1604, 28 ), '*152' },
    { Vector( -5724, 1441, 39 ), '*155' },
    { Vector( -5926, 1166, 28 ), '*151' },
    { Vector( -5796, 1441, 39 ), '*154' },
    { Vector( -6388, 1754, 28 ), '*153' },
    { Vector( -6423.75, 1602, 61 ), '*163' },
}

FCStoreDoors = {
    {Vector(-2024,10868,180),"*310"},
	{Vector(-2136,10868,180),"*309"},
	{Vector(-2362,10496,180),"*311"},
	{Vector(-2249.96875,10316,180),"*312"},
}

TidesHotelDoors = {
}

ShopsDoors = {
    {Vector(-1009.96875,11494,188),"*323"},
	{Vector(-508,11558,188),"*321"},
	{Vector(-332,11558,188),"*322"},
}

CarDealerDoors = {
    { Vector( -7121.59375, 1355, 20 ), '*167' },
    { Vector( -7238.375, 1355, 20 ), '*166' },
}

HospitalDoors = {
    { Vector( 7173, 5052.25, 1 ), '*511' },
    { Vector( 7382.5, 4840, 280 ), '*486' },
    { Vector( 7888.21875, 4996, 280 ), '*501' },
    { Vector( 6998.5, 4840, 280 ), '*483' },
    { Vector( 7610, 5436, 276 ), '*487' },
    { Vector( 7529.5, 5000, 280 ), '*484' },
    { Vector( 7311.75, 5004, 280.25 ), '*499' },
    { Vector( 7311.75, 5004, 560 ), '*497' },
    { Vector( 7609.8125, 4842, 560 ), '*494' },
    { Vector( 7480.21875, 5373, 560 ), '*492' },
    { Vector( 7179.96875, 5199.75, -1 ), '*476' },
    { Vector( 7591.75, 5373, 560 ), '*493' },
    { Vector( 7766.5, 4840, 280 ), '*485' },
    { Vector( 7179.96875, 5152.21875, 279 ), '*479' },
    { Vector( 7200.21875, 5004, 280.25 ), '*500' },
    { Vector( 6776, 4953.5, 280 ), '*482' },
    { Vector( 7180, 5099.75, 279 ), '*478' },
    { Vector( 7172.96875, 5199.75, 1 ), '*510' },
    { Vector( 7355.96875, 5682, 276 ), '*488' },
    { Vector( 7179.96875, 5152.21875, 559 ), '*481' },
    { Vector( 7693.8125, 4994, 560 ), '*495' },
    { Vector( 7772, 5512.21875, 280 ), '*503' },
    { Vector( 6620, 4817.5, 560 ), '*505' },
    { Vector( 7508, 4874, 7 ), '*474' },
    { Vector( 6995.96875, 5322, 276.25 ), '*489' },
    { Vector( 6995.96875, 5322, -3.75 ), '*490' },
    { Vector( 7772, 5623.75, 280 ), '*504' },
    { Vector( 7396, 4874, 7 ), '*475' },
    { Vector( 7180, 5099.75, 559 ), '*480' },
    { Vector( 7200.21875, 5004, 560 ), '*496' },
    { Vector( 7999.75, 4996, 280 ), '*502' },
    { Vector( 7180, 5052.21875, -1 ), '*477' },
    { Vector( 6995.96875, 5322, 556.25 ), '*491' },
	{ Vector( 6902.15625, 4842, 560 ), '*498' },
	{ Vector( 7452, 4874, 7 ), '*474' },
}

GovermentCenterDoors = {
}

JailsDoors = {
}


Apartments1Doors = {
}

Apartments2Doors = {
}

ApartmentsDoors = {
}


RoadCrewDoors = {
    {Vector(-1852,5990,76),"*131"},
    {Vector(-1896,6240,160),"*133"},
    {Vector(-1896,6632,160),"*132"},
    {Vector(-2298,6452,76),"*137"},
    {Vector(-2428,6294,76),"*138"},
    {Vector(-2618,6212,76),"*136"},
}

CasinoDoors = {
}

HardwareStoreDoors = {
    {Vector(1448,-1036,-44),"*121"},
	{Vector(1414,-1691,-44),"*303"},
	{Vector(1907,-1750,-44),"*302"},
}

CityFurniture = {}

UnionSqDoors = {
    {Vector(1449.96875,2694,-44),"*436"},
    {Vector(1562,2694,-44),"*437"},
    {Vector(1134,3300,-44),"*438"},
    {Vector(1538,2981,-36),"*444"},
    {Vector(1440,2987,-36),"*460"},
    {Vector(1438,2981,-36),"*443"},
    {Vector(1538,2981,-36),"*444"},
    {Vector(1538,2981,-36),"*444"},
    {Vector(1538,2981,-36),"*444"},
    {Vector(1506,2981,228),"*446"},
    {Vector(1470,2981,228),"*445"},
    {Vector(1506,2981,492),"*448"},
    {Vector(1470,2981,492),"*447"},
    {Vector(1506,2981,756),"*450"},
    {Vector(1470,2981,756),"*449"},
    {Vector(1854,2908,1080),"*458"},
}

WorldCorpDoors = {
    {Vector(-1130.1875,5505.96875,-49),"*569"},    
    {Vector(-1076.6846923828,5506,-49),"*570"},    
    {Vector(-922,5420,972.25),"*592"},    
    {Vector(-1077.8125,5506,975),"*573"},    
    {Vector(-1130.1875,5505.96875,975),"*574"},    
    {Vector(-1269.8125,5506,975),"*575"},    
    {Vector(-1322.1875,5505.96875,975),"*576"},    
    {Vector(-922,5420,1252),"*593"},    
    {Vector(-1077.8125,5506,1255),"*577"},    
    {Vector(-1130.1875,5505.96875,1255),"*578"},    
    {Vector(-1269.8125,5506,1255),"*579"},    
    {Vector(-1322.1875,5505.96875,1255),"*580"},    
    {Vector(-922,5420,1532.5),"*594"},    
    {Vector(-1269.8125,5506,1535),"*582"},    
    {Vector(-1322.1875,5505.96875,1535),"*581"},    
    {Vector(-1130.1875,5505.96875,1535),"*583"},    
    {Vector(-1077.8125,5506,1535),"*584"},    
    {Vector(-922,5420,1812.5),"*595"},    
    {Vector(-1130.1875,5505.96875,1815),"*586"},    
    {Vector(-1077.8125,5506,1815),"*585"},    
    {Vector(-1269.8125,5506,1815),"*587"},    
    {Vector(-1322.1875,5505.96875,1815),"*588"},    
    {Vector(-1510,5516,1812.5),"*617"},
}

LaGrandeDoors = {
    {Vector(7670,1188,820),"*679"},
    {Vector(6642,2044,-32),"*695"},
	{Vector(6642,1988,-32),"*696"},
	{Vector(7186,1388,831), "*693"},
	{Vector(7186,1332,831), "*692"},
    {Vector(7520,1237,-39),"*687"},
    {Vector(7670,1188,-44),"*682"},
    {Vector(7670,1188,180),"*681"},
    {Vector(7520,1237,185),"*688"},
    {Vector(7670,1188,500),"*680"},
    {Vector(7520,1237,505),"*689"},
    {Vector(7520,1237,825),"*690"},
    {Vector(7470,1237,-39),"*687"},
    {Vector(7470,1227.46875,-41),"*702"},
}

MotelReceptionDoors = {{Vector(-3580,378,-36),"*150"}}

BigZones = {
	{ pos1 = Vector(-13571,-15320,-1524), pos2 = Vector(17202,-3831,2020), name = "Ocean" },
	{ pos1 = Vector(-13546,-3874,-1558), pos2 = Vector(-4724,-1084,1188), name = "Ocean" },
	{ pos1 = Vector(10125,9424,701), pos2 = Vector(-10391,-38,-87), name = "Alleyway" },
	{ pos1 = Vector(-3312,8288,-132), pos2 = Vector(4352,-3947,-638), name = "Sewers" },
	{ pos1 = Vector(2800,4346,-56), pos2 = Vector(5293,6720,2020), name = "Town Square Park" },
	{ pos1 = Vector(2560,1248,-104), pos2 = Vector(704,128,2020), name = "Union Square Park" },
	{ pos1 = Vector(4159,-6332,-1029), pos2 = Vector(6878,-3851,232), name = "Docks" },
	{ pos1 = Vector(1207,-7309,-1122), pos2 = Vector(-1746,-3470,468), name = "Panatlantic Docks" },
	{ pos1 = Vector(5366,-2591,-208), pos2 = Vector(2187,-95,2020), name = "Salvage Yard" },
	{ pos1 = Vector(595,-2591,-240), pos2 = Vector(2187,-95,2020), name = "Allyway" },
	{ pos1 = Vector(-3731,-2628,-240), pos2 = Vector(138,-958,2020), name = "Industrial Warehouses" },
}

StreetBlocks = {
	--{ pos1 = Vector(9425,-3745,-900), pos2 = Vector(-10369,8830,2020), name = "City" },
    { speed = 30, pos1 = Vector(1916,9728,120), pos2 = Vector(2816,12798,2020), name = "Maple Road" },
	{ speed = 30, pos1 = Vector(-7040,11904,120), pos2 = Vector(2816,12798,2020), name = "Maple Road" },
    { speed = 65, pos1 = Vector(-7040,11904,120), pos2 = Vector(-11712,12798,2020), name = "Maple Road" },
	{ speed = 65, pos1 = Vector(-11712,-128,-48), pos2 = Vector(-11200,12798,2020), name = "Maple Road" },
	{ pos1 = Vector(-2817,9728,120), pos2 = Vector(-3710,14699,2020), name = "Memory Lane" },
	{ pos1 = Vector(3457,8634,120), pos2 = Vector(5312,8830,2020), name = "North Street" },
	{ speed = 65, pos1 = Vector(-3710,9728,120), pos2 = Vector(-6144,8830,2020), name = "North Street" },
    { pos1 = Vector(6208,9728,120), pos2 = Vector(-3710,8830,2020), name = "North Street" },
	{ pos1 = Vector(-5249,4352,-48), pos2 = Vector(-6144,2751,2020), name = "North Street" },
    { speed = 65, pos1 = Vector(-5249,9728,-48), pos2 = Vector(-6144,4352,2020), name = "North Street" },
	{ pos1 = Vector(-833,6655,0), pos2 = Vector(-1731,8830,2020), name = "Gho Street" },
	{ pos1 = Vector(2816,6655,0), pos2 = Vector(1916,8830,2020), name = "Aversion Avenue" },
	{ pos1 = Vector(6208,6655,120), pos2 = Vector(5312,8830,2020), name = "Whiskey Road" },
	{ pos1 = Vector(9024,6655,0), pos2 = Vector(5312,5760,2020), name = "Haviture Way" },
	{ pos1 = Vector(9024,6655,-113), pos2 = Vector(8128,-1024,2020), name = "Haviture Way" },
	{ pos1 = Vector(9024,6655,-113), pos2 = Vector(8128,-1024,2020), name = "Haviture Way" },
	{ pos1 = Vector(9024,-128,-113), pos2 = Vector(6208,-1024,2020), name = "Haviture Way" },
	{ pos1 = Vector(2816,6655,0), pos2 = Vector(-1731,5760,2020), name = "13th Street" },
	{ pos1 = Vector(-192,6655,-240), pos2 = Vector(704,-2560,2020), name = "13th Street" },
	{ pos1 = Vector(-192,6655,0), pos2 = Vector(1282,6856,2020), name = "13th Street" },
	{ speed = 30, pos1 = Vector(10176,4352,-64), pos2 = Vector(3456,3456,2020), name = "New Life Street" },
	{ pos1 = Vector(2560,4352,-112), pos2 = Vector(3456,-1024,2020), name = "Union Square" },
	{ pos1 = Vector(704,4546,-112), pos2 = Vector(-2944,3456,2020), name = "Crooked Lane" },
	{ speed = 30, pos1 = Vector(-2048,4352,-112), pos2 = Vector(-2944,-128,2020), name = "Bank Street" },
	{ pos1 = Vector(-8576,1856,-112), pos2 = Vector(-2944,2751,2020), name = "Pleasant Road" },
	{ pos1 = Vector(5308,4352,-176), pos2 = Vector(6208,-2560,2020), name = "Grand Way" },
	{ pos1 = Vector(6593,2400,-112), pos2 = Vector(6208,395,2020), name = "Grand Way" },
	{ pos1 = Vector(704,2369,-112), pos2 = Vector(2560,1248,2020), name = "Union Square" },
	{ speed = 30, pos1 = Vector(-8576,-128,-112), pos2 = Vector(-7680,2751,2020), name = "Pleasant Road" },
	{ speed = 50, pos1 = Vector(-8576,-128,-112), pos2 = Vector(3456,-1024,2020), name = "Any Way" },
    { speed = 65, pos1 = Vector(-8576,-128,-112), pos2 = Vector(-14656,-1024,2020), name = "Any Way" },
	{ speed = 65, pos1 = Vector(-14656,-128,-176), pos2 = Vector(-14144,-11968,2020), name = "Any Way" },
	{ pos1 = Vector(-4608,-2560,-240), pos2 = Vector(6208,-3488,2020), name = "River Road" },
	{ pos1 = Vector(-4608,-2560,-112), pos2 = Vector(-3712,-1024,2020), name = "River Road" },
}

BuildingBlocks = {
	{ pos1 = Vector(-7040,11904,-60), pos2 = Vector(-3710,9850,2020), name = "Suburban Houses" },
	{ pos1 = Vector(-7040,14699,-60), pos2 = Vector(-3710,12798,2020), name = "Suburban Houses" },
	{ pos1 = Vector(-2817,14699,-60), pos2 = Vector(-745,12798,2020), name = "Suburban Houses" },
	{ pos1 = Vector(-745,14880,120), pos2 = Vector(1296,12798,2020), name = "7-Twelve" },
	{ pos1 = Vector(-129,9728,120), pos2 = Vector(1916,11904,2020), name = "Diner" },
	{ pos1 = Vector(-129,9728,120), pos2 = Vector(-2817,11904,2020), name = "Shop District" },
	{ pos1 = Vector(4103,9728,-60), pos2 = Vector(2816,11280,2020), name = "Suburban Houses" },
	{ pos1 = Vector(6208,6655,-896), pos2 = Vector(9472,10263,2020), name = "Police Department" },
	{ pos1 = Vector(5312,7104,-92), pos2 = Vector(4496,8634,340), name = "Leprechauns Winklepicker Bar" },
	{ pos1 = Vector(5496,7680,-92), pos2 = Vector(4919,6976,128), name = "Leprechauns Winklepicker Bar" },
	{ pos1 = Vector(3776,7920,136), pos2 = Vector(4256,8634,310), name = "Pawn Brokers" },
	{ pos1 = Vector(3904,7920,136), pos2 = Vector(4208,7520,310), name = "Pawn Brokers" },
	{ pos1 = Vector(3615,6280,16), pos2 = Vector(4128,6850,170), name = "Red Shop" },
	{ pos1 = Vector(3456,7162,16), pos2 = Vector(3808,6850,170), name = "Red Shop" },
	{ pos1 = Vector(3440,5584,0), pos2 = Vector(2240,4528,570), name = "Town Hall" },
	{ pos1 = Vector(5600,5696,-48), pos2 = Vector(4744,5184,150), name = "Green Shop" },
	{ pos1 = Vector(5600,5120,-48), pos2 = Vector(4744,4608,150), name = "Orange Shop" },
	{ pos1 = Vector(6208,4352,-64), pos2 = Vector(8128,5760,720), name = "Hospital" },
	{ pos1 = Vector(1856,6655,16), pos2 = Vector(1344,7552,200), name = "Blue Shop" },
	{ pos1 = Vector(832,6856,16), pos2 = Vector(288,7713,200), name = "Teal Shop" },
	{ pos1 = Vector(-3384,7424,128), pos2 = Vector(-1731,8830,2020), name = "Church" },
	{ pos1 = Vector(-2688,6913,0), pos2 = Vector(-1731,5968,2020), name = "Gateway Tire & Service Center" },
	{ pos1 = Vector(-3848,5984,48), pos2 = Vector(-4624,7152,250), name = "Private Lockup" },
	{ pos1 = Vector(-192,5760,-112), pos2 = Vector(-2239,4546,2020), name = "World Corp." },
	{ pos1 = Vector(-5249,2955,-32), pos2 = Vector(-4127,3968,2020), name = "Garage Warehouse" },
	{ pos1 = Vector(-6769,2955,-32), pos2 = Vector(-6144,3478,200), name = "Central Pharmacy" },
	{ pos1 = Vector(-6572,3766,-32), pos2 = Vector(-6817,3478,200), name = "Central Pharmacy" },
	{ pos1 = Vector(-9377,2958,0), pos2 = Vector(-8720,3777,2020), name = "Small Garage Lockup" },
	{ pos1 = Vector(-6526,7458,0), pos2 = Vector(-8834,4367,2020), name = "Club" },
	{ pos1 = Vector(-7680,1856,-40), pos2 = Vector(-6670,-128,2020), name = "Car Dealership" },
	{ pos1 = Vector(-5241,1856,-83), pos2 = Vector(-6670,-128,2020), name = "Gas Mogul" },
	{ pos1 = Vector(-5241,1856,-104), pos2 = Vector(-2944,-128,2020), name = "Motel" },
	{ pos1 = Vector(-2048,832,-280), pos2 = Vector(-319,3456,2020), name = "Bank" },
	{ pos1 = Vector(-994,640,-96), pos2 = Vector(-192,-128,200), name = "Richman Jewelers" },
	{ pos1 = Vector(896,5567,0), pos2 = Vector(1407,4366,2020), name = "White Crest Apartments" },
	{ pos1 = Vector(1781,5304,0), pos2 = Vector(1407,4616,2020), name = "White Crest Apartments" },
	{ pos1 = Vector(2304,2369,-104), pos2 = Vector(704,3456,2020), name = "Union Square Apartments" },
	{ pos1 = Vector(4415,3260,-48), pos2 = Vector(4928,2296,200), name = "Cyan Shop" },
	{ pos1 = Vector(6593,2400,-96), pos2 = Vector(8000,395,2020), name = "Le Grande" },
	{ pos1 = Vector(9024,1040,-104), pos2 = Vector(9952,2032,2020), name = "Fire Department" },
	{ pos1 = Vector(-2917,-2088,-96), pos2 = Vector(-3662,-1101,288), name = "Brick Garage" },
	{ pos1 = Vector(-1748,-1196,-96), pos2 = Vector(-240,-2416,504), name = "Metal Warehouse" },
	{ pos1 = Vector(1152,-1024,-96), pos2 = Vector(1908,-2003,180), name = "Hardware Store" },
	{ pos1 = Vector(2400,-1296,-127), pos2 = Vector(3672,-2288,448), name = "Red Warehouse" },
	{ pos1 = Vector(6208,-1024,-104), pos2 = Vector(7200,-2560,496), name = "Haviture Warehouse" },
	{ pos1 = Vector(5824,-4096,-312), pos2 = Vector(6720,-4729,64), name = "Dockhouse" },
	{ pos1 = Vector(-464,-5644,-320), pos2 = Vector(750,-7148,280), name = "Panatlantic Warehouse" },
	{ pos1 = Vector(-5882,-2571,-320), pos2 = Vector(-7944,-4103,2020), name = "Self Storage Units" },
	{ pos1 = Vector(-12953,-10486,-256), pos2 = Vector(-11664,-9490,320), name = "Parker Warehouse" },
	{ pos1 = Vector(12166,-11977,265), pos2 = Vector(13024,-14017,-622), name = "Boat" },
	{ pos1 = Vector(-2944,3043,-104), pos2 = Vector(-3840,4352,2020), name = "Impound Lot" },
}

GM.CalculatedBlocks = table.Copy(BigZones)
for k, v in ipairs(StreetBlocks) do
	v.streetid=k
	table.insert(GM.CalculatedBlocks,v)
end
for k, v in ipairs(BuildingBlocks) do
	table.insert(GM.CalculatedBlocks,v)
end

for _, v in ipairs( GM.CalculatedBlocks ) do -- sake of efficiency
	OrderVectors( v.pos1, v.pos2 )
end