--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

/* Admin helper */

local function MessageAdmins( Msg )
	for _, v in pairs( player.GetHumans() ) do
		if v:IsAdmin() then
			v:ChatPrint( Msg )
		end
	end
end

util.AddNetworkString("RequestNoClipInvis")
net.Receive("RequestNoClipInvis", function(len,ply)
	local DesiredState = net.ReadBool()
	if ply:IsAdmin() then
		if DesiredState then
			ply:SetRenderMode(RENDERMODE_TRANSCOLOR)
			ply:SetColor(Color(255,255,255,0))
		else
			ply:SetRenderMode(RENDERMODE_NORMAL)
			ply:SetColor(Color(255,255,255,255))
		end
	end
end)

hook.Add( "CheckPassword", "CheckPasswordStuff", function( steamID64, ipAddress, svPassword, clPassword, name )
	--[[if clPassword != svPassword then 
		print( name .. " ( " .. steamID64 .. ", " .. ipAddress .. " ) attempted to use the password '" .. clPassword .. "' to connect but failed." )
		for k, v in pairs(player.GetAll()) do
			if v:IsLeadershipTeam() then
				v:ChatPrint(name .. " tried to connect but had the wrong password. (Console)")
				v:PrintMessage(2, name .. " ( " .. steamID64 .. ", " .. ipAddress .. " ) attempted to use the password '" .. clPassword .. "' to connect but failed.")
			end
		end
		return false, "##GameUI_ServerRejectOldVersion"
	end]]
end )

-- Respawn
concommand.Add( "perp_a_sl", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Args[1] then return end

	local Victim = player.GetByUniqueID( Args[1] )
	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	Victim:Spawn()
	Victim:Notify( "You have been respawned." )

	--ASS_LogAction( Player, ASS_ACL_REVIVE, "respawned " .. ASS_FullNick( Victim ) )
end )

-- Heal
concommand.Add( "aSoc_Heal", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end
    if not args[1] then return end

    local user = player.GetByUniqueID( args[1] )

    if user:Alive() then
        user:SetHealth( user:GetMaxHealth() )
        user:Notify("You've been healed.")
    end

end )

-- Toggle Arrest
concommand.Add( "aSoc_ToggleArrest", function( ply, cmd, args )
    --[[if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end
    if not args[1] then return end

    local user = player.GetByUniqueID( args[1] )

    if user.CurrentlyArrested then
        user:UnArrest()
        user:Notify("You've been unarrested.")
    else
        user:Arrest()
        user:Notify("You've been arrested.")
    end]]

end )

-- Reset Stamina
concommand.Add( "aSoc_ResetStamina", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end

    ply.Stamina = 100
    ply:Notify("Your stamina has been replenished.")

end )

-- Reset Hunger
concommand.Add( "aSoc_ReAddHunger", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end

    ply:SetNWInt("Hunger", 100)
    --user:AddHunger( 100 - user:GetHunger() )
    ply:Notify("Your hunger has been replenished.")

end )

-- Reset Saturation
concommand.Add( "aSoc_ReAddSaturation", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end

    ply:SetNWInt("Saturation", 25)
    ply:Notify("Your saturation has been replenished.")

end )

-- Toggle Godmode
concommand.Add( "aSoc_Godmode", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end
    if not args[1] then return end

    local user = player.GetByUniqueID( args[1] )

    if user:GetNWBool("Godmode") then
        user:GodDisable()
        user:SetNWBool("Godmode", user:HasGodMode() )
        user:ChatPrint( "Godmode has been disabled." )
        user:Notify("Godmode has been disabled.")
    else
        user:GodEnable()
        user:SetNWBool("Godmode", user:HasGodMode() )
        user:ChatPrint( "Godmode has been enabled." )
        user:Notify("Godmode has been enabled.")
    end
 
end )

