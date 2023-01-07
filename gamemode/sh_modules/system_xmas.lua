--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- 1 cash
-- 2 seeds
-- 3 special item
-- 4 spin again
-- 5 ammo
-- 6 cash
-- 7 seeds
-- 8 car
-- 9 ak47
-- 10 metal
-- 11 cash
-- 12 ammo
-- 13 seeds
-- 14 vip
-- 15 spin again
-- 16 cash
-- 17 metal
-- 18 seeds
-- 19 m4a1
-- 20 sign

local function TellAll(text)
    for k,v in pairs(player.GetAll()) do
        print(text)
		v:ChatPrint(text)
	end
end

local function FinalizeTransaction(Player)

end

XmasPrizes = {}
XmasPrizes[1] = { -- cash
    Mat = "paris/xmas/icons/cash.png",
    Name = "Cash",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local cash = math.random(2500,10000)
        Player:GiveCash(cash)
        TellAll(Player:Nick() .. " just won $" .. string.Comma(cash) .." at Santa's lucky wheel!")
        Player:Notify( "You just won $" .. string.Comma(cash) .. "!" )
    end,
}

XmasPrizes[2] = { -- seeds
    Mat = "paris/xmas/icons/seeds.png",
    Name = "Seeds",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(3,8)
        local chance = math.random(1,0)
        local display = "cocaine"
        local item = 68 -- Cocaine
        if chance == 1 then
            display = "weed"
            item = 14 -- Weed
        end
        Player:GiveItem(item, amount)
        TellAll(Player:Nick() .. " just won " .. (amount) .." " .. display .. " seeds at Santa's lucky wheel!")
        Player:Notify( "You just won " .. (amount) .." " .. display .. " seeds!" )
    end,
}

XmasPrizes[3] = { -- spin again
    Mat = "paris/xmas/icons/respin.png",
    Name = "M4A1",
    WinFunction = function(Player)
        -- No finalization you just get nothing
        TellAll(Player:Nick() .. " just got another spin at Santa's lucky wheel! (get trolled)!")
        Player:Notify( "You just got another spin! (You won nothing.)" )
        return "Respin"
    end,
}

