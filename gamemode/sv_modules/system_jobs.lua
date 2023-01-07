--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


/*

TEAM_RED NPC 255

TEAM_BLUE NPC 256

*/


hook.Add("VC_spikeStripPlaced", "VC_spikeStripPlaced", function(ent, ply)
	ent.Owner = ply
end)

hook.Add("PlayerDisconnected", "KillSpikeStripsOnleave", function(ply)
	for k, v in pairs(ents.FindByClass("vc_spikestrip")) do
		if v.Owner == ply then
			v:Remove()
		end
	end
end)

function GM:PERP_PlayerChangedTeam()

end

function PLAYER:NearTheseNPCS(NPCS)
	for k, v in pairs(NPCS) do
		if self:NearNPC(v) then
			return true
		end
	end
	return false
end

function PLAYER:JoinJob(job)

	if self.NextJob and self.NextJob > CurTime() then self:Notify("You can't join another job for " .. math.Round(self.NextJob - CurTime(),1) .. " seconds!") return end

	local jobinfo = JOB_DATABASE[job]
	if not jobinfo then self:Notify("Computer Says No.") return end
	if self:GetNetworkedBool("warrent", false) then self:Notify("You can't be a " .. jobinfo.Name .. " while warranted!") return end
	if self.RunningForMayor then self:Notify("You can't be a " .. jobinfo.Name .. " while running for mayor!") return end
	if not self:IsVIP() and jobinfo.RequiredTime and (self:GetTimePlayed() < jobinfo.RequiredTime * 60 * 60) then self:Notify("You don't have enough play time to be a " .. jobinfo.Name .. "! Required Time: " .. jobinfo.RequiredTime .. " hours.") return end
	if jobinfo.VIP and not self:IsVIP() then self:Notify(jobinfo.Name .. " requires VIP status!") return end
	if jobinfo.MaxPlayers != true and team.NumPlayers( TEAM_MEDIC ) >= jobinfo.MaxPlayers then self:Notify("You can't be a " .. jobinfo.Name .. " because the city can't afford any more!") return end
	if IsValid(self.currentVehicle) and !self.currentVehicle.Disabled and self.currentVehicle:GetPos():Distance(self:GetPos()) >= 2500 and not jobinfo.CanUsePersonalVehicle then self:Notify("You can't be a " .. jobinfo.Name .. " because your vehicle is not in the garage!") return end -- if vehicle is nearby its fine
	
	hook.Call("PERP_PlayerChangedTeam", nil, self, job)

	if self:Team() == TEAM_MAYOR and job == TEAM_CITIZEN then
		for k, v in pairs(player.GetHumans()) do
			v:Notify(self:GetRPName() .. " is no longer the mayor!")
			v:ChatPrint(self:GetRPName() .. " is no longer the mayor!")
			if v:Team() == TEAM_SS then
				v:JoinJob(TEAM_CITIZEN)
				v:Notify("You've been demoted because there is no mayor!")
			end
		end
	end

	self:SetTeam(job)
	if not jobinfo.CanUsePersonalVehicle then self:RemoveCar() end
	self:StripWeapons()
	GAMEMODE:PlayerLoadout( self )
	if jobinfo.Armor then
		self:SetArmor(jobinfo.Armor)
	end
	local mdl = jobinfo.Playermodels[ self:GetSex() ][ self:GetFace() ] or jobinfo[ job ][1][1]
	self.JobModel = mdl
	self:SetModel(self.JobModel)
	if not jobinfo.CanEquipInventoryGun then
		self:StripMains()
	else
		self:EquipMains()
	end
	if jobinfo.WelcomeMessage then
		self:Notify("You are now a " .. jobinfo.Name .. "! " .. jobinfo.WelcomeMessage )
	end

	if self:Team() == TEAM_MAYOR then
		GAMEMODE.SendMayorCityBudgetUpdate()
	end

	GAMEMODE:LogToAdmins("Jobs",{
		text = self:Nick() .. " (" .. self:GetRPName() .. ") ["..self:SteamID().."] is now an " .. jobinfo.Name,
		jobinfo = jobinfo,
		player = self:SteamID(),
		position = self:GetPos(),
		type = "join job",
	})

end

util.AddNetworkString("perp_requestjobnpc")
net.Receive("perp_requestjobnpc", function(len,ply)
	local job = net.ReadInt(32)
	local jobinfo = JOB_DATABASE[job]
	if jobinfo.NPC and not ply:NearTheseNPCS(jobinfo.NPC) then return ply:CaughtCheating( "Trying to join " .. jobinfo.Name .. " without being near NPC.", EXPLOIT_POSSIBLETHREAT ) end
	if jobinfo.RequiredTeamOn then if team.NumPlayers( jobinfo.RequiredTeamOn ) < 1 then return ply:Notify("There is no " .. JOB_DATABASE[jobinfo.RequiredTeamOn].Name .. " to protect!") end end
	ply:JoinJob(job)
end)