-- Toggle Invisibility
concommand.Add( "aSoc_Invisibility", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end
    if not args[1] then return end

    local user = player.GetByUniqueID( args[1] )

    if not user.Invisible then
        user.Invisible = true
        user:SetPNWVar( "invisible", 1 )
        user:SetGNWVar( "invisible", 1 ) --Sets GNWVar for hud radar
        user:SetColor( Color( 0, 0, 0, 0 ) )
        user:SetNoDraw( true )
        user:DrawWorldModel( false )

        user:ChatPrint( "Invisibility has been enabled." )
        user:Notify("Invisibility has been enabled.")
    else
        user.Invisible = nil
        user:SetPNWVar( "invisible", 0 )
        user:SetGNWVar( "invisible", 0 ) --Sets GNWVar for hud radar
        user:SetColor( Color( 255, 255, 255, 255 ) )
        user:SetNoDraw( false )
        user:DrawWorldModel( true )
        user:ChatPrint( "Invisibility has been disabled." )
        user:Notify("Invisibility has been disabled.")
    end
 
end )

-- Suicide
concommand.Add( "aSoc_Suicide", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end
    if not args[1] then return end

    local user = player.GetByUniqueID( args[1] )

    if user:Alive() then
        user:Kill()
        user:Notify("You've died.")
    end
 
end )

-- Fix Legs
concommand.Add( "aSoc_FixLegs", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end
	if not args[1] then return end

	local user = player.GetByUniqueID( args[1] )
	if not user.Crippled then return end
	
    user.Crippled = nil
    user:Notify("Your legs have been fixed.")

end )

-- Revive
concommand.Add( "aSoc_Revive", function( ply, cmd, args )
    if not ply:IsAdmin() then return end
    if not IsValid( ply ) then return end
	if not args[1] then return end

    local user = player.GetByUniqueID( args[1] )
	if user:Alive() then return end
	
    if IsValid( user.rag ) then
        user.DontFixCripple = true
        user:Spawn()
        user:SetPos( user.DeathPos )
        user:Notify( "You have been revived." )
        --ASS_LogAction( Player, ASS_ACL_REVIVE, "revived " .. ASS_FullNick( user ) )
    end

end )

-- Give Cash
concommand.Add( "aSoc_GiveCash", function( ply, cmd, args )
    if not ply:IsSuperAdmin() then return end
    if not IsValid( ply ) then return end
	if not args[2] then return end

	if not tonumber(args[2]) then return end

    ply:GiveCash(tonumber(args[2]))
    ply:Notify("Your have been given $" .. string.Comma(tonumber(args[2])) .. " by an admin.")

end )

util.AddNetworkString("ChangeScoreboardBackground")
net.Receive("ChangeScoreboardBackground", function(len,Player)
	if not Player:IsGoldVIP() then return Player:Notify("You must be Gold VIP to set your scoreboard background!") end
	local url = net.ReadString()
	if #url > 255 then return Player:Notify("This URL is too long!") end
	if string.find(string.lower(url),"porn") then return Player:Notify("This content is NSFW!") end
	if ((Player.LastChange or 0) + 30 ) > CurTime() then return Player:Notify("You need to wait atleast 30 seconds to change your background again!") end
	Player.LastChange = CurTime()
	Player:SetNWString("BackgroundURL", tmysql.escape(url))
	tmysql.query("UPDATE `perp_users` SET `background`='"..tmysql.escape(url).."' WHERE `id`='"..Player.PERPID.."';")
end)

-- Rename
concommand.Add( "perp_a_fr", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Args[1] then return end

	local Victim = player.GetByUniqueID( Args[1] )
	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	Log( Player:Nick() .. " forced " .. Victim:Nick() .. " to rename.\n" )

	Victim:ForceRename()
end )

-- Spectate
util.AddNetworkString("perp_spectate")
concommand.Add( "perp_a_s", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Args[1] then return end

	if not Player:Alive() then return Player:Notify( "You're dead..." ) end

	local Victim = player.GetByUniqueID( Args[1] )
	if Player == Victim then return Player:Notify( "You can't spectate yourself." ) end
	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	if IsValid( Player:GetVehicle() ) then Player:ExitVehicle() end

	if not Player.Spectating then
		Player:StripMains() -- Backs up ammo, weapons
		Player:StripWeapons() -- Revokes weapons off player

		Player:GodEnable() -- god the player ;3

		Player.Spectating = { Position = Player:GetPos(), Angle = Player:EyeAngles(), Health = Player:Health(), Armour = Player:Armor() }

		Player:SetColor( Color( 0, 0, 0, 0 ) )
		Player:SetNoDraw( true )
		Player:DrawWorldModel( false )
	end

	Player:Spectate( OBS_MODE_CHASE )
	Player:SpectateEntity( Victim )
	Player:SetMoveType( MOVETYPE_OBSERVER )

	net.Start( "perp_spectate")
		net.WriteEntity( Victim )
	net.Send(Player)

	--ASS_LogAction( Player, ASS_ACL_SPECTATE, "began spectating " .. ASS_FullNick( Victim ) )
end )

