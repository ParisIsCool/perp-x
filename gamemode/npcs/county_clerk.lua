--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local NPC = {}

NPC.Name = "County Clerk"
NPC.ID = 1

NPC.Model = Model( "models/humans/Group01/female_02.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(2510,5054,0),ang=Angle(2,1,0)},
}
NPC.NoTalkSequence = true

--Vector( 4072.5927734375, -4607.8759765625, 264.03125 ), Angle( 1.3519706726074, 90.938896179199, 0)
NPC.Location[ "rp_florida_v2" ] = {Vector( 4072.5927734375, -4607.8759765625, 264.03125 ),}
NPC.Angles[ "rp_florida_v2" ] = {Angle( 1.3519706726074, 90.938896179199, 0),}

NPC.Location['rp_evocity2_v3p'] = Vector(-238.86883544922, -1944.7945556641, 76.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, -180, 0)

NPC.Location["rp_evocity_v33x"] = Vector( -7252, -9220, 72 )
NPC.Angles["rp_evocity_v33x"] = Angle( 0, 90, 0 )

NPC.Location["rp_evocity_v4b1"] = Vector( -7252, -9220, 72 )
NPC.Angles["rp_evocity_v4b1"] = Angle( 0, 90, 0 )

NPC.Location ['rp_rockford_v1b'] = { Vector(-4749.326172, -5163.968750, 65.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, -90.639725, 0.000000) }

NPC.Location ['rp_rockford_v2b'] = { Vector(-4705.9409179688, -5163.96875, 64.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) }

--Vector( -4705.9409179688, -5163.96875, 64.03125 ), Angle( 0.5599467754364, -90.032043457031, 0)


NPC.Location['rp_paralake_city_v3'] = {
	Vector(-4747.8984375, 11392.387695313, 416.03125),
	Vector( -4751.96875, 11067.927734375, 416.03125 ),
}

NPC.Angles['rp_paralake_city_v3'] = {
	Angle(0, 180, 0),
	Angle(0, 180, 0),
}

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 3626.6892089844, -4430.9174804688, -1868.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, 90, 0 ) }

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Welcome to the County Clerk's office, how many I help you?" )

	if LocalPlayer():GetGNWVar( "org", 0 ) == 0 then
		GAMEMODE.DialogPanel:AddDialog( "I'd like to register an organization, please.", NPC.Chat2 )
	elseif GAMEMODE.OrganizationData and GAMEMODE.OrganizationData[ LocalPlayer():GetGNWVar( "org", 0 ) ] and GAMEMODE.OrganizationData[ LocalPlayer():GetGNWVar( "org", 0 ) ][4] then
		GAMEMODE.DialogPanel:AddDialog( "I'd like to disband my organization, please.", NPC.Chat4 )
	else
		GAMEMODE.DialogPanel:AddDialog( "I'd like to leave my organization, please.", NPC.Chat6 )
	end

	GAMEMODE.DialogPanel:AddDialog( "What is the process of getting a name change?", NPC.NameChange )

	if LocalPlayer():Team() == TEAM_CITIZEN then
		if GAMEMODE.IsRunningForMayor then
			GAMEMODE.DialogPanel:AddDialog( "I'd like to retract my bid for mayordom.", NPC.RunForMayor )
		else
			GAMEMODE.DialogPanel:AddDialog( "I'd like to run for mayor.", NPC.RunForMayor )
		end

		GAMEMODE.DialogPanel:AddDialog( "Is the city looking for any Secret Service agents?", NPC.AskAboutSS )
	elseif LocalPlayer():Team() == TEAM_SS then
		local jobinfo = JOB_DATABASE[LocalPlayer():Team()]
		if LocalPlayer():GetGNWVar( "Vehicle" ) and IsValid(Entity(LocalPlayer():GetGNWVar( "Vehicle" ))) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to put my vehicle in the garage.", function() NPC.GarageVehicle() end)
		end
		for k, v in pairs(jobinfo.Vehicles) do
			GAMEMODE.DialogPanel:AddDialog("Give me the " .. v.Nickname .. ", please! ", function() NPC.RequestCar(v) end)
		end
		GAMEMODE.DialogPanel:AddDialog( "I'd like to resign from my post as a Secret Service agent.", NPC.QuitSS )
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		local jobinfo = JOB_DATABASE[LocalPlayer():Team()]
		if LocalPlayer():GetGNWVar( "Vehicle" ) and IsValid(Entity(LocalPlayer():GetGNWVar( "Vehicle" ))) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to put my vehicle in the garage.", function() NPC.GarageVehicle() end)
		end
		for k, v in pairs(jobinfo.Vehicles) do
			GAMEMODE.DialogPanel:AddDialog("Give me the " .. v.Nickname .. ", please! ", function() NPC.RequestCar(v) end)
		end
		GAMEMODE.DialogPanel:AddDialog( "I'm here to resign as mayor.", NPC.MayorLeave )
	end

	GAMEMODE.DialogPanel:AddDialog( "Nevermind... Sorry for bothering you.", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.RequestCar(vehicle)
	local numSquadCars = 0
	local OwnCar = NULL
	local jobinfo = JOB_DATABASE[LocalPlayer():Team()]

	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )


			if VehicleTable and VehicleTable.RequiredClass == TEAM_POLICE then
				numSquadCars = numSquadCars + 1
			end
		end
	end

	if numSquadCars >= jobinfo.MaxVehicles and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the squad cars are taken.\n\n(All squad cars are taken wait until someone who is using one quits the force.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your squad car can be found on the sidewalk outside of the Government Center.)")

		GAMEMODE:RequestJobVehicle(vehicle.ID)

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end