function PLAYER:LeaveJob()

	local ogteam = self:Team()
	local jobinfo = JOB_DATABASE[ogteam]

	if self:Team() == TEAM_MAYOR then
		for k, v in pairs(player.GetHumans()) do
			v:Notify(self:GetRPName() .. " is no longer the mayor!")
			v:ChatPrint(self:GetRPName() .. " is no longer the mayor!")
			if v:Team() == TEAM_SS then
				v:JoinJob(TEAM_CITIZEN)
				v:Notify("You've been demoted because there is no mayor!")
			end
		end
	end

	self:SetTeam(TEAM_CITIZEN)
	self:StripWeapons()
	GAMEMODE:PlayerLoadout( self )
	self:SetArmor( 0 )
	for k, v in pairs(jobinfo.RefillAmmo or {}) do
		self:SetAmmo( 0, k )
	end
	if self.currentVehicle and self.currentVehicle.vehicleTable then self:RemoveCar() end
	self.JobModel = nil
	self:SetModel( self:GetPNWVar( "model" ) )
	self:EquipMains()
	self:Notify("You are no longer a " .. jobinfo.Name .. "!" )

	GAMEMODE:LogToAdmins("Jobs",{
		text = self:Nick() .. " (" .. self:GetRPName() .. ") ["..self:SteamID().."] left " .. jobinfo.Name .. " and is now TEAM_CITIZEN",
		jobinfo = jobinfo,
		newinfo = JOB_DATABASE[TEAM_CITIZEN],
		player = self:SteamID(),
		position = self:GetPos(),
		location = self:GetZoneName(),
		type = "leave job",
	})

end

util.AddNetworkString("perp_leavejobnpc")
net.Receive("perp_leavejobnpc", function(len,ply)
	local job = ply:Team()
	if job == TEAM_CITIZEN then return end
	local jobinfo = JOB_DATABASE[job]
	if not jobinfo then ply:Notify("Computer Says No.") return end
	if jobinfo.NPC and not ply:NearTheseNPCS(jobinfo.NPC) then return ply:CaughtCheating( "Trying to join " .. jobinfo.Name .. " without being near NPC.", EXPLOIT_POSSIBLETHREAT ) end
	
	ply:LeaveJob()
end)

util.AddNetworkString("perp_requestjobvehicle")
net.Receive("perp_requestjobvehicle", function(len,ply)
	local job = ply:Team()
	if job == TEAM_CITIZEN then return end
	local jobinfo = JOB_DATABASE[job]
	local id = net.ReadString()
	if not id then return end
	local vehicleInfo
	for k, v in pairs(JOB_DATABASE[job].Vehicles or {}) do if v.ID == id then vehicleInfo = v end end
	if not vehicleInfo then return end
	if vehicleInfo.RequiredClass != job then return end
	if not jobinfo then ply:Notify("Computer Says No.") return end
	if jobinfo.VehicleNPC and not ply:NearTheseNPCS(jobinfo.VehicleNPC) then return ply:CaughtCheating( "Trying to spawn " .. vehicleInfo.Name .. " without being near Vehicle Spawner NPC.", EXPLOIT_POSSIBLETHREAT ) end
	local cars = {} for _,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do if v.vehicleTable.RequiredClass == job then table.insert(cars,v.vehicleTable.RequiredClass) end end
	if GAMEMODE.MaxVehicles[job] and #cars+1 >= GAMEMODE.MaxVehicles[job] then ply:Notify("There is not enough vehicles to give! Ask the mayor for more!") return end
	GAMEMODE:SpawnVehicle( ply, id )
end)

util.AddNetworkString("perp_requestholsterjobvehicle")
net.Receive("perp_requestholsterjobvehicle", function(len,ply)
	local job = ply:Team()
	if job == TEAM_CITIZEN then return end
	local jobinfo = JOB_DATABASE[job]
	local id = net.ReadString()
	if not IsValid(ply.currentVehicle) then return end
	if not jobinfo then ply:Notify("Computer Says No.") return end
	if jobinfo.VehicleNPC and not ply:NearTheseNPCS(jobinfo.VehicleNPC) then return ply:CaughtCheating( "Trying to spawn " .. vehicleInfo.Name .. " without being near Vehicle Spawner NPC.", EXPLOIT_POSSIBLETHREAT ) end
	ply.currentVehicle:Remove()
end)


