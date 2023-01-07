--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 3
ACHIEVEMENT.Index = "domarijuana"
ACHIEVEMENT.Title = "Pass The Blunt Here"
ACHIEVEMENT.Desc = "Smoke weed with a pipe (in-game of course)"
ACHIEVEMENT.Reward = 4000
ACHIEVEMENT.Class = "General"
ACHIEVEMENT.Mat = "paris/achievements/dodrugs.png"
ACHIEVEMENT.Bool = true
ACHIEVEMENT.Goal = 1

hook.Add("InventoryUseItem", "DoMarijuanAchievement", function(ply, id)
    if id == 65 then
        ply:SetAchievementStatus("domarijuana",ply:GetAchievementStatus(ACHIEVEMENT.Index)+1)
    end
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 2
ACHIEVEMENT.Index = "ownvehicle"
ACHIEVEMENT.Title = "Vehicle Novice"
ACHIEVEMENT.Desc = "Buy 1 vehicle"
ACHIEVEMENT.Reward = 5000
ACHIEVEMENT.Class = "General"
ACHIEVEMENT.Mat = "paris/achievements/car.png"
ACHIEVEMENT.Goal = 1

hook.Add("BuyVehicle", "BuyVehicleAchievement", function(ply, id)
    ply:SetAchievementStatus("ownvehicle",1)
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 1
ACHIEVEMENT.Index = "own5vehicles"
ACHIEVEMENT.Title = "Vehicle Enthusiast"
ACHIEVEMENT.Desc = "Buy 5 vehicles"
ACHIEVEMENT.Reward = 30000
ACHIEVEMENT.Class = "General"
ACHIEVEMENT.Mat = "paris/achievements/car5.png"
ACHIEVEMENT.Goal = 5

hook.Add("BuyVehicle", "Buy5VehicleAchievement", function(ply, id)
    ply:SetAchievementStatus("own5vehicles",ply:GetAchievementStatus(ACHIEVEMENT.Index)+1)
end)

GM:LoadAchievement( ACHIEVEMENT )
