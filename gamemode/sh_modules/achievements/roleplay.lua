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
ACHIEVEMENT.Order = 1
ACHIEVEMENT.Index = "100fires"
ACHIEVEMENT.Title = "The Fireboy"
ACHIEVEMENT.Desc = "Put out 100 fires"
ACHIEVEMENT.Reward = 10000
ACHIEVEMENT.Class = "Roleplay"
ACHIEVEMENT.Mat = "paris/achievements/fireboy.png"
ACHIEVEMENT.Goal = 100

hook.Add("FireExtinguish", "FireboyAchievement", function(ply)
    ply:SetAchievementStatus(ACHIEVEMENT.Index,ply:GetAchievementStatus(ACHIEVEMENT.Index)+1)
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 2
ACHIEVEMENT.Index = "1000fires"
ACHIEVEMENT.Title = "The Fireman"
ACHIEVEMENT.Desc = "Put out 1000 fires"
ACHIEVEMENT.Reward = 100000
ACHIEVEMENT.Class = "Roleplay"
ACHIEVEMENT.Mat = "paris/achievements/fireman.png"
ACHIEVEMENT.Goal = 1000

hook.Add("FireExtinguish", "FireboyAchievement", function(ply)
    ply:SetAchievementStatus(ACHIEVEMENT.Index,ply:GetAchievementStatus(ACHIEVEMENT.Index)+1)
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 3
ACHIEVEMENT.Index = "5criminalsarrested"
ACHIEVEMENT.Title = "Officer 101"
ACHIEVEMENT.Desc = "Arrest 5 criminals"
ACHIEVEMENT.Reward = 5000
ACHIEVEMENT.Class = "Roleplay"
ACHIEVEMENT.Mat = "paris/achievements/handcuff5.png"
ACHIEVEMENT.Goal = 5

hook.Add("HandcuffPerson", "Handcuff5Achievement", function(ply)
    ply:SetAchievementStatus(ACHIEVEMENT.Index,ply:GetAchievementStatus(ACHIEVEMENT.Index)+1)
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 4
ACHIEVEMENT.Index = "100criminalsarrested"
ACHIEVEMENT.Title = "The Seargent"
ACHIEVEMENT.Desc = "Arrest 100 criminals"
ACHIEVEMENT.Reward = 100000
ACHIEVEMENT.Class = "Roleplay"
ACHIEVEMENT.Mat = "paris/achievements/handcuff5.png"
ACHIEVEMENT.Goal = 100

hook.Add("HandcuffPerson", "Handcuff100Achievement", function(ply)
    ply:SetAchievementStatus(ACHIEVEMENT.Index,ply:GetAchievementStatus(ACHIEVEMENT.Index)+1)
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 5
ACHIEVEMENT.Index = "ownorganization"
ACHIEVEMENT.Title = "The CEO"
ACHIEVEMENT.Desc = "Register and own an organization"
ACHIEVEMENT.Reward = 5000
ACHIEVEMENT.Class = "Roleplay"
ACHIEVEMENT.Mat = "paris/achievements/ceo.png"
ACHIEVEMENT.Bool = true
ACHIEVEMENT.Goal = 1

GM:LoadAchievement( ACHIEVEMENT )