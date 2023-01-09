--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

util.AddNetworkString("PERP_LoadAchievements")
function PLAYER:LoadAchievements()
    tmysql.query( Format( Query( "SELECT_ACHIEVEMENTS" ), self.PERPID ), function( Results, Status, ErrorMsg )
        if not IsValid( self ) then return end
        if not Results[1] or not Results[1].data then 
            net.Start("PERP_LoadAchievements")
            net.WriteTable({})
            net.Send(self)
            return
        end
        local PERP_Achievements = util.JSONToTable(Results[1].data) or {}
        self["PERP_Achievements"] = self["PERP_Achievements"] or {}
        for k, v in pairs(PERP_Achievements) do
            self["PERP_Achievements"][v["id"]] = tonumber(v["progress"])
        end
        net.Start("PERP_LoadAchievements")
            net.WriteTable(PERP_Achievements)
        net.Send(self)
    end)
end

function PLAYER:SaveAchievements()
    local formatted = {}
    for k, v in pairs(self["PERP_Achievements"] or {}) do
        table.insert(formatted,{id = k,progress=v})
    end
    local data = util.TableToJSON(formatted)
    tmysql.query("SELECT * FROM `perp_achievements`;", function(Results)
        if Results and Results[1] then
            tmysql.query( Format( "UPDATE `perp_achievements` SET `data`='%s' WHERE `perpid`='%i';", data, self.PERPID ) )
        else
            tmysql.query( Format( "INSERT INTO `perp_achievements` (`perpid`, `data`) VALUES ('%i', '%s');", self.PERPID, data ) )
        end
    end)
end

util.AddNetworkString("PERP_UpdateAchievement")
util.AddNetworkString("PERP_AccomplishAchievement")
function PLAYER:SetAchievementStatus(index,value)
    if not ACHIEVEMENT_DATABASE[index] then return end
    if not self["PERP_Achievements"] then return end
    if self["PERP_Achievements"][index] == value then return end
    if self["PERP_Achievements"][index] and self["PERP_Achievements"][index] > ACHIEVEMENT_DATABASE[index].Goal then return end
    
    local function SetAchievementStatus()
        
        net.Start("PERP_UpdateAchievement")
            net.WriteString(index)
            net.WriteInt(value,32)
        net.Send(self)

        self["PERP_ChangedAchievements"] = self["PERP_ChangedAchievements"] or {}
        self["PERP_Achievements"][index] = tonumber(value)


        local function CompleteAchievement()
            local reward = ""
            if isnumber(ACHIEVEMENT_DATABASE[index].Reward) then
                self:GiveCash(ACHIEVEMENT_DATABASE[index].Reward)
                reward = "they receive $" .. string.Comma(ACHIEVEMENT_DATABASE[index].Reward) .. "!"
            end

            for k,v in pairs(player.GetAll()) do
                v:ChatPrint(self:Nick() .. ' just achieved "' .. ACHIEVEMENT_DATABASE[index].Title .. '" ' .. reward)
            end
        end

        if (ACHIEVEMENT_DATABASE[index].Bool and tonumber(value) == 1) or ( not ACHIEVEMENT_DATABASE[index].Bool and tonumber(value) >= ACHIEVEMENT_DATABASE[index].Goal ) then
            net.Start("PERP_AccomplishAchievement")
            net.Send(self)
            CompleteAchievement()
        end

    end

    self["PERP_Achievements"][index] = tonumber(value)
    SetAchievementStatus()

    self:SaveAchievements()

end

function PLAYER:GetAchievementStatus(index)
    if not self["PERP_Achievements"] then return 0 end
    if self["PERP_Achievements"][index] then return self["PERP_Achievements"][index] else return 0 end
end