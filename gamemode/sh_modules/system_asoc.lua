--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- SHARED

PLAYER = FindMetaTable("Player")

aSoc = aSoc or {}

aSoc.Version = "22.5.26"

local HardcodedRanks = {
    ["aSoc:Owner"] = {
        Display = "Management Team",
        Priority = 5,
        Color = Color(255,20,20),
    },
    ["aSoc:Leader"] = {
        Display = "Leader",
        Priority = 10,
        Color = Color(255,20,20),
    },
    ["aSoc:Director"] = {
        Display = "Community Director",
        Priority = 15,
        Color = Color(255,20,20),
    },
    ["aSoc:Manager"] = {
        Display = "Community Manager",
        Priority = 20,
        Color = Color(255,76,76),
    },
    ["aSoc:DvL"] = {
        Display = "Divisional Leader",
        Priority = 25,
        Color = Color(255,79,43),
    },
    ["aSoc:Developer"] = {
        Display = "Developer",
        Priority = 30,
        Color = Color(255,79,43),
    },
    ["aSoc:ServerManager"] = {
        Display = "Server Manager",
        Priority = 35,
        Color = Color(255,132,43),
    },
    ["aSoc:SeniorAdmin"] = {
        Display = "Senior Administrator",
        Priority = 40,
        Color = Color(204,94,255),
    },
    ["aSoc:Admin"] = {
        Display = "Administrator",
        Priority = 45,
        Color = Color(96, 226, 151),
    },
    ["aSoc:Gold"] = {
        Display = "Gold",
        Priority = 50,
        Color = Color(217, 192, 50), -- idk take perps
    },
    ["aSoc:VIP"] = {
        Display = "VIP",
        Priority = 55,
        Color = Color(134, 50, 217), -- idk take perps
    },
    ["aSoc:Member"] = {
        Display = "Member",
        Priority = 60,
        Color = Color(207, 207, 207), -- same as default
    },
    ["aSoc:Default"] = {
        Display = "Guest",
        Priority = 65,
        Color = Color(207, 207, 207), -- idk take perps
    },
}

aSoc.Ranks = HardcodedRanks

aSoc.DefaultRank = "aSoc:Default"
aSoc.DisguiseRank = "aSoc:Gold"
aSoc.LeadershipRank = "aSoc:Manager"
aSoc.ManagementRank = "aSoc:ServerManager"

local aSocRanks = HardcodedRanks
local DefaultRank = aSoc.DefaultRank

-- quite aids, will not be touching. ^ -->
function PLAYER:GetAsocRank()
    local rank = self:GetNWString("Rank")
    if not aSocRanks[rank] then rank = DefaultRank end
    return rank
end

function PLAYER:IsOwner()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Owner"].Priority
end

function PLAYER:IsLeader()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Leader"].Priority
end

function PLAYER:IsCommunityDirector()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Director"].Priority
end

function PLAYER:IsCommunityManager()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Manager"].Priority
end

function PLAYER:IsDivisionalLeader()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:DvL"].Priority
end

function PLAYER:IsDeveloper()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Developer"].Priority
end

function PLAYER:IsServerManager()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:ServerManager"].Priority
end

function PLAYER:IsSuperAdmin()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:SeniorAdmin"].Priority
end

function PLAYER:IsAdmin()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Admin"].Priority
end

function PLAYER:IsGoldVIP()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Gold"].Priority
end

function PLAYER:IsVIP()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:VIP"].Priority
end

function PLAYER:IsMember()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Member"].Priority
end

function PLAYER:IsDefault()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks["aSoc:Default"].Priority
end

function PLAYER:GetRankName()
    return aSocRanks[self:GetAsocRank()].Display
end

function PLAYER:GetRankColor()
    return aSocRanks[self:GetAsocRank()].Color
end

function PLAYER:GetRankPriority()
    return aSocRanks[self:GetAsocRank()].Priority
end

function PLAYER:IsRankHigherThan(ply)
    return aSocRanks[self:GetAsocRank()].Priority < aSocRanks[ply:GetNWString("Rank") or aSoc.DefaultRank].Priority
end

function PLAYER:IsRankLowerThan(ply)
    return aSocRanks[self:GetAsocRank()].Priority >= aSocRanks[ply:GetNWString("Rank") or aSoc.DefaultRank].Priority
end

function PLAYER:IsManagementTeam()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks[aSoc.ManagementRank].Priority
end

function PLAYER:IsLeadershipTeam()
    return aSocRanks[self:GetAsocRank()].Priority <= aSocRanks[aSoc.LeadershipRank].Priority
end



if CLIENT then
    concommand.Add("getmyrank", function(ply)
        print(ply:GetNWString("Rank"))
    end)
end