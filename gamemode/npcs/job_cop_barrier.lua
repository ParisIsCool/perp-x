--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

//Just a dummy NPC, doesn't do anything, just looks nice

local NPC = {};

NPC.Name = "Police Barrier Guy";
//Check if this NPC.ID is already used!!!
NPC.ID = 27;

NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

--NPC.ShowChatBubble = "Normal";

NPC.Model = Model("models/preytech/perp/players/npcs/perp_cop.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.Location['rp_paralake_city_v3'] = Vector( -8654.0908203125, 9313.0869140625, 295)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 0, 0)

--Vector( -7080.3212890625, -6431.6416015625, 8.03125 ), Angle( -2.0386052131653, -89.783027648926, 0)

NPC.Location['rp_rockford_v2b'] = Vector( -7080.3212890625, -6431.6416015625, 8.03125 )
NPC.Angles['rp_rockford_v2b'] = Angle(0, -90, 0)


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
		GAMEMODE.DialogPanel:SetDialog("Hello, I am here to open the barriers for government vehicles!")
		GAMEMODE.DialogPanel:AddDialog("Uhhhhm .... okay. (*slowly walks away*)", LEAVE_DIALOG);
		GAMEMODE.DialogPanel:Show()
end
if(string.lower(game.GetMap()) != "rp_evocity_v33x") then
	GAMEMODE:LoadNPC(NPC);
end
