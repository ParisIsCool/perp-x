
-- Summer Festivities

local SummerCollects = {
	Vector(-710,13765,128),
	Vector(-6377,13154,128),
	Vector(-2694,10012,142),
	Vector(-3301,7575,129),
	Vector(-2052,7516,128),
	Vector(1639,11003,128),
	Vector(-450,9991,128),
	Vector(-1439,11285,127),
	Vector(2974,7356,56),
	Vector(2271,5434,704),
	Vector(1852,5225,8),
	Vector(3532,4844,-39),
	Vector(3241,5055,224),
	Vector(4480,5717,-55),
	Vector(7390,7708,128),
	Vector(9332,5559,8),
	Vector(9875,4038,-63),
	Vector(7994,1889,-94),
	Vector(7360,3252,-66),
	Vector(5086,9787,128),
	Vector(3527,8423,136),
	Vector(4273,7547,128),
	Vector(3817,8544,768),
	Vector(1325,7249,896),
	Vector(-419,7215,1024),
	Vector(-2174,5846,17),
	Vector(-6895,3641,-39),
	Vector(1265,8747,128),
	Vector(-77,6777,8),
	Vector(319,11065,129),
	Vector(-6046,4320,-39),
	Vector(-12699,9811,248),
	Vector(-11105,-146,-31),
	Vector(-6255,12048,127),
	Vector(-3113,7205,128),
	Vector(-1758,5816,8),
	Vector(410,8603,716),
	Vector(-3125,6557,48),
	Vector(3749,6414,704),
	Vector(-957,11300,136),
	Vector(-593,11393,136),
	Vector(-2250,10401,128),
	Vector(1262,-1597,-95),
	Vector(1762,-1923,-95),
	Vector(1021,7227,35),
	Vector(68,8132,128),
	Vector(-630,7758,147),
	Vector(-3702,10552,128),
	Vector(-2842,11960,126),
	Vector(4671,4619,-55),
	Vector(5528,5825,128),
	Vector(-13843,-9253,-130),
	Vector(-4671,-1091,-102),
	Vector(2177,3523,832),
	Vector(-960,895,704),
	Vector(-225,-72,512),
	Vector(-1861,245,-98),
	Vector(-3271,-2212,-75),
	Vector(-5148,-63,-100),
	Vector(-5323,1795,-49),
	Vector(-8847,1572,-27),
	Vector(-9579,2922,0),
	Vector(-9372,1645,0),
	Vector(-7199,3538,-39),
	Vector(-8101,3754,-39),
	Vector(-6857,3599,-39),
	Vector(-6125,4327,-39),
	Vector(-5030,4198,-39),
	Vector(-3820,4329,-104),
	Vector(-2916,4330,-104),
	Vector(-2659,5271,-19),
	Vector(-3090,6597,48),
	Vector(-3738,6629,48),
	Vector(-4078,5525,48),
	Vector(-1059,2024,-103),
	Vector(-857,347,-103),
	Vector(-335,809,-96),
	Vector(-285,1241,-103),
	Vector(604,2168,-495),
	Vector(-699,1951,-495),
	Vector(-803,931,-495),
	Vector(-2591,939,-495),
	Vector(-2591,1072,-495),
	Vector(-1887,2449,-496),
	Vector(-1888,4644,-343),
	Vector(-3285,5960,-343),
	Vector(967,5400,-343),
	Vector(1868,5291,-448),
	Vector(2889,5277,-447),
	Vector(2755,7113,-264),
	Vector(2551,4878,-447),
	Vector(3366,4100,-447),
	Vector(3158,2548,-496),
	Vector(676,2463,-496),
	Vector(1015,1679,-495),
	Vector(-2025,5914,17),
	Vector(920,7001,16),
	Vector(805,3547,-96),
	Vector(1748,2338,-103),
	Vector(3597,2136,-96),
	Vector(5134,573,-103),
}

-- Spawn Summer Collectables
hook.Add("PlayerInitialSpawn", "SpawnSummerCollectablesYay", function()
	if InitializedCollectablePresents then return end
	InitializedCollectablePresents = true
	timer.Simple(15, function()
		for k, v in pairs(SummerCollects) do
			local e = ents.Create("ent_collectable")
			e:SetModel("models/dlaor/dbeachball.mdl")
			e:SetPos(v)
			e:Spawn()
			e.Collectable = {"SummerCollectable", k}
			e:SetNWString("Collectable","SummerCollectable")
			e:SetNWInt("CollectableNum",k)
		end
	end)
end)



