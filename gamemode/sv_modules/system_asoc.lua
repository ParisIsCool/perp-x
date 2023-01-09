-- yes, code is pretty messy towards the bottom - fits right in with perp. we just wanted this shit out .-.

-- SERVER
aSoc = aSoc or {}

-- Configuration
aSoc.URL = 'http://perp.asocket.net:1624/'

aSoc.VPN_RANGE = "20410195"

-- Hardcoded Ranks, please label them
aSoc.hardcode = {}
--aSoc.hardcode["STEAM_0:0:89634933"] = "aSoc:Owner"              -- paris
aSoc.hardcode["STEAM_0:0:600212122"] = "aSoc:SeniorAdmin"       -- paris alt

-- Discord configuration
aSoc.discord = {}
aSoc.discord.enabled = false
aSoc.discord.users = {} -- SteamID64: DiscordID
aSoc.discord.guild = "772682371303735326"
 
aSoc.roleConfig = {
    ["772683602596462613"] = 'aSoc:Owner',
    ["920512885560590337"] = 'aSoc:Owner',
    ["978818821764816947"] = 'aSoc:ServerManager',
    ["920513010391465995"] = 'aSoc:Admin',
    ["772683689850830859"] = 'aSoc:Gold',
}

-- TREVORS LIBRARYS :D
local function recursiveReplace(tbl)
    local t = {}
    for k, v in pairs(tbl) do
        if type(k) == 'number' then 
            t[k] = v
            continue
        end
        if type(v) == 'table' then
            t[k:gsub("_", "")] = recursiveReplace(v)
            continue
        end
        t[k:gsub("_", "")] = v
    end
    return t
end

local function stringtohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

local function getValues(tbl)
    local t = {} 
    for _, v in pairs(tbl) do
        table.insert(t, v)
    end
    return t
end

-- much more efficient than a "getKeyFromValue" function loop
local function inverseTable(tbl) 
    local t = {}
    for k, v in pairs(tbl) do
        t[v] = k
    end
    return t
end

-- Temporary Logging
aSoc.log = function(msg)
    print("[system_asoc] " .. msg)
end

-- HTTP onSuccess
local function onSuccess(route, body, cb)
    local data = util.JSONToTable(body)
    if type(data) ~= "table" or data.error then
        if data == nil then data = {["error"] = "Malformed response."} end
        aSoc.log("ERROR: Web Request - '" .. route .. "' | '" .. data.error .. "'")
    end
    cb(recursiveReplace(data))
end

-- HTTP onFailure
local function onFailure(route, message, cb)
    aSoc.log("ERROR: Web Request - '" .. route .. "' | '" .. message .. "'")
    cb({['error'] = message})
end

-- POST request.
aSoc.post = function(route, data, cb)
    data = data or {}
    cb = cb or function() end
    http.Post(aSoc.URL .. route, data,
        function(body) onSuccess(route, body, cb) end,
        function(message) onFailure(route, message, cb) end
    )
end

-- GET request.
aSoc.get = function(route, data, cb)
    data = data or {}
    cb = cb or function() end

    local req = "?"
    for k, v in pairs(data) do
        req = req .. k .. "=" .. v .. "&"
    end
    -- print(aSoc.URL .. route .. req)
    -- print(req)
    http.Fetch(aSoc.URL .. route .. req,
        function(body) onSuccess(route, body, cb) end,
        function(message) onFailure(route, message, cb) end
    )
end

-- getDiscordRoles request.
local function getDiscordRoles(id, cb)
    cb = cb or function() end
    if type(id) ~= 'table' then id = { id } end
    aSoc.get('discord/roles/', {['guild'] = aSoc.discord.guild, ['id'] = util.TableToJSON(id)}, function(data)
        cb(data)
    end)  
end

-- getDiscordID if applicable.
local function getDiscordID(steam, cb)
    cb = cb or function() end
    if type(steam) ~= 'table' then steam = { steam } end
    aSoc.get('discord/getFromSteam/', {['steam'] = util.TableToJSON(steam)}, function(data)
        cb(data)
    end)
end

-- Update join status/username.
local function updateJoinStatus(ply, useTag)
    print("[system_asoc] Updating join status for " .. ply:Name(), useTag)
    local url = "gmod/"
    if (useTag) then
        url = url .. "join/"
    else
        url = url .. "leave/"
    end

    local steam = ply:SteamID64()
    local count = useTag and player.GetHumans() or player.GetHumans() - 1
    aSoc.get(url, {['guild'] = aSoc.discord.guild, ['name'] = stringtohex(ply:Name()), ['steam'] = steam, ['count'] = count })
end

