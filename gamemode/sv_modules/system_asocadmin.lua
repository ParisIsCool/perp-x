
util.AddNetworkString("aSoc_Request")

local aSoc_Request = {}
net.Receive("aSoc_Request", function(len,ply)
    if not ply:IsAdmin() then return end

    local Type = net.ReadString()
    local Player = net.ReadEntity()
    local ExtraInfo = net.ReadTable()

    if not Player then Player = ply end
    if not aSoc_Request[Type] then return end
    aSoc_Request[Type](Player, ply, ExtraInfo or {})
end)

aSoc_Request["aSoc_Bring"] = function(Player, Admin)
    local pos = Admin:GetForward() * 50
    Player:SetPos(pos+Admin:GetPos())
    local a = Admin:EyeAngles()
    Player:SetEyeAngles(Angle(0,a.y + 180,0))

    Admin:ChatPrint(string.format("%s [%s] has been brought.", Player:Nick(), Player:SteamID()))
end

aSoc_Request["aSoc_Goto"] = function(Player, Admin)
    local pos = Player:GetForward() * -50
    Admin:SetPos(pos+Player:GetPos())
    local a = Player:EyeAngles()
    Admin:SetEyeAngles(Angle(0,a.y,0))

    Admin:ChatPrint(string.format("You have gone to %s [%s].", Player:Nick(), Player:SteamID()))
end

aSoc_Request["aSoc_Heal"] = function(Player, Admin)
    if not Player:Alive() then
        local pos = Player:GetPos()
        Player:Spawn()
        Player:SetPos(pos)
    end
    Player:SetHealth(Player:GetMaxHealth())
    Player.Crippled = nil
    
    Admin:ChatPrint(string.format("%s [%s] has been healed.", Player:Nick(), Player:SteamID()))
end

hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
	if ply.Invisible then return true end
end )

aSoc_Request["aSoc_Invisibility"] = function(Player, Admin)
    Player.Invisible = not (Player:GetColor().a == 0) -- "not" to toggle it
    if Player.Invisible then
        Player:SetRenderMode(RENDERMODE_TRANSCOLOR)
        local color = Color( 0, 0, 0, 0 )
        Player:SetColor( color )
        hook.Add("Think", "FuckingActiveWeaponInvis"..Player:SteamID(), function()
            if not IsValid(Player) then return end
            for k, v in pairs(Player:GetWeapons()) do
                v:SetRenderMode(RENDERMODE_TRANSCOLOR)
                v:SetColor(color)
            end
        end)

        Admin:ChatPrint(string.format("%s [%s] is now invisible.", Player:Nick(), Player:SteamID()))
    else
        Player:SetRenderMode(RENDERMODE_NORMAL)
        Player:SetColor( Color( 255, 255, 255, 255 ) )
        hook.Remove("Think", "FuckingActiveWeaponInvis"..Player:SteamID())
        for k, v in pairs(Player:GetWeapons()) do
            v:SetRenderMode(RENDERMODE_NORMAL)
            v:SetColor(Color(255,255,255,255))
        end

        Admin:ChatPrint(string.format("%s [%s] is no longer invisible.", Player:Nick(), Player:SteamID()))
    end
end

aSoc_Request["aSoc_Arrest"] = function(Player, Admin)
    if Player.CurrentlyArrested then
        Player:UnArrest()
        Player:Notify("You've been unarrested.")
    else
        Player:Arrest()
        Player:Notify("You've been arrested.")
    end
end

aSoc_Request["aSoc_Kill"] = function(Player, Admin)
    Player:Kill()
    
    Admin:ChatPrint(string.format("%s [%s] has been killed.", Player:Nick(), Player:SteamID()))
end

aSoc_Request["aSoc_Kick"] = function(Player, Admin)
    Player:Kick()
    
    Admin:ChatPrint(string.format("%s [%s] has been kicked.", Player:Nick(), Player:SteamID()))
end

hook.Add( "PlayerNoClip", "aSoc_NoClip", function( ply, desiredState )
	return ply:IsAdmin()
end )

