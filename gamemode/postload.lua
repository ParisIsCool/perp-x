--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local MapGuns = {
	{pos=Vector(2589,4956,704),ang=Angle(0,41,-87)},
	{pos=Vector(-1856,9774,128),ang=Angle(0,0,-88)},
	{pos=Vector(-3749,6643,49),ang=Angle(2,5,-84)},
	{pos=Vector(-8680,3733,-39),ang=Angle(0,63,-87)},
	{pos=Vector(-9578,1803,44),ang=Angle(0,3,88)},
	{pos=Vector(-1650,3186,912),ang=Angle(0,-45,87)},
	{pos=Vector(3485,1711,512),ang=Angle(0,-5,-87)},
	{pos=Vector(-10636,-10968,-319),ang=Angle(0,-34,87)},
	{pos=Vector(-12643,9004,248),ang=Angle(0,69,-87)},
	{pos=Vector(8815,7847,-895),ang=Angle(0,48,-89)},
	{pos=Vector(8926,7954,-895),ang=Angle(0,-134,-87)},
	{pos=Vector(2315,-1999,-155),ang=Angle(1,-5,-83)},
	{pos=Vector(-6445,1600,-27),ang=Angle(0,-38,-88)},
	{pos=Vector(1586,6925,896),ang=Angle(0,-5,-87)},
	{pos=Vector(2825,5301,-454),ang=Angle(-2,0,-168)},
	{pos=Vector(-1040,-9905,-928),ang=Angle(-1,-9,-85)},
	{pos=Vector(14530,-14750,-874),ang=Angle(-1,10,87)},
	{pos=Vector(-2129,5783,18),ang=Angle(0,56,87)},
}

for k, v in pairs(MapGuns) do
	for k, v in pairs(ents.FindInSphere(v.pos,50)) do
		if v:GetClass() == "prop_mapgun" then
			v:Remove()
		end
	end
end


local function spawnRandomMapGun()
	local k = math.random(1,#MapGuns)
	local v = MapGuns[k]
	if not v then return end
	local ent = ents.Create("prop_mapgun")
	ent:SetPos(v.pos)
	ent:SetAngles(v.ang)
	ent:Spawn()
	table.remove(MapGuns, k)
end

hook.Add("InitPostEntity", "SpawnMapGuns", function()
    timer.Simple(30, function()
	    for i = 7, 1, -1 do
		    spawnRandomMapGun()
	    end
    end)
end)
hook.Add("OnReloaded", "SpawnMapGunReload", function()
	for i = 7, 1, -1 do
		spawnRandomMapGun()
	end
end)