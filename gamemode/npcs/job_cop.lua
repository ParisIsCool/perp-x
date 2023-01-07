--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

//Suported Maps
//rp_rockford_v2b, rp_rockford_v1b, rp_evocity_v4b1, rp_evocity2_v3p, rp_evocity_v33x, rp_paralake_city_v3, rp_chaos_city_v33x_03

local NPC = {}

NPC.Name = "Police Department"
NPC.ID = 11

NPC.Model = Model("models/preytech/perp/players/npcs/perp_cop.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(7881,8034,200),ang=Angle(1,-91,0)},
}

--Vector( 6567.9697265625, -2637.4426269531, 136.03125 ), Angle( -0.36419582366943, -178.37831115723, 0)
NPC.Location ['rp_florida_v2'] = {Vector( 6567.9697265625, -2637.4426269531, 136.03125 ),}
NPC.Angles ['rp_florida_v2'] = {Angle( 0, -180, 0),}

NPC.Location['rp_evocity2_v3p'] = Vector(-631.70190429688, -1686.6306152344, -427.96875)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector(-6997, -8858, -431)
NPC.Angles['rp_evocity_v33x'] = Angle(0, -90, 0)

NPC.Location['rp_evocity_v4b1'] = Vector(-6919.362305, -9094.312500, -430)
NPC.Angles['rp_evocity_v4b1'] = Angle(0, 140, 0)

NPC.Location ['rp_rockford_v1b'] = { Vector(-7567.968750, -5723.729980, 10.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle( 0, -180, 0.000000) }

--Vector( -8714.3896484375, -5587.96875, 8.03125 ), Angle( -2.8726658821106, -88.486183166504, 0)

NPC.Location ['rp_rockford_v2b'] = { Vector( -8676.2724609375, -5587, 8.03125 ) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) }

--Vector( -8676.2724609375, -5587.96875, 8.03125 ), Angle( 0.03190042078495, -89.565086364746, 0)


NPC.Location['rp_paralake_city_v3'] = Vector(-8978.6650390625, 10604.016601563, 288.03125)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 90, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 3858, -4079, -2372 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, -90, 0 ) }


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_POLICE or LocalPlayer():Team() == TEAM_SWAT or LocalPlayer():Team() == TEAM_DISPATCHER then
		GAMEMODE.DialogPanel:SetDialog("Are you here to quit?")

		if (LocalPlayer():Team() == TEAM_POLICE) then
			GAMEMODE.DialogPanel:AddDialog("No, I just want to find out where my cop car is!", NPC.SquadCar)
		elseif (LocalPlayer():Team() == TEAM_SWAT) then
			GAMEMODE.DialogPanel:AddDialog("No... I was just wondering where I can pick up my SWAT vehicle?", NPC.SWATVan)
		end
		GAMEMODE.DialogPanel:AddDialog("I need more ammo!", function() 
            LEAVE_DIALOG()
            GAMEMODE:RequestJobAmmo()
        end)
		GAMEMODE.DialogPanel:AddDialog("Actually, yes. Here's my badge.", NPC.QuitJob)
		GAMEMODE.DialogPanel:AddDialog("Errr... No...", NPC.Relief)
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!")

		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG)

