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

NPC.Name = "Content Downloader"
NPC.ID = 102
NPC.ShowChatBubble = true
--NPC.ShowInteract = true

NPC.Model = Model( "models/humans/Group01/male_02.mdl" )

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(2509,4990,0),ang=Angle(0,0,0)},
}


NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_rockford_v2b'] = { Vector(-4830.4145507812, -5163.96875, 64.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0, -90, 0) }
--Vector( 4185.0185546875, -4615.3759765625, 264.03125 ), Angle( 2.275972366333, 90.146980285645, 0)
NPC.Location[ "rp_florida_v2" ] = {Vector( 4185.0185546875, -4615.3759765625, 264.03125 ),}
NPC.Angles[ "rp_florida_v2" ] = {Angle( 2.275972366333, 90.146980285645, 0),}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Welcome to PERP. This server has required content needed to play and see things around the map." )

	GAMEMODE.DialogPanel:AddDialog( "Download Required Server Content", NPC.Content )
	GAMEMODE.DialogPanel:AddDialog( "Join Server Discord", NPC.Discord )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind... Sorry for bothering you.", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end


--[[
function NPC.Download()
	GAMEMODE.DialogPanel:SetDialog( "It's a simple matter of you paying a nominal filing fee of $" ..  util.FormatNumber( GAMEMODE.RenamePrice ) .. " and telling us the name that you want." )

	if LocalPlayer():GetCash() >= GAMEMODE.RenamePrice then
		GAMEMODE.DialogPanel:AddDialog( "Okay, let's do it.", NPC.DoNameChange )
	end

	GAMEMODE.DialogPanel:AddDialog( "That seems a little too expensive...", LEAVE_DIALOG )
end
]]

function NPC.Content()
	LEAVE_DIALOG()
	--gui.OpenURL( "https://steamcommunity.com/sharedfiles/filedetails/?id=1264308186" )
	gui.OpenURL( "https://steamcommunity.com/sharedfiles/filedetails/?id=2324708478" )
end

function NPC.Discord()
	LEAVE_DIALOG()
	gui.OpenURL( "https://asocket.net/discord" )
end

GAMEMODE:LoadNPC( NPC )