-- Unspectate
concommand.Add( "perp_a_ss", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Player.Spectating then return end

	local Data = Player.Spectating
	Player.Spectating = nil

	Player:GodDisable()

	Player:Spectate( OBS_MODE_NONE )
	Player:UnSpectate()

	net.Start( "perp_spectate" )
		net.WriteEntity( NULL )
	net.Send(Player)

	Player.DontFixCripple = true -- if player is mayor then it'll "demote" them without this, and dont fix broken legs :P
	Player:Spawn()
	Player:SetMoveType( MOVETYPE_WALK )

	Player:SetPos( Data.Position )
	Player:SetEyeAngles( Data.Angle )
	Player:SetHealth( Data.Health )
	Player:SetArmor( Data.Armour )

	if Player:Team() == TEAM_CITIZEN then timer.Simple( 0, function() Player:EquipMains() end ) end -- only when they're a citizen

	Player:SetColor( Color( 255, 255, 255, 255 ) )
	Player:SetNoDraw( false )
	Player:DrawWorldModel( true )

	--ASS_LogAction( Player, ASS_ACL_SPECTATE, "stopped spectating" )
end )

-- Pretty fucking shit design... at least it works
hook.Add( "CanPlayerSuicide", "SpecSuicide", function( Player )
	if Player.Spectating then
		Player:ConCommand( "perp_a_ss" )
	end
end )

hook.Add( "PlayerDisconnected", "FixSpectate", function( Player )
	for _, v in pairs( player.GetAll() ) do
		if v.Spectating == Player then
			v:ConCommand( "perp_a_ss" )
		end
	end
end )

local TeamToString = {}
--[[TeamToString[ TEAM_CHIEF ] 		= "TEAM_CHIEF"
TeamToString[ TEAM_POLICE ] 		= "TEAM_POLICE"
TeamToString[ TEAM_DETECTIVE ] 		= "TEAM_DETECTIVE"
TeamToString[ TEAM_SWAT ] 		= "TEAM_SWAT"
TeamToString[ TEAM_MAYOR ] 		= "TEAM_MAYOR"
TeamToString[ TEAM_FIREMAN ] 		= "TEAM_FIREMAN"
TeamToString[ TEAM_FIRECHIEF ] 		= "TEAM_FIRECHIEF"
TeamToString[ TEAM_MEDIC ] 		= "TEAM_MEDIC"
TeamToString[ TEAM_ROADSERVICE ] 	= "TEAM_ROADSERVICE"
TeamToString[ TEAM_SECRET_SERVICE ]     = "TEAM_SECRET_SERVICE"
TeamToString[ TEAM_FBI ] 		= "TEAM_FBI"
TeamToString[ TEAM_DISPATCHER ] 	= "TEAM_DISPATCHER"
TeamToString[ TEAM_BUSDRIVER ] 		= "TEAM_BUSDRIVER"
TeamToString[ TEAM_TAXI ] 		= "TEAM_TAXI"
TeamToString[ TEAM_NATIONAL ] 		= "TEAM_NATIONAL"]]

