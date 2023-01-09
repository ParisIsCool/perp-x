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

-- Password prompt changer / spoofer. Makes people thank server is outtdated when infact is in development.
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

-- custom admin command library
local commands = {}
-- Code for future rewrite which will eliminate the need for concommands.
--[[net.Receive( "admin_command", function( len, Admin )
	local command_index = net.ReadString()
	if not commands[command_index] then return end
	local command = commands[command_index]
	local Args = net.ReadTable()
	if not Admin:IsRankHigherRank( command["Rank"] or "aSoc:Admin" ) then return end
	local Victim = player.GetByUniqueID( Args[1] ) or Admin
	if not IsValid( Victim ) then return Admin:Notify( "Could not find that player." ) end
	command.func( Victim, Admin, Args )
end )]]

local function AdminCommand( Command, Function, Rank )
	commands[Command] = {func=Function,Rank=Rank}
	concommand.Add( Command, function( Admin, Command, Args )
		if not Admin:IsRankHigherRank( Rank or "aSoc:Admin" ) then return end
		local Victim = player.GetByUniqueID( Args[1] ) or Admin
		if not IsValid( Victim ) then return Admin:Notify( "Could not find that player." ) end
		Function( Victim, Admin, Args )
	end )
end

-- Respawn
AdminCommand( "perp_a_sl", function(Player, Admin, Args) 
	Player:Spawn()
	Player:Notify( "You have been respawned." )
end)

-- Heal
AdminCommand( "aSoc_Heal", function( Player, Admin, Args )
    if Player:Alive() then
        Player:SetHealth( user:GetMaxHealth() )
        Player:Notify("You've been healed.")
    end
end )

-- Toggle Arrest
AdminCommand( "aSoc_ToggleArrest", function( Player, Admin, Args )
    if Player.CurrentlyArrested then
        Player:UnArrest()
        Player:Notify("You've been unarrested.")
    else
        Player:Arrest()
        Player:Notify("You've been arrested.")
    end
end )

-- Reset Stamina
AdminCommand( "aSoc_ResetStamina", function( Player, Admin, Args )
    Player:SetNWFloat("Stamina", 100 )
    Player:Notify("Your stamina has been replenished.")
end )

-- Reset Hunger
AdminCommand( "aSoc_ReAddHunger", function( Player, Admin, Args )
    Player:SetNWInt("Hunger", 100)
    Player:Notify("Your hunger has been replenished.")
end )

-- Reset Saturation
AdminCommand( "aSoc_ReAddSaturation", function( Player, Admin, Args )
    ply:SetNWInt("Saturation", 25)
    ply:Notify("Your saturation has been replenished.")
end )

-- Toggle Godmode
AdminCommand( "aSoc_Godmode", function( Player, Admin, Args )
    if Player:GetNWBool("Godmode") then
        Player:GodDisable()
        Player:SetNWBool("Godmode", Player:HasGodMode() )
        Player:ChatPrint( "Godmode has been disabled." )
        Player:Notify("Godmode has been disabled.")
    else
        Player:GodEnable()
        Player:SetNWBool("Godmode", Player:HasGodMode() )
        Player:ChatPrint( "Godmode has been enabled." )
        Player:Notify("Godmode has been enabled.")
    end
end )

-- Toggle Invisibility
AdminCommand( "aSoc_Invisibility", function( Player, Admin, Args )
	if not Player.Invisible then
        Player.Invisible = true
        Player:SetPNWVar( "invisible", 1 )
        Player:SetGNWVar( "invisible", 1 ) --Sets GNWVar for hud radar
        Player:SetColor( Color( 0, 0, 0, 0 ) )
        Player:SetNoDraw( true )
        Player:DrawWorldModel( false )
        Player:ChatPrint( "Invisibility has been enabled." )
        Player:Notify("Invisibility has been enabled.")
    else
        Player.Invisible = nil
        Player:SetPNWVar( "invisible", 0 )
        Player:SetGNWVar( "invisible", 0 ) --Sets GNWVar for hud radar
        Player:SetColor( Color( 255, 255, 255, 255 ) )
        Player:SetNoDraw( false )
        Player:DrawWorldModel( true )
        Player:ChatPrint( "Invisibility has been disabled." )
        Player:Notify("Invisibility has been disabled.")
    end
 
end )

-- Suicide
AdminCommand( "aSoc_Suicide", function( Player, Admin, Args )
    if Player:Alive() then
        Player:Kill()
        Player:Notify("You've died.")
    end
end )

-- Fix Legs
AdminCommand( "aSoc_FixLegs", function( Player, Admin, Args )
	if not Player.Crippled then return end
    Player.Crippled = nil
    Player:Notify("Your legs have been fixed.")
end )

