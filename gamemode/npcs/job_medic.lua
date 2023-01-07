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

NPC.Name = "Emergency Medical Support Agency"
NPC.ID = 13

NPC.Model = Model("models/preytech/perp/players/npcs/perp_medic.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(7430,5420,-55),ang=Angle(0,-90,0)},
}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_MEDIC then
		GAMEMODE.DialogPanel:SetDialog("Hello, can I help you?")

		if LocalPlayer():HasVehicleOut() then
			GAMEMODE.DialogPanel:AddDialog("I want to put my ambulance up.", function() 
				GAMEMODE.DialogPanel:SetDialog("Alright, I have put it in storage..")
				GAMEMODE.DialogPanel:AddDialog("Thanks.", LEAVE_DIALOG)
				GAMEMODE:RequestHolsterJobVehicle()
			 end )
		end

		local jobinfo = JOB_DATABASE[LocalPlayer():Team()]
		if LocalPlayer():GetGNWVar( "Vehicle" ) and IsValid(Entity(LocalPlayer():GetGNWVar( "Vehicle" ))) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to put my vehicle in the garage.", function() NPC.GarageVehicle() end)
		end
		for k, v in pairs(jobinfo.Vehicles) do
			GAMEMODE.DialogPanel:AddDialog("Give me the " .. v.Nickname .. ", please! ", function() NPC.RequestCar(v) end)
		end

		GAMEMODE.DialogPanel:AddDialog("I am looking to quit.", NPC.QuitJob)

		GAMEMODE.DialogPanel:AddDialog("No. Just having a look around.", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Can I help you, Mr. Mayor?")

		GAMEMODE.DialogPanel:AddDialog("Not that I know of...", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Hello. Are you here for a checkup?")

		GAMEMODE.DialogPanel:AddDialog("I'm actually interested in becoming a paramedic.", NPC.Hire)
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

	if not JOB_DATABASE[TEAM_MEDIC] then 
		GAMEMODE.DialogPanel:SetDialog("My job does not exist. Please create me.")
		GAMEMODE.DialogPanel:AddDialog("Ok.", LEAVE_DIALOG)
	elseif ( GAMEMODE:IsTeamFull( TEAM_MEDIC ) ) then
		GAMEMODE.DialogPanel:SetDialog("We have more help than we currently need, sorry.\n\n(This class is full. Try again later.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrant you must get rid of it before becoming a paramedic.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif LocalPlayer():HasBlacklist( "job", TEAM_MEDIC ) then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)
	elseif (LocalPlayer():GetTimePlayed() < JOB_DATABASE[TEAM_MEDIC].RequiredTime * 60 * 60 and !LocalPlayer():IsVIP()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. JOB_DATABASE[TEAM_MEDIC].RequiredTime .. " hours of play time or VIP to be a paramedic.)")

		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Business laws state that we cannot hire mayor nominees. Sorry.\n\n(You cannot be a paramedic while running for mayor.)")

		GAMEMODE.DialogPanel:AddDialog("Ahh, yes. I wouldn't have the time.", LEAVE_DIALOG)
	elseif LocalPlayer():HasVehicleOut() then
		GAMEMODE.DialogPanel:SetDialog( "Your car must be outside or in a garage to become a paramedic." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Yes, you seem qualified.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")

		GAMEMODE:RequestJobJoin(TEAM_MEDIC)

		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who need aid.", LEAVE_DIALOG)
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


			if VehicleTable and VehicleTable.RequiredClass == TEAM_MEDIC then
				numSquadCars = numSquadCars + 1
			end
		end
	end

	if numSquadCars >= jobinfo.MaxVehicles and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the ambulances are taken.\n\n(All vehicles are taken wait until someone who is using one quits the team.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your ambulance car can be found on the sidewalk outside of the Government Center.)")

		GAMEMODE:RequestJobVehicle(vehicle.ID)

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end


GAMEMODE:LoadNPC(NPC)
