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
	{ Vector(4849, -3722, 1647), Vector(-3546, 5550, -163) },
}

policeDoors = { 
	{Vector(-600, -1507, -373.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-687, -1817, -373.75), 'models/props_c17/door03_left.mdl'},
	{Vector(-213, -2081, -373.75), 'models/props_c17/door03_left.mdl'},
}
					
civilDoors = {
	{ Vector(-316, -2207, 522.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(-316, -1655, 522.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(71.5, -1220, 531.5), '*306'},
	{ Vector(-61.5, -1220, 531.5), '*307'},
	{ Vector(-386, -1752, 1802), 'models/props_c17/door01_left.mdl'},
	{ Vector(-510, -1752, 1802), 'models/props_c17/door01_left.mdl'},
	{ Vector(-510, -2124, 1802), 'models/props_c17/door01_left.mdl'},
	{ Vector(-386, -2124, 1802), 'models/props_c17/door01_left.mdl'},
	{ Vector(14, -1452, 3849.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(-126, -1452, 3849.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(-384, -1906, 3849.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(-384, -2000, 3849.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(-2412, 737, 130.25), 'models/props_c17/door03_left.mdl'},
	{ Vector(-2839, 756, 130.25), 'models/props_c17/door03_left.mdl'},
	{ Vector(-2667, 756, 130.25), 'models/props_c17/door03_left.mdl'},
	{ Vector(-2705, 555, 130.25), 'models/props_c17/door03_left.mdl'},
	{ Vector(-2705, 461, 130.25), 'models/props_c17/door03_left.mdl'},

	{ Vector(7508.5, 12830, 136), '*19'},
	{ Vector(7948, 12816, 126.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(7658, 13106, 126.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(7387, 13138, 126.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(7123, 13100, 126.25), 'models/props_c17/door01_left.mdl'},
	{ Vector(7022.5, 13140, 150), '*20'},
	{ Vector(8291, 13170, 134), '*16'}, 
	{ Vector(8291, 13325, 134), '*15'},
	{ Vector(8291, 13480, 134), '*17'},

	{ Vector(8291, 13170, 134), '*316'},
	{ Vector(8291, 13325, 134), '*315'},
	{ Vector(8291, 13480, 134), '*317'},
	{ Vector(7022.5, 13140, 150), '*319'},
	{ Vector(7508.5, 12830, 136), '*314'},
}

clubDoors = { 

}

RealtorOfficeDoors = { 
	{Vector(1783.5, 84.78125, 203), '*103'},
	{Vector(1783.5, 179.1875, 203), '*104'},
	{Vector(1365, 27, 194.25), 'models/props_c17/door01_left.mdl'},
}

BPShopDoors = { 
	{Vector(-7395, 866, 203), '*288'},
	{Vector(-7395, 1038, 203), '*289'},
	{Vector(-7388, 1269, 202.25), 'models/props_c17/door01_left.mdl'},
}

FCStoreDoors = { 

}
					
TidesHotelDoors = { 

}
					
ShopsDoors = { 
	{Vector(773, -1146, 131.5), '*189'},
}
					
CarDealerDoors = { 
	{Vector(2580, -1664.5, 138), '*128'},
	{Vector(2580, -1535.5, 138), '*127'},
	{Vector(1880, -2428, 154), '*123'},
	{Vector(2580, -2960, 154), '*124'},
}
					
HospitalDoors = { 
	{Vector(-2412, 988, 139), '*133'},
	{Vector(-2412, 1052, 139), '*134'},
	{Vector(-2450, 892, 139), '*135'},
	{Vector(-2514, 892, 139), '*136'},
	{Vector(-2667, 756, 130.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-2839, 756, 130.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-2705, 555, 130.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-2705, 461, 130.25), 'models/props_c17/door03_left.mdl'},
	{Vector(-2750, 388, 139), '*132'},
	{Vector(-2814, 388, 139), '*131'},
}
					
GovermentCenterDoors = { 
	{Vector(-772.34375, -1452, 138), '*308'},
	{Vector(-675.625, -1452, 138), '*188'},
	{Vector(-395.625, -1452, 138), '*309'},
	{Vector(-492.34375, -1452, 138), '*310'},
}
					
JailsDoors = { 
	{Vector(590, -2073, -377), '*206'},
	{Vector(718, -2073, -377), '*205'},
	{Vector(846, -2073, -377), '*204'},
	{Vector(846, -2272, -377), '*201'},
	{Vector(718, -2272, -377), '*199'},
	{Vector(590, -2272, -377), '*197'},
	{Vector(462, -2272, -377), '*194'},
}
					
ApartmentsDoors = { 
	{Vector(3740, -2086, 132), '*177'},
	{Vector(3740.375, -2146, 132), '*176'},
}
					
RoadCrewDoors = { 
	{Vector(7948, 12816, 126.25), 'models/props_c17/door01_left.mdl'},
	{Vector(7508.5, 12830, 136), '*314'},
	{Vector(7387, 13138, 126.25), 'models/props_c17/door01_left.mdl'},
	{Vector(7123, 13100, 126.25), 'models/props_c17/door01_left.mdl'},
	{Vector(7022.5, 13140, 150), '*319'},
	{Vector(7658, 13106, 126.25), 'models/props_c17/door01_left.mdl'},
	{Vector(8291, 13480, 134), '*317'},
	{Vector(8291, 13325, 134), '*315'},
	{Vector(8291, 13170, 134), '*316'},
}

CasinoDoors = {
	//{ Vector( -3992, -6441, 252.25 ), "models/props_c17/door01_left.mdl" }
}

CityFurniture = {}