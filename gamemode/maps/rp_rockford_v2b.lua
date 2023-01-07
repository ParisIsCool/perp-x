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
	
	hook.Add( "InitPostEntity", "FixTooManyVertexes", function()
		RunConsoleCommand( "con_filter_text_out", "vertex" )
		RunConsoleCommand( "con_filter_enable", "1" )
	end )
end

InnerCity = { 
	{ Vector( -9911.4697, -13291.6055, 1680.3978 ), Vector( -3028.1880, -3869.2109, -1001.8713 ) },
}

policeDoors = { 
{Vector(-8892, -5786, 60.25), 'models/props/storedoor1.mdl'},
{Vector(-8892, -5878, 60.25), 'models/props/storedoor1.mdl'},

{Vector(-8538, -5636, 59.744499206543), 'models/props_doors/doormainmetalsmall01.mdl'},
{Vector(-8538, -5636, 59.744499206543), 'models/props_doors/doormainmetalsmall01.mdl'},
{Vector(-7842, -4932, 60.25), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7846, -5020, 59.744499206543), 'models/props_doors/doormainmetalsmall01.mdl'},
{Vector(-7481.919921875, -4932, 60.25), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7548, -5034, 59.744499206543), 'models/props_doors/doormainmetalsmall01.mdl'},
{Vector(-7456, -5174, 60.25), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7469.919921875, -5308, 60.25), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7548, -5178, 59.744499206543), 'models/props_doors/doormainmetalsmall01.mdl'},
{Vector(-7529.990234375, -5764, 60.25), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7548, -5394, 59.744499206543), 'models/props_doors/doormainmetalsmall01.mdl'},
{Vector(-7324, -5322, 60.25), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7620, -5952, 148), '*105'},
{Vector(-7717.919921875, -4932, 60.25), 'models/props_doors/doormainmetalwindowsmall01.mdl'},

