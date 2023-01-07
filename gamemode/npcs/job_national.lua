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

NPC.Name = "National Guard"
NPC.ID = 257

NPC.Model = Model("models/aa3hacks/aa3male01_npc.mdl")

NPC.Location, NPC.Angles = {}, {}

--Vector( -3519.5720214844, -5008.03125, 64.03125 ), Angle( -0.62801694869995, -88.160339355469, 0)

NPC.Location ['rp_rockford_v2b'] = { Vector( -3519.5720214844, -5008.03125, 64.03125 ) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) }


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_POLICE or LocalPlayer():Team() == TEAM_SWAT or LocalPlayer():Team() == TEAM_DISPATCHER or LocalPlayer():Team() == TEAM_NATIONAL then
		
		if LocalPlayer():Team() == TEAM_NATIONAL then
		
			GAMEMODE.DialogPanel:SetDialog("Are you here to quit?.")
			GAMEMODE.DialogPanel:AddDialog("No... I wanted ammo.", NPC.Ammo)
			GAMEMODE.DialogPanel:AddDialog("No... I wanted a vehicle.", NPC.Vehicles)
			GAMEMODE.DialogPanel:AddDialog("Yes. I'm quitting, bitchass. <quit>", NPC.QuitJob)
			GAMEMODE.DialogPanel:AddDialog("No, just joshin with ya, hehe.", LEAVE_DIALOG)
			
		else
			GAMEMODE.DialogPanel:SetDialog("Hello Sir.")
			GAMEMODE.DialogPanel:AddDialog("Good day.", LEAVE_DIALOG)
		end
		
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!")
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG)

//Civ first menu
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Welcome to the Rockford Detachment of the National Guard !\n\nHow can I help you?")

		GAMEMODE.DialogPanel:AddDialog("I'd like to join the National Guard.", NPC.HireGuard)
		GAMEMODE.DialogPanel:AddDialog("You can't help me, no body can help me! ", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Hello, sir.")

		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.QuitJob()
	LEAVE_DIALOG()
	RunConsoleCommand('perp_nationalguard_q')
end

function NPC.Vehicles()
	
	GAMEMODE.DialogPanel:SetDialog("Oh ok... Heres your options.")
	
	GAMEMODE.DialogPanel:AddDialog("MRAP (Bulletproof)", NPC.Nat1)
	GAMEMODE.DialogPanel:AddDialog("Humvee (Bulletproof)", NPC.Nat2)
	GAMEMODE.DialogPanel:AddDialog("Nvm...", LEAVE_DIALOG)
	
end

function NPC.Nat1()
	local numChiefCars = 0
	local OwnCar = NULL

	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )

			if VehicleTable and VehicleTable.RequiredClass == TEAM_NATIONAL then
				numChiefCars = numChiefCars + 1
			end
		end
	end

	if numChiefCars >= GAMEMODE.MaxVehicles[ "NationalGuard" ] and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the vehicles are taken.")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Your vehicle is waiting outside!")

		RunConsoleCommand('perp_nationalguard_1')

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end

function NPC.Nat2()
	local numChiefCars = 0
	local OwnCar = NULL

	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )

			if VehicleTable and VehicleTable.RequiredClass == TEAM_NATIONAL then
				numChiefCars = numChiefCars + 1
			end
		end
	end

	if numChiefCars >= GAMEMODE.MaxVehicles[ "NationalGuard" ] and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the vehicles are taken.")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Your vehicle is waiting outside!")

		RunConsoleCommand('perp_nationalguard_2')

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end

function NPC.HireGuard()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local PoliceNumber = team.NumPlayers(TEAM_NATIONAL)

	local Blacklist = LocalPlayer():HasBlacklist( "job", "NationalGuard" )

	if LocalPlayer():IsOwner() then
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your uniform, firearm, and hand cuffs. (If you abuse your new-found power, you will be blacklisted and possibly banned.)")
	
		RunConsoleCommand('perp_nationalguard_j')
	
		GAMEMODE.DialogPanel:AddDialog("On my honor, I would never betray my badge, integrity, character, or public trust.", LEAVE_DIALOG)
	elseif team.NumPlayers( TEAM_MAYOR ) == 0 then
	--if team.NumPlayers( TEAM_MAYOR ) == 0 then
		GAMEMODE.DialogPanel:SetDialog("The National Guard is not active! You cannot join unless there is a Mayor and they activate the National Guard.")

		GAMEMODE.DialogPanel:AddDialog("Ohh ok... I'll check back in later.", LEAVE_DIALOG)
	elseif GetGNWVar( "nationalguard_active" ) == 0 then
		GAMEMODE.DialogPanel:SetDialog("The National Guard is not active! You cannot join unless the Mayor activates the National Guard.")

		GAMEMODE.DialogPanel:AddDialog("Aww shucks, I'll check back in later.", LEAVE_DIALOG)
	elseif (PoliceNumber >= GAMEMODE.MaxPlayers[ "NationalGuard" ]) then
		GAMEMODE.DialogPanel:SetDialog("We apologize. There's been a mistake, see, we don't have any positions currently available at our department. Maybe next time?\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Aww shucks, I'll check back in later.", LEAVE_DIALOG)
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials. (You have a warrant you must get rid of it before becoming a NationalGuard.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_NationalGuard * 60 * 60 and !LocalPlayer():IsVIP()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_NationalGuard .. " hours of play time or VIP to be an officer.)")

		GAMEMODE.DialogPanel:AddDialog("Shoot, okay then..", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.")

		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG)
	elseif IsValid( ourVehicle ) then
		GAMEMODE.DialogPanel:SetDialog( "You need to put your vehicle into your garage before you can become a police officer." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your uniform, firearm, and hand cuffs. (If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_nationalguard_j')

		GAMEMODE.DialogPanel:AddDialog("On my honor, I would never betray my badge, integrity, character, or public trust.", LEAVE_DIALOG)
	end
end

function NPC.Ammo()
	GAMEMODE.DialogPanel:SetDialog( "OH THANK GOD!\n Head in to the room on your left to get weapons and ammo!" )

	--RunConsoleCommand( "perp_p_ammo" )

	GAMEMODE.DialogPanel:AddDialog( "Thank you, sir!", LEAVE_DIALOG )
end

GAMEMODE:LoadNPC(NPC)

//Original Text for Menu
//On my honor, I would never betray my badge, integrity, character, or public trust.\nI will always uphold the constitution, my community, and the agency I serve.
