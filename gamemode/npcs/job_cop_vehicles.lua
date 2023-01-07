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

NPC.Name = "Police Garage"
NPC.ID = 133

NPC.Model = Model("models/preytech/perp/players/npcs/perp_cop.mdl")
NPC.Skin = 3;
NPC.bodygroups = {}
NPC.bodygroups[1] = 0;
NPC.bodygroups[2] = 0;
NPC.bodygroups[3] = 0;
NPC.bodygroups[4] = 1;
NPC.bodygroups[5] = 1;
NPC.bodygroups[6] = 0;
NPC.bodygroups[7] = 0;
NPC.bodygroups[8] = 0;
NPC.bodygroups[9] = 0;
NPC.bodygroups[10] = 0;
NPC.bodygroups[11] = 0;
NPC.bodygroups[12] = 0;

NPC.Location, NPC.Angles = {}, {}
NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(8567,7512,-120),ang=Angle(0,90,0)},
}


--Vector( 7003.1669921875, -2351.96875, 136.03125 ), Angle( 0.82390403747559, 89.776039123535, 0)
NPC.Location[ "rp_florida_v2" ] = {Vector( 7003.1669921875, -2351.96875, 136.03125 ),}
NPC.Angles[ "rp_florida_v2" ] = {Angle( 0, 90, 0),}

NPC.Location['rp_evocity_v4b1'] = Vector( -6798.1635742188, -10601.884765625, -175.96875 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 128.040, 0.000 )

NPC.Location ['rp_rockford_v1b'] = { Vector( -8159.7084960938, -5670.580078125, 8.03125 ) };
NPC.Angles ['rp_rockford_v1b'] = { Angle( 0, -55.307, 0.000 ) };

NPC.Location ['rp_rockford_v2b'] = { Vector( -7152.3330078125, -5814.3081054688, 8.03125 ) };
NPC.Angles ['rp_rockford_v2b'] = { Angle( 0, -146, 0.000 ) };

--Vector( -7152.3330078125, -5814.3081054688, 8.03125 )

NPC.Location['rp_paralake_city_v3'] = Vector( -10352.326171875, 9323.3974609375, 168.03125 )
NPC.Angles['rp_paralake_city_v3'] = Angle( 1.0548851490021, 43.514797210693, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 3865.03125, -5842.2216796875, -2124.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, 90, 0 ) }


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_POLICE or LocalPlayer():Team() == TEAM_CHIEF or LocalPlayer():Team() == TEAM_DETECTIVE or LocalPlayer():Team() == TEAM_FBI or LocalPlayer():Team() == TEAM_SWAT or LocalPlayer():Team() == TEAM_DISPATCHER then

		GAMEMODE.DialogPanel:SetDialog("Welcome to the Motor Pool. Can I be of assistance?");

		local jobinfo = JOB_DATABASE[LocalPlayer():Team()]
		if LocalPlayer():GetGNWVar( "Vehicle" ) and IsValid(Entity(LocalPlayer():GetGNWVar( "Vehicle" ))) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to put my vehicle in the garage.", function() NPC.GarageVehicle() end)
		end
		for k, v in pairs(jobinfo.Vehicles) do
			GAMEMODE.DialogPanel:AddDialog("Give me the " .. v.Nickname .. ", please! ", function() NPC.RequestCar(v) end)
		end
		GAMEMODE.DialogPanel:AddDialog("Errr... No...", NPC.Relief);

	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!");
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Are you sure you're a cop?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right...sorry about that.", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show();
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
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the squad cars are taken.\n\n(All squad cars are taken wait until someone who is using one quits the force.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your squad car can be found on the sidewalk outside of the Government Center.)")

		GAMEMODE:RequestJobVehicle(vehicle.ID)

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end

function NPC.GarageVehicle()
	GAMEMODE.DialogPanel:SetDialog("Ok your vehicle is in the garage now!")

	GAMEMODE.DialogPanel:AddDialog("Thanks, Cya around!", LEAVE_DIALOG)

	GAMEMODE:RequestHolsterJobVehicle()
end

function NPC.Relief()
	GAMEMODE.DialogPanel:SetDialog("That's awkward man.")

	GAMEMODE.DialogPanel:AddDialog("Yeah man.", LEAVE_DIALOG)
end

GAMEMODE:LoadNPC(NPC)