local function discordSync(ply)
    -- Get Discord ID if applicable
    local steam = ply:SteamID64()
    getDiscordID(steam, function(data)
        local rank = "aSoc:Default"
        if (not data.id or not data.id[steam]) then
            ply:ChatPrint("It appears your discord is not currently linked! Issue the command '/discord' for free Gold VIP!")
            ply:SetRank(rank)
            return
        end

        -- Store discord id.
        aSoc.discord.users[steam] = data.id[steam]

        getDiscordRoles(data.id[steam], function(data)
            if not data.roles then goto apply end
            for _, roles in pairs(data.roles) do
                for _, v in ipairs(roles) do
                    if aSoc.roleConfig[v] and aSoc.Ranks[aSoc.roleConfig[v]].Priority < aSoc.Ranks[rank].Priority then
                        rank = aSoc.roleConfig[v]
                    end
                end
            end
            ::apply::
            ply:SetRank(rank)
        end)

    end)
end

-- syncs user permissions to tmysql database.
local function databaseSync(ply)
    local steam = ply:SteamID()
    local rank = "aSoc:Default"
    local query = "SELECT * FROM `aSoc_users` WHERE `steamid` = '" .. steam .. "'"
    tmysql.query(query, function(Results)
        if Results[1] then
            rank = Results[1].rank
            ply:SetNWBool("isManagement", Results[1].management == 1)
        end
        ply:SetRank(rank)
    end)
end

-- master sync function.
aSoc.syncPermissions = function(ply)
    if aSoc.hardcode and aSoc.hardcode[ply:SteamID()] then
        ply:SetRank(aSoc.hardcode[ply:SteamID()])
        ply:SetNWBool("isManagement", aSoc.Ranks[aSoc.hardcode[ply:SteamID()]].Priority >= aSoc.Ranks[aSoc.ManagementRank].Priority )
        return
    end
    if aSoc.discord.enabled then
        discordSync(ply)
    else
        databaseSync(ply)
    end
end

aSoc.syncAllPermissions = function()

    if #player.GetHumans() == 0 then return end

    if aSoc.discord.enabled then
        local steams = {} -- Get all steam identifiers.
        for _, v in ipairs(player.GetHumans()) do
            if aSoc.hardcode[v:SteamID()] then continue end
            table.insert(steams, v:SteamID64())
        end

        if #steams == 0 then return end
        getDiscordID(steams, function(data) -- Retrieve all discord identifiers. 
            if not data or type(data.id) ~= 'table' or #table.ClearKeys(data.id) == 0 then return end
            getDiscordRoles(table.ClearKeys(data.id), function(_data)
                if not _data.roles then -- If api could not be reached.
                    for _, v in ipairs(steams) do -- Reset all users to aSoc:Default
                        if not data.id or not data.id[v] then player.GetBySteamID64(v):SetRank("aSoc:Default") end
                    end
                    return
                end
                
                for _, v in ipairs(steams) do -- Reset user if they do not have any roles.
                    if not data.id or not data.id[v] or not _data.roles[data.id[v]] then -- If api could not be reached, the user does not have a discord id, or the user does not have any roles.
                        player.GetBySteamID64(v):SetRank("aSoc:Default") -- Reset to asoc default.
                    end
                end

                local inv = inverseTable(data.id)
                for id, roles in pairs(_data.roles) do
                    local rank = "aSoc:Default"
                    for _, v in ipairs(roles) do
                        if aSoc.roleConfig[v] and aSoc.Ranks[aSoc.roleConfig[v]].Priority < aSoc.Ranks[rank].Priority then
                            rank = aSoc.roleConfig[v]
                        end
                    end
                    player.GetBySteamID64(inv[id]):SetRank(rank)
                end
            end)
        end)
    else
        local steams = ""
        local n = 0
        for _, v in ipairs(player.GetHumans()) do
            n = n + 1
            if aSoc.hardcode[v:SteamID()] then continue end
            local comma = ""
            if #player.GetHumans() != n then comma = "," end
            steams = steams .. "'" .. v:SteamID() .. "'" .. comma
        end
        tmysql.query("SELECT * FROM `aSoc_users` WHERE `steamid` IN (" .. steams .. ");", function(Results)
            for _, v in pairs(Results or {}) do
                player.GetBySteamID(v.steamid):SetRank(v.rank)
            end
        end)
    end
end

-- PlayerAuthed
hook.Add('PlayerAuthed', 'aSoc_PlayerInitialSpawn', function(ply)
    -- Sync permissions
    aSoc.syncPermissions(ply)

    -- Update join status/username.
    if aSoc.discord.enabled then
        updateJoinStatus(ply, true)
    end

end) 