function NPC.Chat2()
	GAMEMODE.DialogPanel:SetDialog( "Wonderful! There will be a five thousand dollar filing fee which is only taken in cash is that okay?" )

	if LocalPlayer():GetCash() >= 5000 then
		GAMEMODE.DialogPanel:AddDialog( "Sure, that sounds great.", NPC.Chat3 )
		GAMEMODE.DialogPanel:AddDialog( "Ehh... That seems a tad expensive. I'll have to pass.", LEAVE_DIALOG )
	elseif LocalPlayer():GetCash() + LocalPlayer():GetBank() >= 5000 then
		GAMEMODE.DialogPanel:AddDialog( "I don't have enough cash on me... Damn beaurocracy.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:AddDialog( "Looks like I can't aford it... Damn beaurocracy.", LEAVE_DIALOG )
	end
end

function NPC.Chat3()
	GAMEMODE.DialogPanel:SetDialog( "(3 Hours Later...) Alright, all the paper work is done. Have a nice day.\n\n[ You can open the Organizations tab with F3. ]" )

	RunConsoleCommand( "perp_o_n" )

	GAMEMODE.DialogPanel:AddDialog( "Thank you!", LEAVE_DIALOG )
end

function NPC.Chat4()
	GAMEMODE.DialogPanel:SetDialog( "Are you sure? Once I file the paperwork, I can't reform your organization.\n\n[ WARNING: You CANNOT undo this. ]" )

	GAMEMODE.DialogPanel:AddDialog( "Yes, I'm sure.", NPC.Chat5 )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind. I need to think about it more.", LEAVE_DIALOG )
end

function NPC.Chat5()
	GAMEMODE.DialogPanel:SetDialog( "Okay, I'll file the paperwork immediately." )

	RunConsoleCommand( "perp_o_q" )

	GAMEMODE.DialogPanel:AddDialog( "Thank you.", LEAVE_DIALOG )
end

function NPC.Chat6()
	GAMEMODE.DialogPanel:SetDialog( "Okay, I'll remove you from the organization roster. Have a nice day." )

	RunConsoleCommand( "perp_o_q" )

	GAMEMODE.DialogPanel:AddDialog( "Thank you.", LEAVE_DIALOG )
end

function NPC.NameChange()
	GAMEMODE.DialogPanel:SetDialog( "It's a simple matter of you paying a nominal filing fee of $" ..  util.FormatNumber( GAMEMODE.RenamePrice ) .. " and telling us the name that you want." )

	if LocalPlayer():GetCash() >= GAMEMODE.RenamePrice then
		GAMEMODE.DialogPanel:AddDialog( "Okay, let's do it.", NPC.DoNameChange )
	end

	GAMEMODE.DialogPanel:AddDialog( "That seems a little too expensive...", LEAVE_DIALOG )
end

function NPC.GarageVehicle()
	GAMEMODE.DialogPanel:SetDialog("Ok your vehicle is in the garage now!")

	GAMEMODE.DialogPanel:AddDialog("Thanks, Cya around!", LEAVE_DIALOG)

	GAMEMODE:RequestHolsterJobVehicle()
end


function NPC.DoNameChange()
	ShowRenamePanel()
	LEAVE_DIALOG()
end

function NPC.RunForMayor()
	local Blacklist = LocalPlayer():HasBlacklist( "job", "Mayor" )

	if team.NumPlayers( TEAM_MAYOR ) > 0 then
		GAMEMODE.DialogPanel:SetDialog( "We already have a mayor, so you'll need to wait for the next election cycle.")
		GAMEMODE.DialogPanel:AddDialog( "Okay, I'll check back later.", LEAVE_DIALOG )
		return
	elseif LocalPlayer():Team() ~= TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog( "Unfortunately you cannot run for mayor while serving as a government official. Conflict of interests, unfortunately.\n\n(If you wish to run for mayor, you must first quit your other job.)" )
		GAMEMODE.DialogPanel:AddDialog( "Oh, okay.", LEAVE_DIALOG )
		return
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog( "We do not allowed people with an active warrant to run for mayor.\n\n(You have a warrant you must get rid of it before running for mayor.)" )
		GAMEMODE.DialogPanel:AddDialog( "Oh, okay.", LEAVE_DIALOG )
		return
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I'm afraid you've reached your term limits\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog( "Oh, right...", LEAVE_DIALOG )
	elseif LocalPlayer():GetTimePlayed() < JOB_DATABASE[TEAM_MAYOR].RequiredTime * 60 * 60 and not LocalPlayer():IsVIP() then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. JOB_DATABASE[TEAM_MAYOR].RequiredTime .. " hours of play time or VIP to be a mayor.)" )

		GAMEMODE.DialogPanel:AddDialog( "Alright. I'll check back in later, then.", LEAVE_DIALOG )
	elseif GAMEMODE.IsRunningForMayor then
		GAMEMODE.DialogPanel:SetDialog( "Okay, I've taken your name off of the ballot." )
		GAMEMODE.DialogPanel:AddDialog( "Okay, thank you.", LEAVE_DIALOG )
		GAMEMODE.IsRunningForMayor = nil

		RunConsoleCommand( "perp_g_b" )
	else
		GAMEMODE.IsRunningForMayor = true
		GAMEMODE.DialogPanel:SetDialog( "Okay, I've added your name to the ballot." )
		GAMEMODE.DialogPanel:AddDialog( "Okay, thank you.", LEAVE_DIALOG )

		RunConsoleCommand( "perp_g_b" )
	end