---------------------------

--[[
		Old Xmas :()
--]]

---------------------------

local smalltrees = {
	{Vector(3097,5497,0), Angle(0,-90,0)},
	{Vector(3077,4653,0), Angle(0,180,0)},
}

local bigtrees = {
	{Vector(1251,678,-104), Angle(0,90,0)},
}

--[[local presents = {
	{ Vector( -4917, -7645, 0 ), Angle( 0, 81, 0 ) },
	{ Vector( -4944, -7644, 0 ), Angle( 0, 88, 0 ) },
	{ Vector( -4933, -7657, 20 ), Angle( 0, 83, 0 ) },
	{ Vector( -5157, -7625, 0 ), Angle( 0, 42, 0 ) },
	{ Vector( -5127, -7622, 0 ), Angle( 0, 101, 0 ) },
	{ Vector( -5185, -7660, 0 ), Angle( 0, 111, 0 ) },
	{ Vector( -5211, -7674, 0 ), Angle( 0, 119, 0 ) },
	{ Vector( -5213, -7635, 0 ), Angle( 0, -30, 0 ) },
	{ Vector( -5205, -7653, 20 ), Angle( 0, 117, 0 ) },
	{ Vector( -5136, -7635, 20 ), Angle( 0, -87, 0 ) },
	{ Vector( -5165, -7649, 20 ), Angle( 0, -61, 0 ) },
	{ Vector( -5187, -7612, 0 ), Angle( 0, -80, 0 ) },
	{ Vector( -4971, -7638, 0 ), Angle( 0, -120, 0 ) },
	{ Vector( -5000, -7624, 0 ), Angle( 0, -96, 0 ) },
	{ Vector( -5151, -7643, 40 ), Angle( 0, -63, 0 ) },
	{ Vector( -5386, -5726, 64 ), Angle( 0, 70, 0 ) },
	{ Vector( -3891, -5712, 64 ), Angle( 0, 110, 0 ) },
}]]

--[[local fences = {
	{ Vector( -4543, -7396, -50 ), Angle( 0, -79, 0 ) },
	{ Vector( -4661, -7432, -50 ), Angle( 0, -68, 0 ) },
	{ Vector( -4770, -7490, -50 ), Angle( 0, -56, 0 ) },
	{ Vector( -4854, -7578, -50 ), Angle( 0, -32, 0 ) },
	{ Vector( -4915, -7690, -50 ), Angle( 0, -25, 0 ) },
}]]



local function SpawnTrees()

	if os.date("%m", os.time()) != "12" then return end

	for k, v in pairs(smalltrees or {}) do
		local ent = ents.Create("prop_physics")
		ent:SetModel("models/tfre/xmas_tree_interior.mdl")
		ent:SetPos(v[1])
		ent:SetAngles(v[2])
		ent:Spawn()
		ent:GetPhysicsObject():EnableMotion(false);
		ent:SetColor(Color(math.Clamp(math.random(0, 255), 50, 255),math.Clamp(math.random(0, 255), 50, 255),math.Clamp(math.random(0, 255), 50, 255)))
		ent.XMas = true
		ent.UnBurnable = true
	end
	for k, v in pairs(bigtrees or {}) do
		local ent = ents.Create("prop_physics")
		ent:SetModel("models/tfre/xmas_tree.mdl")
		ent:SetPos(v[1])
		ent:SetAngles(v[2])
		ent:Spawn()
		ent:GetPhysicsObject():EnableMotion(false);
		ent.XMas = true
		ent.UnBurnable = true
	end
	for k, v in pairs(presents or {}) do
		local ent = ents.Create("ent_xmaspresent")
		ent:SetPos(v[1])
		ent:SetAngles(v[2])
		ent:Spawn()
		ent:GetPhysicsObject():EnableMotion(false);
		ent:SetColor(Color(math.Clamp(math.random(0, 255), 50, 255),math.Clamp(math.random(0, 255), 50, 255),math.Clamp(math.random(0, 255), 50, 255)))
		ent.XMas = true
		ent.UnBurnable = true
	end
	for k, v in pairs(fences or {}) do
		local ent = ents.Create("prop_physics")
		ent:SetModel("models/props_wasteland/wood_fence01a.mdl")
		ent:SetPos(v[1])
		ent:SetAngles(v[2] + Angle(0,90,0))
		ent:Spawn()
		ent:GetPhysicsObject():EnableMotion(false);
		ent.XMas = true
		ent.UnBurnable = true
	end

	local santa = ents.Create("bot_santa")
	santa:SetModel("models/player/christmas/santa_npc.mdl")
	santa:SetPos(Vector(1516,670,-103))
	santa:SetAngles(Angle( 0, 90, 0 ))
	santa:Spawn()
	-- santa:GetPhysicsObject():EnableMotion(false);
	santa.XMas = true
	santa.UnBurnable = true
	timer.Create("SantaTalkPlease", 5, 0, function()
		if math.random(0, 1) == 0 then
			santa:EmitSound( "paris/santa/" .. tostring(math.random(1, 3)) .. ".wav" )
		end
	end)