-- Revive
AdminCommand( "aSoc_Revive", function( Player, Admin, Args )
    if IsValid( Player.rag ) then -- i hate this is how we check :(
        Player.DontFixCripple = true
        Player:Spawn()
        Player:SetPos( Player.DeathPos )
        Player:Notify( "You have been revived." )
    end
end )

-- Give Cash
AdminCommand( "aSoc_GiveCash", function( Player, Admin, Args )
	Player:GiveCash(tonumber(args[2]))
    Player:Notify("Your have been given $" .. string.Comma(tonumber(args[2])) .. " by an admin.")
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
AdminCommand( "perp_a_fr", function( Player, Admin, Args )
	Log( Admin:Nick() .. " forced " .. Player:Nick() .. " to rename.\n" )
	Player:ForceRename()
end )

-- Spectate
util.AddNetworkString("perp_spectate")
AdminCommand( "perp_a_s", function( Player, Admin, Args )
	if not Admin:Alive() then return Admin:Notify( "You're dead..." ) end
	if Player == Admin then return Admin:Notify( "You can't spectate yourself." ) end
	if not IsValid( Player ) then return Admin:Notify( "Could not find that player." ) end
	if IsValid( Admin:GetVehicle() ) then Admin:ExitVehicle() end
	if not Admin.Spectating then
		Admin:StripMains() -- Backs up ammo, weapons
		Admin:StripWeapons() -- Revokes weapons off player
		Admin:GodEnable() -- god the player ;3
		Admin.Spectating = { Position = Admin:GetPos(), Angle = Admin:EyeAngles(), Health = Admin:Health(), Armour = Admin:Armor() }
		-- above keeps track of the player's position, angle, health, and armour so we can restore it later
		Admin:SetColor( Color( 0, 0, 0, 0 ) )
		Admin:SetNoDraw( true )
		Admin:DrawWorldModel( false )
	end
	Admin:Spectate( OBS_MODE_CHASE )
	Admin:SpectateEntity( Player )
	Admin:SetMoveType( MOVETYPE_OBSERVER )
	net.Start( "perp_spectate")
		net.WriteEntity( Player )
	net.Send(Admin)
end )

-- Unspectate
AdminCommand( "perp_a_ss", function( Player, Admin, Args )
	if not Admin.Spectating then return end
	local Data = Admin.Spectating
	Admin.Spectating = nil
	Admin:GodDisable()
	Admin:Spectate( OBS_MODE_NONE )
	Admin:UnSpectate()
	net.Start( "perp_spectate" )
		net.WriteEntity( NULL )
	net.Send(Admin)
	Admin.DontFixCripple = true -- if player is mayor then it'll "demote" them without this, and dont fix broken legs :P
	Admin:Spawn()
	Admin:SetMoveType( MOVETYPE_WALK )
	Admin:SetPos( Data.Position )
	Admin:SetEyeAngles( Data.Angle )
	Admin:SetHealth( Data.Health )
	Admin:SetArmor( Data.Armour )
	if Admin:Team() == TEAM_CITIZEN then timer.Simple( 0, function() Admin:EquipMains() end ) end -- CHANGE THIS PLS.
	Admin:SetColor( Color( 255, 255, 255, 255 ) )
	Admin:SetNoDraw( false )
	Admin:DrawWorldModel( true )
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

local blacklistypes = {
	["job"] = "Job",
	["advert"] = "Advert",
	["ooc"] = "OOC",
	["driving"] = "Driving",
	["help"] = "Help",
	["serious"] = "Serious"
}
-- Blacklist
AdminCommand( "perp_a_bl", function( Player, Admin, Args )
	if not Args[1] or not Args[2] or not Args[3] or not Args[4] then return end
	local Type = Args[2]
	local banTime = tonumber( Args[3] )
	local Reason = Args[4]

	if not blacklistypes[Type] then return Player:Notify( "Invalid Blacklist" ) end

	banTime = math.Clamp( banTime, 0, 1440 )
	banTime = banTime * 60

	local Team = JOB_DATABASE[ Player:Team() ].Name

	if Player:HasBlacklist( Type, Type == "job" and Team ) then
		return Admin:Notify( "They already have that blacklist!" )
	end

	if Type == "advert" then
		Player:Notify( "You've been blacklisted from advert by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Log( Format( "%s has been successfully blacklisted from %s", Player:Nick(), Type ) )
	elseif Type == "ooc" then
		Player:Notify( "You've been blacklisted from Global OOC by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Log( Format( "%s has been successfully blacklisted from %s", Player:Nick(), "Global OOC" ) )
	elseif Type == "driving" then
		Player:Notify( "You've been blacklisted from driving by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Player:ExitVehicle()
		Log( Format( "%s has been successfully blacklisted from %s", Player:Nick(), Type ) )
	elseif Type == "help" then
		Player:Notify( "You've been blacklisted from Help by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ) )
		Log( Format( "%s has been successfully blacklisted from %s", Player:Nick(), Type ) )
	elseif Type == "serious" then
		Log( Format( "%s has been successfully blacklisted from %s", Player:Nick(), Type ) )
	else
		if Player:Team() == TEAM_CITIZEN then return Player:Notify( "You can not blacklist a player from citizenship" ) end

		Player:Notify( Format( "You've been blacklisted from %s by an admin. Reason: " .. Reason .. ", time remaining: " .. ( banTime == 0 and "forever" or TimeToString( banTime - os.time() ) ), Team ) )
		Log( Format( "%s has been successfully blacklisted from job %s", Player:Nick(), Team ) )

		if Player:Team() == TEAM_MAYOR then
			Player:SetModel( Player:GetPNWVar( "model" ) )
			Player.JobModel = nil
			Player:EquipMains()
			Player:SetTeam( TEAM_CITIZEN )
			Log("The mayor has been demoted + blacklisted.")
			for _, v in pairs( player.GetAll() ) do
				v:Notify( "The mayor has been blacklisted and removed by an admin!" )					
				if v:Team() == TEAM_SECRET_SERVICE then
					v:LeaveJob()
					v:Notify( "You've been demoted because the mayor was impeached! :(" )
				elseif v:Team() == TEAM_NATIONAL then
					v:LeaveJob()
					v:Notify( "You've been demoted because the mayor was impeached! :(" )
				end
			end
		else
			Player:LeaveJob()
		end
	end

	Player:GiveBlacklist( Type, banTime, Reason, Admin:SteamID(), Type == "job" and Team )
end )

-- Unblacklist
AdminCommand( "perp_a_ubl", function( Player, Admin, Args )
	if not Args[1] or not Args[2] then return end
	local Type = Args[2]
	local Value = Args[3]

	if not Player:HasBlacklist( Type, Value ) then
		return Admin:Notify( "They're not blacklisted from " .. Type )
	end

	if Type == "advert" then
		Player:Notify( "Your Advert blacklist has been lifted." )
		Log( Format( "%s's %s blacklist has been successfully lifted.", Player:Nick(), Type ) )
	elseif Type == "ooc" then
		Player:Notify( "Your Global OOC blacklist has been lifted." )
		Log( Format( "%s's %s blacklist has been successfully lifted.", Player:Nick(), "Global OOC" ) )
	elseif Type == "job" then
		Player:Notify( "Your " .. TeamName[ Value ] .. " job blacklist has been lifted." )
		Log( Format( "%s's %s %s blacklist has been successfully lifted.", Player:Nick(), TeamName[ Value ], Type ) )
	elseif Type == "driving" then
		Player:Notify( "Your driving blacklist has been lifted." )
		Log( Format( "%s's %s blacklist has been successfully lifted.", Player:Nick(), Type ) )
	end

	Player:RevokeBlacklist( Type, Value )
end )

-- Demote
AdminCommand( "perp_adm_demote", function( Player, Admin, Args )
	local ogteam = Player:Team()
	Player:LeaveJob()
	if Admin ~= Player then Player:Notify( "You have been demoted by an admin." ) end
	Admin:Notify( Format( "Demoted %s from %s", Player:Nick(), JOB_DATABASE[ogteam].Name ) )
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
AdminCommand( "perp_adm_goto", function( Player, Admin, Args )
	if Admin:GetMoveType() == MOVETYPE_NOCLIP then
		return Admin:SetPos( Player:GetPos() )
	end

	local vec = playerSend( Admin, Player )
	if vec then
		Admin:SetPos( vec )
		Admin:SetEyeAngles( ( Player:GetPos() - Admin:GetPos() ):Angle() )
	else
		Admin:ChatPrint( "Error teleporting!" )
	end
end )

-- Bring player
AdminCommand( "perp_adm_bring", function( Player, Admin, Args )
	if Player:InVehicle() then Player:ExitVehicle() end

	local vec = playerSend( Player, Admin )
	if vec then
		Player:SetPos( vec )
		Player:SetEyeAngles( ( Admin:GetPos() - Player:GetPos() ):Angle() )
	else
		Admin:ChatPrint( "Error bringing." )
	end
end )

function GM.FreezeAll(Player, Admin, Args)
	for k,v in pairs(player.GetAll())do
		if not v:IsAdmin() then
			v:Freeze(true)
		end
		v:Notify("All Non-Administrators have been frozen for Administrative purposes.");
	end
	
	PERP_AllPlayersAreFrozen = true
end
AdminCommand("perp_a_fa", GM.FreezeAll, "aSoc:SeniorAdmin")

function GM.UnFreezeAll(Player, Admin, Args)
	for k,v in pairs(player.GetAll()) do
		v:Freeze(false)
		v:Notify("Everyone has been unfrozen, please resume roleplay procedures.");
	end
	
	PERP_AllPlayersAreFrozen = false
end
AdminCommand("perp_a_ufa", GM.UnFreezeAll, "aSoc:SeniorAdmin")

function GM.DisableOOC(Player, Admin, Args)
	GAMEMODE.AllowOOC = !GAMEMODE.AllowOOC

	for k,v in pairs(player.GetAll()) do
		if !GAMEMODE.AllowOOC then
			v:Notify("OOC Has been temporarily disabled to preserve order.");
		else
			v:Notify("OOC has been re-enabled. Please follow standard roleplay procedures.")
		end
	end

end
AdminCommand("perp_a_ooct", GM.DisableOOC, "aSoc:SeniorAdmin")

-- Disguise
AdminCommand( "disguise", function( Player, Admin, Args )
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