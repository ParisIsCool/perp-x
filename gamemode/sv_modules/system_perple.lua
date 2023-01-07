--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- ASK FOR SHIPMENT DATA
util.AddNetworkString("perp_perple_info")
net.Receive("perp_perple_info", function(len,Player)
    if not Player["Business_Data"] then return end
    net.Start("perp_perple_info")
    net.WriteTable(Player["Business_Data"])
    net.Send(Player)
end)

function PLAYER:SaveBusinessData()
    tmysql.query(string.format("UPDATE `perp_users` SET `business_data`='%s' WHERE `id`='%i';",util.TableToJSON(self["Business_Data"]),self.PERPID))
end

util.AddNetworkString("perp_perple_buy_business")
net.Receive("perp_perple_buy_business", function(len,Player)
    if Player["Business_Data"][1] then return Player:Notify("You may only have 1 business at this time") end-- only 1 business for now
    local BusinessID = net.ReadInt(8)
    if not GAMEMODE.Businesses[BusinessID] then return end
    if Player:GetBank() < GAMEMODE.Businesses[BusinessID].Cost then Player:Notify("You do not have enough money to purchase this.") end
    local BusinessData = {ID=BusinessID,Supply=0,Stock=0,Rate=GAMEMODE.Businesses[BusinessID].NormalPay}
    table.insert(Player["Business_Data"],BusinessData)
    Player:SaveBusinessData()
    Player:TakeBank(GAMEMODE.Businesses[BusinessID].Cost)
    Player:Notify("You successfully purchased " .. GAMEMODE.Businesses[BusinessID].Name .. " for $" .. string.Comma(GAMEMODE.Businesses[BusinessID].Cost) .. ".")
end)