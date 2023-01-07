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

NPC.Name = "Federal Bureau of Investigation"
NPC.ID = 131
-- 	{Vector(8458,9081,288), Angle(0,-90,0)},

NPC.Model = Model("models/humans/Group01/female_02.mdl")
--NPC.Model = Model("models/fbi_pack/fbi_01.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.NoTalkSequence = true

NPC.Location ['rp_florida_v2'] = {Vector( 6801.6103515625, -2560.5822753906, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.95591926574707, -0.63718414306641, 0)}

NPC.Location['rp_chaos_city_v33x_03'] = { Vector( 3190.2353515625, -4625.234375, -1476.96875 ) }
NPC.Angles ['rp_chaos_city_v33x_03'] = { Angle( 0, 0, 0) }

NPC.Location['rp_evocity_v4b1'] = { Vector(-7673.031250, -9435.836914, 475.031250) }
NPC.Angles ['rp_evocity_v4b1'] = { Angle(0, 0, 0) }

NPC.Location['rp_evocity_v33x'] = { Vector(-6952.121094, -9389.687500, -431.9688) }
NPC.Angles ['rp_evocity_v33x'] = { Angle(0, -179, 0) }

NPC.Location ['rp_paralake_city_v1'] = Vector(-8993, 10598, 288);
NPC.Angles ['rp_paralake_city_v1'] = Angle(0, 90, 0);

--Vector( -3675.5393066406, -4632.9145507813, 64.03125 ), Angle( -0.46301883459091, -87.705581665039, 0)
NPC.Location ['rp_rockford_v1b'] = { Vector( -3675.5393066406, -4632.9145507813, 64.03125 ) }
NPC.Angles ['rp_rockford_v1b'] = { Angle( 0, -87, 0.000 ) }

NPC.Location ['rp_rockford_v2b'] = { Vector(-8736.37890625, -5587, 8.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) }

--Vector( -8736.37890625, -5587.9853515625, 8.03125 ), Angle( 0.031839549541473, -88.509010314941, 0)


NPC.Location['rp_paralake_city_v3'] = Vector(-5636.9096679688, 12542.047851563, 832.03125)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 0, 0)


NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(7943,8034,200),ang=Angle(1,-91,0)},
}


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_FBI then

		GAMEMODE.DialogPanel:SetDialog("You're here to quit, aren't you? This ALWAYS happens! Can't find any reliable work nowadays!");

		if (LocalPlayer():Team() == TEAM_FBI) then
			GAMEMODE.DialogPanel:AddDialog("Has my squad car been prepped for pickup?", NPC.SquadCar);
			--GAMEMODE.DialogPanel:AddDialog("I'm looking for my badass SUV motherfucker", NPC.SquadCar2);
			GAMEMODE.DialogPanel:AddDialog("Actually, I'm looking to go to the range, got any ammo?", function() 
				LEAVE_DIALOG()
				GAMEMODE:RequestJobAmmo()
			end)
			  --quit job
			GAMEMODE.DialogPanel:AddDialog("Actually, yes. Here's my badge.", NPC.QuitJob);
			GAMEMODE.DialogPanel:AddDialog("Errr... No...", NPC.Relief);
		elseif (LocalPlayer():Team() ==! TEAM_FBI) then
			GAMEMODE.DialogPanel:SetDialog("Hi.");
			--GAMEMODE.DialogPanel:AddDialog("No... I was just wondering if any squad cars were available.", NPC.SquadCar);
			--promotes
			--GAMEMODE.DialogPanel:AddDialog("Actually, I was hoping to Be Chief.", NPC.PromoteToChief);
		    --GAMEMODE.DialogPanel:AddDialog("Actually, I was hoping to Be Detective.", NPC.PromoteToDetective);
			GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);

		--elseif (LocalPlayer():Team() == TEAM_SWAT) then
			--GAMEMODE.DialogPanel:AddDialog("No... I was just wondering if any SWAT vans were available.", NPC.SWATVan);
		end
          -- get more ammo

		--if mayor say to hi mayor
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!");
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Shh.... We're not telling anyone.... \nRequired: " .. JOB_DATABASE[TEAM_FBI].RequiredTime .. " hours of playtime and Gold VIP");
		GAMEMODE.DialogPanel:AddDialog("I was hoping to get into the FBI.", NPC.PromoteToFBI);
		GAMEMODE.DialogPanel:AddDialog("That's...weird. Bye.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);
	end

	GAMEMODE.DialogPanel:Show();
end

--promo new fbi
function NPC.PromoteToFBI ()
	local FBINumber = team.NumPlayers(TEAM_FBI);
	if (FBINumber >= JOB_DATABASE[TEAM_FBI].MaxPlayers && !LocalPlayer():IsSuperAdmin()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, we already waste too much money on this department.");
		GAMEMODE.DialogPanel:AddDialog("Alright. Keep that on the down low please!!", LEAVE_DIALOG);
	else//if (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_FBI])) then

		if LocalPlayer():IsOwner() then
			GAMEMODE.DialogPanel:SetDialog("Congratulations on receiving FBI!\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");
            GAMEMODE:RequestJobJoin(TEAM_FBI)

			GAMEMODE.DialogPanel:AddDialog("Thanks, now get back to work!", LEAVE_DIALOG);
		elseif (LocalPlayer():GetTimePlayed() < JOB_DATABASE[TEAM_FBI].RequiredTime * 60 * 60 || !LocalPlayer():IsVIP()) then
			GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. JOB_DATABASE[TEAM_FBI].RequiredTime .. " hours of play time plus VIP for FBI Job)");

			GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);
		else
			GAMEMODE.DialogPanel:SetDialog("Congratulations on your promotion FBI! Your job is to manage the force.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");

			GAMEMODE:RequestJobJoin(TEAM_FBI)

			GAMEMODE.DialogPanel:AddDialog("Thanks, now get back to work!", LEAVE_DIALOG);
		end
	end
