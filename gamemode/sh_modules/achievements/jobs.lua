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
ACHIEVEMENT.Index = "EMS"
ACHIEVEMENT.Title = "The Medics"
ACHIEVEMENT.Desc = "Join the EMS Team"
ACHIEVEMENT.Reward = 3000
ACHIEVEMENT.Class = "Jobs"
ACHIEVEMENT.Mat = "paris/achievements/becomeems.png"
ACHIEVEMENT.Bool = true
ACHIEVEMENT.Goal = 1

hook.Add("PERP_PlayerChangedTeam", "EMSAchievement", function(ply,new_team)
    if new_team == TEAM_MEDIC then
        ply:SetAchievementStatus(ACHIEVEMENT.Index, 1)
    end
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 2
ACHIEVEMENT.Index = "Firefighters"
ACHIEVEMENT.Title = "The Firefighters"
ACHIEVEMENT.Desc = "Join the Firefighting Team"
ACHIEVEMENT.Reward = 3000
ACHIEVEMENT.Class = "Jobs"
ACHIEVEMENT.Mat = "paris/achievements/becomefireman.png"
ACHIEVEMENT.Bool = true
ACHIEVEMENT.Goal = 1

hook.Add("PERP_PlayerChangedTeam", "FirefighterAchievement", function(ply,new_team)
    if new_team == TEAM_FIREMAN then
        ply:SetAchievementStatus(ACHIEVEMENT.Index, 1)
    end
end)

GM:LoadAchievement( ACHIEVEMENT )

local ACHIEVEMENT = {}
ACHIEVEMENT.Order = 2
ACHIEVEMENT.Index = "Mayor"
ACHIEVEMENT.Title = "The Mayor"
ACHIEVEMENT.Desc = "Become the mayor of the town"
ACHIEVEMENT.Reward = 10000
ACHIEVEMENT.Class = "Jobs"
ACHIEVEMENT.Mat = "paris/achievements/mayor.png"
ACHIEVEMENT.Bool = true
ACHIEVEMENT.Goal = 1

hook.Add("PERP_PlayerChangedTeam", "MayorAchievement", function(ply,new_team)
    if new_team == TEAM_MAYOR then
        ply:SetAchievementStatus(ACHIEVEMENT.Index, 1)
    end
end)

GM:LoadAchievement( ACHIEVEMENT )