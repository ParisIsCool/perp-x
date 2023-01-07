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

NPC.Name = "Health Guy NG"
NPC.ID = 259

NPC.Model = Model("models/aa3hacks/aa3male03_npc.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_rockford_v2b'] = { Vector( -3595.0065917969, -4651.3701171875, 64.03125 ) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) }

--Vector( -3595.0065917969, -4651.3701171875, 64.03125 ), Angle( 0.62801146507263, -89.720611572266, 0)

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_NATIONAL 
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
		GAMEMODE.DialogPanel:AddDialog("You're not a NG! Get bent!", LEAVE_DIALOG)
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
