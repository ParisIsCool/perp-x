--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.OrganizationData = GM.OrganizationData or {}

function GM.LoadOrganizations()
	tmysql.query( Query( "LOADORGANISATIONS" ), function( Results, Status, ErrorMsg )
		Msg( "Loading Organizations...\n" )
		for _, v in pairs( Results ) do
			local name, motd, owner, id, firstname, lastname = v[ "name" ], v[ "motd" ], v[ "owner" ], tonumber( v[ "id" ] ), v[ "rp_name_first" ] or "John", v[ "rp_name_last" ] or "Doe"
			GAMEMODE.OrganizationData[ id ] = { name, motd, firstname .. " " .. lastname, owner, {} }

			tmysql.query( Format( Query( "LOADORGANISATIONMEMBERS" ), id ), function( Results, Status, ErrorMsg )
				for _, v in pairs( Results ) do
					local Owner, SteamID = v[ "rp_name_first" ] .. " " .. v[ "rp_name_last" ], v[ "id" ]

					table.insert( GAMEMODE.OrganizationData[ id ][5], { Owner, SteamID } )
				end
			end, QUERY_FLAG_ASSOC )

			--Msg( "\t-> Loaded " .. name .. " [ID: " .. id .. "] [Owner: " .. v[ "rp_name_first" ] .. " " .. v[ "rp_name_last" ] .. "]\n" ) -- REMOVED TO STOP SERVER CRASH ON START WITH PTERODACTYL PANEL
		end
		Msg( "Done\n" )
	end, QUERY_FLAG_ASSOC )
end

util.AddNetworkString("perp_rod")
util.AddNetworkString("perp_rod_mod")
util.AddNetworkString("perp_rod_m")
function GM:RequestOrganizationData( Player, orgID )
	if GAMEMODE.OrganizationData[ orgID ] then
		net.Start( "perp_rod" )
			net.WriteInt( orgID, 16 )
			net.WriteString( GAMEMODE.OrganizationData[ orgID ][1] )
			net.WriteString( GAMEMODE.OrganizationData[ orgID ][3] )
			net.WriteBool( tonumber(GAMEMODE.OrganizationData[ orgID ][4]) == ( Player.PERPID or 0 ) )
		net.Send(Player)
		
		net.Start( "perp_rod_mod" )
			net.WriteInt( orgID, 16 )
			net.WriteString( GAMEMODE.OrganizationData[ orgID ][2] )
		net.Send(Player)
		
		for _, v in pairs( GAMEMODE.OrganizationData[ orgID ][5] ) do
			net.Start( "perp_rod_m" )
				net.WriteInt( orgID, 16 )
				net.WriteString( v[1] )
				net.WriteString( v[2] )
			net.Send(Player)
		end
	end
end

/*************************************************
	Command "perp_o_c"
	Job: Change Organization MOTD/Name
*************************************************/

util.AddNetworkString("perp_srod")
concommand.Add( "perp_o_c", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end
	
	local playerOrg = Player:GetGNWVar( "org", 0 )
	
	if playerOrg == 0 then return end
	if not GAMEMODE.OrganizationData[ playerOrg ] then return end
	if tonumber(GAMEMODE.OrganizationData[ playerOrg ][4]) ~= Player.PERPID then return end

	Player:Notify( "Updating your organization..." )
	
	local oldName = GAMEMODE.OrganizationData[ playerOrg ][1]
	local oldMOTD = GAMEMODE.OrganizationData[ playerOrg ][2]
	
	local newName, newMOTD = Args[1], Args[2]
	
	if string.len( newName ) > 20 then newName = string.sub( newName, 1, 20 ) end

	tmysql.query( Format( Query( "CHECKORGNAMEAVAILABLITY" ), tmysql.escape( newName ) ), function( Results, Status, ErrorMsg ) 
		if newName ~= oldName and Results[1] then
			return Player:Notify( "This organisation name is currently unavailable, try again." )
		end

		GAMEMODE.OrganizationData[ playerOrg ][1] = newName
		GAMEMODE.OrganizationData[ playerOrg ][2] = newMOTD

		tmysql.query( Format( Query( "UPDATEORGANISATION" ), tmysql.escape( newName ), tmysql.escape( newMOTD ), playerOrg ) )

		if newName ~= oldName then
			-- Update the org's name
			net.Start( "perp_srod" )
			net.WriteInt( playerOrg, 16 )
			net.WriteString( newName )
			net.Broadcast()
		end
		
		if newMOTD ~= oldMOTD then
			for _, v in pairs( player.GetAll() ) do
				if v:GetGNWVar( "org", 0 ) == playerOrg then
					-- Update the MOTD of the group
					net.Start( "perp_rod_mod" )
						net.WriteInt( playerOrg, 16 )
						net.WriteString( GAMEMODE.OrganizationData[ playerOrg][2] )
					net.Send(v)
				end
			end
		end
		
		Player:Notify( "Changes successfully saved." )
	end )
end )

