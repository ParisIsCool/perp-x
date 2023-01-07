--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

--[[

{Vector(1513, -3959, -1815), '*156'},
{Vector(1386, -4086, -1815), '*157'},


]]--

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
						{Vector(3282, -4523.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(3376, -4523.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(4100, -4387.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(4006, -4387.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(4109, -4717.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(3655, -4319.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(3561, -4319.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(4109, -4577.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(4109, -4717.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(4341, -4641.509765625, -1413.5), '*75'},
						{Vector(4341, -4774.509765625, -1413.5), '*74'},
						{Vector(3906, -4387.009765625, -1422.7199707031), 'models/props_c17/door01_left.mdl'},
						{Vector(3354, -4387.009765625, -1422.7199707031), 'models/props_c17/door01_left.mdl'},
						{Vector(3362, -4523.009765625, -1422.7199707031), 'models/props_c17/door01_left.mdl'},
						{Vector(4110, -4050, -1815), '*164'},
						{Vector(4110, -3932, -1815), '*165'},
						{Vector(4110, -4306, -1815), '*166'},
						{Vector(4110, -4188, -1815), '*167'},
						{Vector(-7515, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
						{Vector(-6963, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
						{Vector(-6528, -9556.5, 527.5), '*218'},
						{Vector(-6528, -9423.5, 527.5), '*219'},
						{Vector(-7432, -9099, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7432, -8975, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7060, -8975, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7060, -9099, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7308, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-7214, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-6760, -9359, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-6760, -9499, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-7125, -8798, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-7389, -9272, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-3816, -8232, 290), '*113'},
						{Vector(-3816, -7944, 290), '*111'},
						{Vector(-3816, -7656, 290), '*112'},
						{Vector(-3804, -7572.009765625, 248), '*115'},
						{Vector(-3684, -7572.009765625, 248), '*114'},
						{Vector(-3828, -7122, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3828, -7306.990234375, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3828, -7370.990234375, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3659, -7317, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3659, -7381, 252.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(-9383, 9044, 126.281), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9768, 9097, 126.281), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9880, 9334, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9880, 9240, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10256, 9020, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10015, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10121, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10529, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10623, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10609, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10703, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
						{Vector(3480, -4490.009765625, -2318.75), 'models/props_c17/door03_left.mdl'},
						{Vector(3744, -4016.0100097656, -2318.75), 'models/props_c17/door03_left.mdl'},
						{Vector(4054, -4103.009765625, -2318.75), 'models/props_c17/door03_left.mdl'},

}
					
civilDoors = { 
	

	{ Vector(1312, 4603, 144), '*159' },
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
	{ Vector( -6758, -10521, -124.5 ), "*145" },
	{ Vector( -3804, -7572, 248 ), "*62" },
	{ Vector( -3684, -7572, 248 ), "*61" },
	{ Vector( -3816, -7656, 290 ), "*59" },
	{ Vector( -3816, -7944, 290 ), "*58" },
	{ Vector( -3816, -8232, 290 ), "*60" },
	{ Vector( -10904, 9333, 135 ), "*241" },
}

clubDoors = { 
	{Vector(-6967, -12459, 135), '*244'},
	{Vector(-7089, -12459, 135), '*245'}
}

RealtorOfficeDoors = { 
	{Vector(1689, -2283, -1763), '*168'},
	{Vector(1689, -2165, -1763), '*169'},
	{Vector(1062, -2557, -1763), '*170'},
	{Vector(929, -2606, -1763), '*171'},
	--{ Vector( -7092, -7786, 135 ), "*171" },
	--{ Vector( -7092, -7664, 135 ), "*172" },
	--{ Vector( -10904.5, 9393, 135 ), "*240" },
}

BPShopDoors = { 
		{Vector(3373, 829.98999023438, -1806), '*85'},
		{Vector(3373, 707.98999023438, -1806), '*86'},
		{Vector(-7685, 5225, -1434.5), '*175'},
		{Vector(-7949, 5225, -1434.5), '*174'},

	--{ Vector( -7348, -6349, 135 ), "*170" },
	--{ Vector( -7348, -6227, 135 ), "*169" },
	--{ Vector( 10524, 13380, 121.5 ), "*175" },
	--{ Vector( 10260, 13380, 121.5 ), "*176" },
}

FCStoreDoors = { 
	{Vector(5564, -1686, -1806), '*92'},
	{Vector(5686, -1686, -1806), '*91'},

	--{ Vector( -5305, -6468, 135 ), "*181" },
	--{ Vector( -5183, -6468, 135 ), "*180" },
}
					
TidesHotelDoors = { 
		{ Vector(-11159, -1325.5100097656, -2073), '*105' },
		{ Vector(-11099, -1325.0100097656, -2073), '*104' },
		{ Vector(-10911, -1325.5100097656, -2073), '*107' },
		{ Vector(-10851, -1325.0100097656, -2073), '*106' },
		{ Vector(-11065, 724.98999023438, -1946), '*109' },
		{ Vector(-10945, 724.98999023438, -1946), '*110' },


	--{ Vector( -5445.5, -4454, 135 ), "*51" },
	--{ Vector( -5445, -4514, 135 ), "*50" },
	--{ Vector( -5445.5, -4702, 135 ), "*53" },
	--{ Vector( -5445, -4762, 135 ), "*52" },
}
					
ShopsDoors = { 
	{ Vector( -6454, -10258, 127.5 ), "*64" },
	{ Vector( -5255, -6945, 135 ), "*182" },
	{ Vector( -5377, -6945, 135 ), "*183" },
}
					
CarDealerDoors = { 
	{ Vector( 4066, -4757, 142 ), "*30" },
	{ Vector( 4598, -4057, 142 ), "*29" },
	{ Vector( 5361.5, -4757, 126 ), "*34" },
	{ Vector( 5490.5, -4757, 126 ), "*33" },
}
					
HospitalDoors = { 
	{ Vector( -9440.5, 9393, 135 ), "*239" },
	{ Vector( -9440, 9333, 135 ), "*238" },
}
					
GovermentCenterDoors = { 
	{ Vector( -6760, -8712.625, 134 ), "*140" },
	{ Vector( -6760, -8809.34375, 134 ), "*63" },
	{ Vector( -6760, -8992.625, 134 ), "*142" },
	{ Vector( -6760, -9089.34375, 134 ), "*141" },
	{ Vector( -7782, -10415, -170.79219055176 ), "*65" },
	{ Vector( -6892, -10160, -88 ), "*68" },
	{ Vector( -6758, -10521, -124.5 ), "*145" },
}
					
JailsDoors = { 
	{ Vector( -7027, -9253, -372 ), "*78" },
	{ Vector( -7482, -9844, -372 ), "*71" },
	{ Vector( -7479.1875, -10369.375, -372 ), "*87" },
	{ Vector( -8066, -9825, -377.75 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -7972, -9825, -377.75 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -7580, -10331, -381 ), "*76" },
	{ Vector( -7580, -10203, -381 ), "*74" },
	{ Vector( -7580, -10075, -381 ), "*72" },
	{ Vector( -7580, -9947, -381 ), "*69" },
	{ Vector( -7381, -9947, -381 ), "*82" },
	{ Vector( -7381, -10075, -381 ), "*81" },
	{ Vector( -7381, -10203, -381 ), "*80" },
	{ Vector( -7381, -10331, -381 ), "*79" },
}
					
ApartmentsDoors = { 
	--{Vector(1386, -4086, -1815), '*157'},
    --{Vector(1513, -3959, -1815), '*156'},
    {Vector(265,-5107,-1687), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1563, -4460, -1623), '*158'},
	{Vector(1563, -4460, -1623), '*158'},
	{Vector(1563, -4461, -1534), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1563, -4460, -1335), '*162'},
	{Vector(1696, -4453, -1678), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1696, -4453, -1534), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1696, -4453, -1390), 'models/joebloom/doors/door_interior01.mdl'},
}
					
RoadCrewDoors = { 
	{ Vector( 694, 4067, 136 ), "*161" },
	{ Vector( 694, 3955, 136 ), "*162" },
	{ Vector( 694, 3851, 136 ), "*164" },
	{ Vector( 694, 3739, 136 ), "*163" },
	{ Vector( 743, 4093, 126.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( 845, 4528, 126.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( 845, 4592, 126.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( 937, 4101, 136 ), "*166" },
	{ Vector( 937, 4220, 136 ), "*165" },
	{ Vector( 1312, 4603, 144 ), "*159" },
	{ Vector( 1084, 4603, 144 ), "*160" },
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