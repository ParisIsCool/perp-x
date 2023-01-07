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

NPC.Name = "Burger King"
NPC.ID = 157

NPC.Model = Model( "models/humans/Group01/male_07.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_florida_v2'] = {Vector( 1029.22265625, -2928.03125, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.69198310375214, 89.736000061035, 0)}

NPC.Location['rp_evocity2_v3p'] = Vector(-7703.1943359375, 1245.8392333984, 148.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector(-7720.3891601563, -3964.03125, 72)
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 90, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector(-7726, -4265, 72)
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 90, 0 )

NPC.Location ['rp_rockford_v1b'] = {
Vector( 744.03125, 2111.2043457031, 544.03125 ),
Vector( 861.97204589844, 1743.96875, 544.03125 ),
}

NPC.Angles ['rp_rockford_v1b'] = {
Angle( -0, -180, 0),
Angle( -4, 90, 0)
}

NPC.Location ['rp_rockford_v2b'] = {
Vector( 744.03125, 2111.2043457031, 544.03125 ),
Vector( 861.97204589844, 1743.96875, 544.03125 ),
}

NPC.Angles ['rp_rockford_v2b'] = { 
Angle( -0, -180, 0),
Angle( -4, 90, 0)
}

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 1461.8641357422, 11101.03125, -1868.96875 ), Vector( 1372.7687988281, 11101.03125, -1868.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, -90, 0 ), Angle( 0, -90, 0 ) }


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 9 )
end

GAMEMODE:LoadNPC( NPC )