function aSoc.Initialize(ply)
    -- Sync permissions
    aSoc.syncPermissions(ply)

    -- Check if player on aSocket VPN!
    local ip_blocks = string.Explode(".",ply:IPAddress())
    if aSoc.VPN_RANGE == ip_blocks[1]..ip_blocks[2]..ip_blocks[3] then
        ply:SetNWBool("aSocket",true)
    end

end

-- PlayerDisconnected
hook.Add('PlayerDisconnected', 'aSoc_PlayerDisconnected', function(ply)
    -- Update join status/username.
    if aSoc.discord.enabled then
        updateJoinStatus(ply, false)
    end
end)

-- sets the player's rank in the database
function PLAYER:SetDatabaseRank(rank)
    local steam = self:SteamID()
    tmysql.query("SELECT * FROM `aSoc_users` WHERE `steamid` = '" .. steam .. ";'", function(Results)
        if Results[1] then
            tmysql.query("UPDATE `aSoc_users` SET `rank` = '"..rank.."' WHERE `steamid` = '" .. steam .. "';")
        else
            tmysql.query("INSERT INTO `aSoc_users` (`rank`, `steamid`) VALUES ('"..rank.."', '" .. steam .. "');")
        end
    end)
end

-- Set Rank.
function PLAYER:SetRank(rank)
    local previousRank = self:GetNWString("Rank")
    self:SetNWString( "Rank", rank or "aSoc:Owner" )
    if previousRank ~= rank then 
        -- Default disguised to true if staff.
        if self:IsAdmin() then self:SetGNWVar( "disguised", true ) end
        GAMEMODE:PlayerLoadout(self) 
    end -- NOTE: Equipped weapons will not carry over. Known issue - not a priority atm, as it can simply be re-equipped.
end

timer.Create("aSocRefreshRank", 10, 0, aSoc.syncAllPermissions)


-- not touching dis code
concommand.Add("asoc", function(ply,cmd,args)
    if args[1] and ply:IsLeadershipTeam() then
        args[1] = "aSoc" .. ":" .. args[1]
        ply:SetRank( args[1] )
        if ply:GetNWString("Rank") == args[1] then
            ply:PrintMessage(HUD_PRINTCONSOLE, "aSoc has set your rank to " .. args[1] .. " !" )
        else
            ply:PrintMessage(HUD_PRINTCONSOLE, "aSoc couldn't find this rank!" )
        end
    else
        if ply.aSocTimer then
            if ply.aSocTimer < CurTime() then
                aSoc.syncPermissions(ply)
                ply.aSocTimer = CurTime() + 10
            else
                ply:PrintMessage(HUD_PRINTCONSOLE, "aSoc Cooldown! " .. math.Round(ply.aSocTimer - CurTime()) .. " seconds remaining!" )
            end
        else
            aSoc.syncPermissions(ply)
            ply.aSocTimer = CurTime() + 10
        end
    end
end)

concommand.Add("asoc_kick", function(admin,cmd,args)
    if not admin:IsAdmin() then return end
    local ply = player.GetBySteamID(args[1])
    if not IsValid(ply) then return end

    local steam = ply:SteamID64()
    local steamName = ply:Nick()

    local staff = admin:SteamID64()
    local staffName = admin:Nick()
    
    local reason = args[2]
 
    local request = { 
        ["steam"] = steam,
        ["name"] = stringtohex(steamName),
        ["staff"] = staff, 
        ["staffName"] = stringtohex(staffName),
        ["reason"] = stringtohex(reason), 
        ["guild"] = aSoc.discord.guild
    }
    
    aSoc.get('gmod/kick', request)
    ply:Kick("You have been kicked by " .. staffName .. " for the following reason: \n\n" .. reason)

    for _, v in ipairs(player.GetHumans()) do
        v:ChatPrint(steamName .. " has been kicked by " .. staffName .. " for the following reason: \"" .. reason .. "\"")
    end
end)

local function tempTime(time)
    if time == 0 then return "Indefinite" end
    --borrowed from the client js --> lua
    local timeTable = {
        -- ['ms'] = {['divisor'] = 1, ['mod'] = 1000, ['wholeValue'] = time, ['value'] = 0},
        ['s'] = {['divisor'] = 1, ['mod'] = 60, ['wholeValue'] = time, ['value'] = 0},
        ['m'] = {['divisor'] = 60, ['mod'] = 60, ['wholeValue'] = 0, ['value'] = 0},
        ['h'] = {['divisor'] = 60, ['mod'] = 24, ['wholeValue'] = 0, ['value'] = 0},
        ['d'] = {['divisor'] = 24, ['mod'] = 7, ['wholeValue'] = 0, ['value'] = 0},
        ['w'] = {['divisor'] = 7, ['mod'] = 52, ['wholeValue'] = 0, ['value'] = 0},
        ['y'] = {['divisor'] = 52, ['mod'] = 0, ['wholeValue'] = 0, ['value'] = 0},
    }

    local str = ''

    -- lua does not like to keep the associative order - unless...
    local keys = {'s', 'm', 'h', 'd', 'w', 'y'}    
    for k, v in ipairs(keys) do
        local p = (k - 1) ~= 0 and k - 1 or 1
        local current = timeTable[keys[k]]
        local prev = timeTable[keys[p]]
        current.wholeValue = prev.wholeValue / current.divisor
        current.value = current.wholeValue % current.mod
        current.wholeValue = current.wholeValue - current.value

    end

    -- Compact string.
    local fill = false
    for i = #keys, 1, -1 do
        if (timeTable[keys[i]].value > 0) then
            fill = true
        elseif (not fill) then
            continue
        end
        str = str .. timeTable[keys[i]].value .. keys[i]
        if (i ~= 0) then str = str .. ' ' end
    end
    return str