--cell
{Vector(-7228, -5650, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7548, -5650, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7548, -5402, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7228, -5402, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},

--cell entrance
{Vector(-7194, -5380, 60), 'models/props_wasteland/prison_celldoor001a.mdl'},
{Vector(-7370, -5380, -1356), '*126'},

--holding cell bar door
{Vector(-7170, -5380, 60), '*119'},

-- jail tops
{Vector(-7122, -5380, 60), '*120'},
--jail bottom
{Vector(-7370, -5380, -1356), '*127'},
{Vector(-7548, -5650, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7548, -5402, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7228, -5402, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
{Vector(-7228, -5650, -1356.2600097656), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
-- gate
{Vector(-7050, -6424, 52), '*115'},

}
	
nationalGuardDoor = {

{Vector(-3710, -4990, 116), 'models/props_doors/doormain01_small.mdl'},
{Vector(-3329.90625, -4990, 116), 'models/props_doors/doormain01_small.mdl'},
{Vector(-3662, -5244, 116), 'models/props/storedoor1.mdl'},
{Vector(-3570, -5244, 116), 'models/props/storedoor1.mdl'},


}
	
civilDoors = { 
	
{Vector(-4686, -5756, 116), 'models/props/storedoor1.mdl'},
{Vector(-4594, -5756, 116), 'models/props/storedoor1.mdl'},
{Vector(-4110, -5756, 116), 'models/props/storedoor1.mdl'},
{Vector(-4018, -5756, 116), 'models/props/storedoor1.mdl'},
{Vector(-4980.080078125, -5132, 772), 'models/props_doors/doormain01_small.mdl'},
{Vector(-4884, -5132, 772), 'models/props_doors/doormain01_small.mdl'},
{Vector(-4452.080078125, -5132, 772), 'models/props_doors/doormain01_small.mdl'},
{Vector(-4356, -5132, 772), 'models/props_doors/doormain01_small.mdl'},
{Vector(-4084.080078125, -5132, 772), 'models/props_doors/doormain01_small.mdl'},
{Vector(-3988, -5132, 772), 'models/props_doors/doormain01_small.mdl'},
{Vector(-5262, -5756, 116), 'models/props/storedoor1.mdl'},
{Vector(-5170, -5756, 116), 'models/props/storedoor1.mdl'},


//sidedoors cityhall

{Vector(-2817.919921875, -4990, 116), 'models/props_doors/doormain01_small.mdl'},
{Vector(-3198, -4990, 116), 'models/props_doors/doormain01_small.mdl'},
{Vector(-4412, -4900.080078125, 116), 'models/props_doors/doormain01_small.mdl'},
{Vector(-4412, -4804, 116), 'models/props_doors/doormain01_small.mdl'},

	--ems
	{Vector(-5170, -5756, 116), 'models/props/storedoor1.mdl'},
	{Vector(-4736, -3680.0200195313, 141.05999755859), '*89'},
	{Vector(-5504.0200195313, -3680, 141.05999755859), '*86'},
	{Vector(-5764, -3770, 59.744499206543), 'models/props_doors/doormainmetalsmall01.mdl'},
	{Vector(-5800, -3386, 60.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-6204, -3310, 60.250701904297), 'models/props/storedoor1.mdl'},
	{Vector(-6204, -3218, 60.250701904297), 'models/props/storedoor1.mdl'},
	{Vector(-6001.919921875, -3070, 60.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-5974, -3070, 60.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-5362, -3132, 324.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-5362, -3396, 324.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-4966, -3132, 324.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-4722, -3132, 324.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-4722, -3396, 324.25), 'models/props_doors/doormain01_small.mdl'},
	


	--firehouse baydoors
	
{Vector(-5504, -2880, 141.05999755859), '*84'},
	{Vector(-5248, -2880, 141.05999755859), '*82'},
	{Vector(-4992, -2880, 141.05999755859), '*80'},
	{Vector(-4736, -2880, 141.05999755859), '*13'},
	{Vector(-4736, -3680.0200195313, 141.05999755859), '*88'},
	{Vector(-4992, -3680, 141.05999755859), '*87'},
	{Vector(-5248, -3680, 141.05999755859), '*86'},
	{Vector(-5504.0200195313, -3680, 141.05999755859), '*85'},

}


BusDoor = { 
	{Vector(-1394, 4220, 596), 'models/props/storedoor1.mdl'},
	{Vector(-1486, 4220, 596), 'models/props/storedoor1.mdl'},
	{Vector(-2958, -5244, 116), 'models/props/storedoor1.mdl'},
	{Vector(-2866, -5244, 116), 'models/props/storedoor1.mdl'},

}


clubDoors = { 
{Vector(-9860, -1006, 60), 'models/props/storedoor1.mdl'},
{Vector(-9860, -914, 60), 'models/props/storedoor1.mdl'},

}

BankDoor = {
	{Vector(-2848, -2916, 84.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-2915.9399414062, -2848.0600585938, 84.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-3780, -3324, 84), '*93'},
	{Vector(-3716, -3370, 84), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-3880, -4096, 124.2799987793), '*94'},

--[[{Vector(-2818.9499511719, -2885.0500488281, 52.222499847412), 'models/props/storedoor1.mdl'},
{Vector(-2884, -2820, 52.222499847412), 'models/props/storedoor1.mdl'},
{Vector(-3916, -3330, 52), 'models/props_doors/doormain01_small.mdl'},
{Vector(-3140, -3520, 68), '*35'},]]--
}

RealtorOfficeDoors = { 
	{Vector(-1054, 6463.875, 596), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-1272, 6578, 544.25), 'models/props_jorpakko/exterior_door_01.mdl'},
	{Vector(-1272, 6478, 544.25), 'models/props_jorpakko/exterior_door_01.mdl'},


}

BPShopDoors = { 
{Vector(-1372, 5802, 596), 'models/props/storedoor1.mdl'},
{Vector(-1372, 5710, 596), 'models/props/storedoor1.mdl'},


}

GasShopDoor = { 
{Vector(644, 3982, 596), 'models/props/storedoor1.mdl'},
{Vector(644, 3890, 596), 'models/props/storedoor1.mdl'},
{Vector(-14276, 2610, 444), 'models/props/storedoor1.mdl'},
{Vector(-14276, 2702, 444), 'models/props/storedoor1.mdl'},



}

FCStoreDoors = { 
{Vector(2236, 3858, 596.2509765625), 'models/props/storedoor1.mdl'},
{Vector(2236, 3950, 596.2509765625), 'models/props/storedoor1.mdl'},



}
					
TidesHotelDoors = { 
	{Vector(-5445.5, -4454, 135), '*30'},
	{Vector(-5445, -4514, 135), '*29'},
	{Vector(-5445.5, -4702, 135), '*32'},
	{Vector(-5445, -4762, 135), '*31'},

}
					
ShopsDoors = { 
	{Vector(-7268.7299804688, -3244, 60), 'models/props/storedoor1.mdl'},


}
					
CarDealerDoors = { 
{Vector(-4142, -1084, 52), 'models/props/storedoor1.mdl'},
{Vector(-4050, -1084, 52), 'models/props/storedoor1.mdl'},
{Vector(-5356, -1664, 112), '*43'},
{Vector(-5356, -1664, 112), '*28'},




}
					
HospitalDoors = { 

{Vector(-126, -5382, 116), 'models/props_doors/doormainmetalwindow01.mdl'},
{Vector(761.91998291016, -5562.080078125, 116), 'models/props_doors/doormainmetalwindow01.mdl'},
{Vector(126, -6330, 116), 'models/props_doors/doormainmetalwindow01.mdl'},
{Vector(-278, -6050, 116.25), 'models/props_doors/doormain01_small.mdl'},
{Vector(-126.08000183105, -5442.080078125, 116), 'models/props_doors/doormainmetalwindow01.mdl'},
--frontdoors
{Vector(-378, -5886, 114), '*43'},
{Vector(-226, -5658, 114), '*46'},
{Vector(638, -5342, 114), '*48'},
--baydoors
{Vector(-68, -4840, 216), '*51'},
{Vector(708, -4840, 216), '*52'},
{Vector(350, -5154, 114), '*49'},


}
					
GovermentCenterDoors = { 
	--{ Vector( -6760, -8712.625, 134 ), "*140" },
	--{ Vector( -6760, -8809.34375, 134 ), "*63" },
	--{ Vector( -6760, -8992.625, 134 ), "*142" },
	--{ Vector( -6760, -9089.34375, 134 ), "*141" },
	--{ Vector( -7782, -10415, -170.79219055176 ), "*65" },
	--{ Vector( -6892, -10160, -88 ), "*68" },
	--{ Vector( -6758, -10521, -124.5 ), "*145" },
}
					
JailsDoors = { 

{Vector(-7426, -5296, 60), '*80'},
{Vector(-7426, -5200, 60), '*81'},
{Vector(-7426, -5104, 60), '*82'},
{Vector(-7294, -5054, 60), '*83'},
{Vector(-7294, -5150, 60), '*84'},
{Vector(-7294, -5246, 60), '*85'},
}
	
	
Apartments1Doors = {
{Vector(-1437, 9156, 671), 'models/props_c17/door02_double.mdl'},
{Vector(-1379, 9156, 671), 'models/props_c17/door02_double.mdl'},
}
		
Apartments2Doors = { 
{Vector(413, 8252, 671), 'models/props_c17/door02_double.mdl'},
{Vector(355, 8252, 671), 'models/props_c17/door02_double.mdl'},
}

RockfordCustoms = {

{Vector(-8000, -1912, 132), '*110'},

}
					
RoadCrewDoors = { 
    	
	{Vector(-7074, 824, 44), '*118'},
	{Vector(-7226, 318, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7290, -210, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7108, 50, 60), 'models/props/storedoor1.mdl'},
	{Vector(-7108, 142, 60), 'models/props/storedoor1.mdl'},
	{Vector(-8016, -768, 198), '*107'},

}

CasinoDoors = {
	{Vector(2236, 1554, 596.2509765625), 'models/props/storedoor1.mdl'},
	{Vector(2236, 1646, 596.2509765625), 'models/props/storedoor1.mdl'},

}

CityFurniture = {}

--[[
CityFurniture[ "Speed Trap" ] = {
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.5698, -3387.2551, 64.425), Angle = Angle( -0.0048, 179.9958, -0.0005) },
	{ Model = Model( "models/hunter/triangles/1x1x1carved.mdl" ), Pos = Vector( -6033.7988, -3413.8708, 88.2247), Angle = Angle( 0.1264, 90.0148, 0.1264) },
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.8125, -3387.2368, 64.3827), Angle = Angle( -0.0006, -89.806, 0.0016) },
	{ Model = Model( "models/hunter/triangles/1x1x1carved.mdl" ), Pos = Vector( -5973.1372, -3413.3044, 88.0773), Angle = Angle( -0.0207, -179.8008, -0.0104) },
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.814, -3387.2363, 112.2587), Angle = Angle( -0.0006, -89.806, 0.0016) },
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.5659, -3387.2556, 112.301), Angle = Angle( -0.0048, 179.9958, -0.0005) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5955.1377, -3328.4219, 64.382), Angle = Angle( -0.0173, 173.4347, 0.0008) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3232, -3213.6365, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3228, -3101.0103, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3223, -2988.3843, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3218, -2875.7583, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3213, -2763.1323, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3208, -2650.5063, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3203, -2537.8804, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/hunter/tubes/tube2x2x05d.mdl" ), Pos = Vector( -5888.2905, -2613.5046, 24.7955), Angle = Angle( 45, -90.0069, -90) },
	{ Model = Model( "models/hunter/tubes/tube2x2x05d.mdl" ), Pos = Vector( -5808.6421, -2612.3342, 24.2928), Angle = Angle( 45, -89.9998, -90) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3198, -2425.2544, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3193, -2312.6284, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3188, -2200.0024, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3184, -2087.3765, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3179, -1974.7504, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3174, -1862.1243, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.3169, -1749.4982, 64.502), Angle = Angle( 0, 179.9997, 0) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -5949.4868, -1637.012, 64.5555), Angle = Angle( -0.0507, 179.9406, -0.0002) },
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.5425, -1506.3217, 64.4945), Angle = Angle( -0.0034, -0.1836, -0.0017) },
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.2964, -1506.337, 64.3901), Angle = Angle( -0.0076, 90.0146, -0.0058) },
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.3013, -1506.3434, 112.2661), Angle = Angle( -0.0076, 90.0146, -0.0058) },
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.5454, -1506.3202, 112.3705), Angle = Angle( -0.0034, -0.1836, -0.0017) },
	{ Model = Model( "models/hunter/triangles/1x1x1carved.mdl" ), Pos = Vector( -5975.2534, -1477.8013, 88.2243), Angle = Angle( -0.0165, -90.2026, -0.0175) },
	{ Model = Model( "models/hunter/triangles/1x1x1carved.mdl" ), Pos = Vector( -6033.105, -1479.1659, 88.2248), Angle = Angle( -0.0008, 0.0157, -0.0008) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6052.8755, -1562.9404, 64.5959), Angle = Angle( -0.1742, -7.3735, 0.0057) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.1123, -1676.163, 64.574), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.1104, -1788.7891, 64.5742), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.1084, -1901.4152, 64.5744), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.1064, -2014.0413, 64.5746), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.1045, -2126.6675, 64.5747), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.1025, -2239.2935, 64.5749), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.1006, -2351.9194, 64.5751), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.0986, -2464.5454, 64.5753), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.0967, -2577.1714, 64.5755), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/hunter/tubes/tube2x2x05d.mdl" ), Pos = Vector( -6117.1772, -2621.0427, 27.0124), Angle = Angle( 45, -90.001, -90) },
	{ Model = Model( "models/hunter/tubes/tube2x2x05d.mdl" ), Pos = Vector( -6193.2925, -2624.2395, 27.5436), Angle = Angle( 44.9998, -89.2088, -89.9851) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.0947, -2689.7974, 64.5757), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.0928, -2802.4233, 64.5758), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.0908, -2915.0493, 64.576), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.0889, -3027.6753, 64.5762), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.0869, -3140.3013, 64.5764), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/concrete_barrier001a.mdl" ), Pos = Vector( -6060.085, -3252.9272, 64.5766), Angle = Angle( 0, 0.0009, -0.0001) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9775, -3269.3105, 228.005), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9717, -3134.7915, 228.0064), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9658, -3000.2725, 228.0078), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.96, -2865.7534, 228.0093), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9541, -2731.2344, 228.0107), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9482, -2596.7153, 228.0121), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9424, -2462.1963, 228.0136), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9365, -2327.6772, 228.015), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9307, -2193.1582, 228.0164), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9248, -2058.6392, 228.0179), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9189, -1924.12, 228.0193), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9131, -1789.6008, 228.0207), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -6054.9072, -1655.0817, 228.0222), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1167, -1655.0868, 228.0052), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1226, -1789.606, 228.0038), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1284, -1924.1251, 228.0023), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1343, -2058.6443, 228.0009), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1401, -2193.1633, 227.9995), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.146, -2327.6824, 227.998), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1519, -2462.2014, 227.9966), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1577, -2596.7205, 227.9951), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1636, -2731.2395, 227.9937), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1694, -2865.7585, 227.9923), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1753, -3000.2776, 227.9908), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.1812, -3134.7966, 227.9894), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector( -5953.187, -3269.3157, 227.988), Angle = Angle( -0.0095, 179.9976, 179.9994) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0635, -3317.8528, 265.5302), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.064, -3222.6008, 265.5302), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6003.4375, -3269.3184, 263.9516), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0645, -3127.3489, 265.5302), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6003.5342, -3122.3242, 262.5745), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0649, -3032.0969, 265.5302), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0654, -2936.845, 265.5301), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6003.6147, -2999.8291, 261.4268), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0659, -2841.593, 265.5301), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6003.7114, -2852.835, 260.0497), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0664, -2746.3411, 265.5301), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6003.792, -2730.3398, 258.9021), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0669, -2651.0891, 265.53), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6003.8887, -2583.3457, 257.525), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0674, -2555.8372, 265.53), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6003.9692, -2460.8506, 256.3773), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0679, -2460.5852, 265.53), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0684, -2365.3333, 265.5299), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0688, -2270.0813, 265.5299), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6004.0659, -2313.8564, 255.0001), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0693, -2174.8293, 265.5299), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0698, -2079.5774, 265.5298), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6004.1465, -2191.3613, 253.8524), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0703, -1984.3254, 265.5298), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6004.2271, -2068.8662, 252.7048), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0708, -1889.0735, 265.5298), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6004.3237, -1921.8728, 251.3275), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0713, -1793.8215, 265.5298), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0718, -1698.5696, 265.5297), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6004.4204, -1774.8794, 249.9503), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0723, -1603.3176, 265.5297), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6004.4849, -1676.8838, 249.0322), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0728, -1508.0657, 265.5297), Angle = Angle( -45, 0.0002, 90) },
	{ Model = Model( "models/mechanics/solid_steel/steel_beam_8.mdl" ), Pos = Vector( -6004.5332, -1603.3871, 248.3435), Angle = Angle( 0.0418, 0.0368, -0.5368) },
	{ Model = Model( "models/phxtended/tri1x1x2solid.mdl" ), Pos = Vector( -6003.0732, -1412.8137, 265.5296), Angle = Angle( -45, 0.0002, 90) },
}
]]
