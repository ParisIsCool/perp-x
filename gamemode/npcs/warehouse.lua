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

NPC.Name = "Kane's Crazy Warehouse"
NPC.ID = 19
NPC.ShowChatBubble = true

NPC.Model = Model( "models/humans/Group01/male_02.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(2509,5111,0),ang=Angle(2,1,0)},
}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Hello, welcome to my warehouse, how can I help you?" )

	GAMEMODE.DialogPanel:AddDialog( "I'd like to see my stored items please.", NPC.DoIt )
	GAMEMODE.DialogPanel:AddDialog( "Whoops wrong person..", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.DoIt()
	GAMEMODE.WarehousePanel:Show()

	LEAVE_DIALOG()
end

GAMEMODE:LoadNPC( NPC )