local StringToTeam = {}
--[[StringToTeam[ "Chief" ] 		= TEAM_CHIEF
StringToTeam[ "Police" ] 		= TEAM_POLICE
StringToTeam[ "SWAT" ] 			= TEAM_SWAT
StringToTeam[ "Mayor" ] 		= TEAM_MAYOR
StringToTeam[ "Fireman" ] 		= TEAM_FIREMAN
StringToTeam[ "FireChief" ] 		= TEAM_CHIEF
StringToTeam[ "Paramedic" ] 		= TEAM_MEDIC
StringToTeam[ "Road Crew" ] 		= TEAM_ROADSERVICE
StringToTeam[ "Secret Service" ] 	= TEAM_SECRET_SERVICE
StringToTeam[ "FBI Agent" ] 		= TEAM_FBI
StringToTeam[ "Dispatcher" ] 		= TEAM_DISPATCHER
StringToTeam[ "Bus Driver" ] 		= TEAM_BUSDRIVER
StringToTeam[ "Detective" ]		= TEAM_DETECTIVE
StringToTeam[ "National Guard" ]	= TEAM_NATIONAL]]

TeamName = {}
TeamName[ "TEAM_CHIEF" ] 		= "PoliceChief"
TeamName[ "TEAM_POLICE" ] 		= "Police"
TeamName[ "TEAM_DETECTIVE" ] 		= "Detective"
TeamName[ "TEAM_SWAT" ] 		= "SWAT"
TeamName[ "TEAM_MAYOR" ] 		= "Mayor"
TeamName[ "TEAM_FIREMAN" ] 	        = "Fireman"
TeamName[ "TEAM_MEDIC" ] 	        = "Paramedic"
TeamName[ "TEAM_ROADSERVICE" ] 		= "Road Crew"
TeamName[ "TEAM_SECRET_SERVICE" ] 	= "Secret Service"
TeamName[ "TEAM_FBI" ] 			= "FBI"
TeamName[ "TEAM_DISPATCHER" ] 		= "Dispatcher"
TeamName[ "TEAM_BUSDRIVER" ] 		= "Bus Driver"
TeamName[ "TEAM_TAXI" ] 		= "Taxi Driver"
TeamName[ "TEAM_NATIONAL" ] 		= "National Guard"

