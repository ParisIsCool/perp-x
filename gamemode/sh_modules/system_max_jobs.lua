--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

--GOVERMENT---

-- (Note From Paris), one day we should organize this by files instead of it spread out everywhere in many files.

-- Upkeep, MaxPayDay, MaxVehicles, MaxEmployement

GM.Jobs = {}
GM.Jobs[ "Chief" ] 		    = { Upkeep = 50, MaxPayDay = 250, MaxVehicles = 1, MaxEmployement = 1 }
GM.Jobs[ "Police" ] 		= { Upkeep = 50, MaxPayDay = 220, MaxVehicles = 18, MaxEmployement = 18 }
GM.Jobs[ "SWAT" ] 			= { Upkeep = 75, MaxPayDay = 220, MaxVehicles = 4, MaxEmployement = 10 }
GM.Jobs[ "Detective" ] 		= { Upkeep = 50, MaxPayDay = 230, MaxVehicles = 4, MaxEmployement = 4 }

GM.Jobs[ "Fireman" ] 		= { Upkeep = 75, MaxPayDay = 270, MaxVehicles = 6, MaxEmployement = 10 }
GM.Jobs[ "FireChief" ] 		= { Upkeep = 50, MaxPayDay = 260, MaxVehicles = 1, MaxEmployement = 1 }
GM.Jobs[ "Paramedic" ] 		= { Upkeep = 50, MaxPayDay = 250, MaxVehicles = 4, MaxEmployement = 8 }

GM.Jobs[ "SecretService" ] 	= { Upkeep = 100, MaxPayDay = 250, MaxVehicles = 3, MaxEmployement = 5 }
GM.Jobs[ "FBI" ] 			= { Upkeep = 50, MaxPayDay = 250, MaxVehicles = 4, MaxEmployement = 4 }

GM.Jobs[ "Dispatcher" ] 	= { Upkeep = 50, MaxPayDay = 210, MaxEmployement = 2 }
GM.Jobs[ "RoadService" ] 	= { Upkeep = 75, MaxPayDay = 200, MaxVehicles = 5, MaxEmployement = 10 }
GM.Jobs[ "BusDriver" ] 		= { Upkeep = 75, MaxPayDay = 190, MaxVehicles = 2, MaxEmployement = 2 }
GM.Jobs[ "TaxiDriver" ] 	= { Upkeep = 75, MaxPayDay = 190, MaxVehicles = 2, MaxEmployement = 2 }
GM.Jobs[ "TeamRed" ] 	= { Upkeep = 75, MaxPayDay = 5, MaxVehicles = 5, MaxEmployement = 50 }
GM.Jobs[ "TeamBlue" ] 	= { Upkeep = 75, MaxPayDay = 5, MaxVehicles = 5, MaxEmployement = 50 }
GM.Jobs[ "NationalGuard" ] 	= { Upkeep = 75, MaxPayDay = 270, MaxVehicles = 15, MaxEmployement = 20 }

function CurrentPChief()
	if #team.GetPlayers( TEAM_CHIEF ) >= 1 then
		return GetGNWVar("current_pchief")
	else
		return "Vacant."
	end
end

function CurrentFChief()
	if #team.GetPlayers( TEAM_FIRECHIEF ) >= 1 then
		return GetGNWVar("current_fchief")
	else
		return "Vacant."
	end
end

function CurrentMayor()
	if #team.GetPlayers( TEAM_MAYOR ) >= 1 then
		return GetGNWVar("current_mayor")
	else
		return "Vacant."
	end
end

function CurrentNG()
	if GetGNWVar( "nationalguard_active" ) == 1 then
		return "Active."
	else
		return "Inactive."
	end
end

hook.Add("Initialize", "SysMaxVehicles", function()
	--if GAMEMODE.MaxVehicles then return end
	GAMEMODE.MaxVehicles = {}
	for k, v in pairs(JOB_DATABASE) do
		if isnumber(v.MaxVehicles) then
			GAMEMODE.MaxVehicles[k] = math.ceil(v.MaxVehicles*0.5)
		end
	end
end)
GM.MaxJobs		= GM.MaxJobs or {}
GM.MaxPlayers 	= GM.MaxPlayers or {}