end

function NPC.AskAboutSS()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local SSNumber = team.NumPlayers( TEAM_SECRET_SERVICE )

	local Blacklist = LocalPlayer():HasBlacklist( "job", "Secret Service" )

	if team.NumPlayers( TEAM_MAYOR ) == 0 then
		GAMEMODE.DialogPanel:SetDialog( "We do not currently have a mayor - what would be the point in protecting someone who doesn't exist?" )

		GAMEMODE.DialogPanel:AddDialog( "I guess that makes sense...", LEAVE_DIALOG )
	elseif SSNumber >= JOB_DATABASE[TEAM_FBI].MaxPlayers then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, we're not currently looking to hire any new secret service agents.\n\n(This class is full. Try again later.)" )

		GAMEMODE.DialogPanel:AddDialog( "Alright. I'll check back in later, then.", LEAVE_DIALOG )
	elseif LocalPlayer():IsWarrented()then
		GAMEMODE.DialogPanel:SetDialog( "We do not allow criminals to serve as government officials.\n\n(You have a warrant you must get rid of it before becoming a police officer.)" )

		GAMEMODE.DialogPanel:AddDialog( "Oh, okay...", LEAVE_DIALOG )
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I'm afraid you've reached your term limits\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog( "Oh, right...", LEAVE_DIALOG )
	elseif LocalPlayer():GetTimePlayed() < JOB_DATABASE[TEAM_SS].RequiredTime * 60 * 60 and not LocalPlayer():IsVIP() then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. JOB_DATABASE[TEAM_SS].RequiredTime .. " hours of play time or VIP to be an officer.)" )

		GAMEMODE.DialogPanel:AddDialog( "Alright. I'll check back in later, then.", LEAVE_DIALOG )
	elseif GAMEMODE.IsRunningForMayor then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but people running for mayordom cannot be hired by the city due to legal issues." )

		GAMEMODE.DialogPanel:AddDialog( "Oh, that's lame.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "Yes, of course. Welcome to the ChaosCity branch of the Secret Service. As a member of the secret service, you are tasked with the protection of the mayor at all cost. You will also have, if the mayor so chooses to supply you with one, a stretch limo that you can use to help the mayor travel about the city.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)" )

		GAMEMODE:RequestJobJoin(TEAM_SS)

		GAMEMODE.DialogPanel:AddDialog( "Thank you. I'll get my suit on!", LEAVE_DIALOG )
	end
