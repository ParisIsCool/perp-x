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

NPC.Name = "Road Services"
NPC.ID = 21

NPC.Model = Model( "models/humans/clanof06/male_02.mdl" )
NPC.Skin = 1
NPC.BodyGroups = {
    [1] = 1,
    [2] = 0,
}

NPC.Location, NPC.Angles = {}, {}

--Vector( 1728.6566162109, -3123.3596191406, 136.03125 ), Angle( 1.7478675842285, -0.12983855605125, 0)

NPC.Location[ "rp_florida_v2" ] = {Vector( 1728.6566162109, -3123.3596191406, 136.03125 ),}
NPC.Angles[ "rp_florida_v2" ] = {Angle( 0, 0, 0)}

NPC.Location['rp_evocity2_v3p'] = Vector(7855.7573242188, 12883.682617188, 72.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector(612, 4471, 72)
NPC.Angles['rp_evocity_v33x'] = Angle(0, 90, 0)

NPC.Location['rp_evocity_v4b1'] = Vector(820.183960, 3571.737793, 72)
NPC.Angles['rp_evocity_v4b1'] = Angle(0, -84, 0)

NPC.Location ['rp_rockford_v1b'] = { Vector(-7288.031250, 169.428101, 12.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, -1.200229, 0.000000)}

NPC.Location ['rp_rockford_v2b'] = { Vector(-7288.031250, 169.428101, 12.031250) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(4.180012, -1.200229, 0.000000)}


NPC.Location['rp_paralake_city_v3'] = Vector(-11141.53515625, 10056.548828125, 64.03125)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, -180, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = Vector( -10251, 14873, -1482 )
NPC.Angles[ "rp_chaos_city_v33x_03" ] = Angle( 0, -180, 0 )

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    {pos=Vector(-2917,3566,-103), ang=Angle(0,0,0)},
}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_ROADSERVICE then
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
		GAMEMODE.DialogPanel:SetDialog("Hello. Are you here for a checkup?")

		GAMEMODE.DialogPanel:AddDialog("I'm actually interested in becoming a road service worker.", NPC.Hire)
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

function NPC.GarageVehicle()
	GAMEMODE.DialogPanel:SetDialog("Ok your vehicle is in the garage now!")

	GAMEMODE.DialogPanel:AddDialog("Thanks, Cya around!", LEAVE_DIALOG)

	GAMEMODE:RequestHolsterJobVehicle()
end

function NPC.QuitJob()
	LEAVE_DIALOG()

	GAMEMODE:RequestJobLeave()
end

function NPC.Hire()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local RoadCrewMembers = team.NumPlayers(TEAM_ROADSERVICE)

	local Blacklist = LocalPlayer():HasBlacklist( "job", "Road Crew" )

    local jobInfo = JOB_DATABASE[TEAM_ROADSERVICE]

	if LocalPlayer():IsOwner() then
		GAMEMODE.DialogPanel:SetDialog("Yes, you seem qualified.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		GAMEMODE:RequestJobJoin(TEAM_ROADSERVICE)

		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who need some help.", LEAVE_DIALOG)
	elseif (RoadCrewMembers >= GAMEMODE.MaxJobs[ TEAM_ROADSERVICE ] ) then
		GAMEMODE.DialogPanel:SetDialog("We have more help than we currently need, sorry.\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif Blacklist then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < jobInfo.RequiredTime * 60 * 60 and !LocalPlayer():IsVIP()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. jobInfo.RequiredTime .. " hours of play time or VIP to be a road worker.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Business laws state that we cannot hire mayor nominees. Sorry.\n\n(You cannot be a road service worker while running for mayor.)")

		GAMEMODE.DialogPanel:AddDialog("Ahh, yes. I wouldn't have the time.", LEAVE_DIALOG)
	elseif IsValid( ourVehicle ) and LocalPlayer():GetPos():Distance( ourVehicle:GetPos() ) >= 500 then
		GAMEMODE.DialogPanel:SetDialog( "Your car must be in a garage or outside to become mechanic." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Yes, you seem qualified.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		GAMEMODE:RequestJobJoin(TEAM_ROADSERVICE)

		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who need some help.", LEAVE_DIALOG)
	end
end

function NPC.RequestCar(vehicle)
	local numSquadCars = 0
	local OwnCar = NULL
	local jobinfo = JOB_DATABASE[LocalPlayer():Team()]

	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )
			if VehicleTable and VehicleTable.RequiredClass == TEAM_ROADSERVICE then
				numSquadCars = numSquadCars + 1
			end
		end
	end

	if numSquadCars >= jobinfo.MaxVehicles and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the busses are taken.\n\n(All busses are taken wait until someone who is using one quits.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Drive carefully and follow the rules of the road.)")

		GAMEMODE.DialogPanel:AddDialog( "Thank you!", LEAVE_DIALOG )

		GAMEMODE:RequestJobVehicle(vehicle.ID)
	end
end

GAMEMODE:LoadNPC(NPC)