if SERVER then

	util.AddNetworkString("perp2_job_info")
	function GM:SendJobInformation( Player )
		net.Start( "perp2_job_info" )
			net.WriteTable( GAMEMODE.MaxPlayers )
			net.WriteTable( GAMEMODE.MaxVehicles )
			local PayDay = {}
			for k, v in pairs(GAMEMODE.JobPaydayInfo) do
				PayDay[k] = v[2]
			end
			net.WriteTable( PayDay )
		if IsValid(Player) then
			net.Send(Player)
		else
			net.Broadcast()
		end
	end

else

	-- Clientside Shit
	GM.PayDay = GM.PayDay or {}
	net.Receive( "perp2_job_info", function()
		GAMEMODE.MaxPlayers = net.ReadTable()
		GAMEMODE.MaxVehicles = net.ReadTable()
		GAMEMODE.PayDay = net.ReadTable()
	end )

end

-- Kinda inefficient ⬇
--[[timer.Create( "CalculateMaxJobs", 5, 0, function()
	-- We now rely on the mayors options, oh god :/
	
	GAMEMODE.MaxPlayers[ "Police" ] 		= math.Clamp( math.Round( #player.GetAll() / 3 ), 1, GAMEMODE.Jobs[ "Police" ][ "MaxEmployement" ] )
	GAMEMODE.MaxVehicles[ "Police" ] 		= math.Clamp( math.Round( #player.GetAll() / 3 ), 1, GAMEMODE.Jobs[ "Police" ][ "MaxVehicles" ] )
	
	GAMEMODE.MaxPlayers[ "TeamRed" ]		= GAMEMODE.Jobs[ "TeamRed" ][ "MaxEmployement" ]
	GAMEMODE.MaxVehicles[ "TeamRed" ] 		= GAMEMODE.Jobs[ "TeamRed" ][ "MaxVehicles" ]
	
	GAMEMODE.MaxPlayers[ "TeamBlue" ]		= GAMEMODE.Jobs[ "TeamBlue" ][ "MaxEmployement" ]
	GAMEMODE.MaxVehicles[ "TeamBlue" ] 		= GAMEMODE.Jobs[ "TeamBlue" ][ "MaxVehicles" ]
	
	if #team.GetPlayers( TEAM_MAYOR ) >= 1 then return end
	
	GAMEMODE.MaxPlayers[ "Chief" ] 			= math.Clamp( math.Round( #player.GetAll() / 1 ), 1, GAMEMODE.Jobs[ "Chief" ][ "MaxEmployement" ] )	
	GAMEMODE.MaxPlayers[ "Detective" ] 		= math.Clamp( math.Round( #player.GetAll() / 3 ), 1, GAMEMODE.Jobs[ "Detective" ][ "MaxEmployement" ] )
		
	GAMEMODE.MaxPlayers[ "Fireman" ] 		= math.Clamp( math.Round( #player.GetAll() / 2 ), 1, GAMEMODE.Jobs[ "Fireman" ][ "MaxEmployement" ] )
	GAMEMODE.MaxPlayers[ "FireChief" ] 		= math.Clamp( math.Round( #player.GetAll() / 1 ), 1, GAMEMODE.Jobs[ "FireChief" ][ "MaxEmployement" ] )
	GAMEMODE.MaxPlayers[ "Paramedic" ] 		= math.Clamp( math.Round( #player.GetAll() / 2 ), 1, GAMEMODE.Jobs[ "Paramedic" ][ "MaxEmployement" ] )
	
	GAMEMODE.MaxPlayers[ "SecretService" ]	= math.Clamp( math.Round( #player.GetAll() / 4 ), 1, GAMEMODE.Jobs[ "SecretService" ][ "MaxEmployement" ] )
	GAMEMODE.MaxPlayers[ "FBI" ]			= math.Clamp( math.Round( #player.GetAll() / 4 ), 1, GAMEMODE.Jobs[ "FBI" ][ "MaxEmployement" ] )
	
	GAMEMODE.MaxPlayers[ "Dispatcher" ] 	= math.Clamp( math.Round( #player.GetAll() / 4 ), 1, GAMEMODE.Jobs[ "Dispatcher" ][ "MaxEmployement" ] )
	GAMEMODE.MaxPlayers[ "RoadService" ]	= math.Clamp( math.Round( #player.GetAll() / 2 ), 1, GAMEMODE.Jobs[ "RoadService" ][ "MaxEmployement" ] )
	GAMEMODE.MaxPlayers[ "BusDriver" ]		= math.Clamp( math.Round( #player.GetAll() / 2 ), 1, GAMEMODE.Jobs[ "BusDriver" ][ "MaxEmployement" ] )
	GAMEMODE.MaxPlayers[ "TaxiDriver" ]		= math.Clamp( math.Round( #player.GetAll() / 2 ), 1, GAMEMODE.Jobs[ "TaxiDriver" ][ "MaxEmployement" ] )
		
	if #player.GetAll() >= GAMEMODE.MinimumForSWAT then
		GAMEMODE.MaxPlayers[ "SWAT" ] = math.Clamp( math.Round( #player.GetAll() / 5 ), 0, GAMEMODE.Jobs[ "SWAT" ][ "MaxEmployement" ] )
	else
		GAMEMODE.MaxPlayers[ "SWAT" ] = 0
	end
	
	//want atleast 15 to be national guard AND national guard needs to be active to get a vehicle...
	if #player.GetAll() >= GAMEMODE.MinimumForSWAT and GetGNWVar( "nationalguard_active" ) == 1 then
		GAMEMODE.MaxPlayers[ "NationalGuard" ] = math.Clamp( math.Round( #player.GetAll() / 5 ), 0, GAMEMODE.Jobs[ "NationalGuard" ][ "MaxEmployement" ] )
	else
		GAMEMODE.MaxPlayers[ "NationalGuard" ] = 0
	end
    
	GAMEMODE.MaxVehicles[ "Chief" ] 		= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "Chief" ] / 1 ), 0, GAMEMODE.Jobs[ "Chief" ][ "MaxVehicles" ] )
	GAMEMODE.MaxVehicles[ "SWAT" ]			= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "SWAT" ] / 2 ), 0, GAMEMODE.Jobs[ "SWAT" ][ "MaxVehicles" ] )
	GAMEMODE.MaxVehicles[ "Detective" ] 	= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "Detective" ] / 2 ), 0, GAMEMODE.Jobs[ "Detective" ][ "MaxVehicles" ] )
	
	GAMEMODE.MaxVehicles[ "Fireman" ] 		= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "Fireman" ] / 2 ), 0, GAMEMODE.Jobs[ "Fireman" ][ "MaxVehicles" ] )
	GAMEMODE.MaxVehicles[ "FireChief" ] 	= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "FireChief" ] / 1 ), 0, GAMEMODE.Jobs[ "FireChief" ][ "MaxVehicles" ] )
	GAMEMODE.MaxVehicles[ "Paramedic" ] 	= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "Paramedic" ] / 2 ), 0, GAMEMODE.Jobs[ "Paramedic" ][ "MaxVehicles" ] )
	
	GAMEMODE.MaxVehicles[ "SecretService" ] = math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "SecretService" ] / 2 ), 0, GAMEMODE.Jobs[ "SecretService" ][ "MaxVehicles" ] )	
	GAMEMODE.MaxVehicles[ "FBI" ] 			= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "FBI" ] / 2 ), 0, GAMEMODE.Jobs[ "FBI" ][ "MaxVehicles" ] )
	
	GAMEMODE.MaxVehicles[ "RoadService" ]	= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "RoadService" ] / 2 ), 0, GAMEMODE.Jobs[ "RoadService" ][ "MaxVehicles" ] )
	GAMEMODE.MaxVehicles[ "BusDriver" ]		= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "BusDriver" ] / 2 ), 0, GAMEMODE.Jobs[ "BusDriver" ][ "MaxVehicles" ] )
	GAMEMODE.MaxVehicles[ "TaxiDriver" ]	= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "BusDriver" ] / 2 ), 0, GAMEMODE.Jobs[ "TaxiDriver" ][ "MaxVehicles" ] )
	GAMEMODE.MaxVehicles[ "NationalGuard" ]	= math.Clamp( math.Round( GAMEMODE.MaxPlayers[ "NationalGuard" ] / 2 ), 0, GAMEMODE.Jobs[ "NationalGuard" ][ "MaxVehicles" ] )
end )]]