--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function ENTITY:GetZoneName ( )

	local loc = "an unknown location"
	for k, v in ipairs( GAMEMODE.LifeAlert or {} ) do
		if self:GetPos():WithinAABox(v.pos1,v.pos2) then
			loc = v.name
		end
	end
	
	return loc
end

function PLAYER:BroadcastLifeAlert ( )
	local lifeAlertZone = self:GetZoneName()
	
	if (!lifeAlertZone) then return end
		
	GAMEMODE:PlayerSay(self, "/911 [Life Alert] An accident has occured at " .. lifeAlertZone .. ".", true, true)
end

local BigZones = {
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

local StreetBlocks = {
	--{ pos1 = Vector(9425,-3745,-900), pos2 = Vector(-10369,8830,2020), name = "City" },
	{ pos1 = Vector(-11712,11904,120), pos2 = Vector(2816,12798,2020), name = "Maple Road" },
	{ pos1 = Vector(-11712,-128,-48), pos2 = Vector(-11200,12798,2020), name = "Maple Road" },
	{ pos1 = Vector(1916,9728,120), pos2 = Vector(2816,12798,2020), name = "Maple Road" },
	{ pos1 = Vector(-2817,9728,120), pos2 = Vector(-3710,14699,2020), name = "Memory Lane" },
	{ pos1 = Vector(3457,8634,120), pos2 = Vector(5312,8830,2020), name = "North Street" },
	{ pos1 = Vector(6208,9728,120), pos2 = Vector(-6144,8830,2020), name = "North Street" },
	{ pos1 = Vector(-5249,9728,-48), pos2 = Vector(-6144,2751,2020), name = "North Street" },
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
	{ pos1 = Vector(10176,4352,-64), pos2 = Vector(3456,3456,2020), name = "New Life Street" },
	{ pos1 = Vector(2560,4352,-112), pos2 = Vector(3456,-1024,2020), name = "Union Square" },
	{ pos1 = Vector(704,4546,-112), pos2 = Vector(-2944,3456,2020), name = "Crooked Lane" },
	{ pos1 = Vector(-2048,4352,-112), pos2 = Vector(-2944,-128,2020), name = "Bank Street" },
	{ pos1 = Vector(-8576,1856,-112), pos2 = Vector(-2944,2751,2020), name = "Pleasant Road" },
	{ pos1 = Vector(5308,4352,-176), pos2 = Vector(6208,-2560,2020), name = "Grand Way" },
	{ pos1 = Vector(6593,2400,-112), pos2 = Vector(6208,395,2020), name = "Grand Way" },
	{ pos1 = Vector(704,2369,-112), pos2 = Vector(2560,1248,2020), name = "Union Square" },
	{ pos1 = Vector(-8576,-128,-112), pos2 = Vector(-7680,2751,2020), name = "Pleasant Road" },
	{ pos1 = Vector(-14656,-128,-112), pos2 = Vector(3456,-1024,2020), name = "Any Way" },
	{ pos1 = Vector(-14656,-128,-176), pos2 = Vector(-14144,-11968,2020), name = "Any Way" },
	{ pos1 = Vector(-4608,-2560,-240), pos2 = Vector(6208,-3488,2020), name = "River Road" },
	{ pos1 = Vector(-4608,-2560,-112), pos2 = Vector(-3712,-1024,2020), name = "River Road" },
}

local BuildingBlocks = {
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

local CalculatedBlocks = table.Copy(BigZones)
for k, v in ipairs(StreetBlocks) do
	table.insert(CalculatedBlocks,v)
end
for k, v in ipairs(BuildingBlocks) do
	table.insert(CalculatedBlocks,v)
end
GM.LifeAlert = 	CalculatedBlocks