util.AddNetworkString("perp_requestjobammo")
net.Receive("perp_requestjobammo", function(len,ply)
	local job = ply:Team()
	if job == TEAM_CITIZEN then return end
	local jobinfo = JOB_DATABASE[job]
	if not jobinfo then ply:Notify("Computer Says No.") return end
	if jobinfo.VehicleNPC and not ply:NearTheseNPCS(jobinfo.NPC) then return ply:CaughtCheating( "Trying to get ammo " .. vehicleInfo.Name .. " without being near NPC.", EXPLOIT_POSSIBLETHREAT ) end
	GAMEMODE:PlayerLoadout( ply )
	if jobinfo.Armor then
		ply:SetArmor(jobinfo.Armor)
	end
end)

local wages = {}
for k, v in pairs(JOB_DATABASE) do
	wages[k] = v.Pay
end
if GAMEMODE then
	GM.JobWages = GAMEMODE.JobWages or wages
else
	GM.JobWages = wages
end
util.AddNetworkString("mayor_announceandsavewages")
net.Receive("mayor_announceandsavewages", function(len,ply)
	local newwages = net.ReadTable()
	for k, v in pairs(newwages) do
		GAMEMODE.JobWages[k] = math.Clamp(v,10,JOB_DATABASE[k].Pay+200)
	end
	for _, ply in pairs(player.GetAll()) do
		ply:Notify("The mayor has made changes to job wages!")
	end
	net.Start("SendWagesToClients")
	net.WriteTable(GAMEMODE.JobWages)
	net.WriteTable(GAMEMODE.MaxJobs)
	net.WriteTable(GAMEMODE.MaxVehicles)
	net.WriteString(GAMEMODE.MayorLaws)
	net.Broadcast()
end)

local maxjobs = {}
for k, v in pairs(JOB_DATABASE) do
	maxjobs[k] = v.DefaultMaxPlayers
end
if GAMEMODE then
	GM.MaxJobs = GAMEMODE.MaxJobs or maxjobs
else
	GM.MaxJobs = maxjobs
end
util.AddNetworkString("mayor_announceandsavejobsmaxes")
util.AddNetworkString("mayor_announceandsavevehiclemaxes")
util.AddNetworkString("SendJobMaxesToClients")
util.AddNetworkString("SendVehicleMaxesToClients")
util.AddNetworkString("mayor_fire")
util.AddNetworkString("mayor_announcenewlaws")
util.AddNetworkString("SendMayorLaws")
net.Receive("mayor_announceandsavejobsmaxes", function(len,ply)
	if ply:Team() != TEAM_MAYOR then return end
	local newmaxjobs = net.ReadTable()
	for k, v in pairs(newmaxjobs) do
		GAMEMODE.MaxJobs[k] = v
	end
	for _, ply in pairs(player.GetAll()) do
		ply:Notify("The mayor has made changes to job wages!")
	end
	net.Start("SendJobMaxesToClients")
	net.WriteTable(GAMEMODE.MaxJobs)
	net.Broadcast()
end)
net.Receive("mayor_announceandsavevehiclemaxes", function(len,ply)
	if ply:Team() != TEAM_MAYOR then return end
	local newmaxvehs = net.ReadTable()
	for k, v in pairs(newmaxvehs) do
		GAMEMODE.MaxVehicles[k] = v
	end
	for _, ply in pairs(player.GetAll()) do
		ply:Notify("The mayor has made changes to max vehicles per job!")
	end
	net.Start("SendVehicleMaxesToClients")
	net.WriteTable(GAMEMODE.MaxVehicles)
	net.Broadcast()
end)

net.Receive("mayor_announcenewlaws", function(len,ply)
	if ply:Team() != TEAM_MAYOR then return end
	GAMEMODE.MayorLaws = net.ReadString()
	for _, ply in pairs(player.GetAll()) do
		ply:Notify("The mayor has made changes to the written laws!")
	end
	net.Start("SendMayorLaws")
	net.WriteString(GAMEMODE.MayorLaws)
	net.Broadcast()
end)

net.Receive("mayor_fire", function(len,ply)
	if ply:Team() != TEAM_MAYOR then return end
	local fire = net.ReadEntity()
	fire:LeaveJob()
	fire:Notify("You have been demoted by the mayor!")
	ply:Notify(fire:GetRPName() .. " has been demoted.")
	fire.NextJob = CurTime() + 180
end)