XmasPrizes[4] = { -- ammo
    Mat = "paris/xmas/icons/ammo.png",
    Name = "Ammo",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(1,3)
        local items = {30,31,32}
        local chance = math.random(1,#items)
        local item = ITEM_DATABASE[items[chance]]
        Player:GiveItem(item.id, amount)
        TellAll(Player:Nick() .. " just won x" .. amount .. " " .. item.Name .. " at Santa's lucky wheel!")
        Player:Notify( "You just won x" .. amount .. " " .. item.Name .. "!" )
    end,
}

XmasPrizes[5] = { -- cash
    Mat = "paris/xmas/icons/cash.png",
    Name = "Cash",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local cash = math.random(2500,10000)
        Player:GiveCash(cash)
        TellAll(Player:Nick() .. " just won $" .. string.Comma(cash) .." at Santa's lucky wheel!")
        Player:Notify( "You just won $" .. string.Comma(cash) .. "!" )
    end,
}

XmasPrizes[6] = { -- seeds
    Mat = "paris/xmas/icons/seeds.png",
    Name = "Seeds",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(3,8)
        local chance = math.random(1,0)
        local display = "cocaine"
        local item = 68 -- Cocaine
        if chance == 1 then
            display = "weed"
            item = 14 -- Weed
        end
        Player:GiveItem(item, amount)
        TellAll(Player:Nick() .. " just won " .. (amount) .." " .. display .. " seeds at Santa's lucky wheel!")
        Player:Notify( "You just won " .. (amount) .." " .. display .. " seeds!" )
    end,
}

XmasPrizes[7] = { -- text sign
    Mat = "paris/xmas/icons/sign.png",
    Name = "Signs",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(1,3)
        Player:GiveItem(114, amount)
        TellAll(Player:Nick() .. " just won x" .. amount .. " text signs at Santa's lucky wheel!")
        Player:Notify( "You just won x" .. amount .. " text signs!" )
    end,
}

-- XmasPrizes[7] = { -- car
--     Mat = "paris/xmas/icons/car.png",
--     Name = "Podium Vehicle",
--     WinFunction = function(Player)
--         FinalizeTransaction(Player)
--         local cartable = VEHICLE_DATABASE[XMAS_SHOWCASE_VEHICLE.vehicleTable.ID]
--         local cashamount = cartable.Cost
--         if cashamount > 500000 then
--             cashamount = 500000
--         end
--         if Player.Vehicles[XMAS_SHOWCASE_VEHICLE.vehicleTable.ID] then
--             TellAll(Player:Nick() .. " just won a " .. cartable.Name .." but already owns it! That means they get the cash amount of $" .. string.Comma(cashamount) .. "!" )
--             Player:Notify( "You just won a " .. cartable.Name .." but you already own it! You get $" .. string.Comma(cashamount) .. "!" )
--             -- give cash
--             Player:GiveCash(cashamount)
--         else
--             TellAll(Player:Nick() .. " just won a " .. cartable.Name .."!!" )
--             Player:Notify( "You just won a " .. cartable.Name .."!!" )
--             -- give car
--             local vehicleID = tostring(XMAS_SHOWCASE_VEHICLE.vehicleTable.ID)
--             local vehicleTable = VEHICLE_DATABASE[vehicleID]
--             if Player.Vehicles[ vehicleID ] then
--                 return Player:Notify( "You already own this vehicle." )
--             end
        
--             local Log = Format( "%s won a %s from Santa's lucky wheel.", Player:Nick(), vehicleTable.Name )
--             --Log( "cashlog", Log, Player:SteamID() )
--             print(Log)
        
--             --Player:TakeBank( vehicleTable.Cost, true )
        
--             Player.Vehicles[ vehicleID ] = {
--                 PaintID = 1,
--                 HeadLights = 1,
--                 UnderGlow = 0,
--                 DixieHorn = 0,
--                 Hydraulics = 0,
--                 Fuel = 10000,
--             }
        
--             print(Format( Query( "CREATEVEHICLE" ), Player:SteamID(), vehicleID ))
--             tmysql.query( Format( Query( "CREATEVEHICLE" ), Player:SteamID(), vehicleID ) )
        
--             Player:PERPSave()
        
--             -- Con fucking gradulations, you now own this car, blah blah...
--             Player:Notify( Format( "You are the new owner of a %s for $%s", vehicleTable.Name, util.FormatNumber( vehicleTable.Cost ) ) )
        
--             net.Start( "perp_vehicle_init" )
--                 net.WriteString( vehicleTable.ID )
--                 net.WriteInt( 1, 16 ) -- PaintID or error :(
--             net.Send(Player)
        
--         end
--     end,
-- }

XmasPrizes[8] = { -- ak47
    Mat = "paris/xmas/icons/ak47.png",
    Name = "AK47",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        Player:GiveItem(28,1)
        TellAll(Player:Nick() .. " just won an AK-47 at Santa's lucky wheel!")
        Player:Notify( "You just won an AK47!" )
    end,
}

XmasPrizes[9] = { -- metal
    Mat = "paris/xmas/icons/metal.png",
    Name = "M4A1",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        Player:GiveItem(18,5)
        TellAll(Player:Nick() .. " just won 5 pieces of metal Santa's lucky wheel!")
        Player:Notify( "You just won 5 pieces of metal!" )
    end,
}

XmasPrizes[10] = { -- cash
    Mat = "paris/xmas/icons/cash.png",
    Name = "Cash",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local cash = math.random(2500,10000)
        Player:GiveCash(cash)
        TellAll(Player:Nick() .. " just won $" .. string.Comma(cash) .." at Santa's lucky wheel!")
        Player:Notify( "You just won $" .. string.Comma(cash) .. "!" )
    end,
}

XmasPrizes[11] = { -- ammo
    Mat = "paris/xmas/icons/ammo.png",
    Name = "Ammo",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(1,3)
        local items = {30,31,32}
        local chance = math.random(1,#items)
        local item = ITEM_DATABASE[items[chance]]
        Player:GiveItem(item.id, amount)
        TellAll(Player:Nick() .. " just won x" .. amount .. " " .. item.Name .. " at Santa's lucky wheel!")
        Player:Notify( "You just won x" .. amount .. " " .. item.Name .. "!" )
    end,
}

XmasPrizes[12] = { -- seeds
    Mat = "paris/xmas/icons/seeds.png",
    Name = "Seeds",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(3,8)
        local chance = math.random(1,0)
        local display = "cocaine"
        local item = 68 -- Cocaine
        if chance == 1 then
            display = "weed"
            item = 14 -- Weed
        end
        Player:GiveItem(item, amount)
        TellAll(Player:Nick() .. " just won " .. (amount) .." " .. display .. " seeds at Santa's lucky wheel!")
        Player:Notify( "You just won " .. (amount) .." " .. display .. " seeds!" )
    end,
}

if SERVER then
    util.AddNetworkString("OpenVIPChoosePlayerPanel")
end

-- XmasPrizes[13] = { -- vip
--     Mat = "paris/xmas/icons/vip.png",
--     Name = "VIP",
--     WinFunction = function(Player)

--         Player.xMasVIPValid = true

--         local RankLevel = "aSoc:VIP"
--         local Length = 3600*72
--         local Time = os.time() + Length

--         Player.xMasRankLevel = RankLevel
--         Player.xMasTime = Time
--         Player.xMasLength = Length

--         TellAll(Player:Nick() .. " just won VIP at Santa's lucky wheel!!")
--         Player:Notify( "You just won VIP!" )
--         if Player:IsVIP() then
--             net.Start("OpenVIPChoosePlayerPanel")
--                 net.WriteString(RankLevel)
--                 net.WriteInt(Length, 32)
--                 net.WriteInt(Time, 32)
--             net.Send(Player)
--         else
--             aSoc.BuyDonatorRank(Player:SteamID(),"aSoc:VIP",Length,"XMAS_SYS")
--         end
--     end,
-- }

XmasPrizes[13] = { -- cash
    Mat = "paris/xmas/icons/cash.png",
    Name = "Cash",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local cash = math.random(2500,10000)
        Player:GiveCash(cash)
        TellAll(Player:Nick() .. " just won $" .. string.Comma(cash) .." at Santa's lucky wheel!")
        Player:Notify( "You just won $" .. string.Comma(cash) .. "!" )
    end,
}

XmasPrizes[14] = { -- spin again
    Mat = "paris/xmas/icons/respin.png",
    Name = "Respin",
    WinFunction = function(Player)
        -- No finalization you just get nothing
        TellAll(Player:Nick() .. " just got another spin at Santa's lucky wheel!")
        Player:Notify( "You just got another spin! (You won nothing.)" )
        return "Respin"
    end,
}

XmasPrizes[15] = { -- cash
    Mat = "paris/xmas/icons/cash.png",
    Name = "Cash",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local cash = math.random(2500,10000)
        Player:GiveCash(cash)
        TellAll(Player:Nick() .. " just won $" .. string.Comma(cash) .." at Santa's lucky wheel!")
        Player:Notify( "You just won $" .. string.Comma(cash) .. "!" )
    end,
}

XmasPrizes[16] = { -- metal
    Mat = "paris/xmas/icons/metal.png",
    Name = "Pieces of Metal",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        Player:GiveItem(18,5)
        TellAll(Player:Nick() .. " just won 5 pieces of metal Santa's lucky wheel!")
        Player:Notify( "You just won 5 pieces of metal!" )
    end,
}

XmasPrizes[17] = { -- seeds
    Mat = "paris/xmas/icons/seeds.png",
    Name = "Seeds",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(3,8)
        local chance = math.random(1,0)
        local display = "cocaine"
        local item = 68 -- Cocaine
        if chance == 1 then
            display = "weed"
            item = 14 -- Weed
        end
        Player:GiveItem(item, amount)
        TellAll(Player:Nick() .. " just won " .. (amount) .." " .. display .. " seeds at Santa's lucky wheel!")
        Player:Notify( "You just won " .. (amount) .." " .. display .. " seeds!" )
    end,
}

XmasPrizes[18] = { -- m4a1
    Mat = "paris/xmas/icons/m4a1.png",
    Name = "M4A1",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        Player:GiveItem(112,1)
        TellAll(Player:Nick() .. " just won an M4A1 at Santa's lucky wheel!")
        Player:Notify( "You just won an M4A1!" )
    end,
}

XmasPrizes[19] = { -- text sign
    Mat = "paris/xmas/icons/sign.png",
    Name = "Signs",
    WinFunction = function(Player)
        FinalizeTransaction(Player)
        local amount = math.random(1,3)
        Player:GiveItem(114, amount)
        TellAll(Player:Nick() .. " just won x" .. amount .. " text signs at Santa's lucky wheel!")
        Player:Notify( "You just won x" .. amount .. " text signs!" )
    end,
}

XmasPrizes[20] = { -- spin again
    Mat = "paris/xmas/icons/respin.png",
    Name = "Respin",
    WinFunction = function(Player)
        -- No finalization you just get nothing
        TellAll(Player:Nick() .. " just got another spin at Santa's lucky wheel!")
        Player:Notify( "You just got another spin! (You won nothing.)" )
        return "Respin"
    end,
}

for k, v in pairs(XmasPrizes) do
    v.LoadedMat = Material(v.Mat)
end