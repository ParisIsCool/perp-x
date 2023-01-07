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

NPC.Name = "Taxi Driver";
NPC.ID = 101;

NPC.Model = Model( "models/humans/clanof06/male_04.mdl" )
NPC.Skin = 7
NPC.BodyGroups = {
    [1] = 0,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}

--NPC.Location = Vector(-2986.678711, 6912.656738, 68);
--NPC.Angles = Angle(0, 180, 0);
--Vector( -3008.1296386719, -5008.03125, 64.03125 ), Angle( -0.23202548921108, -90.369232177734, 0)


NPC.Location ['rp_florida_v2'] = {Vector( -2024.0452880859, 7199.8344726562, 128.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.2300106883049, -0.37178683280945, 0)}

NPC.Location ['rp_rockford_v2b'] = { Vector(-3008.1296386719, -5008.03125, 64.03125) };
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) };

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    { pos=Vector(1184,40,-103),ang=Angle(0,-90,0) },
}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_TAXI_DRIVER then
		GAMEMODE.DialogPanel:SetDialog("Hello, can I help you?")
		local jobinfo = JOB_DATABASE[LocalPlayer():Team()]
		if LocalPlayer():GetGNWVar( "Vehicle" ) and IsValid(Entity(LocalPlayer():GetGNWVar( "Vehicle" ))) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to put my vehicle in the garage.", function() NPC.GarageVehicle() end)
		end
		for k, v in pairs(jobinfo.Vehicles or {}) do
			GAMEMODE.DialogPanel:AddDialog("I'm looking to get a " .. v.Nickname .. ", please! ", function() NPC.RequestCar(v) end)
		end
		GAMEMODE.DialogPanel:AddDialog("This job is too much for me. I'm here to quit.", NPC.QuitJob)
		GAMEMODE.DialogPanel:AddDialog("No, Just having a look around.", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Can I help you, Mr. Mayor?")

		GAMEMODE.DialogPanel:AddDialog("Not that I know of...", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Hello. Do you think you have the patience to become a taxi driver?")

		GAMEMODE.DialogPanel:AddDialog("I'm actually interested in becoming a taxi driver.", NPC.Hire)
		GAMEMODE.DialogPanel:AddDialog("No. Just having a look around.", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_FIREMAN then
		GAMEMODE.DialogPanel:SetDialog("Thank you for protecting us from the ravages of fire!")

		GAMEMODE.DialogPanel:AddDialog("You're quite welcome, sir.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Hello.")

		GAMEMODE.DialogPanel:AddDialog("Hi...", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.QuitJob ( )
	LEAVE_DIALOG()

	GAMEMODE:RequestJobLeave()
end

function NPC.Hire ( )
	local FiremanNumber = team.NumPlayers(TEAM_TAXI_DRIVER)

    local jobInfo = JOB_DATABASE[TEAM_TAXI_DRIVER]

	if (FiremanNumber >= GAMEMODE.MaxJobs[TEAM_TAXI_DRIVER]) then
		GAMEMODE.DialogPanel:SetDialog("We have more help than we currently need, sorry.\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (LocalPlayer():HasBlacklist( "job", "TEAM_TAXI" )) then
		local expires = LocalPlayer():HasBlacklist( "job", "TEAM_TAXI" )

		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)")
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)")
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)")
		end

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < jobInfo.RequiredTime * 60 * 60) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. jobInfo.RequiredTime .. " hours of play time to be a bus driver.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Business laws state that we cannot hire mayor nominees. Sorry.\n\n(You cannot be a bus driver while running for mayor.)")

		GAMEMODE.DialogPanel:AddDialog("Ahh, yes. I wouldn't have the time.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Yes, you seem qualified.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		GAMEMODE:RequestJobJoin(TEAM_TAXI_DRIVER)

		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who needs a ride.", LEAVE_DIALOG)
	end
end

function NPC.GarageVehicle()
	GAMEMODE.DialogPanel:SetDialog("Ok your vehicle is in the garage now!")

	GAMEMODE.DialogPanel:AddDialog("Thanks, Cya around!", LEAVE_DIALOG)

	GAMEMODE:RequestHolsterJobVehicle()
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
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the busses are taken.\n\n(All busses are taken wait until someone who is using one quits.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Drive carefully and follow the rules of the road.)")

		GAMEMODE:RequestJobVehicle(vehicle.ID)

		GAMEMODE.DialogPanel:AddDialog("Thank you!", LEAVE_DIALOG)
	end
end

-- function NPC.taxi()
-- 	local numBus2 = 0
-- 	local OwnCar = NULL

-- 	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

-- 	for _, v in pairs( player.GetHumans() ) do
-- 		if v:GetGNWVar( "Vehicle" ) then
-- 			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )

-- 			if VehicleTable and VehicleTable.RequiredClass == TEAM_TAXI then
-- 				numBus2 = numBus2 + 1
-- 			end
-- 		end
-- 	end

--   if numBus2 >= GAMEMODE.MaxVehicles[ "TaxiDriver" ] and not ( OwnCar:IsValid() ) then
-- 		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the taxis have been taken out on duty.\n\n(All taxis are taken.  Please wait until someone who is using one quits the job.)")

-- 		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
-- 	else
-- 		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.")

-- 		RunConsoleCommand('perp_taxi_cha')

-- 		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
-- 	end
-- end

GAMEMODE:LoadNPC(NPC)
