-- SERVER
aSoc = aSoc or {}

-- dis is aids
util.AddNetworkString( "DiscordLinkPanel" )
util.AddNetworkString( "aSoc_registerSteam" )
util.AddNetworkString( "aSoc_verifyCode" )
util.AddNetworkString( "aSoc_steamRegistration_res" )
util.AddNetworkString( "aSoc_verificationCode_res" )

-- make event handler for playersay
hook.Add("PlayerSay", "PERP_CheckIfSayDiscord", function( ply, text, team )
    if (string.StartWith(string.lower(text), "/discord")) then
        net.Start("DiscordLinkPanel")
            net.WriteString( aSoc.discord.users[ply:SteamID64()] or "N/A" )
        net.Send(ply)
    end
end)

net.Receive( "aSoc_registerSteam", function(_, ply)
    aSoc.get('discord/registerSteam/', { ['steam'] = ply:SteamID64(), ['id'] = net.ReadString() }, function(data)
        net.Start("aSoc_steamRegistration_res")
            net.WriteBool(data.success)
        net.Send(ply) 
    end)
end)

net.Receive( "aSoc_verifyCode", function(_, ply)
    local steam = ply:SteamID64()
    aSoc.get('discord/verifyCode/', {['steam'] = steam, ['code'] = net.ReadString(), ['guild'] = aSoc.discord.guild}, function(data)
        tmysql.query("SELECT `time` FROM `perp_freevip` WHERE `steamid`='" .. steam .. "';", function(Results)
            if tonumber(Results[1]) then
                -- deny later
            else
                tmysql.query("INSERT INTO `perp_freevip` (`steamid`,`time`) VALUES ('"..steam.."','"..os.time().."');")
            end
        end)
        if data.success then
            aSoc.syncPermissions(ply)
            for k,v in pairs(player.GetAll()) do
                v:ChatPrint(ply:Nick() .. " has verified their discord account and received Gold VIP perks! Type '/discord' for more information.")
            end
        end
        net.Start("aSoc_verificationCode_res")
            net.WriteBool(data.success)
        net.Send(ply) 
    end)
end)