util.AddNetworkString("perp_mayor_end")
local function MonitorMayorVotes()
	if not GAMEMODE.MayorElection then
		return timer.Remove( "MonitorMayorVotes" )
	end

	if GAMEMODE.TotalVotesCounted < GAMEMODE.VotesNeeded and GAMEMODE.MayorElection > CurTime() then return end

	Msg( "Counting mayor votes...\n" )

	GAMEMODE.ElectionOn = false

	GAMEMODE.TotalVotesCounted = nil
	GAMEMODE.VotesNeeded = nil
	GAMEMODE.MayorElection = nil

	local largestVote_Count = -1
	local Player

	for _, v in pairs( player.GetAll() ) do
		v.MayorVoteCounted = nil

		if v.RunningForMayor then
			if v.NumVotes > largestVote_Count then
				largestVote_Count = v.NumVotes
				Player = v
			end
			v.RunningForMayor = nil
			v.NumVotes = nil
		end
	end

	if not IsValid( Player ) then
		return Error( "No mayor was chosen.\n" )
	end

	Msg( Player:Nick() .. " [ " .. Player:GetRPName() .. " ] won election.\n" )

	net.Start( "perp_mayor_end" )
		net.WriteEntity( Player )
		net.WriteInt( largestVote_Count, 8 )
	net.Broadcast()

	Player:JoinJob(TEAM_MAYOR)
end

