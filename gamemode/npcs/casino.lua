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

NPC.Name = "Casino Attendant"
NPC.ID = 1337

NPC.Model = Model( "models/humans/Group01/male_09.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.Location[ "rp_florida_v2" ] = {Vector( 982.28619384766, -5002.5869140625, 152.03125 ),}
NPC.Angles[ "rp_florida_v2" ] = {Angle( 0, 180, 0),}

NPC.Location['rp_evocity_v33x'] = Vector( -3850, -6462, 198 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, -172, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( -3850, -6462, 198 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, -172, 0 )

NPC.Location ['rp_rockford_v2b'] = { Vector(2066, 1604, 544.02001953125) };
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, 0, 0) };

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Hello, What can I do for you?" )

	GAMEMODE.DialogPanel:AddDialog( "What do I do here?", NPC.WhatDoIDoHere )
	GAMEMODE.DialogPanel:AddDialog( "How do I play?", NPC.HowDoIPlay )
	GAMEMODE.DialogPanel:AddDialog( "I'm fine thanks", LEAVE_DIALOG )
	
	GAMEMODE.DialogPanel:Show()
end

function NPC.WhatDoIDoHere()
	GAMEMODE.DialogPanel:SetDialog( "You can play slot machines, on your left,\nor you can try against our experienced BlackJack dealer." )

	GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )
end

function NPC.HowDoIPlay()
	GAMEMODE.DialogPanel:SetDialog( "Take a seat at the slots and use the two button to set your bet amount, and spin to SPIN!\nYou can also go to the tables and talk to the card dealer to play BlackJack." )

	GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )
end

GAMEMODE:LoadNPC( NPC )