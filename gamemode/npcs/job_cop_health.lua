--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]
///////////////////////////////
////MADE BY BRADLEY CARTER/////
///////////////////////////////

local NPC = {}

NPC.Name = "Health Guy PD"
NPC.ID = 8989

NPC.Model = Model("models/props_interiors/medicalcabinet02.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_rockford_v2b'] = { Vector( -7452.3364257812, -4615, 18 ) }
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
--]]

function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_POLICE 
	or LocalPlayer():Team() == TEAM_CHIEF 
	or LocalPlayer():Team() == TEAM_DETECTIVE 
	or LocalPlayer():Team() == TEAM_FBI 
	or LocalPlayer():Team() == TEAM_SWAT 
	or LocalPlayer():Team() == TEAM_DISPATCHER 
	or LocalPlayer():IsOwner()
	then

		GAMEMODE.DialogPanel:SetDialog("Get ya health here!")
		GAMEMODE.DialogPanel:AddDialog("Health", NPC.Health)
		GAMEMODE.DialogPanel:AddDialog("Armor", NPC.Armor)
		GAMEMODE.DialogPanel:AddDialog("Nvm m8, toodles", LEAVE_DIALOG)
	
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!")
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG)
		
	else
		GAMEMODE.DialogPanel:AddDialog("You're not a cop! Get bent!", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show();
end

function NPC.Health()

	GAMEMODE.DialogPanel:SetDialog("There ya be.")

	net.Start("giveGovHealth")
	net.SendToServer()
	
	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	
end

function NPC.Armor()

	GAMEMODE.DialogPanel:SetDialog("There ya be.")

	net.Start("giveGovArmor")
	net.SendToServer()
	
	GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)
	
end

GAMEMODE:LoadNPC(NPC)
