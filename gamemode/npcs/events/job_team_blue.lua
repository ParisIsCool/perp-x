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

NPC.Name = "TEAM BLUE";
NPC.ID = 256;

NPC.Model = Model( "models/humans/Group01/male_05.mdl" )

NPC.Location, NPC.Angles = {}, {}

--Vector( -3328.1086425781, -282.62002563477, 544.03125 ), Angle( -0.49603760242462, -90.366020202637, 0)

NPC.Location ['rp_rockford_v2b'] = { Vector(-3328.1086425781, -282.62002563477, 544.03125) };
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) };

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_BLUE then
		
		GAMEMODE.DialogPanel:SetDialog("TEAM_BLUE OPTIONS")
		GAMEMODE.DialogPanel:AddDialog("Leave Team", NPC.QuitJob)
		GAMEMODE.DialogPanel:AddDialog("EXIT NPC", LEAVE_DIALOG)
		
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		
		GAMEMODE.DialogPanel:SetDialog("TEAM_BLUE OPTIONS")
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
	RunConsoleCommand('perp_team_blue_q')
	
end

function NPC.Hire ( )

	GAMEMODE.DialogPanel:SetDialog("You have joined Team Blue)")
	RunConsoleCommand('perp_team_blue_j')
	GAMEMODE.DialogPanel:AddDialog("Bye", LEAVE_DIALOG)
	
end

GAMEMODE:LoadNPC(NPC)