end

concommand.Add("asoc_ban", function(admin,cmd,args)
    if not admin:IsAdmin() then return end
    local ply = player.GetBySteamID(args[1])
    if not IsValid(ply) then return end

    local steam = ply:SteamID64()
    local steamName = ply:Nick()

    local staff = admin:SteamID64()
    local staffName = admin:Nick()
    
    local reason = args[2]
    local duration = (tonumber(args[3]) or 0) * 60

    local request = { 
        ["steam"] = steam,
        ["name"] = stringtohex(steamName),
        ["staff"] = staff, 
        ["staffName"] = stringtohex(staffName),
        ["reason"] = stringtohex(reason),
        ["duration"] = duration,
        ["guild"] = aSoc.discord.guild
    }
    
    aSoc.get('gmod/ban', request, function(data)
        if not data.success then 
            if not IsValid(ply) then return end
            return ply:Kick("Consider this a warning." .. "\n\n" .. reason) 
        end

        if not IsValid(ply) then return end
        ply:Kick("You have been banned by " .. staffName .. " for the following reason: \n\n" .. reason .. "\n\n" .. "Duration: " .. tempTime(duration))
        
        for _, v in ipairs(player.GetHumans()) do
            local time = tempTime(duration)
            local msg = ""
            if time == "Indefinite" then 
                msg = steamName .. " has been banned by " .. staffName .. " indefinitely for the following reason: \"" .. reason .. "\""
            else
                msg = steamName .. " has been banned by " .. staffName .. " for " .. tempTime(duration) .. " - for the following reason: \"" .. reason .. "\""
            end
            v:ChatPrint(msg)
        end
    end)
    aSoc.BanCache[steam] = {
        ['reason'] = reason,
        ['unbanDate'] = duration ~= 0 and os.time() + duration or duration
    }
end)

local function updatebancache()
    aSoc.get('gmod/get-bans', {}, function(data)
        if not data.bans then return log("Could not retrieve bans data.") end
 
        local newCache = {}
        for _, v in ipairs(data.bans) do
            if not v.active then continue end
            newCache[v.steam] = {
                ['reason'] = v.reason,
                ['unbanDate'] = v.duration ~= 0 and v.time + v.duration or v.duration
            }
        end

        aSoc.BanCache = newCache

        for k, v in pairs(player.GetAll()) do
            local steamID64 = v:SteamID64()
            if not aSoc.BanCache[steamID64] then return end
            local msg = ''
            if aSoc.BanCache[steamID64].unbanDate == 0 then
                msg = "You have been banned indefinitely.\n\nReason: " .. aSoc.BanCache[steamID64].reason
            else
                msg = "You are banned for another ~" .. tempTime(aSoc.BanCache[steamID64].unbanDate - os.time()) .. ".\n\nReason: " .. aSoc.BanCache[steamID64].reason
            end
            v:Kick(msg)
        end
    end)
end

aSoc.BanCache = aSoc.BanCache or {}

aSoc.InitializeCacheCheck = aSoc.InitializeCacheCheck or false

hook.Add("CheckPassword", "CheckIfPlayerBanned_aSoc", function(steamID64, ipAddress, svPassword, clPassword, name)

    if not aSoc.InitializeCacheCheck then
        timer.Create("aSoc_BanCacheChecker", 60, 0, function()
            updatebancache()
        end)
    end

    updatebancache()
    if aSoc.BanCache[steamID64] then
        local msg = ''
        if aSoc.BanCache[steamID64].unbanDate == 0 then
            msg = "You have been banned indefinitely.\n\nReason: " .. aSoc.BanCache[steamID64].reason
        else
            msg = "You are banned for another ~" .. tempTime(aSoc.BanCache[steamID64].unbanDate - os.time()) .. ".\n\nReason: " .. aSoc.BanCache[steamID64].reason
        end
        return false, msg
    end
end)