--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]
///////////////////////////////
//		  UPDATED BY:		 //
//		  BRAD CARTER		 //
//		  OCT. 30 2018		 //
///////////////////////////////


if CLIENT then
	Material( "tools/toolsblack" ):SetInt( "$alpha", 0 )
	
	hook.Add( "InitPostEntity", "FixTooManyVertexes", function()
		RunConsoleCommand( "con_filter_text_out", "vertex" )
		RunConsoleCommand( "con_filter_enable", "1" )
	end )
end

-- For speed limit area thing on HUD
InnerCity = { 

	{Vector(8648, -13506, 1600), Vector(-3631, 3341, 136)},

}

--[[-------------------------------------------------------------

				Doors - Use godstick for this (dev tools > get door pos)

-------------------------------------------------------------]]--

policeDoors = { 

--Make sure to label location when adding

--Police Department
	{Vector(6212, -1640, 240), '*112'},
	{Vector(6212, -2718, 192), '*136'},
	{Vector(6212, -2610, 192.25), '*137'},
	{Vector(6620, -2463, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6620, -2865, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6935, -2956, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6780, -2687, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(7095, -2372, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(7096, -2508, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6401, -2836, -130), 'models/props_c17/door01_left.mdl'},
	{Vector(6476, -3117, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6868, -3117, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6868, -3667, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6476, -3667, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6852, -3971, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6476, -3667, 510), 'models/props_c17/door01_left.mdl'},
	{Vector(6868, -3667, 510), 'models/props_c17/door01_left.mdl'},
	{Vector(6476, -3117, 510), 'models/props_c17/door01_left.mdl'},
	{Vector(6868, -3117, 510), 'models/props_c17/door01_left.mdl'},
	{Vector(6590, -2711, 510.25), 'models/props_c17/door01_left.mdl'},
	{Vector(6590, -2617, 510), 'models/props_c17/door01_left.mdl'},
	{Vector(6754, -2617, 510), 'models/props_c17/door01_left.mdl'},
	{Vector(6754, -2711, 510.25), 'models/props_c17/door01_left.mdl'},

--Police Deparmtent
	{Vector(6282, -3092, -132), '*114'},
	{Vector(6422, -3092, -132), '*115'},
	{Vector(6562, -3092, -132), '*116'},
	{Vector(6702, -3092, -132), '*117'},
	{Vector(6245, -2956, -130), 'models/props_c17/door01_left.mdl'},

--Prison
	{Vector(14016, 11256, 224), '*252'},
	{Vector(13888, 11256, 224), '*251'},
	{Vector(13904, 12156, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14000, 12156, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14972, 13007, 182.00100708008), 'models/natalya/props/door_02.mdl'},
	{Vector(14000, 13940, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13904, 13940, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(12932, 12993, 182.00100708008), 'models/natalya/props/door_02.mdl'},
	{Vector(13444, 12328, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13444, 12232, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13320, 13068, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13416, 13068, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13140, 13304, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13236, 13304, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13904, 12412, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14000, 12412, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14084, 12328, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14084, 12232, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14000, 12156, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13904, 12156, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14460, 12328, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14460, 12232, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14668, 12681.900390625, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14764, 12681.900390625, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14972, 13007, 182.00100708008), 'models/natalya/props/door_02.mdl'},
	{Vector(14764, 13304, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14668, 13304, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14460, 13864, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14460, 13768, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14000, 13684, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13904, 13684, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13444, 13864, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(13444, 13768, 182.00100708008), 'models/natalya/props/door_03.mdl'},
	{Vector(14215, 13380, 128.00100708008), 'models/env/doors/vaultbardoor/vaultbardoor.mdl'},
	{Vector(14215, 13151, 177), '*255'},
	{Vector(14215, 12895, 177), '*254'},
	{Vector(13689, 12716, 128.00100708008), 'models/env/doors/vaultbardoor/vaultbardoor.mdl'},
	{Vector(13689, 12945, 177), '*264'},
	{Vector(13689, 13201, 177), '*265'},
	{Vector(13689, 13228, 262.50100708008), 'models/env/doors/vaultbardoor/vaultbardoor.mdl'},
	{Vector(13689, 12945, 311.5), '*261'},
	{Vector(13689, 12689, 311.5), '*262'},
	{Vector(14215, 12895, 311.5), '*259'},
	{Vector(14215, 13151, 311.5), '*258'},
	{Vector(14215, 13407, 311.5), '*257'},
	{Vector(13952, 12664, 184.13999938965), '*267'},
	{Vector(13692, 12449, 182.00100708008), 'models/natalya/props/door_02.mdl'},
	{Vector(14212, 12495, 182.00100708008), 'models/natalya/props/door_02.mdl'},
	{Vector(13689, 13201, 311.5), '*260'},
	{Vector(13689, 12689, 177), '*263'},
	{Vector(14215, 13407, 177), '*256'},

}

civilDoors = { 

--Make sure to label location when adding

--Fire Department
	{Vector(6212, -4200, 240), '*109'},
	{Vector(6212, -4584, 240), '*108'},
	{Vector(6212, -4749, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6395, -4828, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6469, -4828, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(6772, -5091, 190), 'models/props_c17/door01_left.mdl'},
	
}

BusDoor = { 

	{Vector(-2856, 6956, 180), '*273'},
	{Vector(-2457, 7156, 190.00100708008), 'models/props_c17/door01_left.mdl'},

}

clubDoors = { 

	{Vector(-1086, -5246, 192), '*221'},
	{Vector(-1086, -5202, 192), '*222'},

}

BankDoor = {

}

RealtorOfficeDoors = { 

	{Vector(3646, -6160.009765625, 224), '*12'},
	{Vector(3522, -6160.009765625, 224), '*13'},
	{Vector(3080.0100097656, -6726, 224), '*11'},
	{Vector(3080.0100097656, -6602, 224), '*10'},
	{Vector(3220, -7073, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(3972, -6209, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(4104, -7123, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(4104, -6205, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(4908, -6604, 188), '*142'},

}

BPShopDoors = { 

	{Vector(4804, -194, 192), '*138'},
	{Vector(4804, -302, 192), '*139'},
	{Vector(-4062, 8252, 192), '*233'},
	{Vector(-3954, 8252, 192), '*234'},

}

GasShopDoor = { 

}

FCStoreDoors = { 

--Make sure to label location when adding
	{Vector(11072, 4020, 190), '*206'},
	{Vector(10954, 4020, 190), '*207'},

}

TidesHotelDoors = { 

--Make sure to label location when adding

}

ShopsDoors = { 

--Make sure to label location when adding

--Garry's Mall
	{Vector(8002, -4402, 191), '*214'},
	{Vector(8002, -4446, 191), '*215'},


}

CarDealerDoors = { 

	{Vector(-1432, 5048, 216), '*248'},

}

HospitalDoors = { 

--Make sure to label location when adding
	{Vector(6662, 380, 190), '*190'},
	{Vector(6778, 380, 190), '*191'},
	{Vector(6672, 820, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6768, 820, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6401, 328, 188), 'models/props_doors/doormain01.mdl'},
	{Vector(6852, 976, 188), 'models/props_doors/doormain01.mdl'},
	{Vector(6852, 1040, 188), 'models/props_doors/doormain01.mdl'},
	{Vector(7088, 1427, 188), 'models/props_doors/doormain01.mdl'},
	{Vector(6768, 1496, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6672, 1496, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6588, 1523, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6588, 1619, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6852, 1630, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6852, 1534, 188), 'models/props_doors/doormainmetalwindowsmall01.mdl'},
	{Vector(6662, 1844, 190), '*192'},
	{Vector(6778, 1844, 190), '*193'},
	{Vector(6432, 1196, 188), 'models/props_doors/doormain01.mdl'},
	{Vector(6368, 1196, 188), 'models/props_doors/doormain01.mdl'},
	{Vector(6588, 832, 188), 'models/props_doors/doormain01.mdl'},
	{Vector(6370, 820, 188), 'models/props_doors/doormain01.mdl'},

}

GovermentCenterDoors = { 

--Make sure to label location when adding

--Town Hall
	{Vector(4460, -4853, 318.25), 'models/props_c17/door01_left.mdl'},
	{Vector(4460, -4947, 318), 'models/props_c17/door01_left.mdl'},
	{Vector(4066, -4220.009765625, 352), '*2'},
	{Vector(4190, -4220.009765625, 352), '*1'},

}

JailsDoors = { 
--Not used, these dont auto lock. Im not wasting time making them autolock.
}
	
--Sea Side Apartments 1 
Apartments1Doors = {

	{Vector(10260, 2465, 334.28100585938), 'models/props_c17/door01_left.mdl'},

}

--Sea Side Apartments 2
Apartments2Doors = { 

{Vector(9996, 2511, 334.28100585938), 'models/props_c17/door01_left.mdl'},

}

--Downtown Heights
Apartments3Doors = { 

{Vector(8330, -458, 191), '*230'},
{Vector(8374, -458, 191), '*231'},

}

--Carter Residence
Apartments4Doors = { 

{Vector(-1086, -3806, 191), '*224'},
{Vector(-1086, -3762, 191), '*225'},

}

--Harbor View Hotel
Apartments5Doors = { 

{Vector(3627, -8684, 222), '*143'},
{Vector(3717, -8684, 222), '*144'},

}

RoadCrewDoors = { 

	{Vector(2044, -3111, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(2044, -3017, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(1676, -2953, 190), 'models/props_c17/door01_left.mdl'},
	{Vector(2044, -2760, 382), '*102'},
	{Vector(2044, -2440, 382), '*105'},

}

CasinoDoors = {

	{Vector(-66, -4978, 191), '*228'},
	{Vector(-66, -5022, 191), '*227'},

}

--[[-------------------------------------------------------------

				Mayor Contraption Props
				Make something useful this time...

-------------------------------------------------------------]]--

CityFurniture = {}

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

