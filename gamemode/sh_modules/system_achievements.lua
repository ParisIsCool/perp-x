--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


ACHIEVEMENT_DATABASE = {}

function GM:LoadAchievement(achievement)
    if not istable(achievement) then return end
    ACHIEVEMENT_DATABASE[achievement.Index] = achievement
    if CLIENT then
        achievement.Material = Material(achievement.Mat)
    end
end