end

local function DeleteTrees()
	for k, v in pairs(ents.GetAll()) do
		if v.XMas then
			v:Remove()
		end
	end
end

hook.Add("PlayerInitialSpawn", "XMasSpawn", function()
	if not HasXMasSpawnedYet then
		HasXMasSpawnedYet = true
		SpawnTrees()
	end
end)

if HasXMasSpawnedYet then
	DeleteTrees()
	SpawnTrees()
end

local leavelist = {}

hook.Add("PlayerDisconnected", "xMasYOUCANNOTLEAVEBITCH", function(ply)
	if leavelist[ply:UniqueID()] then
		if XmasPrizes[#XmasPrizes-leavelist[ply:UniqueID()]].WinFunction(ply) == "Respin" then
			ply:XMASSetXMasSpin(0)
		end
	end
end)

function PLAYER:XMASSetXMasSpin(time)
	SetPerpExtra(self, "SantaSpin", time)
end

concommand.Add("setxmasspin", function(ply,cmd,args)
	if ply:IsLeader() then
		SetPerpExtra(ply, "SantaSpin", tonumber(args[1]))
	end
end)

util.AddNetworkString("xmas_startspin")
util.AddNetworkString("xmas_clientready")
net.Receive("xmas_startspin", function(len,ply)
	-- checks and shit

	if ply.xMasSpinning then 
		leavelist[ply:UniqueID()] = nil -- u dont get prize
		ply:Kick("You've been kicked for attempting a possible exploit with Santa's Gifts. If you believe this is an error please contact a staff member.")
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint(ply:Nick() .. " has been kicked for attempting a possible exploit with Santa's Gifts.")
		end
		return 
	end

	local time = ply:GetNWInt("SantaSpin")
	if time and time-60 > os.time() then
		ply:ChatPrint("You cannot spin. Next spin available " .. os.date("%c",time))
		return
	end
	
	ply:XMASSetXMasSpin(os.time() + (3600*24))

	ply.xMasSpinning = true
	
	local winningnumber = math.random(0, #XmasPrizes-1)
	
	leavelist[ply:UniqueID()] = winningnumber

	net.Start("xmas_startspin")
		net.WriteInt(winningnumber,8)
	net.Send(ply)

	net.Receive("xmas_clientready", function(len,Player)
		if Player == ply and Player.xMasSpinning then
			if XmasPrizes[#XmasPrizes-winningnumber].WinFunction(Player) == "Respin" then
				ply:XMASSetXMasSpin(0)
			end
			Player.xMasSpinning = false
		end
	end)

end)

local function ChooseNewCar()

	if os.date("%m", os.time()) != "12" then return end

	if IsValid(XMAS_SHOWCASE_VEHICLE) then
		XMAS_SHOWCASE_VEHICLE:Remove()
	end

	local c = 0
	local vehicleTable = table.Random( VEHICLE_DATABASE )
	while vehicleTable.RequiredClass or (not vehicleTable.Cost) do
		vehicleTable = table.Random( VEHICLE_DATABASE )
		c = c + 1
		if c>100 then return print("line 210, system xmas") end
	end
	
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint("A new podium vehicle has been set at santa's gifts! Go check it out!")
	end

	local Colors = {
		Color(219, 50, 50), -- Red
		Color(219, 154, 50), -- Orange
		Color(250, 250, 57), -- Yellow
		Color(109, 255, 69), -- Green
		Color(69, 255, 209), -- Light Blue
		Color(69, 91, 255), -- Dark Blue
		Color(187, 69, 255), -- Violet
		Color(255, 255, 255), -- White
		Color(89, 89, 89), -- Grey
		Color(5, 5, 5) -- Black
	}

	local newVehicle = ents.Create( "prop_vehicle_jeep" )
	XMAS_SHOWCASE_VEHICLE = newVehicle
	newVehicle:SetModel( vehicleTable.WorldModel )
	newVehicle:SetColor(Colors[math.random(1, #Colors)])
	newVehicle:SetPos( Vector(1200,1054,63) + Vector(0, 0, 30) )
	newVehicle:SetAngles( Angle(0,0,0) )
	--newVehicle:SetKeyValue( "vehiclescript", vehicleTable.Script )
	newVehicle:Spawn()
	--newVehicle:PhysicsDestroy()

	timer.Simple(0, function()
		newVehicle:VC_setGodMode(true)
		newVehicle:Fire('turnon', '', 0)
		timer.Simple(1, function()
			if IsValid(newVehicle) then
				newVehicle:VC_SetHighBeams(true)
				newVehicle:VC_SetRunningLights(true)
				newVehicle:VC_SetFogLights(true)
				newVehicle:PhysicsDestroy()
			end
		end)
	end)

	hook.Add("Think", "XMASPODIUMSPINVEH", function()
		if IsValid(newVehicle) then
			newVehicle:SetPos(Vector( -4651, -7639, 0 ))
			newVehicle:SetAngles(Angle(0,CurTime()*10,0))
		end
	end)

	newVehicle.vehicleTable = vehicleTable

end

-- hook.Add("Initialize", "XMASStartCarCycle", function()
-- 	ChooseNewCar()
-- 	-- 3600*60
-- 	timer.Create("XMASPodiumChooseCycle", 3600, 0, function()
-- 		ChooseNewCar()
-- 	end)
-- end)

hook.Add("VC_canEnterPassengerSeat", "VC_canEnterPassengerSeat_XMASSYSTEMPODIUM", function(ply, seat, veh)
	return XMAS_SHOWCASE_VEHICLE != veh
end)

hook.Add("VC_canSwitchSeat", "VC_canSwitchSeat_XMASSYSTEMPODIUM", function(ply, ent_from, ent_to)
	return ply:GetVehicle() != XMAS_SHOWCASE_VEHICLE
end)

hook.Add("CanPlayerEnterVehicle", "XMASSYSTEMPODIUM", function(player, vehicle, role)
	return vehicle != XMAS_SHOWCASE_VEHICLE
end)

-- concommand.Add("podium", function()
-- 	ChooseNewCar()
-- end)

local function TellAll(text)
    for k,v in pairs(player.GetAll()) do
        print(text)
		v:ChatPrint(text)
	end
end

net.Receive("OpenVIPChoosePlayerPanel", function(len, Player)
	if not Player.xMasVIPValid then
		Player:Kick("Attempted to exploit Santa's Gift System.... (VIP RELATED) (LIKELY A CHEATER)")
		return
	end
	Player.xMasVIPValid = false

	local RankLevel = Player.xMasRankLevel
	local Time = Player.xMasTime

	local sid = net.ReadString()
	local nick = net.ReadString()
	if util.SteamIDTo64( sid ) == "0" then
		Player:Kick("An error has occured at Santa's Gift System.... (VIP RELATED)")
		return
	end

	TellAll(Player:Nick() .. " just gifted " .. tostring(nick) .. " 3 days of free VIP from Santa's Gifts!")

	aSoc.GetRank(sid,function(rank)
		if aSoc.Ranks[rank].Priority <= aSoc.Ranks["aSoc:VIP"].Priority then -- THEY ARE VIP OOPS
			Player:XMASSetXMasSpin(0) -- best we can do
		else
			aSoc.BuyDonatorRank(sid,RankLevel,Player.xMasLength,"XMAS_SYS")
		end
	end)

end)