end


function NPC.QuitJob ( )
	LEAVE_DIALOG()
	GAMEMODE:RequestJobLeave()
end

function NPC.Relief ( )
	GAMEMODE.DialogPanel:SetDialog("Oh... In that case, hey! What can I do for you?");

	GAMEMODE.DialogPanel:AddDialog("Nothing...", LEAVE_DIALOG);
end

function NPC.RefillAmmo ( )
	if (LocalPlayer().LastPoliceRefill && CurTime()-LocalPlayer().LastPoliceRefill < 60*15) then
		GAMEMODE.DialogPanel:SetDialog("Woah there buddy, you've already had your fair share of ammo.");
		GAMEMODE.DialogPanel:AddDialog("My bad, I'll be fair with sharing the ammo!", LEAVE_DIALOG);
	else
		LocalPlayer().LastPoliceRefill = CurTime();
		GAMEMODE.DialogPanel:SetDialog("Here's your standard issue ammo.");
		RunConsoleCommand('perp_police_ra');
		GAMEMODE.DialogPanel:AddDialog("I'll have some fun at the range, thanks!", LEAVE_DIALOG);
	end
end

function NPC.SquadCar()
    GAMEMODE.DialogPanel:SetDialog("You can find your vehicle by talking to our attendant in the parking lot.")
	GAMEMODE.DialogPanel:AddDialog("Sweet, thanks!", LEAVE_DIALOG)
end

--[[function NPC.SquadCar2() old
	local numSquadCars = 0
	local OwnCar = NULL


	if (LocalPlayer():Team() == TEAM_FBI) then
		GAMEMODE.DialogPanel:SetDialog("Sir, yes sir. Your vehicle is ready.");

		RunConsoleCommand('perp_pc_fbi2');
	end

	if LocalPlayer():GetGNWVar( "Vehicle" ) then OwnCar = Entity(LocalPlayer():GetGNWVar( "Vehicle" )) end

	for _, v in pairs( player.GetHumans() ) do
		if v:GetGNWVar( "Vehicle" ) then
			local VehicleTable = lookForVT( Entity(v:GetGNWVar( "Vehicle" )) )


			if VehicleTable and VehicleTable.RequiredClass == TEAM_POLICE then
				numSquadCars = numSquadCars + 1
			end
		end
	end

	if numSquadCars >= GAMEMODE.MaxVehicles[ "Police" ] and not ( OwnCar:IsValid() ) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the squad cars are taken.\n\n(All squad cars are taken wait until someone who is using one quits the force.)")

		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your squad car can be found on the sidewalk outside of the Government Center.)")

		RunConsoleCommand('perp_p_c')

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	end
end
]]--

GAMEMODE:LoadNPC(NPC)
