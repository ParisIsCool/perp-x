--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local NPC = {};

NPC.Name = "Fire Chief";
NPC.ID = 122;

NPC.Model = Model("models/humans/Group01/male_02.mdl")
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.


NPC.Location, NPC.Angles = {}, {}

NPC.Location['rp_evocity_v4b1'] = Vector(-3788.7495117188, -7019.685546875, 198.03125)
NPC.Angles['rp_evocity_v4b1'] = Angle(0, -180, 0)

NPC.Location ['rp_florida_v2'] = {Vector( 6397.6850585938, -4933.0454101562, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( -0.10010965168476, 179.80683898926, 0)}

NPC.Location ['rp_rockford_v1b'] = Vector(-4208.922852, -3492.031250, 5.031250)
NPC.Angles ['rp_rockford_v1b'] = Angle(0, 89.019829, 0.000000)

NPC.Location ['rp_rockford_v2b'] = Vector(-5721.835938, -2946.375244, 275.031250)
NPC.Angles ['rp_rockford_v2b'] = Angle(2.639999, -89.019829, 0.000000)

--Vector( -13382.008789063, 12790.163085938, 64.03125 ), Angle( 0.65878772735596, -90.162689208984, 0)
NPC.Location ['rp_paralake_city_v3'] = Vector( -13382.008789063, 12790.163085938, 64.03125 );
NPC.Angles ['rp_paralake_city_v3'] = Angle( 0, -90, 0);

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 7082.03125, -2523.8415527344, -1742.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, -180, 0 ) }


--NPC.ShowChatBubble = "Normal";

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	
	
	local FireChiefNumber = team.NumPlayers(TEAM_FIRECHIEF);
			
	if LocalPlayer():Team() == TEAM_FIRECHIEF then
		GAMEMODE.DialogPanel:SetDialog("What vehicle would you like?");

		GAMEMODE.DialogPanel:AddDialog("Suburban", NPC.FireChiefCar);
		GAMEMODE.DialogPanel:AddDialog("Rescue 1", NPC.FireChiefCar2);
		GAMEMODE.DialogPanel:AddDialog("I'm here to quit the team. It's more than I can handle.", NPC.QuitJob);

		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);

	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor.");

		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG);

	elseif LocalPlayer():Team() == TEAM_FIREMAN then
		GAMEMODE.DialogPanel:SetDialog("Hello. We could use new FireChief, are you interested?");

		GAMEMODE.DialogPanel:AddDialog("Yes, I'm interested in a position as a FireChief.", NPC.PromoteToFirechief);
		GAMEMODE.DialogPanel:AddDialog("No thank you.", LEAVE_DIALOG);
	
	--elseif not LocalPlayer():IsVIP() then
	--
	--	GAMEMODE.DialogPanel:SetDialog("Hello, Sorry this Job is restricted to VIP Only.");
	--
	--	GAMEMODE.DialogPanel:AddDialog("No thank you.", LEAVE_DIALOG);
	--	GAMEMODE.DialogPanel:Show();
	
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
	
		GAMEMODE.DialogPanel:SetDialog("Hello. We could use new FireChief, are you interested?");

		GAMEMODE.DialogPanel:AddDialog("Yes, I'm interested in a position as a FireChief.", NPC.PromoteToFirechief);
		
		GAMEMODE.DialogPanel:AddDialog("No thank you.", LEAVE_DIALOG);
		
		
	else
		GAMEMODE.DialogPanel:SetDialog("Hello.");

		GAMEMODE.DialogPanel:AddDialog("Goodbye.", LEAVE_DIALOG);
	end

	GAMEMODE.DialogPanel:Show();
end

function NPC.QuitJob ( )
	LEAVE_DIALOG();

	RunConsoleCommand('perp_fc_q');
end

function NPC.PromoteToFirechief()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local FireChiefNumber = team.NumPlayers(TEAM_FIRECHIEF)

	local Blacklist = LocalPlayer():HasBlacklist( "job", "FireChief" )
	
	if not LocalPlayer():IsVIP() then 
	
	LocalPlayer():Notify( "FireChief is restricted to VIP Only" )
	
		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	end


	if LocalPlayer():IsOwner() then
		GAMEMODE.DialogPanel:SetDialog("Ahh, yes! Thank you for coming by! We've been looking to hire a chief.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_fc_j')

		GAMEMODE.DialogPanel:AddDialog("Thank you. I will do my hardest to protect the city.", LEAVE_DIALOG)
	elseif (FireChiefNumber >= GAMEMODE.MaxPlayers[ "FireChief" ]) then
		GAMEMODE.DialogPanel:SetDialog("We aren't currently seeking firechief. Sorry.\n\n(This job is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrant you must get rid of it before becoming a fireChief.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_FireChief * 60 * 60 && not LocalPlayer():IsVIP()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_FireChief .. " hours of play time or VIP to be a fireChief.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("You seem like the business type, are you sure you don't have other things going?\n\n(You cannot be a fire chief while running for mayor.)")

		GAMEMODE.DialogPanel:AddDialog("Ahh, yes. I wouldn't have the time.", LEAVE_DIALOG)
	elseif IsValid( ourVehicle ) then
		GAMEMODE.DialogPanel:SetDialog( "You need to put your vehicle into your garage before you can become a firechief." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Ahh, yes! Thank you for coming by! We've been looking to hire a chief.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		RunConsoleCommand('perp_fc_j')

		GAMEMODE.DialogPanel:AddDialog("Thank you. I will do my hardest to protect the city from fires.", LEAVE_DIALOG)
	end
end

function NPC.FireChiefCar()
	local numFireChiefCars = 0
	local OwnCar = NULL

	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )

			if VehicleTable and VehicleTable.RequiredClass == TEAM_FIRECHIEF then
				numFireChiefCars = numFireChiefCars + 1
			end
		end
	end

	if numFireChiefCars >= GAMEMODE.MaxVehicles[ "FireChief" ] and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the Chief cars are taken.\n\n(All Chief cars are taken wait until someone who is using one quits the force.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your Chief car can be found in garage of the Government Center.)")

		RunConsoleCommand('perp_fc_c')

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end

function NPC.FireChiefCar2()
	local numFireChiefCars = 0
	local OwnCar = NULL

	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )

			if VehicleTable and VehicleTable.RequiredClass == TEAM_FIRECHIEF then
				numFireChiefCars = numFireChiefCars + 1
			end
		end
	end

	if numFireChiefCars >= GAMEMODE.MaxVehicles[ "FireChief" ] and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the Chief cars are taken.\n\n(All Chief cars are taken wait until someone who is using one quits the force.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your Chief car can be found in garage of the Government Center.)")

		RunConsoleCommand('perp_fc_c2')

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end

--[[function NPC.FireChiefcar()
	local numFireChiefCars = 0
	local OwnCar = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity( v:GetGNWVar( "Vehicle" ) ) )


			if VehicleTable and VehicleTable.RequiredClass == TEAM_FIRECHIEF then
				numFireChiefCars = numFireChiefCars + 1
			end
		end
	end

	if numFireChiefCars >= GAMEMODE.MaxVehicles[ "FireChief" ] and not IsValid( OwnCar ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the fire trucks have been taken out on duty.\n\n(All fire trucks are taken wait until someone who is using one quits the department.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your fire truck can be found on the sidewalk along side the Government Center.)")

		RunConsoleCommand('perp_fc_c')

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end]]--

GAMEMODE:LoadNPC(NPC)