/*************************************************
	Command "perp_o_i"
	Job: Invite a player to your Organization
*************************************************/

util.AddNetworkString("perp_invite")
concommand.Add( "perp_o_i", function( Player, Command, Args )
	if not Args[1] then return end
	
	local playerOrg = Player:GetGNWVar( "org", 0 )
	
	if playerOrg == 0 then return end
	if not GAMEMODE.OrganizationData[ playerOrg ] then return end
	if tonumber(GAMEMODE.OrganizationData[ playerOrg ][4]) ~= Player.PERPID then return end
	
	local sPlayer = player.GetByUniqueID( Args[1] )
	if not sPlayer then return end

	if sPlayer:GetGNWVar( "org", 0 ) ~= 0 then return end

	Player:Notify( "You've invited " .. sPlayer:GetRPName() .. " to your organization!" )
	
	sPlayer.invitedTo = playerOrg
	sPlayer.invitedBy = Player
	
	net.Start( "perp_invite" )
		net.WriteString( GAMEMODE.OrganizationData[ playerOrg ][1] )
	net.Send(sPlayer)
end )

/*************************************************
	Command "perp_o_r"
	Job: Kick player from Organization
*************************************************/

util.AddNetworkString("perp_cleany_org")
util.AddNetworkString("perp_rod_c")
concommand.Add( "perp_o_r", function( Player, Command, Args )
	if not Args[1] or not Args[1]:find( "STEAM_0:" ) then return end

	local playerOrg = Player:GetGNWVar( "org", 0 )
	
	if playerOrg == 0 then return end
	if not GAMEMODE.OrganizationData[ playerOrg ] then return end
	if tonumber(GAMEMODE.OrganizationData[ playerOrg ][4]) ~= Player.PERPID then return end
	
	local sPlayer
	for k, v in pairs( player.GetAll() ) do
		if v:SteamID() == Args[1] then
			sPlayer = v
		end
	end

	if not sPlayer then -- Silent kick, aka player is offline
		tmysql.query( Format( Query( "SELECTID" ), Args[1] ), function( Results, Status, ErrorMsg )
			if not (Results and Results[1]) then return end
			for k, v in pairs(Results) do
				tmysql.query( Format( Query( "FINDORGMEMBER" ), v.id ), function( Results, Status, ErrorMsg )
					if Results[1] and tonumber( Results[1][ "organization" ] ) == playerOrg then -- Results are in strings, need to tonumber the value :)
						tmysql.query( Format( Query( "SETORGANISATION" ), 0, Args[1] ) )

						Player:Notify( "You have kicked " .. Results[1][ "rp_name_first" ] .. " " .. Results[1][ "rp_name_last" ] .. " out of your org." )

						for _, v in pairs( player.GetAll() ) do
							if v:GetGNWVar( "org", 0 ) == playerOrg then
								net.Start( "perp_rod_c" )
									net.WriteInt( playerOrg, 16 )
									net.WriteString( Args[1] )
								net.Send(v)
							end
						end

						for k, v in pairs( GAMEMODE.OrganizationData[ playerOrg ][5] ) do
							if v[2] == Args[1] then
								GAMEMODE.OrganizationData[ playerOrg ][5][k] = nil
							end
						end
					end
				end, QUERY_FLAG_ASSOC )
			end
		end)
	else
		if sPlayer:GetGNWVar( "org", 0 ) ~= playerOrg then return end

		Player:Notify( "You have kicked " .. sPlayer:GetRPName() .. " out of your org." )
		sPlayer:Notify( "You have been kicked out of " .. GAMEMODE.OrganizationData[ playerOrg ][1] .. "." )
		sPlayer:SetGNWVar( "org", nil )

		for k, v in pairs( GAMEMODE.OrganizationData[ playerOrg ][5] ) do
			if v[2] == sPlayer.PERPID then
				GAMEMODE.OrganizationData[ playerOrg ][5][k] = nil
			end
		end

		net.Start( "perp_cleany_org" )
			net.WriteInt( playerOrg, 16 )
		net.Send(sPlayer)

		tmysql.query( Format( Query( "SETORGANISATION" ), 0, Player.PERPID ) )
		
		for _, v in pairs( player.GetAll() ) do
			if v:GetGNWVar( "org", 0 ) == playerOrg then
				net.Start( "perp_rod_c" )
					net.WriteInt( playerOrg, 16 )
					net.WriteString( sPlayer.PERPID )
				net.Send(v)
			end
		end
	end
