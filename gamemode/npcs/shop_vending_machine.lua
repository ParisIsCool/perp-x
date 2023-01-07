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

NPC.Name = "Vending Machine"
NPC.ID = 269
NPC.ToolTipMessage = "Press [ E ] on vending machine to\nbuy a snack."

NPC.Model = Model( "models/uc/props_fastfood/snack_machine_01a.mdl" )

NPC.Location, NPC.Angles = {}, {}
NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(8731.6,7420,200),ang=Angle(0,180,0)},
    {pos=Vector(7687,5014,-55),ang=Angle(0,90,0)},
    {pos=Vector(3112,5186,0),ang=Angle(0,-180,0)},
    {pos=Vector(-1348,2623,-103),ang=Angle(0,0,0)},
    {pos=Vector(-7614,1418,-31),ang=Angle(0,0,0)},
	{pos=Vector(-838,4977,-103),ang=Angle(0,-180,0)},

}


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 69 )
end

GAMEMODE:LoadNPC( NPC )