end

function NPC.QuitSS()
	LEAVE_DIALOG()

	GAMEMODE:RequestJobLeave()
end

function NPC.GrabLimo()
	local numSquadCars = 0

	if IsValid( LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL ) then
		numSquadCars = numSquadCars + 1
	end

	if GAMEMODE.MaxVehicles[ "SecretService" ] == 0 then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but the Tahoe is out for repairs.\n\n(The mayor has not chosen to fund a escalade/limo for the Secret Service.)" )

		GAMEMODE.DialogPanel:AddDialog( "Okay, I'll check back later.", LEAVE_DIALOG )
	elseif numSquadCars >= GAMEMODE.MaxVehicles[ "SecretService" ] then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but the Tahoe is already out. Try calling your partner, perhaps?" )

		GAMEMODE.DialogPanel:AddDialog( "Good idea.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "Sure, here are the keys.\n\n(The Tahoe can be found on the sidewalk outside of the Government Center.)" )

		RunConsoleCommand( "perp_ss_c" )

		GAMEMODE.DialogPanel:AddDialog( "Thank you!", LEAVE_DIALOG )
	end
end

function NPC.GrabEscalade()
	local numSquadCars = 0

	if IsValid( LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL ) then
		numSquadCars = numSquadCars + 1
	end

	if GAMEMODE.MaxVehicles[ "SecretService" ] == 0 then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but the escalade is out for repairs.\n\n(The mayor has not chosen to fund a escalade/limo for the Secret Service.)" )

		GAMEMODE.DialogPanel:AddDialog( "Okay, I'll check back later.", LEAVE_DIALOG )
	elseif numSquadCars >= GAMEMODE.MaxVehicles[ "SecretService" ] then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but the escalade is already out. Try calling your partner, perhaps?" )

		GAMEMODE.DialogPanel:AddDialog( "Good idea.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "Sure, here are the keys.\n\n(The escalade can be found on the sidewalk outside of the Government Center.)" )

		RunConsoleCommand( "perp_ss_esc" )

		GAMEMODE.DialogPanel:AddDialog( "Thank you!", LEAVE_DIALOG )
	end
end

function NPC.GrabLimo2()
	local numSquadCars = 0

	if IsValid( LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL ) then
		numSquadCars = numSquadCars + 1
	end

	if GAMEMODE.MaxVehicles[ "SecretService" ] == 0 then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but the limo is out for repairs.\n\n(The mayor has not chosen to fund a limo for the Secret Service.)" )

		GAMEMODE.DialogPanel:AddDialog( "Okay, I'll check back later.", LEAVE_DIALOG )
	elseif numSquadCars >= GAMEMODE.MaxVehicles[ "SecretService" ] then
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but the limo is already out. Try calling your partner, perhaps?" )

		GAMEMODE.DialogPanel:AddDialog( "Good idea.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "Sure, here are the keys.\n\n(The limo can be found on the sidewalk outside of the Government Center.)" )

		RunConsoleCommand( "perp_ss_climo" )

		GAMEMODE.DialogPanel:AddDialog( "Thank you!", LEAVE_DIALOG )
	end
end

function NPC.MayorLeave( )
	GAMEMODE:RequestJobLeave()

	GAMEMODE.DialogPanel:SetDialog( "Alright, I have removed you from the city's system..\n\n(You are no longer mayor.)" )

	GAMEMODE.DialogPanel:AddDialog( "Okay, Thanks.", LEAVE_DIALOG )
end

GAMEMODE:LoadNPC( NPC )
