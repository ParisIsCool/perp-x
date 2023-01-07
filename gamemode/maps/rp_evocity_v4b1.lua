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
	{Vector(-6768, -8986, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-6768, -8892, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-6984, -9208, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-7047, -9261, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-6775, -9261, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-6775, -9525, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-7047, -9525, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-7144, -9572, -377.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-7144, -9666, -377.75), 'models/props_c17/door03_left.mdl'},
}
					
civilDoors = { 
	--[[{ Vector(1312, 4603, 144), '*159' },
	{ Vector(1084, 4603, 144), '*160' },
	{ Vector(937, 4220, 136), '*165' },
	{ Vector(937, 4101, 136), '*166' },
	{ Vector( -3816, -8232, 290 ), "*113" },
	{ Vector( -3816, -7944, 290 ), "*111" },
	{ Vector( -3816, -7656, 290 ), "*112" },
	{ Vector( -3804, -7572.009765625, 248 ), "*115" },
	{ Vector( -3684, -7572.009765625, 248 ), "*114" },
	{ Vector( -3828, -7122, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3828, -7306.990234375, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3828, -7370.990234375, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3659, -7317, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3659, -7381, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -9383, 9044, 126.281 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -9768, 9097, 126.281 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -9880, 9334, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -9880, 9240, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10256, 9020, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10015, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10121, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10529, 9231, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10623, 9231, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10609, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10703, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -6758, -10521, -124.5 ), "*145" },]]--
	
	{Vector(-7214, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
{Vector(-7308, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
{Vector(-6760, -9359, 3845.25), 'models/props_c17/door01_left.mdl'},
{Vector(-6760, -9499, 3845.25), 'models/props_c17/door01_left.mdl'},
{Vector(-7587, -9305, 1798.25), 'models/props_c17/door01_left.mdl'},
{Vector(-7493, -9305, 1798.25), 'models/props_c17/door01_left.mdl'},
{Vector(-6769, -9169, 1798.25), 'models/props_c17/door01_left.mdl'},

{Vector(-6863, -9169, 1798.25), 'models/props_c17/door01_left.mdl'},
{Vector(-6760, -9499, 1798.25), 'models/props_c17/door01_left.mdl'},
{Vector(-7507, -9305, 518.28100585938), 'models/props_c17/door01_left.mdl'},
{Vector(-7515, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
{Vector(-6963, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
{Vector(-6528, -9423.5, 527.5), '*60'},
{Vector(-6528, -9556.5, 527.5), '*59'},
{Vector(-6760, -9089.3701171875, 134), '*63'},
{Vector(-6760, -8992.6298828125, 134), '*64'},
{Vector(-6760, -8712.6298828125, 134), '*62'},
{Vector(-6760, -8809.3701171875, 134), '*42'},

	
	--hospital
	{ Vector( -3804, -7572, 248 ), "*62" },
	{ Vector( -3684, -7572, 248 ), "*61" },
	{ Vector( -3816, -7656, 290 ), "*59" },
	{ Vector( -3816, -7944, 290 ), "*58" },
	{ Vector( -3816, -8232, 290 ), "*60" },	
	{ Vector(-10904, 9333, 135), '*146'},
	{ Vector(-10904.5, 9393, 135), '*145'},
	{ Vector(-9440.5, 9393, 135), '*144'},
	{ Vector(-9440, 9333, 135), '*143'},
}

clubDoors = { 
	{Vector(-3816, -8232, 290), '*39'},
	{Vector(-3816, -7944, 290), '*37'},
	{Vector(-3816, -7656, 290), '*38'},
	{Vector(-3684, -7572, 248), '*40'},
	{Vector(-3804, -7572, 248), '*41'},
	{Vector(-3659, -7381, 252.25), 'models/props_c17/door01_left.mdl'},
	{Vector(-3659, -7317, 252.25), 'models/props_c17/door01_left.mdl'},
	{Vector(-3828, -7370.96875, 252.25), 'models/props_c17/door01_left.mdl'},
	{Vector(-3828, -7306.96875, 252.25), 'models/props_c17/door01_left.mdl'},
	{Vector(-3828, -7122, 252.25), 'models/props_c17/door01_left.mdl'},
}

RealtorOfficeDoors = { 
	{Vector(-7092, -7786, 135), '*82'},
	{Vector(-7092, -7664, 135), '*83'},
	{Vector(-7543, -7456, 126.25), 'models/props_c17/door01_left.mdl'},
};

BPShopDoors = { --FBI
	{Vector(-7507, -9305, 518.25), 'models/props_c17/door01_left.mdl'},
	{Vector(-7515, -9169, 518.25), 'models/props_c17/door01_left.mdl'},
	{Vector(-6963, -9169, 518.25), 'models/props_c17/door01_left.mdl'},
	{Vector(-6528, -9556.5, 527.5), '*59'},
	{Vector(-6528, -9423.5, 527.5), '*60'},

};

FCStoreDoors = { 
	{Vector(-5183, -6468, 135), '*91'},
	{Vector(-5305, -6468, 135), '*92'},
};
					
TidesHotelDoors = { 
	{Vector(-5445.5, -4454, 135), '*30'},
	{Vector(-5445, -4514, 135), '*29'},
	{Vector(-5445.5, -4702, 135), '*32'},
	{Vector(-5445, -4762, 135), '*31'},
};

GasShopDoors = {
	{Vector(-7348, -6227, 135), '*80'},
	{Vector(-7348, -6349, 135), '*81'},
	{Vector(10260, 13380, 121.5), '*87'},
	{Vector(10524, 13380, 121.5), '*86'},

};
					
ShopsDoors = { 
	{ Vector( -6454, -10258, 127.5 ), "*64" },	
	{Vector(-5255, -6945, 135), '*93'},
	{Vector(-5377, -6945, 135), '*94'},

};
					
CarDealerDoors = { 
	{Vector(4066, -4757, 142), '*190'},
	{Vector(5361.5, -4757, 126), '*194'},
	{Vector(5490.5, -4757, 126), '*193'},
	{Vector(4598, -4057, 142), '*189'},
};
					
HospitalDoors = { 
	{Vector(-10623, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-10529, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-10703, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-10609, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-10015, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-10121, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-10256, 9020, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-9880, 9240, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-9880, 9334, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-9768, 9097, 126.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-9383, 9044, 126.25), 'models/props_c17/door03_left.mdl'},
};
					
GovermentCenterDoors = { 
	{Vector(-6760, -8712.625, 134), '*62'},
	{Vector(-6760, -8809.34375, 134), '*42'},
	{Vector(-6760, -8992.625, 134), '*64'},
	{Vector(-6760, -9089.34375, 134), '*63'},
};
					
JailsDoors = { 
	{Vector(-7008, -9652, -381), '*9'},
	{Vector(-7312, -9532, -381), '*11'},
	{Vector(-7312, -9404, -381), '*13'},
	{Vector(-7312, -9276, -381), '*14'},
	{Vector(-7312, -9148, -381), '*16'},
	{Vector(-7312, -9028, -381), '*7'},

}
					
ApartmentsDoors = { 
	{Vector(-10416, -9919, 128), '*142'},
	{Vector(-10416.400390625, -9859, 128), '*141'},

}
					
RoadCrewDoors = { 
    	
	{Vector(664, 3871, 122.25), 'models/props_c17/door01_left.mdl'},
	{Vector(928, 3909, 122.25), 'models/props_c17/door01_left.mdl'},
	{Vector(563.5, 3911, 146), '*177'},
	{Vector(1049.5, 3601, 132), '*176'},


}

CasinoDoors = {
	{ Vector( -3992, -6441, 252.25 ), "models/props_c17/door01_left.mdl" }
}

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

CityFurniture[ "4th Floor" ] = {
	{ Model = Model( "models/props/cs_office/computer.mdl" ), Pos = Vector(-7248, -8774, 3824), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props/cs_office/phone.mdl" ), Pos = Vector(-7217, -8765, 3824), Angle = Angle(0, 89, 0) },
	{ Model = Model( "models/props/cs_office/computer_caseb.mdl" ), Pos = Vector(-7233, -8772, 3791), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_lab/binderredlabel.mdl" ), Pos = Vector(-7287, -8763, 3825), Angle = Angle(-1, -38, 90) },
	{ Model = Model( "models/props_lab/desklamp01.mdl" ), Pos = Vector(-7283, -8779, 3833), Angle = Angle(0, 45, 0) },
	{ Model = Model( "models/props_interiors/furniture_lamp01a.mdl" ), Pos = Vector(-7260, -8654, 3825), Angle = Angle(0, -112, -1) },
	{ Model = Model( "models/props/cs_assault/acunit02.mdl" ), Pos = Vector(-6773, -8677, 4089), Angle = Angle(-1, 180, 0) },
	{ Model = Model( "models/props_c17/shelfunit01a.mdl" ), Pos = Vector(-7441, -9083, 3790), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_c17/shelfunit01a.mdl" ), Pos = Vector(-7517, -9083, 3790), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_c17/shelfunit01a.mdl" ), Pos = Vector(-7594, -9083, 3790), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_c17/shelfunit01a.mdl" ), Pos = Vector(-7670, -9082, 3790), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_c17/clock01.mdl" ), Pos = Vector(-7261, -9093, 3911), Angle = Angle(90, -90, 180) },
	{ Model = Model( "models/props_c17/briefcase001a.mdl" ), Pos = Vector(-7199, -8770, 3800), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props/cs_assault/acunit02.mdl" ), Pos = Vector(-7747, -8685, 4078), Angle = Angle(-1, 0, 0) },
	{ Model = Model( "models/props_combine/breendesk.mdl" ), Pos = Vector(-6592, -9362, 3791), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props_lab/huladoll.mdl" ), Pos = Vector(-6594, -9329, 3823), Angle = Angle(0, -37, 0) },
	{ Model = Model( "models/props_junk/garbage_coffeemug001a.mdl" ), Pos = Vector(-6579, -9336, 3825), Angle = Angle(0, -21, 0) },
	{ Model = Model( "models/props/cs_office/computer.mdl" ), Pos = Vector(-6584, -9397, 3823), Angle = Angle(0, 47, 0) },
	{ Model = Model( "models/props/cs_office/offpaintingo.mdl" ), Pos = Vector(-6595, -9408, 3878), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/bookshelf3.mdl" ), Pos = Vector(-6729, -9180, 3791), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/bookshelf2.mdl" ), Pos = Vector(-6676, -9180, 3791), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/bookshelf1.mdl" ), Pos = Vector(-6623, -9180, 3791), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet2.mdl" ), Pos = Vector(-6589, -9183, 3791), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_assault/acunit02.mdl" ), Pos = Vector(-6409, -9182, 3875), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props_lab/workspace001.mdl" ), Pos = Vector(-6386, -9249, 3791), Angle = Angle(0, -93, 0) },
	{ Model = Model( "models/props/cs_militia/couch.mdl" ), Pos = Vector(-6591, -9468, 3790), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/table_coffee.mdl" ), Pos = Vector(-6591, -9531, 3791), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props/cs_office/snowman_hat.mdl" ), Pos = Vector(-6596, -9530, 3818), Angle = Angle(-4, -42, -15) },
	{ Model = Model( "models/props/cs_office/projector_remote.mdl" ), Pos = Vector(-6582, -9528, 3816), Angle = Angle(0, -30, 0) },
	{ Model = Model( "models/props/cs_office/water_bottle.mdl" ), Pos = Vector(-6569, -9533, 3821), Angle = Angle(1, -133, 1) },
	{ Model = Model( "models/props/cs_office/water_bottle.mdl" ), Pos = Vector(-6567, -9538, 3821), Angle = Angle(1, -27, 0) },
	{ Model = Model( "models/props/cs_office/water_bottle.mdl" ), Pos = Vector(-6573, -9539, 3821), Angle = Angle(-1, -135, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1_group.mdl" ), Pos = Vector(-6484, -9464, 3792), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1_group.mdl" ), Pos = Vector(-6484, -9464, 3792), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1_group.mdl" ), Pos = Vector(-6484, -9464, 3792), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props_wasteland/kitchen_shelf001a.mdl" ), Pos = Vector(-6379, -9546, 3791), Angle = Angle(0, 89, 0) },
	{ Model = Model( "models/props_lab/reciever01b.mdl" ), Pos = Vector(-6386, -9551, 3806), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/fire_extinguisher.mdl" ), Pos = Vector(-6392, -9525, 3802), Angle = Angle(-89, 94, 89) },
	{ Model = Model( "models/props/cs_office/file_box.mdl" ), Pos = Vector(-6379, -9524, 3824), Angle = Angle(0, -178, 0) },
	{ Model = Model( "models/props/cs_office/file_box.mdl" ), Pos = Vector(-6378, -9538, 3824), Angle = Angle(0, -178, 0) },
	{ Model = Model( "models/props_lab/reciever01c.mdl" ), Pos = Vector(-6376, -9567, 3826), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props_lab/reciever01d.mdl" ), Pos = Vector(-6375, -9567, 3831), Angle = Angle(7, 178, 1) },
	{ Model = Model( "models/props_c17/consolebox03a.mdl" ), Pos = Vector(-6375, -9563, 3863), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props_c17/consolebox05a.mdl" ), Pos = Vector(-6382, -9562, 3872), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/cardboard_box01.mdl" ), Pos = Vector(-6377, -9548, 3888), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props_lab/reciever01a.mdl" ), Pos = Vector(-6372, -9529, 3874), Angle = Angle(0, 180, 89) },
	{ Model = Model( "models/props/cs_office/file_box.mdl" ), Pos = Vector(-6378, -9475, 3863), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/projector.mdl" ), Pos = Vector(-6376, -9489, 3888), Angle = Angle(0, -91, 0) },
	{ Model = Model( "models/props/cs_office/cardboard_box02.mdl" ), Pos = Vector(-6373, -9466, 3888), Angle = Angle(0, -179, 0) },
	{ Model = Model( "models/props_lab/harddrive01.mdl" ), Pos = Vector(-6379, -9458, 3834), Angle = Angle(0, 177, 0) },
	{ Model = Model( "models/props_lab/reciever01c.mdl" ), Pos = Vector(-6381, -9471, 3826), Angle = Angle(-1, -179, 0) },
	{ Model = Model( "models/props_lab/reciever01c.mdl" ), Pos = Vector(-6381, -9481, 3829), Angle = Angle(-1, -178, -29) },
	{ Model = Model( "models/props_lab/harddrive01.mdl" ), Pos = Vector(-6375, -9496, 3834), Angle = Angle(0, 178, 0) },
	{ Model = Model( "models/props_lab/harddrive01.mdl" ), Pos = Vector(-6380, -9504, 3834), Angle = Angle(0, 178, 0) },
	{ Model = Model( "models/props_lab/harddrive02.mdl" ), Pos = Vector(-6377, -9499, 3806), Angle = Angle(0, 175, 90) },
	{ Model = Model( "models/props_lab/clipboard.mdl" ), Pos = Vector(-6379, -9469, 3803), Angle = Angle(0, -167, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1_group.mdl" ), Pos = Vector(-6378, -9610, 3791), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1_group.mdl" ), Pos = Vector(-6378, -9610, 3791), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1_group.mdl" ), Pos = Vector(-6378, -9610, 3791), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1.mdl" ), Pos = Vector(-6378, -9653, 3791), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet1.mdl" ), Pos = Vector(-6378, -9674, 3791), Angle = Angle(0, -180, 0) },
	{ Model = Model( "models/props/cs_assault/acunit02.mdl" ), Pos = Vector(-6397, -9676, 3886), Angle = Angle(-1, 90, 0) },
	{ Model = Model( "models/props/cs_office/plant01.mdl" ), Pos = Vector(-6475, -9666, 3791), Angle = Angle(0, 130, 1) },
	{ Model = Model( "models/props_combine/breendesk.mdl" ), Pos = Vector(-6548, -9663, 3792), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props_lab/cactus.mdl" ), Pos = Vector(-6513, -9668, 3828), Angle = Angle(0, 85, 0) },
	{ Model = Model( "models/props_lab/monitor01a.mdl" ), Pos = Vector(-6546, -9671, 3836), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_combine/breenclock.mdl" ), Pos = Vector(-6581, -9676, 3827), Angle = Angle(1, 48, 0) },
	{ Model = Model( "models/props_lab/clipboard.mdl" ), Pos = Vector(-6576, -9658, 3823), Angle = Angle(0, 58, 0) },
	{ Model = Model( "models/props_c17/computer01_keyboard.mdl" ), Pos = Vector(-6547, -9647, 3822), Angle = Angle(-11, 90, 0) },
	{ Model = Model( "models/props/cs_office/phone.mdl" ), Pos = Vector(-6522, -9647, 3823), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_lab/harddrive02.mdl" ), Pos = Vector(-6533, -9653, 3801), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_lab/clipboard.mdl" ), Pos = Vector(-6576, -9658, 3823), Angle = Angle(0, 58, 0) },
	{ Model = Model( "models/props_junk/garbage_coffeemug001a.mdl" ), Pos = Vector(-6584, -9652, 3826), Angle = Angle(0, 54, 0) },
	{ Model = Model( "models/props_wasteland/controlroom_filecabinet001a.mdl" ), Pos = Vector(-6604, -9673, 3805), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_wasteland/controlroom_filecabinet001a.mdl" ), Pos = Vector(-6604, -9673, 3805), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_combine/breendesk.mdl" ), Pos = Vector(-6734, -9639, 3791), Angle = Angle(0, -180, 0) },
	{ Model = Model( "models/props_lab/plotter.mdl" ), Pos = Vector(-6743, -9604, 3793), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props_lab/desklamp01.mdl" ), Pos = Vector(-6737, -9634, 3832), Angle = Angle(-1, -36, -2) },
	{ Model = Model( "models/props_lab/bindergreenlabel.mdl" ), Pos = Vector(-6749, -9642, 3823), Angle = Angle(-1, 3, 22) },
	{ Model = Model( "models/props_lab/bindergreen.mdl" ), Pos = Vector(-6750, -9649, 3823), Angle = Angle(0, 0, 1) },
	{ Model = Model( "models/props_lab/bindergraylabel01a.mdl" ), Pos = Vector(-6750, -9653, 3823), Angle = Angle(0, 3, 1) },
	{ Model = Model( "models/props_lab/binderbluelabel.mdl" ), Pos = Vector(-6750, -9656, 3823), Angle = Angle(0, 0, 1) },
	{ Model = Model( "models/props_lab/binderblue.mdl" ), Pos = Vector(-6749, -9660, 3823), Angle = Angle(0, 2, 0) },
	{ Model = Model( "models/props_junk/popcan01a.mdl" ), Pos = Vector(-6738, -9668, 3826), Angle = Angle(-1, 6, 1) },
	{ Model = Model( "models/props_combine/breenclock.mdl" ), Pos = Vector(-6747, -9678, 3827), Angle = Angle(0, 46, 0) },
	{ Model = Model( "models/props_lab/huladoll.mdl" ), Pos = Vector(-6732, -9672, 3824), Angle = Angle(0, 49, 0) },
	{ Model = Model( "models/props/cs_office/phone.mdl" ), Pos = Vector(-6724, -9677, 3823), Angle = Angle(0, 47, 0) },
	{ Model = Model( "models/props_lab/partsbin01.mdl" ), Pos = Vector(-6750, -9654, 3851), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_lab/partsbin01.mdl" ), Pos = Vector(-6750, -9623, 3852), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/tv_plasma.mdl" ), Pos = Vector(-6756, -9637, 3869), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/offcorkboarda.mdl" ), Pos = Vector(-6755, -9577, 3851), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/offpaintingk.mdl" ), Pos = Vector(-6753, -9552, 3883), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props/cs_office/file_cabinet2.mdl" ), Pos = Vector(-6740, -9540, 3791), Angle = Angle(0, -4, 0) },
	{ Model = Model( "models/props/cs_office/trash_can.mdl" ), Pos = Vector(-6735, -9567, 3791), Angle = Angle(0, -2, 0) },
	{ Model = Model( "models/props_combine/breendesk.mdl" ), Pos = Vector(-6734, -9639, 3791), Angle = Angle(0, -180, 0) },
	{ Model = Model( "models/props/cs_office/offpaintingb.mdl" ), Pos = Vector(-6603, -9450, 3868), Angle = Angle(0, -180, 0) },
	{ Model = Model( "models/props/cs_office/offpaintinge.mdl" ), Pos = Vector(-6539, -9450, 3871), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/vending_machine.mdl" ), Pos = Vector(-6871, -9665, 3791), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props/cs_office/vending_machine.mdl" ), Pos = Vector(-6966, -9666, 3791), Angle = Angle(0, 180, 0) },
	{ Model = Model( "models/props_c17/doll01.mdl" ), Pos = Vector(-6593, -9522, 3807), Angle = Angle(-18, 111, 90) },
	{ Model = Model( "models/props/cs_office/exit_wall.mdl" ), Pos = Vector(-7057, -9297, 3897), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_combine/breendesk.mdl" ), Pos = Vector(-7138, -8898, 3791), Angle = Angle(0, -180, 0) },
	{ Model = Model( "models/props/cs_office/computer.mdl" ), Pos = Vector(-7129, -8897, 3823), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_c17/furniturecouch001a.mdl" ), Pos = Vector(-6851, -9070, 3808), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_c17/furniturecouch001a.mdl" ), Pos = Vector(-6787, -8985, 3808), Angle = Angle(0, -180, 0) },
	{ Model = Model( "models/props/cs_office/computer_caseb.mdl" ), Pos = Vector(-7125, -8883, 3791), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/tv_plasma.mdl" ), Pos = Vector(-7260, -9093, 3922), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props/cs_office/projector_remote.mdl" ), Pos = Vector(-7280, -8765, 3824), Angle = Angle(-1, 1, 0) },
	{ Model = Model( "models/props/cs_militia/toilet.mdl" ), Pos = Vector(-7230, -9151, 4189), Angle = Angle(0, 0, 0) },
}

CityFurniture[ "1st Floor Security" ] = {
	{ Model = Model( "models/props_c17/fence01b.mdl" ), Pos = Vector(-7717, -9272, 126), Angle = Angle(0, 90, 0) },
	{ Model = Model( "models/props_building_details/storefront_template001a_bars.mdl" ), Pos = Vector(-7680, -9238, 124), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_building_details/storefront_template001a_bars.mdl" ), Pos = Vector(-7615, -9239, 124), Angle = Angle(0, 1, 0) },
	{ Model = Model( "models/props_c17/fence01a.mdl" ), Pos = Vector(-7552, -9273, 126), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props_c17/fence01b.mdl" ), Pos = Vector(-7449, -9284, 126), Angle = Angle(1, 75, 0) },
	{ Model = Model( "models/props/cs_office/bookshelf1.mdl" ), Pos = Vector(-7542, -9282, 72), Angle = Angle(-1, -90, 0) },
	{ Model = Model( "models/props_wasteland/controlroom_desk001a.mdl" ), Pos = Vector(-7595, -9343, 89), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/phone.mdl" ), Pos = Vector(-7584, -9335, 106), Angle = Angle(0, 1, 0) },
	{ Model = Model( "models/props_lab/clipboard.mdl" ), Pos = Vector(-7584, -9324, 106), Angle = Angle(0, 1, 0) },
	{ Model = Model( "models/props/cs_office/computer.mdl" ), Pos = Vector(-7590, -9307, 106), Angle = Angle(0, -1, 0) },
	{ Model = Model( "models/props/cs_office/computer_caseb.mdl" ), Pos = Vector(-7599, -9281, 72), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/trash_can.mdl" ), Pos = Vector(-7591, -9397, 72), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props_wasteland/controlroom_desk001b.mdl" ), Pos = Vector(-7594, -9467, 89), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/file_box.mdl" ), Pos = Vector(-7589, -9456, 106), Angle = Angle(0, 0, 0) },
	{ Model = Model( "models/props/cs_office/computer.mdl" ), Pos = Vector(-7589, -9499, 106), Angle = Angle(0, -4, 0) },
	{ Model = Model( "models/props/cs_office/phone.mdl" ), Pos = Vector(-7580, -9516, 106), Angle = Angle(-1, 1, 0) },
	{ Model = Model( "models/props/cs_office/computer_caseb.mdl" ), Pos = Vector(-7588, -9513, 72), Angle = Angle(0, 2, 0) },
	{ Model = Model( "models/props_c17/fence01b.mdl" ), Pos = Vector(-7585, -9525, 126), Angle = Angle(0, -90, 0) },
	{ Model = Model( "models/props_c17/fence01b.mdl" ), Pos = Vector(-7616, -9631, 126), Angle = Angle(0, 180, 0) },
}