-- Blacklist
concommand.Add( "perp_a_bl", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Args[1] or not Args[2] or not Args[3] or not Args[4] then return end

	local Victim = player.GetByUniqueID( Args[1] )
	local Type = Args[2]
	local banTime = tonumber( Args[3] )
	local Reason = Args[4]

	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	if Type ~= "job" and Type ~= "advert" and Type ~= "ooc" and Type ~= "driving" and Type ~= "help" and Type != "serious" then return Player:Notify( "Invalid Blacklist" ) end -- possible exploit.

	banTime = math.Clamp( banTime, 0, 1440 )
	banTime = banTime * 60 -- 24 hours :(

	local Team = TeamToString[ Victim:Team() ]

	if Victim:HasBlacklist( Type, Type == "job" and Team ) then
		return Player:Notify( "They already have that blacklist!" )
	end

	if Type == "advert" then
		Victim:Notify( "You've been blacklisted from advert by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Log( Format( "%s has been successfully blacklisted from %s", Victim:Nick(), Type ) )
	elseif Type == "ooc" then
		Victim:Notify( "You've been blacklisted from Global OOC by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Log( Format( "%s has been successfully blacklisted from %s", Victim:Nick(), "Global OOC" ) )
	elseif Type == "driving" then
		Victim:Notify( "You've been blacklisted from driving by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Victim:ExitVehicle()
		Log( Format( "%s has been successfully blacklisted from %s", Victim:Nick(), Type ) )
	elseif Type == "help" then
		Victim:Notify( "You've been blacklisted from Help by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Log( Format( "%s has been successfully blacklisted from %s", Victim:Nick(), Type ) )
	elseif Type == "serious" then
		Log( Format( "%s has been successfully blacklisted from %s", Victim:Nick(), Type ) )
	else
		if Victim:Team() == TEAM_CITIZEN then return Player:Notify( "You can not blacklist a player from citizenship" ) end

		Victim:Notify( Format( "You've been blacklisted from %s by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ), TeamName[ TeamToString[ Victim:Team() ] ] ) )
		Log( Format( "%s has been successfully blacklisted from job %s", Victim:Nick(), TeamName[ TeamToString[ Victim:Team() ] ] ) )

		if Victim:Team() == TEAM_MAYOR then
			Victim:SetModel( Player:GetPNWVar( "model" ) )
			Victim.JobModel = nil
			Victim:EquipMains()
			Victim:SetTeam( TEAM_CITIZEN )
			SetGNWVar( "nationalguard_active", 0) //Deactivates national guard

			for _, v in pairs( player.GetAll() ) do
				if v ~= Player and v ~= Victim then
					v:Notify( "The mayor has been impeached!" )
					Log("The mayor has been demoted + blacklisted.")					
				end
				if v:Team() == TEAM_SECRET_SERVICE then
					v:LeaveJob()
					v:Notify( "You've been demoted because the mayor was impeached! :(" )
				elseif v:Team() == TEAM_NATIONAL then
					v:LeaveJob()
					v:Notify( "You've been demoted because the mayor was impeached! :(" )
				end
			end
		else
			--GAMEMODE.JobQuit[ Victim:Team() ]( Victim )
			Victim:LeaveJob()
		end
	end

	Victim:GiveBlacklist( Type, banTime, Reason, Player:SteamID(), Type == "job" and Team )
end )

-- Unblacklist
concommand.Add( "perp_a_ubl", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Args[1] or not Args[2] then return end

	local Victim = player.GetByUniqueID( Args[1] )
	local Type = Args[2]
	local Value = Args[3]

	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	if Type == "job" then
		Value = TeamToString[ StringToTeam[ Value ] ]
	end

	if not Victim:HasBlacklist( Type, Value ) then
		return Player:Notify( "They're not blacklisted from " .. Type )
	end

	if Type == "advert" then
		Victim:Notify( "Your Advert blacklist has been lifted." )
		Log( Format( "%s's %s blacklist has been successfully lifted.", Victim:Nick(), Type ) )
	elseif Type == "ooc" then
		Victim:Notify( "Your Global OOC blacklist has been lifted." )
		Log( Format( "%s's %s blacklist has been successfully lifted.", Victim:Nick(), "Global OOC" ) )
	elseif Type == "job" then
		Victim:Notify( "Your " .. TeamName[ Value ] .. " job blacklist has been lifted." )
		Log( Format( "%s's %s %s blacklist has been successfully lifted.", Victim:Nick(), TeamName[ Value ], Type ) )
	elseif Type == "driving" then
		Victim:Notify( "Your driving blacklist has been lifted." )
		Log( Format( "%s's %s blacklist has been successfully lifted.", Victim:Nick(), Type ) )
	end

	Victim:RevokeBlacklist( Type, Value )
end )

-- Demote
concommand.Add( "perp_adm_demote", function( Player, Command, Args )
	if not Player:IsAdmin() then return end

	local Victim = player.GetBySteamID64( Args[1] )
	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	local ogteam = Victim:Team()

	Victim:LeaveJob()

	--if Player ~= Victim then Victim:Notify( "You have been demoted by an admin." ) end
	--Player:Notify( Format( "Demoted %s from %s", Victim:Nick(), TeamName[ TeamToString[ Victim:Team() ] ] ) ) --Doesnt seem to work > the name of the persons team... 
	Player:Notify( Format( "Demoted %s from %s", Victim:Nick(), JOB_DATABASE[ogteam].Name ) )
end )

-- Code from ULX so thank Megiddo for this. This is so players don't get stuck in the world when you teleport them
local function playerSend( from, to, force )
	if not to:IsInWorld() and not force then return false end -- No way we can do this one
		local yawForward = to:EyeAngles().yaw
	local directions = { -- Directions to try
		math.NormalizeAngle( yawForward - 180 ), -- Behind first
		math.NormalizeAngle( yawForward + 180 ), -- Front
		math.NormalizeAngle( yawForward + 90 ), -- Right
		math.NormalizeAngle( yawForward - 90 ), -- Left
		yawForward,
	}
		local t = {}
	t.start = to:GetPos() + Vector( 0, 0, 15 ) -- Move them up a bit so they can travel across the ground
	t.filter = { to, from }
		local i = 1
	t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
	local tr = util.TraceEntity( t, from )
	while tr.Hit do -- While it's hitting something, check other angles
		i = i + 1
		if i > #directions then  -- No place found
			if force then
				return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
			else
				return false
			end
		end
			t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47
			tr = util.TraceEntity( t, from )
	end
	return tr.HitPos
end

-- Teleport to
concommand.Add( "perp_adm_goto", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Args[1] then return end

	local Victim = player.GetByUniqueID( Args[1] )
	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	if Player:GetMoveType() == MOVETYPE_NOCLIP then
		return Player:SetPos( Victim:GetPos() )
	end

	local vec = playerSend( Player, Victim )
	if vec then
		Player:SetPos( vec )
		Player:SetEyeAngles( ( Victim:GetPos() - Player:GetPos() ):Angle() )

		--ASS_LogAction( Player, ASS_ACL_TELEPORT, "teleported to " .. ASS_FullNick( Victim ) )
	else
		Player:ChatPrint( "Error teleporting!" )
	end
end )

-- Bring player
concommand.Add( "perp_adm_bring", function( Player, Command, Args )
	if not Player:IsAdmin() then return end
	if not Args[1] then return end

	local Victim = player.GetByUniqueID( Args[1] )
	if not IsValid( Victim ) then return Player:Notify( "Could not find that player." ) end

	if Victim:InVehicle() then Victim:ExitVehicle() end

	local vec = playerSend( Victim, Player )
	if vec then
		Victim:SetPos( vec )
		Victim:SetEyeAngles( ( Player:GetPos() - Victim:GetPos() ):Angle() )

		--ASS_LogAction( Player, ASS_ACL_TELEPORT, "brought " .. ASS_FullNick( Victim ) .. " to themself" )
	else
		Player:ChatPrint( "Error bringing." )
	end
end )

function GM.FreezeAll(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end
	
	for k,v in pairs(player.GetAll())do
		if (v:IsAdmin()) then
		else
		v:Freeze(true)

		end
		v:Notify("All Non-Administrators have been frozen for Administrative purposes.");
	end
	
	PERP_AllPlayersAreFrozen = true
end
concommand.Add("perp_a_fa", GM.FreezeAll)

function GM.UnFreezeAll(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end

	for k,v in pairs(player.GetAll()) do
		v:Freeze(false)
		v:Notify("Everyone has been unfrozen, please resume roleplay procedures.");
	end
	
	PERP_AllPlayersAreFrozen = false
end
concommand.Add("perp_a_ufa", GM.UnFreezeAll)

function GM.DisableOOC(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end

		GAMEMODE.AllowOOC = !GAMEMODE.AllowOOC

	for k,v in pairs(player.GetAll()) do
		if !GAMEMODE.AllowOOC then
			v:Notify("OOC Has been temporarily disabled to preserve order.");
		else
			v:Notify("OOC has been re-enabled. Please follow standard roleplay procedures.")
		end
	end

end
concommand.Add("perp_a_ooct", GM.DisableOOC)

-- Disguise
concommand.Add( "disguise", function( Player, Command, Args )
	if not Player:IsAdmin() then return end -- Nothing to disguise, duhh.

	local Disguise = Player:GetGNWVar( "disguised" )

	if Disguise then
		Player:SetGNWVar( "disguised", nil )
		Player:ChatPrint( "You have been un-disguised." )
	else
		Player:SetGNWVar( "disguised", true )
		Player:ChatPrint( "You have been disguised." )
	end

end )

/* Player disconnected while someone was in there car */

hook.Add( "PlayerDisconnected", "RejoinToReSpawnCar", function( Player )
	if IsValid( Player.currentVehicle ) and IsValid( Player.currentVehicle:GetDriver() ) and Player.currentVehicle:GetDriver() ~= Player then
		local Driver = Player.currentVehicle:GetDriver()

		local VT = Player.currentVehicle.vehicleTable
		local Log = Format( "%s (%s)<%s> left the server while %s (%s)<%s> at %s was in their %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), Driver:Nick(), Driver:GetRPName(), Driver:SteamID(), Driver:GetZoneName(), VT.Name or "N/A" )
		GAMEMODE:Log( "car_disconnects", Log )

		MessageAdmins( Format( "%s (%s) left the server while %s (%s) at %s was in their %s", Player:Nick(), Player:GetRPName(), Driver:Nick(), Driver:GetRPName(), Driver:GetZoneName(), VT.Name or "N/A" ) )
	end
end )

/* NLR Checker + RDM Checker */

hook.Add( "PlayerDeath", "NLR/RDM Checker", function( Player, Weapon, Killer )
	if Player == Killer then return end

	-- PROP KILL
	if IsValid( Killer ) and Killer:GetClass():lower():find( "ent_prop" ) or Killer:GetClass():lower():find( "ent_item" ) then
		Killer = Killer.Owner
		if not IsValid( Killer ) and Killer ~= Player then return end

		local Log = Format( "%s (%s)<%s> prop killed %s (%s)<%s>", Killer:Nick(), Killer:GetRPName(), Killer:SteamID(), Player:Nick(), Player:GetRPName(), Player:SteamID() )
		GAMEMODE:Log( "prop_kills", Log )

		return MessageAdmins( Format( "%s (%s) prop killed %s (%s)", Killer:Nick(), Killer:GetRPName(), Player:Nick(), Player:GetRPName() ) )
	end

	-- CAR DEATH
	if IsValid( Killer ) and Killer:IsVehicle() and IsValid( Killer:GetDriver() ) then
		local VehicleTable = Killer.vehicleTable
		Killer = Killer:GetDriver()

		local Log = Format( "%s (%s)<%s> in a %s killed %s (%s)<%s> at %s", Killer:Nick(), Killer:GetRPName(), Killer:SteamID(), VehicleTable and VehicleTable.Name or "N/A", Player:Nick(), Player:GetRPName(), Player:SteamID(), Killer:GetZoneName() )
		GAMEMODE:Log( "car_death", Log )

		return MessageAdmins( Format( "%s (%s) in a %s killed %s (%s) at %s", Killer:Nick(), Killer:GetRPName(), VehicleTable and VehicleTable.Name or "N/A", Player:Nick(), Player:GetRPName(), Player:GetZoneName() ) )
	end

	if not ( IsValid( Player ) and Player:IsPlayer() ) or not ( IsValid( Killer ) and Killer:IsPlayer() ) then return end

	local LastKiller = Player.LastKiller
	local DeathTime = Player.NLRDeathTime

	Player.LastKiller = Killer
	Player.NLRDeathTime = os.time()

	-- Check if the player NLRed and killed the same player that killed them
	if IsValid( Killer.LastKiller ) and os.time() - ( Killer.NLRDeathTime or 0 ) <= 300 then -- Last killer is still valid and they died within 5 minutes of dying agian :P
		if Killer.LastKiller == Player then
			local Log = Format( Killer:Nick() .. " killed " .. Player:Nick() .. " at %s who killed them between a 5 minute time frame", Player:Nick(), Player:GetRPName(), Player:SteamID(), Player:GetZoneName(), Killer:Nick(), Killer:GetRPName(), Killer:SteamID() )
			GAMEMODE:Log( "car_death", Log )

			return MessageAdmins( Format( "%s (%s) killed %s (%s) at %s who killed them between a 5 minute time frame [RDM|NLR]", Player:Nick(), Player:GetRPName(), Killer:Nick(), Killer:GetRPName(), Player:GetZoneName() ) )
		end
	end

	-- Check if the player was killed again by the same player
	if IsValid( LastKiller ) and os.time() - ( DeathTime or 0 ) <= 300 then -- Last killer is still valid and they died within 5 minutes of dying again...
		if LastKiller == Killer then
			local Log = Format( "%s (%s)<%s> was killed at %s within 5 minutes of dying by the same player: %s (%s)<%s>", Player:Nick(), Player:GetRPName(), Player:SteamID(), Player:GetZoneName(), Killer:Nick(), Killer:GetRPName(), Killer:SteamID() )
			GAMEMODE:Log( "possible_nlrrdm", Log )

			return MessageAdmins( Format( "%s (%s) was killed at %s within 5 minutes of dying by the same player: %s (%s) [RDM|NLR]", Player:Nick(), Player:GetRPName(), Player:GetZoneName(), Killer:Nick(), Killer:GetRPName() ) )
		end
	end
end )