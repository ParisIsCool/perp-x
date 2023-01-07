--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

net.Receive("PERP_LoadAchievements", function()
    local PERP_Achivements = net.ReadTable()
    LocalPlayer()["PERP_Achivements"] = {}
    for k, v in pairs(PERP_Achivements or {}) do
        LocalPlayer()["PERP_Achivements"][v["id"]] = tonumber(v["progress"])
    end
end)

concommand.Add("cl_getachievements", function()
    PrintTable(LocalPlayer()["PERP_Achivements"])
end)

net.Receive("PERP_UpdateAchievement", function()
    if not LocalPlayer()["PERP_Achivements"] then LocalPlayer()["PERP_Achivements"] = {} end
    LocalPlayer()["PERP_Achivements"][net.ReadString()] = net.ReadInt(32)
end)

net.Receive("PERP_AccomplishAchievement", function()
    surface.PlaySound("paris/achievement_earned2.wav")
end)