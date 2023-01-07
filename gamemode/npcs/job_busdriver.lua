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

NPC.Name = "Bus Driver";
NPC.ID = 22;

NPC.Model = Model( "models/humans/clanof06/male_02.mdl" )
NPC.Skin = 5
NPC.BodyGroups = {
    [1] = 0,
    [2] = 2,
}
NPC.Sequence = 374

NPC.Location, NPC.Angles = {}, {}

--NPC.Location = Vector(-2986.678711, 6912.656738, 68);
--NPC.Angles = Angle(0, 180, 0);

NPC.Location ['rp_florida_v2'] = {Vector( -2024.5753173828, 7118.1181640625, 128.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.2300106883049, -0.37178683280945, 0)}

NPC.Location['rp_evocity_v4b1'] = Vector( -4798.623046875, -5806.9760742188, 198.03125 );
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, -40.441, 0.000 );

NPC.Location ['rp_rockford_v1b'] = { Vector(-1465.223755, 4436.031250, 548.031250) };
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, -90.599915, 0.000000) };

NPC.Location ['rp_rockford_v2b'] = { Vector(-1420.144775, 3923.968750, 555.031250) };
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, 90, 0) };

NPC.Location['rp_paralake_city_v3'] = Vector( -9513.212890625, 6312.48046875, 308.03128051758 )
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 0, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = Vector( -9469, 8157, -1482 )
NPC.Angles[ "rp_chaos_city_v33x_03" ] = Angle( 0, -90, 0 )

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    {pos=Vector(5169,3577,-55), ang=Angle(0,90,0)},
}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_BUSDRIVER then
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
		GAMEMODE.DialogPanel:SetDialog("Hello. Do you think you have the patience to become a bus driver?")

		GAMEMODE.DialogPanel:AddDialog("I'm actually interested in becoming a bus driver.", NPC.Hire)
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
	local FiremanNumber = team.NumPlayers(TEAM_BUSDRIVER)

    local jobInfo = JOB_DATABASE[TEAM_BUSDRIVER]

	print(LocalPlayer():GetTimePlayed() , jobInfo.RequiredTime * 60 * 60)

	if (FiremanNumber >= GAMEMODE.MaxJobs[TEAM_BUSDRIVER]) then
		GAMEMODE.DialogPanel:SetDialog("We have more help than we currently need, sorry.\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
		elseif (LocalPlayer():HasBlacklist( "job", "TEAM_BUSDRIVER" )) then
		local expires = LocalPlayer():HasBlacklist( "job", "TEAM_BUSDRIVER" )

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

		GAMEMODE:RequestJobJoin(TEAM_BUSDRIVER)

		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who needs a ride.", LEAVE_DIALOG)
	end
end

/*

TEAM_BUSDRIVER

RunConsoleCommand('perp_bd_cha')
RunConsoleCommand('perp_bd_new')

*/


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

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end

function NPC.GarageVehicle()
	GAMEMODE.DialogPanel:SetDialog("Ok your vehicle is in the garage now!")

	GAMEMODE.DialogPanel:AddDialog("Thanks, Cya around!", LEAVE_DIALOG)

	GAMEMODE:RequestHolsterJobVehicle()
end

GAMEMODE:LoadNPC(NPC)
