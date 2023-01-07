--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

//I dont know what coded this but holy shit

--i guess they didnt want to spend time changing the CAR NPC TO A FUCKING WEAPON NPC PROPERLY... Would have been much cleaner.

-- i bet it was brad - paris

local NPC = {}

NPC.Name = "Weapons Guy NG"
NPC.ID = 258

NPC.Model = Model("models/aa3hacks/aa3male08_npc.mdl")

--Vector( -3662.599609375, -4651.908203125, 64.03125 ), Angle( 0.76001143455505, -89.588607788086, 0)


NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_rockford_v2b'] = { Vector( -3662.599609375, -4651.908203125, 64.03125 ) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) }

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
--[[
function NPC.OnTalk ( )
		GAMEMODE.DialogPanel:SetDialog("Welcome to the Weapons Locker! Can I be of any assistance? (I'm not finished yet!!!)")
		GAMEMODE.DialogPanel:AddDialog("I'll see you later!", LEAVE_DIALOG);
	GAMEMODE.DialogPanel:Show()
end

/*

    Player:StripWeapon( "cw_fiveseven" )
    Player:StripWeapon( "khr_p226" )
    Player:StripWeapon( "cw_glock20" )
    Player:StripWeapon( "cw_m3super90_police" )
	Player:StripWeapon( "weapon_perp_battering_ram" )
	Player:StripWeapon( "khr_m4a4" )
	Player:StripWeapon( "weapon_perp_sh_flashbang" )
	Player:StripWeapon( "weapon_perp_handcuffs" )
	Player:StripWeapon( "weapon_perp_nightstick" )
	Player:StripWeapon( "weapon_perp_binoculars" )
	Player:StripWeapon( "stungun" )
	Player:StripWeapon( "weapon_perp_taser" )
	Player:StripWeapon( "weapon_perp_car_radar" )
	Player:StripWeapon( "vc_spikestrip_wep" );

	if Player:IsVIP() then
		Player:StripWeapon( "weapon_perp_car_ticket_vip" )
	else
		Player:StripWeapon( "weapon_perp_car_ticket_regular" )
	end

*/



--]]

function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_NATIONAL then

		GAMEMODE.DialogPanel:SetDialog("Welcome to the Weapons Locker! Can I be of any assistance?");

		if (LocalPlayer():IsOwner()) then
			GAMEMODE.DialogPanel:AddDialog("M4A1", NPC.ChiefCar2)
			GAMEMODE.DialogPanel:AddDialog("Shotgun", NPC.ChiefCar);
			GAMEMODE.DialogPanel:AddDialog("Glock", NPC.DetectiveCar2);
			--GAMEMODE.DialogPanel:AddDialog("USP - Pistol", NPC.DetectiveCar);
			GAMEMODE.DialogPanel:AddDialog("Five-Seven", NPC.SquadCar2)
			GAMEMODE.DialogPanel:AddDialog("Flash Grenade.", NPC.SWATVan)
		elseif(LocalPlayer():Team() == TEAM_NATIONAL) then
			if LocalPlayer():IsVIP() then
				GAMEMODE.DialogPanel:AddDialog("M4A1", NPC.ChiefCar2)
			end
			GAMEMODE.DialogPanel:AddDialog("Shotgun", NPC.ChiefCar);
			GAMEMODE.DialogPanel:AddDialog("Glock", NPC.DetectiveCar2);
			--GAMEMODE.DialogPanel:AddDialog("USP - Pistol", NPC.DetectiveCar);
			GAMEMODE.DialogPanel:AddDialog("Five-Seven", NPC.SquadCar2)
			GAMEMODE.DialogPanel:AddDialog("Flash Grenade.", NPC.SWATVan)
		end

		GAMEMODE.DialogPanel:AddDialog("Taser", NPC.Taser);
		GAMEMODE.DialogPanel:AddDialog("Refill Ammo", NPC.Ammo);
		GAMEMODE.DialogPanel:AddDialog("Errr... No...", NPC.Relief);

	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!");
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("You're not a cop! Get out!");
		GAMEMODE.DialogPanel:AddDialog("Alrighty then...", LEAVE_DIALOG);
	end

	GAMEMODE.DialogPanel:Show();
end

function NPC.Relief()
	GAMEMODE.DialogPanel:SetDialog("Oh... In that case, hey! What can I do for you?")

	GAMEMODE.DialogPanel:AddDialog("Nothing...", LEAVE_DIALOG)
end

function NPC.Ammo()
	GAMEMODE.DialogPanel:SetDialog( "Sure thing, here you go." )

	--RunConsoleCommand( "perp_p_ammo" )
	
	net.Start("giveGovAmmo")
	net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog( "Thank you, sir!", LEAVE_DIALOG )
end

function NPC.ChiefCar()

		GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n")

		net.Start("giveGovShotgun")
		net.SendToServer()

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

function NPC.ChiefCar2()
		GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n")

		net.Start("giveGovM4A1")
		net.SendToServer()

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

function NPC.DetectiveCar()
		GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

		net.Start("giveGovUSP")
		net.SendToServer()

		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

function NPC.DetectiveCar2()
	GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

		net.Start("giveGovGlock")
		net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

--STEANDARD EVO OR CROWNVIC
function NPC.SquadCar()
	GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

	net.Start("giveGovGlock")
	net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

-- CROWNVIC OR CROWNVIC
function NPC.SquadCar1()
	GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

	net.Start("giveGovUSP")
	net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

-- G2 impala or crownvic
function NPC.SquadCar2()
	GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

	net.Start("giveGovFiveSeven")
	net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end
-- G3 charger or crownvic

function NPC.Taser( Player )
	GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

	net.Start("giveGovTaser")
	net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

function NPC.SWATVan()
	GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

	net.Start("giveGovFlash")
	net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end

function NPC.SWATVan2()
	GAMEMODE.DialogPanel:SetDialog("Sure, here is the gun.\n\n")

	net.Start("giveGovFiveSeven")
	net.SendToServer()

	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
end


GAMEMODE:LoadNPC(NPC)