//Civ first menu
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Welcome to the Southside Police Department!\n\nHow can I help you?")

		GAMEMODE.DialogPanel:AddDialog("I'd like to become a police officer.", NPC.HirePolice)
		--GAMEMODE.DialogPanel:AddDialog("I'm interested in becoming a S.W.A.T Officer.", NPC.HireSWAT)
		--GAMEMODE.DialogPanel:AddDialog("Are you looking for any 911 Operators?", NPC.HireDispatcher)
		GAMEMODE.DialogPanel:AddDialog("You can't help me, no body can help me! ", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Hello, sir.")

		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.QuitJob()
	LEAVE_DIALOG()

	GAMEMODE:RequestJobLeave()
end

function NPC.Relief()
	GAMEMODE.DialogPanel:SetDialog("Oh... In that case, hey! What can I do for you?")

	GAMEMODE.DialogPanel:AddDialog("Nothing...", LEAVE_DIALOG)
end

function NPC.HirePolice()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local PoliceNumber = team.NumPlayers(TEAM_POLICE)

	local Blacklist = LocalPlayer():HasBlacklist( "job", "Police" )

	if LocalPlayer():IsOwner() then
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your uniform, firearm, and hand cuffs. (If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		GAMEMODE:RequestJobJoin(TEAM_POLICE)

		GAMEMODE.DialogPanel:AddDialog("On my honor, I would never betray my badge, integrity, character, or public trust.", LEAVE_DIALOG)
	elseif (PoliceNumber >= GAMEMODE.MaxJobs[ TEAM_POLICE ]) then
		GAMEMODE.DialogPanel:SetDialog("We apologize. There's been a mistake, see, we don't have any positions currently available at our department. Maybe next time?\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Aww shucks, I'll check back in later.", LEAVE_DIALOG)
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials. (You have a warrant you must get rid of it before becoming a police officer.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < JOB_DATABASE[TEAM_POLICE].RequiredTime * 60 * 60 and !LocalPlayer():IsVIP()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. JOB_DATABASE[TEAM_POLICE].RequiredTime .. " hours of play time or VIP to be an officer.)")

		GAMEMODE.DialogPanel:AddDialog("Shoot, okay then..", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.")

		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG)
	elseif IsValid( ourVehicle ) then
		GAMEMODE.DialogPanel:SetDialog( "You need to put your vehicle into your garage before you can become a police officer." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your uniform, firearm, and hand cuffs. (If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		GAMEMODE:RequestJobJoin(TEAM_POLICE)

		GAMEMODE.DialogPanel:AddDialog("On my honor, I would never betray my badge, integrity, character, or public trust.", LEAVE_DIALOG)
	end
end

function NPC.HireSWAT()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local PoliceNumber = team.NumPlayers(TEAM_SWAT)

	local Blacklist = LocalPlayer():HasBlacklist( "job", "SWAT" )

	if LocalPlayer():IsOwner() then
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your body armor, MP5, and Service Pistol. You will be required to answer all calls by the mayor or Police Officers in danger. \n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_s_j')

		GAMEMODE.DialogPanel:AddDialog("On my honor, I would never betray my badge, integrity, character, or public trust.", LEAVE_DIALOG)
	elseif (PoliceNumber >= GAMEMODE.MaxJobs[TEAM_SWAT] and !LocalPlayer():IsSuperAdmin()) then
		if table.Count(player.GetAll()) >= GAMEMODE.MinimumForSWAT then
			GAMEMODE.DialogPanel:SetDialog("It appears that our SWAT team is filled.\n\n(This class is full. Try again later.)")
		else
			GAMEMODE.DialogPanel:SetDialog("There is no SWAT team currently in action.\n\n(SWAT requires at least " .. GAMEMODE.MinimumForSWAT .. " players in the server.)")
		end

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (team.NumPlayers(TEAM_CHIEF) == 0) then
		GAMEMODE.DialogPanel:SetDialog("There needs to be a Police Chief for you to go on SWAT!")

		GAMEMODE.DialogPanel:AddDialog("Boo, hiss.", LEAVE_DIALOG)
	elseif #player.GetAll() < GAMEMODE.MinimumForSWAT then
		GAMEMODE.DialogPanel:SetDialog( "There's not enough players to need SWAT, requires 15 players." )

		GAMEMODE.DialogPanel:AddDialog( "Oh ok...", LEAVE_DIALOG )
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrant you must get rid of it before becoming a SWAT team member.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif ((LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_SWAT * 60 * 60 or !LocalPlayer():IsVIP()) and !LocalPlayer():IsAdmin()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_SWAT .. " hours of play time and VIP to be a SWAT officer.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.")

		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG)
	elseif IsValid( ourVehicle ) then
		GAMEMODE.DialogPanel:SetDialog( "You need to put your vehicle into your garage before you can become a SWAT member." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your body armor, MP5, and Service Pistol. You will be required to answer all calls by the mayor or Police Officers in danger.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_s_j')

		GAMEMODE.DialogPanel:AddDialog("On my honor, I would never betray my badge, integrity, character, or public trust.", LEAVE_DIALOG)
	end
end

function NPC.HireDispatcher()
	local PoliceNumber = team.NumPlayers(TEAM_DISPATCHER)

	local Blacklist = LocalPlayer():HasBlacklist( "job", "Dispatcher" )

	if (PoliceNumber >= GAMEMODE.MaxJobs[ TEAM_DISPATCHER ] and !LocalPlayer():IsSuperAdmin()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, we have more than enough.\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrant you must get rid of it before becoming a police operator.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_Dispatcher * 60 * 60 and !LocalPlayer():IsVIP()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_Dispatcher .. " hours of play time and VIP to be a police operator.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.")

		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG)
	elseif (!LocalPlayer():HasItem("item_phone")) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you know how to use a phone?...\n\n(You need a phone to use this job.)")

		GAMEMODE.DialogPanel:AddDialog("What is a phone?", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Your job is to answer calls from people in distress. We will route all incoming calls directly to your cells phones, so you can work from home if need be.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_di_j')

		GAMEMODE.DialogPanel:AddDialog("I'll serve to my best ability, sir!", LEAVE_DIALOG)
	end
end

--STEANDARD EVO OR CROWNVIC
function NPC.SquadCar()
	GAMEMODE.DialogPanel:SetDialog("You can find your vehicle by talking to our attendant in the parking lot.")

	GAMEMODE.DialogPanel:AddDialog("Sweet, thanks!", LEAVE_DIALOG)
end

function NPC.SWATVan()
	GAMEMODE.DialogPanel:SetDialog("You can find your vehicle by talking to our attendant in the parking lot.")

	GAMEMODE.DialogPanel:AddDialog("Awesome dude! I'll go now!", LEAVE_DIALOG)
end

GAMEMODE:LoadNPC(NPC)

//Original Text for Menu
//On my honor, I would never betray my badge, integrity, character, or public trust.\nI will always uphold the constitution, my community, and the agency I serve.