end )

/*************************************************
	Command "perp_o_a"
	Job: Accept Invite
*************************************************/

concommand.Add( "perp_o_a", function( Player, Command, Args )
	if Player:GetGNWVar( "org", 0 ) ~= 0 then return end
	if not Player.invitedTo or not Player.invitedBy then return end
	
	Player:SetGNWVar( "org", Player.invitedTo )
	
	if IsValid( Player.invitedBy ) then
		Player.invitedBy:Notify( Player:GetRPName() .. " has accepted your invitation." )
	end

	tmysql.query( Format( Query( "SETORGANISATION" ), Player.invitedTo, Player.PERPID ) )

	table.insert( GAMEMODE.OrganizationData[ Player.invitedTo ][5], { Player:GetRPName(), Player.PERPID } )

	for _, v in pairs( player.GetAll() ) do
		if v:GetGNWVar( "org", 0 ) == Player.invitedTo and v ~= Player then			
			net.Start( "perp_rod_m" )
				net.WriteInt( Player.invitedTo, 16 )
				net.WriteString( Player:GetRPName() )
				net.WriteString( Player.PERPID )
			net.Send(v)
		end
	end

	net.Start( "perp_rod" )
		net.WriteInt( Player.invitedTo, 16 )
		net.WriteString( GAMEMODE.OrganizationData[ Player.invitedTo ][1] )
		net.WriteString( GAMEMODE.OrganizationData[ Player.invitedTo ][3] )
		net.WriteBool( false )
	net.Send(Player)

	net.Start( "perp_rod_mod" )
		net.WriteInt( Player.invitedTo, 16 )
		net.WriteString( GAMEMODE.OrganizationData[ Player.invitedTo ][2] )
	net.Send(Player)

	for _, v in pairs( GAMEMODE.OrganizationData[ Player.invitedTo ][5] ) do
		net.Start( "perp_rod_m" )
			net.WriteInt( Player.invitedTo, 16 )
			net.WriteString( v[1] )
			net.WriteString( v[2] )
		net.Send(Player)
	end
	
	Player.invitedTo = nil
	Player.invitedBy = nil
end )

/*************************************************
	Command "perp_o_n"
	Job: Create Organization
*************************************************/

local OrgCost = 5000