local iLastSignup = CurTime()
util.AddNetworkString("perp_mayor_election")
concommand.Add( "perp_g_b", function( Player )
	local Blacklist = Player:HasBlacklist( "job", "TEAM_MAYOR" )

	if Blacklist then Player:Notify( "You are currently blacklisted from this job for: " .. Blacklist.Reason .. ", time remaining: " .. ( Blacklist.Expire == 0 and "forever" or TimeToString( Blacklist.Expire - os.time() ) ) ) return end

	if Player:Team() ~= TEAM_CITIZEN then return end
	if not Player:NearNPC(1) then return Player:CaughtCheating( "Trying to sign up for mayor while away from NPC" ) end
	if Player.Owner then return end
	if GAMEMODE.ElectionOn then return end
	if iLastSignup > CurTime() then return Player:Notify( "Please try again in two seconds." ) end
	if Player:GetTimePlayed() < JOB_DATABASE[TEAM_MAYOR].RequiredTime * 60 * 60 and not Player:IsVIP() then return end
	iLastSignup = CurTime() + 2

	if Player.RunningForMayor then
		Player.RunningForMayor = nil
	else
		Player.RunningForMayor = true
	end

	local numRunningForMayor = {}
	for _, v in pairs( player.GetAll() ) do
		if v.RunningForMayor then
			table.insert( numRunningForMayor, v )
		end
	end

	local RequiredAmountofPPL = math.Clamp( math.Round( #player.GetAll() / 2 ), 2, 5 )
	if #numRunningForMayor >= RequiredAmountofPPL then
		Msg( "Starting mayor election with " .. #numRunningForMayor .. " contestants.\n" )

		GAMEMODE.ElectionOn = true

		net.Start( "perp_mayor_election" )
			net.WriteInt( #numRunningForMayor,8 )

			for _, v in pairs( numRunningForMayor ) do
				v.NumVotes = 0
				net.WriteEntity( v )
			end
		net.Broadcast()

		GAMEMODE.MayorElection = CurTime() + 30
		GAMEMODE.TotalVotesCounted = 0
		GAMEMODE.VotesNeeded = table.Count( player.GetAll() )
		timer.Create( "MonitorMayorVotes", 1, 0, MonitorMayorVotes )
	else
		local s = "person"
		if RequiredAmountofPPL - #numRunningForMayor > 1 then s = "people" end
		Player:Notify( RequiredAmountofPPL - #numRunningForMayor .. ' more ' .. s .. ' required to start an election!')
	end
end )

concommand.Add( "perp_g_v", function( Player, Command, Args )
	if not Args[1] then return end
	if Player.MayorVoteCounted then return end
	if not GAMEMODE.MayorElection then return end

	Player.MayorVoteCounted = true

	local votedFor_UID = Args[1]

	local votedFor_Player
	for _, v in pairs( player.GetAll() ) do
		if v:UniqueID() == votedFor_UID then
			votedFor_Player = v
			break
		end
	end
	if not votedFor_Player then return end
	if not votedFor_Player.RunningForMayor then return end

	votedFor_Player.NumVotes = votedFor_Player.NumVotes + 1
	GAMEMODE.TotalVotesCounted = GAMEMODE.TotalVotesCounted + 1
end )

concommand.Add( "perp_g_d", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end

	--if not Player:Team() == TEAM_MAYOR then return end
		if Player:Team() ~= TEAM_MAYOR then
				for k, v in pairs(player.GetAll()) do
					if (v:IsAdmin()) then
						v:PrintMessage(HUD_PRINTCONSOLE, "[====EXPLOITER====]" .. Player:Nick() .. " tried to Warrent without being the proper Mayor.");
						v:Notify( "[====EXPLOITER====]" .. Player:Nick() .. " tried to Warrent without being the proper Mayor." )
					end
				end
			Player:Kick("Exploiter");
			return false
		end

		if Player.NextDemoteAllowed and Player.NextDemoteAllowed > CurTime() then return end
	Player.NextDemoteAllowed = CurTime() + 59

	local toChangeUID = Args[1]
	local reason = Args[2]

	local toChangePlayer = player.GetByUniqueID( toChangeUID )
	if not toChangePlayer then return Player:Notify( "Could not find player." ) end
	if Player == toChangePlayer then return end

	if not Player:Team() == TEAM_MAYOR then
		return Player:Kick( "Bad boys.. bad boys.. whatcha gonna do? What you gonna do when I ban YOU?" )
	end

	if toChangePlayer:Team() == TEAM_CITIZEN then
		return Player:Notify( "You cannot demote a citizen." )
	end

	GAMEMODE.JobQuit[ toChangePlayer:Team() ]( toChangePlayer )

	Player:Notify( "Player demoted." )
	toChangePlayer:Notify( "You have been demoted by the mayor for '" .. reason .. "'" )
end )

	/*demote as chief */
concommand.Add( "perp_g_d_pc", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end

	--if not Player:Team() == TEAM_CHIEF then return end

		if Player:Team() ~= TEAM_CHIEF then
			for k, v in pairs(player.GetAll()) do
				if (v:IsAdmin()) then
					v:PrintMessage(HUD_PRINTCONSOLE, "[====EXPLOITER====]" .. Player:Nick() .. " tried to Warrent without being the proper chief.");
					v:Notify( "[====EXPLOITER====]" .. Player:Nick() .. " tried to Warrent without being the proper chief." )
				end
			end
			Player:Kick("Exploiter");
			return false
		end
	if Player.NextDemoteAllowed and Player.NextDemoteAllowed > CurTime() then return end
	Player.NextDemoteAllowed = CurTime() + 59

	local toChangeUID = Args[1]
	local reason = Args[2]

	local toChangePlayer = player.GetByUniqueID( toChangeUID )
	if not toChangePlayer then return Player:Notify( "Could not find player." ) end
	if Player == toChangePlayer then return end

	if toChangePlayer:Team() == TEAM_CITIZEN then
		return Player:Notify( "You cannot demote a citizen." )
	elseif toChangePlayer:Team() == TEAM_MAYOR then
		for _, v in pairs( player.GetAll() ) do
			
			if v:Team() == TEAM_SECRET_SERVICE then
				GAMEMODE.JobQuit[ v:Team() ]( v )
				v:Notify( "You've been demoted because the mayor was impeached! :(" )
			elseif v:Team() == TEAM_NATIONAL then
				GAMEMODE.JobQuit[ v:Team() ]( v )
				v:Notify( "You've been demoted because the mayor was impeached! :(" )
			end
			
		end
		
		SetGNWVar( "nationalguard_active", 0)

	end

	GAMEMODE.JobQuit[ toChangePlayer:Team() ]( toChangePlayer )

	Player:Notify( "Player demoted." )
	toChangePlayer:Notify( "You have been demoted by the Chief for '" .. reason .. "'" )
end )

	/*demote as firechief*/
concommand.Add( "perp_g_d_fc", function( Player, Command, Args )

	if not Args[1] or not Args[2] then return end

	--if not Player:Team() == TEAM_FIRECHIEF then return end
	if Player:Team() ~= TEAM_FIRECHIEF then
		for k, v in pairs(player.GetAll()) do
				if (v:IsAdmin()) then
					v:PrintMessage(HUD_PRINTCONSOLE, "[====EXPLOITER====]" .. Player:Nick() .. " tried without being the proper firechief.");
					v:Notify( "[====EXPLOITER====]" .. Player:Nick() .. " tried without being the proper firechief." )
				end
			end
			Player:Kick("Exploiter");
			return false
		end

	if Player.NextDemoteAllowed and Player.NextDemoteAllowed > CurTime() then return end
	Player.NextDemoteAllowed = CurTime() + 59

	local toChangeUID = Args[1]
	local reason = Args[2]

	local toChangePlayer = player.GetByUniqueID( toChangeUID )
	if not toChangePlayer then return Player:Notify( "Could not find player." ) end
	if Player == toChangePlayer then return end

	if toChangePlayer:Team() == TEAM_CITIZEN then
		return Player:Notify( "You cannot demote a citizen." )
	end

	GAMEMODE.JobQuit[ toChangePlayer:Team() ]( toChangePlayer )

	Player:Notify( "Player demoted." )
	toChangePlayer:Notify( "You have been demoted by the FIRECHIEF for '" .. reason .. "'" )
end )

// detective--//
local ammoToGive = 70


/*timer.Create( "Unwarrent", 10, 0, function()
	for _, v in pairs( player.GetAll() ) do
		if v:IsWarrented() and v.warrent_expire <= CurTime() then
			v:Notify( "Your warrant has expired." )

			v:SetGNWVar( "warrented", nil )

			for _, g in pairs( team.GetPlayers( TEAM_CHIEF ) ) do
				g:Notify( v:GetRPName() .. "'s warrant has expired." )
			end

			for _, g in pairs( team.GetPlayers( TEAM_POLICE ) ) do
				g:Notify( v:GetRPName() .. "'s warrant has expired." )
			end

			for _, g in pairs( team.GetPlayers( TEAM_DETECTIVE ) ) do
				g:Notify( v:GetRPName() .. "'s warrant has expired." )
			end

			for _, g in pairs( team.GetPlayers( TEAM_FBI ) ) do
				g:Notify( v:GetRPName() .. "'s warrant has expired." )
			end

			for _, g in pairs( team.GetPlayers( TEAM_SECRET_SERVICE ) ) do
				g:Notify( v:GetRPName() .. "'s warrant has expired." )
			end

			for _, g in pairs( team.GetPlayers( TEAM_SWAT ) ) do
				g:Notify( v:GetRPName() .. "'s warrant has expired." )
			end
		end
	end
end )*/

function UnwarrantPlayers( name ) //Moved this to sv_hooks into the FinishedOff and Death hooks.
	for _, g in pairs( team.GetPlayers( TEAM_CHIEF ) ) do
		g:Notify( name .. "'s warrant has been removed." )
	end

	for _, g in pairs( team.GetPlayers( TEAM_POLICE ) ) do
		g:Notify( name .. "'s warrant has been removed." )
	end

	for _, g in pairs( team.GetPlayers( TEAM_DETECTIVE ) ) do
		g:Notify( name .. "'s warrant has been removed." )
	end

	for _, g in pairs( team.GetPlayers( TEAM_FBI ) ) do
		g:Notify( name .. "'s warrant has been removed." )
	end

	for _, g in pairs( team.GetPlayers( TEAM_SECRET_SERVICE ) ) do
		g:Notify( name .. "'s warrant has been removed." )
	end

	for _, g in pairs( team.GetPlayers( TEAM_SWAT ) ) do
		g:Notify( name .. "'s warrant has been removed." )
	end
end

concommand.Add( "perp_g_w", function( Player, Command, Args )
	if not Player:Team() == TEAM_MAYOR then return end
	if not Args[1] or not Args[2] then return end

	local UniqueID = Args[1]
	local Reason = Args[2]

	local Victim = player.GetByUniqueID( UniqueID )

	if not IsValid( Victim ) then return Player:Notify( "Could not find player." ) end
	if Victim == Player then return Player:Notify( "You can't warrant yourself." ) end
	if not Player:Team() == TEAM_MAYOR then return Player:Kick( "Bad boys.. bad boys.. whatcha gonna do? What you gonna do when I ban YOU?" ) end
	if Victim:IsGovernmentOfficial() then return Player:Notify( "You cannot warrant a government official." ) end
	if Victim:IsWarrented() then return Player:Notify( "That player is already warranted." ) end

	Player:Notify( "Player warranted." )
	Victim:Notify( "You have been warranted by the mayor for '" .. Reason .. "'" )
	//Victim.warrent_expire = CurTime() + WARRENT_TIME

	for k, v in pairs(team.GetPlayers(TEAM_CHIEF)) do
		v:Notify( Victim:GetRPName() .. " has been warranted.");
	end

	for _, v in pairs( team.GetPlayers( TEAM_POLICE ) ) do
		v:Notify( Victim:GetRPName() .. " has been warranted." )
	end

	for k, v in pairs(team.GetPlayers(TEAM_FBI)) do
		v:Notify( Victim:GetRPName() .. " has been warranted.");
	end

	for k, v in pairs(team.GetPlayers(TEAM_DETECTIVE)) do
		v:Notify( Victim:GetRPName() .. " has been warranted.");
	end

	for _, v in pairs( team.GetPlayers( TEAM_SECRET_SERVICE ) ) do
		v:Notify( Victim:GetRPName() .. " has been warranted." )
	end

	for _, v in pairs( team.GetPlayers( TEAM_SWAT ) ) do
		v:Notify( Victim:GetRPName() .. " has been warranted." )
	end

	if Player.NextWarrentAllowed and Player.NextWarrentAllowed > CurTime() then return end
	Player.NextWarrentAllowed = CurTime() + 9

	Victim:SetGNWVar( "warrented", true )
end )

concommand.Add( "perp_gg_w", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end

	local UniqueID = Args[1]
	local Reason = Args[2]

	local Victim = player.GetByUniqueID( UniqueID )

	Victim:Notify( "You have been warranted by the mayor for '" .. Reason .. "'" )
	//Victim.warrent_expire = CurTime() + WARRENT_TIME

	for k, v in pairs(team.GetPlayers(TEAM_CHIEF)) do
		v:Notify( Victim:GetRPName() .. " has been warranted.");
	end

	for _, v in pairs( team.GetPlayers( TEAM_POLICE ) ) do
		v:Notify( Victim:GetRPName() .. " has been warranted." )
	end

	for k, v in pairs(team.GetPlayers(TEAM_FBI)) do
		v:Notify( Victim:GetRPName() .. " has been warranted.");
	end

	for k, v in pairs(team.GetPlayers(TEAM_DETECTIVE)) do
		v:Notify( Victim:GetRPName() .. " has been warranted.");
	end

	for _, v in pairs( team.GetPlayers( TEAM_SECRET_SERVICE ) ) do
		v:Notify( Victim:GetRPName() .. " has been warranted." )
	end

	for _, v in pairs( team.GetPlayers( TEAM_SWAT ) ) do
		v:Notify( Victim:GetRPName() .. " has been warranted." )
	end

	if Player.NextWarrentAllowed and Player.NextWarrentAllowed > CurTime() then return end
	Player.NextWarrentAllowed = CurTime() + 9

	Victim:SetGNWVar( "warrented", true )
end )


hook.Add( "PlayerInitialSpawn", "SendCityInfo", function( Player )
	GAMEMODE:SendJobInformation( Player )
end )

local UpdateNotice = false
timer.Create( "SendCityInfoTimer", 5, 0, function()
	if UpdateNotice then
		GAMEMODE:SendJobInformation()
		UpdateNotice = false
	end
end )

function PLAYER:IsMayor()
	return self:Team() == TEAM_MAYOR
end

local LastAnnounce = CurTime()
concommand.Add( "perp_m_ann_ch", function( Player )
	if not Player:IsMayor() then return end

	if LastAnnounce > CurTime() then return end
	LastAnnounce = CurTime() + 10

	for _, v in pairs( player.GetAll() ) do
		v:Notify( "The mayor has restated the local government laws and limits. Use a law book to see what's different." )
	end
end )

--------------------------------------------------------
-- GENERAL SERVER SETTINGS
--------------------------------------------------------

------------------------
-- Inside City Speed Limit
------------------------

concommand.Add( "perp_m_sl_i", function( Player, Command, Args )
	if not Player:IsMayor() then return end

	SetGNWVar( "innercity_speedlimit_i", math.Clamp( tonumber( Args[1] ), 20, 120 ) )

	UpdateNotice = true
end )

------------------------
-- Outside City Speed Limit
------------------------

concommand.Add( "perp_m_sl_o", function( Player, Command, Args )
	if not Player:IsMayor() then return end

	SetGNWVar( "innercity_speedlimit_o", math.Clamp( tonumber( Args[1] ), 20, 120 ) )

	UpdateNotice = true
end )

------------------------
-- TAX ON ITEMS
------------------------

concommand.Add( "perp_m_t_s", function( Player, Command, Args )
	if not Player:IsMayor() then return end

	SetGNWVar( "tax_sales", math.Clamp( tonumber( Args[1] ), 0, GAMEMODE.MaxTax_Sales ) )

	UpdateNotice = true
end )

------------------------
-- TAX ON PAY DAY
------------------------

concommand.Add( "perp_m_t_i", function( Player, Command, Args )
	if not Player:IsMayor() then return end

	SetGNWVar( "tax_income", math.Clamp( tonumber( Args[1] ), 0, GAMEMODE.MaxTax_Income ) )

	UpdateNotice = true
end )

------------------------
-- PARKING TICKET FEE
------------------------

concommand.Add( "perp_m_ticket_p", function( Player, Command, Args )
	if not Player:IsMayor() then return end

	SetGNWVar( "ticket_price", math.Clamp( tonumber( Args[1] ), 500, GAMEMODE.MaxTicketPrice ) )

	UpdateNotice = true
end )

//MADE BY BRAD CARTER / PARIS



util.AddNetworkString( "giveGovShotgun" )
util.AddNetworkString( "giveGovM4A1" )
util.AddNetworkString( "giveGovUSP" )
util.AddNetworkString( "giveGovGlock" )
util.AddNetworkString( "giveGovFiveSeven" )
util.AddNetworkString( "giveGovTaser" )
util.AddNetworkString( "giveGovFlash" )
util.AddNetworkString( "giveGovAmmo" )
util.AddNetworkString( "giveGovHealth" )
util.AddNetworkString( "giveGovArmor" )


local function IsAllowed(ply)
	local allowedteams = {}
	allowedteams[TEAM_CHIEF] = true
	allowedteams[TEAM_DETECTIVE] = true
	allowedteams[TEAM_POLICE] = true
	allowedteams[TEAM_SWAT] = true
	allowedteams[TEAM_NATIONAL] = true
	return allowedteams[ply:Team()]
end



net.Receive("giveGovShotgun", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		Player:Give("cw_m3super90_police")
		Player:Notify( "You have recieved a Shotgun" )
	
	end
end )

net.Receive("giveGovM4A1", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		Player:Give("khr_m4a4")
		Player:Notify( "You have recieved a M4" )
	
	end
end )

net.Receive("giveGovUSP", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		Player:Give("khr_p226")
		Player:Notify( "You have recieved a USP" )
	
	end
end )

net.Receive("giveGovGlock", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		Player:Give("cw_glock20")
		Player:Notify( "You have recieved a Glock" )
	
	end
end )

net.Receive("giveGovFiveSeven", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		Player:Give("cw_fiveseven")
		Player:Notify( "You have recieved a Five-Seven" )
	
	end
end )

net.Receive("giveGovTaser", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		Player:Give( "stungun" )
		Player:Notify( "You have recieved a Taser" )
	
	end
end )

net.Receive("giveGovFlash", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		Player:Give( "weapon_perp_sh_flashbang" )
		Player:Notify( "You have recieved a Flash Grenade" )
	
	end
end )

net.Receive("giveGovAmmo", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 258 ) or Player:NearNPC( 156 )) and IsAllowed(Player) then
	
		local ammoToGive = 70 //PISTOL
		local ammoToGive2 = 150 //RIFLE
		local ammoToGive3 = 70 //BUCKSHOT
	
		--RunConsoleCommand( "perp_p_ammo" )
		--Player:Notify( "You have recieved Ammo" )

		//PISTOL AMMO
		local weapon = Player:GetWeapon( "cw_fiveseven" ) or Player:GetWeapon( "khr_p226" ) or Player:GetWeapon( "cw_glock20" )
		Player:GiveAmmo(ammoToGive-math.Clamp(Player:GetAmmoCount('pistol'), 0, ammoToGive), 'pistol');

		//RIFLE AMMO
		local weapon = Player:GetWeapon( "cw_mp5_kry" ) or Player:GetWeapon( "khr_m4a4" )
		Player:GiveAmmo(ammoToGive2-math.Clamp(Player:GetAmmoCount('smg1'), 0, ammoToGive2), 'smg1');
		
		//BUCKSHOT AMMO
		local weapon = Player:GetWeapon( "cw_m3super90" )
		Player:GiveAmmo(ammoToGive3-math.Clamp(Player:GetAmmoCount('buckshot'), 0, ammoToGive3), 'buckshot');
		
		Player:Notify( "You have recieved Ammo" )
	
	end
end )

net.Receive("giveGovHealth", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 8989 ) or Player:NearNPC( 259 )) and IsAllowed(Player) then
	
		--Player:Give( "weapon_perp_sh_flashbang" )
		Player:Notify( "Your health has been restored to 100%" )
		Player:SetHealth( 100 )
	
	end
end )

net.Receive("giveGovArmor", function(len, Player)
	
	if Player:IsGovernmentOfficial() and (Player:NearNPC( 8989 ) or Player:NearNPC( 259 )) and IsAllowed(Player) then
	
		--Player:Give( "weapon_perp_sh_flashbang" )
		Player:Notify( "Your armor has been restored to 100%" )
		Player:SetArmor( 100 )
	
	end
end )

local function BroadcastPanic( ply )
	if !ply:IsGovernmentOfficial() then return end

	local panicAlertZone = ply:GetZoneName()
		
	GAMEMODE:PlayerSay( ply, "/radio [PANIC] A Government Official has triggered their panic button at " .. tostring(panicAlertZone) .. ", urgent assistance is required!", true, false)
end
concommand.Add( "perp_gov_panic", BroadcastPanic )