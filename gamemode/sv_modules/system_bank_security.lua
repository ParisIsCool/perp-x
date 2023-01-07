local function BankSecurityMoney()
    if ( team.NumPlayers(TEAM_BANK_SECURITY) < 1 ) then return end

    local spawnPos = {
        {Vector(-1389,1764,-94), Angle(0,0,0)},
        {Vector(-1387,1560,-94), Angle(0,0,0)},
        {Vector(-1385,1334,-94), Angle(0,0,0)},
        {Vector(-1382,1136,-94), Angle(0,0,0)},
        {Vector(-1380,930,-94), Angle(0,0,0)},
    }
    
    for _, v in pairs( team.GetPlayers(TEAM_BANK_SECURITY) ) do
        v:Notify("The delivery truck has arrived - get the money and bring it to the vault. You have 15 minutes!")
        v:ChatPrint("The delivery truck has arrived - get the money and bring it to the vault. You have 15 minutes!")
    end

    local vector = Vector(-1353,1528,-112) -- temp
    for k, v in pairs(ents.FindInSphere(vector,400)) do
        if v:GetClass() == "prop_physics" or v:GetClass() == "ent_stockade" then
            v:Remove()
        end
    end

    local best
    for _, vec in ipairs(spawnPos) do
        local cont
        for _, v in pairs(ents.FindInSphere(vec[1],130)) do
            -- since gmod apparently doesnt use lua 5.2+ and we cant use goto...
            if (v:GetClass() == "prop_vehicle_jeep") or v:IsPlayer() then cont = true end
        end
        if cont then continue end
        
        best = vec
        break
    end

    if not best then 
        best = {Vector(-1821,1630,-94), Angle(0,-90,0)}
        -- If you are not parked in a parking spot, and all parking spots are taken your vehicle gets yeeted because you are dumb. 
        for k, v in pairs(ents.FindInSphere(best[1],400)) do
            if v:GetClass() == "prop_vehicle_jeep" then
                v:Remove()
            end
        end
    end
    
    local vehicle = ents.Create("ent_stockade")
    vehicle:SetAngles(best[2])
    vehicle:SetPos(best[1] + Vector(0,0,8))
    vehicle:Spawn()
    vehicle:EmitSound("perp2.5/car_horn.wav", 75, 100, 1, CHAN_AUTO)
    vehicle:GetPhysicsObject():EnableMotion(false)
    vehicle.wheels = {}

    local function AddWheel(pos,ang)
        local wheel = ents.Create("prop_physics", vehicle)
        wheel:SetAngles(ang)
        wheel:SetPos(pos+best[1])
        wheel:SetModel("models/winningrook/gtav/stockade/stockade_wheel.mdl")
        wheel:Spawn()
        wheel:GetPhysicsObject():EnableMotion(false)
        table.insert(vehicle.wheels,wheel)
    end
    AddWheel(best[2]:Forward()*80 + best[2]:Right()*-40,best[2])
    AddWheel(best[2]:Forward()*80 + best[2]:Right()*40,best[2])
    AddWheel(best[2]:Forward()*-80 + best[2]:Right()*-40,best[2])
    AddWheel(best[2]:Forward()*-80 + best[2]:Right()*40,best[2])
end

local function EndMission()
    for _, v in pairs( ents.FindByClass( 'ent_stockade' ) ) do 
        if not (v.Served >= v.Quantity) then
            for _, ply in pairs( team.GetPlayers(TEAM_BANK_SECURITY) ) do
                ply:Notify("You failed to deliver all of the money on time!")
                ply:ChatPrint("You failed to deliver all of the money on time!")
            end
        end
        for k, v in pairs(v.wheels or {}) do
            v:Remove()
        end
        v:Remove()
    end
end

concommand.Add('mrkrabs', BankSecurityMoney)
-- BankSecurityMoney()
concommand.Add('squiddy', EndMission)

timer.Create( "BankSecurityMoney", 15*60, 0, function() 
    -- Make sure there is no ongoing robbery.
    -- Delete all remaining money entities in vault. 
    -- Reset broken cameras, etc. 
    BankSecurityMoney()
    timer.Create("MoneyMission", 10*60, 1, EndMission)
end) 