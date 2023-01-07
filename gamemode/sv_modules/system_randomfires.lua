--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
//  Developed Listening To:  //
//      Cage The Beatles     //
///////////////////////////--]]

local FireVectors = {}
FireVectors["rp_southside"] = {
    Vector(6517,1607,-103),
	Vector(4753,-281,-95),
	Vector(1030,559,-50),
	Vector(-5242,125,-73),
	Vector(-3843,2853,-66),
	Vector(-3174,2891,-99),
	Vector(-3603,4237,-103),
	Vector(-3763,3462,-98),
	Vector(787,4990,-48),
	Vector(4071,7397,128),
	Vector(3451,5903,24),
	Vector(2340,1047,-101),
	Vector(-8035,3114,-33),
	Vector(-9549,1957,13),
	Vector(-8892,2740,14),
	Vector(-3806,6497,78),
	Vector(-3121,5571,48),
	Vector(-2644,6012,17),
	Vector(-3164,6920,89),
	Vector(-2553,9872,156),
	Vector(-2430,11211,128),
	Vector(1812,10601,151),
	Vector(895,11728,162),
	Vector(-1859,79,-94),
	Vector(-3254,639,-103),
	Vector(538,4473,-98),
}

RANDOM_FIRES = RANDOM_FIRES or 0

local function RandomFire()
    if team.NumPlayers(TEAM_FIREMAN) <= 0 then return end
    print("Spawning random fire: " .. RANDOM_FIRES)
    if RANDOM_FIRES > 5 then return end
    local randomPlace = math.random(1,2)
    RANDOM_FIRES = RANDOM_FIRES + 1
    if randomPlace == 1 then -- random property
        local tab = {}
        for k, v in pairs(PROPERTY_DATABASE) do -- make tabke of unowned properties
            if not IsValid(GetGNWVar( "p_" .. k )) then
                table.insert(tab,v)
            end
        end
        local Property = table.Random(tab) -- pick one randomly
        local AmountOfDoors = math.ceil(math.random(1,#Property.Doors/2))
        for i = AmountOfDoors,1,-1 do
            local door = Property.Doors[i] -- find door, set on fire
            local Fire = ents.Create( "ent_fire" )
            Fire:SetPos( door[1] )
            Fire:Spawn()
        end
        for _, ply in pairs(player.GetHumans()) do
            if ply:Team() == TEAM_FIREMAN then
                ply:ChatPrint("A fire has been spotted at " .. Property.Name .. ". It has been added to your radar!")
                AddMapBlipSpecificPlayer(Property.HUDBlip,"paris/blips/fire.png", Property.Name.. " Fire", 24, Color(255,123,61), 10000000, "*", false, ply)
            end
        end
        hook.Add("Think", "RemoveRandomFireBlip"..Property.Name, function()
            for k, v in pairs(ents.FindInSphere(Property.HUDBlip,2000)) do
                if v:GetClass() == "ent_fire" then
                    return
                end
            end
            RemoveBlip(Property.Name.. " Fire")
            RANDOM_FIRES = RANDOM_FIRES - 1
            hook.Remove("Think", "RemoveRandomFireBlip"..Property.Name)
        end)
    elseif randomPlace == 2 then -- random vector
        if FireVectors[game.GetMap()] then
            local spot = table.Random(FireVectors[game.GetMap()]) -- find random spot from list above
            local Fire = ents.Create( "ent_fire" )
            Fire:SetPos( spot )
            Fire:Spawn()
            local location = Fire:GetZoneName()
            for _, ply in pairs(player.GetHumans()) do
                if ply:Team() == TEAM_FIREMAN then
                    ply:ChatPrint("A fire has been spotted at " .. location .. ". It has been added to your radar!")
                    AddMapBlipSpecificPlayer(spot,"paris/blips/fire.png", location.. " Fire " .. Fire:EntIndex(), 24, Color(255,123,61), 10000000, "*", false, ply)
                end
            end
            local entindex = Fire:EntIndex()
            hook.Add("Think", "RemoveRandomFireBlip"..location..entindex, function()
                for k, v in pairs(ents.FindInSphere(spot,2000)) do
                    if v:GetClass() == "ent_fire" then
                        return
                    end
                end
                RemoveBlip(location.. " Fire " .. entindex)
                RANDOM_FIRES = RANDOM_FIRES - 1
                hook.Remove("Think", "RemoveRandomFireBlip"..location..entindex)
            end)
        end
    end
end

RandomFire()

timer.Create("RandomFire", 60*2, 0, RandomFire)