aSoc_Request["aSoc_Godmode"] = function(Player, Admin)
    if Player:HasGodMode() then
        Player:GodDisable()
        Player:SetNWBool("HasGodMode", false)
        Admin:ChatPrint(string.format("%s [%s] is no longer in god mode.", Player:Nick(), Player:SteamID()))
    else
        Player:GodEnable()
        Player:SetNWBool("HasGodMode", true)
        Admin:ChatPrint(string.format("%s [%s] is now in god mode.", Player:Nick(), Player:SteamID()))
    end
end

util.AddNetworkString("aSoc_SpaceToUnspectate")
aSoc_Request["aSoc_Spectate"] = function(Player, Admin)
    Admin.SpectateInfo = { Position = Admin:GetPos(), Angle = Admin:EyeAngles(), Health = Admin:Health(), Armour = Admin:Armor(), GodMode = Admin:HasGodMode(), MoveType = Admin:GetMoveType() }
    Admin.S_Weapons = {}
    for k, v in pairs(Admin:GetWeapons()) do
        Admin.S_Weapons[v:GetClass()] = true
    end
    Admin:StripWeapons()
    Admin:GodEnable()
    Admin:Spectate( OBS_MODE_IN_EYE )
    Admin:SpectateEntity( Player )
    net.Start("aSoc_SpaceToUnspectate")
    net.Send(Admin)
    Admin:ChatPrint(string.format("%s [%s] is now being spectated", Player:Nick(), Player:SteamID()))
end

net.Receive("aSoc_SpaceToUnspectate", function(len,ply)
    if not ply:IsAdmin() then return end
    if not ply.SpectateInfo then return end
    local si = ply.SpectateInfo
    for k, v in pairs(ply.S_Weapons) do
        ply:Give(k)
    end
    ply:Spectate( OBS_MODE_NONE )
    ply:UnSpectate()
    ply:Spawn()
	ply:SetPos( si.Position )
	ply:SetEyeAngles( si.Angle )
	ply:SetHealth( si.Health )
	ply:SetArmor( si.Armour )
    if not si.GodMode then
        ply:GodDisable()
    end
    ply:SetMoveType(si.MoveType)
end)

aSoc_Request["aSoc_SetRank"] = function(Player, Admin, ExtraInfo)
    local Rank = ExtraInfo.Rank
    if not Admin:IsManagementTeam() then
         -- something really bad has happend
         -- admin cheating?
        Admin:Kick()
        return
    end

    Player:SetRank( Rank, 999999999 )

    Admin:ChatPrint(string.format("%s [%s] has been set to the rank of %s", Player:Nick(), Player:SteamID(), Rank))
end

aSoc_Request["aSoc_SetJob"] = function(Player, Admin, ExtraInfo)
    local job = ExtraInfo.id
    if not JOB_DATABASE[job] then return end
    Player:JoinJob(job)

    Admin:ChatPrint(string.format("%s [%s] has been set to the rank of %s", Player:Nick(), Player:SteamID(), JOB_DATABASE[job].Name))
end

util.AddNetworkString("aSoc_RunPlayerFunction_Response")
aSoc_Request["aSoc_RunPlayerFunction"] = function(Player, Admin, ExtraInfo)
    if not Admin:IsManagementTeam() then
         -- something really bad has happend
         -- admin cheating?
        Admin:Kick()
        return
    end

    local err, iffalse = RunString( ExtraInfo.lua or "", "aSoc_RunPlayerFunction", false)
    net.Start("aSoc_RunPlayerFunction_Response")
        net.WriteTable({
            error = err or "none",
            returned = aSoc_returned or "none"
        })
    net.Send(Admin)

    Admin:ChatPrint(string.format("Lua has been run successfully on %s [%s]", Player:Nick(), Player:SteamID()))
end

util.AddNetworkString("aSoc_RequestPlayerDictionary")
net.Receive("aSoc_RequestPlayerDictionary", function(len,ply)
    if not ply:IsManagementTeam() then return end
    net.Start("aSoc_RequestPlayerDictionary")
    local playerobject = FindMetaTable("Player")
    local tab = {}
    for k, v in pairs(playerobject) do
        if k == "MetaBaseClass" then
            for bs, _ in pairs(v) do
                tab[bs] = true
            end
        else
            tab[k]=true
        end
    end
    net.WriteTable(tab)
    net.Send(ply)
end)