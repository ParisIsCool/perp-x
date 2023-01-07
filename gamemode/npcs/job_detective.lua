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

NPC.Name = "Detective"
NPC.ID = 135

--NPC.Model = Model("models/gta5/deputypol.mdl")
NPC.Model = Model("models/humans/Group01/female_02.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_florida_v2'] = {Vector( 6800.03125, -2778.0373535156, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 2.1439743041992, 1.474781036377, 0)}

NPC.Location['rp_evocity2_v3p'] = Vector(-631.70190429688, -1686.6306152344, -427.96875)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector(-6997, -8858, -431)
NPC.Angles['rp_evocity_v33x'] = Angle(0, -90, 0)

NPC.Location['rp_evocity_v4b1'] = { Vector(-6952.121094, -9389.687500, -431.9688) }
NPC.Angles ['rp_evocity_v4b1'] = { Angle(0, -179, 0) }

NPC.Location ['rp_rockford_v1b'] = { Vector( -7567.96875, -5671.0947265625, 8.03125 ) }
NPC.Angles ['rp_rockford_v1b'] = { Angle( 0, -180, 0.000 ) }

NPC.Location ['rp_rockford_v2b'] = {  Vector( -8790.6220703125, -5587, 8.03125 ) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0.00000) }

---8790.6220703125, -5587.96875, 8.03125 ), Angle( 0.16391268372536, -90.093063354492, 0)


NPC.Location['rp_paralake_city_v3'] = Vector(-8908.701171875, 10606.567382813, 288.03125)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 90, 0)



function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Are you interested in becoming a Police Detective");

    GAMEMODE.DialogPanel:AddDialog("Yes, I was hoping to be a Police Detective.", NPC.PromoteToDetective);
		--GAMEMODE.DialogPanel:AddDialog("Actually, I was hoping to Be Detective.", NPC.PromoteToDetective);
		GAMEMODE.DialogPanel:AddDialog("No.", LEAVE_DIALOG);

	elseif LocalPlayer():Team() == TEAM_POLICE or LocalPlayer():Team() == TEAM_CHIEF or LocalPlayer():Team() == TEAM_DETECTIVE or LocalPlayer():Team() == TEAM_FBI or LocalPlayer():Team() == TEAM_SWAT or LocalPlayer():Team() == TEAM_DISPATCHER then

		GAMEMODE.DialogPanel:SetDialog("You're here to quit, aren't you? This ALWAYS happens! Can't find any reliable work nowadays!");

		--if (LocalPlayer():Team() == TEAM_CHIEF or LocalPlayer():Team() == TEAM_DETECTIVE) then
		if (LocalPlayer():Team() == TEAM_CHIEF) then
			GAMEMODE.DialogPanel:AddDialog("Can show me where I can find my car, Sergeant?", NPC.ChiefCar);
		--	GAMEMODE.DialogPanel:AddDialog("I'd like one of them new fangled Suburbans", NPC.ChiefCar2)
			--GAMEMODE.DialogPanel:AddDialog("Has my squad car been prepped for pickup?", NPC.DetectiveCar);
		elseif (LocalPlayer():Team() == TEAM_DETECTIVE) then
			--GAMEMODE.DialogPanel:AddDialog("Has my squad car been prepped for pickup?", NPC.ChiefCar);
			GAMEMODE.DialogPanel:AddDialog("Has my squad car been prepped for pickup?", NPC.DetectiveCar);

    elseif LocalPlayer():Team() == TEAM_POLICE then
  		GAMEMODE.DialogPanel:SetDialog("Hello there, sir! Thank you for protecting us from the wild savages of Rockford!");
  		GAMEMODE.DialogPanel:AddDialog("Hello there chap! You're quite welcome!", LEAVE_DIALOG);
  	else
  		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);
      			--GAMEMODE.DialogPanel:AddDialog("Actually, I was hoping to get into the FBI.", NPC.PromoteToFbi);

		--elseif (LocalPlayer():Team() == TEAM_SWAT) then
			--GAMEMODE.DialogPanel:AddDialog("No... I was just wondering if any SWAT vans were available.", NPC.SWATVan);
		end
          -- get more ammo
		GAMEMODE.DialogPanel:AddDialog("Actually, I'm looking to go to the range, got any ammo?", NPC.Ammo);
          --quit job
		GAMEMODE.DialogPanel:AddDialog("Actually, yes. Here's my badge.", NPC.QuitJob);
		GAMEMODE.DialogPanel:AddDialog("Errr... No...", NPC.Relief);

		--if mayor say to hi mayor
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!");
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);
	end

	GAMEMODE.DialogPanel:Show();
end

function NPC.PromoteToDetective()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local DetectiveNumber = team.NumPlayers(TEAM_DETECTIVE)

	local Blacklist = LocalPlayer():HasBlacklist( "job", "Detective" )

	if LocalPlayer():IsOwner() then
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your uniform, firearm, and hand cuffs. You can ask the mayor personally to issue a warrant when you need one. We have several squad cars available, just ask the garage operator.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_pc_jo_und')

		GAMEMODE.DialogPanel:AddDialog("I'll serve to my best ability, sir!", LEAVE_DIALOG)
	elseif (DetectiveNumber >= GAMEMODE.MaxPlayers[ "Detective" ]) then
		GAMEMODE.DialogPanel:SetDialog("Ahh, sorry. It seems that we aren't currently looking for any new Police Detectives. Sorry.\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrant you must get rid of it before becoming a police officer.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < JOB_DATABASE[TEAM_DETECTIVE].RequiredTime * 60 * 60) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. JOB_DATABASE[TEAM_DETECTIVE].RequiredTime .. " hours of play time.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.")

		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG)
	elseif IsValid( ourVehicle ) then
		GAMEMODE.DialogPanel:SetDialog( "You need to put your vehicle into your garage before you can become the Chief." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your uniform, firearm, and hand cuffs. You can ask the mayor personally to issue a warrant when you need one. We have several squad cars available, just ask the garage operator.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_pc_jo_und')

		GAMEMODE.DialogPanel:AddDialog("I'll serve to my best ability, sir!", LEAVE_DIALOG)
	end
end

function NPC.QuitJob ( )
	LEAVE_DIALOG();
    if LocalPlayer():Team() == TEAM_CHIEF then
		RunConsoleCommand('perp_pc_q');

    elseif LocalPlayer():Team() == TEAM_DETECTIVE then
		RunConsoleCommand('perp_uc_q');
	end
end

function NPC.Relief()
	GAMEMODE.DialogPanel:SetDialog("Oh... In that case, hey! What can I do for you?")

	GAMEMODE.DialogPanel:AddDialog("Nothing...", LEAVE_DIALOG)
end


function NPC.Ammo()
	GAMEMODE.DialogPanel:SetDialog( "Sure thing, here you go." )

	RunConsoleCommand( "perp_p_ammo" )

	GAMEMODE.DialogPanel:AddDialog( "Thank you, sir!", LEAVE_DIALOG )
end

function NPC.ChiefCar()
	GAMEMODE.DialogPanel:SetDialog("Sorry, but we recently hired a garage manager.\n\nPlease speak with him upstairs to retrieve your vehicle.")

	GAMEMODE.DialogPanel:AddDialog("Okay, Thanks.", LEAVE_DIALOG)
end

function NPC.DetectiveCar()
	GAMEMODE.DialogPanel:SetDialog("Sorry, but we recently hired a garage manager.\n\nPlease speak with him upstairs to retrieve your vehicle.")

	GAMEMODE.DialogPanel:AddDialog("Okay, Thanks.", LEAVE_DIALOG)
end


GAMEMODE:LoadNPC(NPC)