concommand.Add( "perp_o_n", function( Player )
	if not Player:NearNPC( 1 ) then Player:CaughtCheating( "Trying to make org without being near NPC.", EXPLOIT_POSSIBLETHREAT ) end

	if Player:GetCash() < OrgCost then return end

	local Log = Format( "%s spent $%s on a new organization", Player:Nick(), util.FormatNumber( OrgCost ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( OrgCost, true )

	tmysql.query( Format( Query( "CREATEORGANISATION" ), Player.PERPID ) )

	-- Find a better way to do this, can we get an mysql reply when we make an organisation rather than using another query? :/

	Player:Notify( "Making your Organization, please wait..." )
	Player:Lock()

	tmysql.query( Format( Query( "FINDORGANISATION" ), Player.PERPID, Player.PERPID ), function( Results, Status, ErrorMsg )
		if not Results[1] then
			local Log = Format( "%s's org was not created properly, refund of $%s was given", Player:Nick(), util.FormatNumber( OrgCost ) )
			GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

			Player:GiveCash( OrgCost, true )
			Player:Notify( "There was an error, try again." )

			Player:UnLock()
			return
		end

		Player:Notify( "Organization was successfully made!" )
		Player:UnLock()

		Player:PERPSave()

		Player:SetAchievementStatus("ownorganization",Player:GetAchievementStatus("ownorganization")+1)

		Player:SetGNWVar( "org", tonumber( Results[1][ "id" ] ) )

		tmysql.query( Format( Query( "SETORGANISATION" ), Results[1][ "id" ], Player.PERPID ) )

		local ownerName = Player:GetGNWVar( "rp_fname", "Joe" ) .. " " .. Player:GetGNWVar( "rp_lname", "Doe" )

		GAMEMODE.OrganizationData[ tonumber( Results[1][ "id" ] ) ] = { "New Organization", "No Current MOTD", ownerName, Player.PERPID, {} }
		table.insert( GAMEMODE.OrganizationData[ tonumber( Results[1][ "id" ] ) ][5], { ownerName, Player.PERPID } )

		for _, v in pairs( player.GetAll() ) do
			if v == Player then continue end
			net.Start( "perp_srod" )
			net.WriteInt( Results[1][ "id" ], 16 )
			net.WriteString( "New Organization" )
			net.Broadcast()
		end

		net.Start( "perp_rod", Player )
			net.WriteInt( Results[1][ "id" ], 16 )
			net.WriteString( "New Organization" )
			net.WriteString( ownerName )
			net.WriteBool( true )
		net.Send(Player)

		net.Start( "perp_rod_mod" )
			net.WriteInt( Results[1][ "id" ], 16 )
			net.WriteString( "No Current MOTD" )
		net.Send(Player)

		net.Start( "perp_rod_m" )
			net.WriteInt( Results[1][ "id" ], 16 )
			net.WriteString( ownerName )
			net.WriteString( Player.PERPID )
		net.Send(Player)
	end, QUERY_FLAG_ASSOC )

end )

/*************************************************
	Command "perp_o_q"
	Job: Leave Organization
*************************************************/

concommand.Add( "perp_o_q", function( Player )
	if not Player:NearNPC( 1 ) then return Player:CaughtCheating( "Trying to leave org without being near NPC.", EXPLOIT_POSSIBLETHREAT ) end

	if Player:GetGNWVar( "org", 0 ) == 0 then return end
	
	local orgID = Player:GetGNWVar( "org", 0 )
	
	if not GAMEMODE.OrganizationData[ orgID ] then return end
	
	if Player.PERPID == GAMEMODE.OrganizationData[ orgID ][4] then
		for _, v in pairs( player.GetAll() ) do
			if v:GetGNWVar( "org", 0 ) == orgID then
				if v ~= Player then
					v:Notify( GAMEMODE.OrganizationData[ orgID ][1] .. " has been disbaned." )
				end

				v:SetGNWVar( "org", nil )
			end
		end

		GAMEMODE.OrganizationData[ orgID ] = nil

		Player:Notify( "You've disbanded your organization." )

		tmysql.query( Format( Query( "DISBANDORGANISATION" ), orgID ) )

		tmysql.query( Format( Query( "DELETEORGANISATION" ) , orgID ) )
	else		
		Player:SetGNWVar( "org", nil )
		tmysql.query( Format( Query( "SETORGANISATION" ), 0, Player.PERPID ) )
		
		net.Start( "perp_cleany_org" )
			net.WriteInt( orgID, 16 )
		net.Send(Player)

		Player:Notify( "You've left your organization." )
		
		for _, v in pairs( player.GetAll() ) do
			if v:GetGNWVar( "org", 0 ) == orgID then
				net.Start( "perp_rod_c" )
					net.WriteInt( orgID, 16 )
					net.WriteString( Player.PERPID )
				net.Send(v)
			end
		end
	end
end )