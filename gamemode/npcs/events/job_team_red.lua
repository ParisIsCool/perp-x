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

NPC.Name = "TEAM RED";
NPC.ID = 255;

NPC.Model = Model( "models/humans/Group01/male_05.mdl" )

NPC.Location, NPC.Angles = {}, {}

--Vector( -4640.5810546875, -274.23553466797, 544.03125 ), Angle( -0.49603760242462, -90.366020202637, 0)

NPC.Location ['rp_rockford_v2b'] = { Vector(-4640.5810546875, -274.23553466797, 544.03125) };
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) };

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_RED then
		
		GAMEMODE.DialogPanel:SetDialog("TEAM_RED OPTIONS")
		GAMEMODE.DialogPanel:AddDialog("Leave Team", NPC.QuitJob)
		GAMEMODE.DialogPanel:AddDialog("EXIT NPC", LEAVE_DIALOG)
		
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		
		GAMEMODE.DialogPanel:SetDialog("TEAM_RED OPTIONS")
		GAMEMODE.DialogPanel:AddDialog("Join Team", NPC.Hire)
		GAMEMODE.DialogPanel:AddDialog("EXIT NPC", LEAVE_DIALOG)

	else
	
		GAMEMODE.DialogPanel:SetDialog("Hi")
		GAMEMODE.DialogPanel:AddDialog("Bye", LEAVE_DIALOG)
		
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.QuitJob ( )

	LEAVE_DIALOG()
	RunConsoleCommand('perp_team_red_q')
	
end

function NPC.Hire ( )

	GAMEMODE.DialogPanel:SetDialog("You have joined Team Red)")
	RunConsoleCommand('perp_team_red_j')
	GAMEMODE.DialogPanel:AddDialog("Bye", LEAVE_DIALOG)
	
end

GAMEMODE:LoadNPC(NPC)
