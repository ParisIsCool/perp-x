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

NPC.Name = "Electronics"
NPC.ID = 23

NPC.Model = Model( "models/humans/clanof06/male_02.mdl" )
NPC.Skin = 1
NPC.BodyGroups = {
    [1] = 0,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-608,11470,136),ang=Angle(0,179,0)},
}

NPC.Location ['rp_florida_v2'] = {Vector( 7805.578125, -4498.923828125, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 3.0679779052734, -90.072875976562, 0)}

NPC.Location['rp_chaos_city_v33x_03'] = { Vector( 5877, 1059, -1868 ) }
NPC.Angles['rp_chaos_city_v33x_03'] = { Angle( 0, 180, 0 ) }

NPC.Location['rp_evocity2_v3p'] = Vector(746, -1438, 76)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 90, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -5095, -7227, 72 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 180, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( -5095, -7227, 72 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 180, 0 )

NPC.Location ['rp_rockford_v1b'] = { Vector(-7349.0458984375, -3009.5554199219, 10.03125) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, -133.706924, 0.000000) }

NPC.Location['rp_paralake_city_v3'] = Vector( -8244.7626953125, 12505.188476563, 292.03125 )
NPC.Angles['rp_paralake_city_v3'] = Angle(35.671974182129, -104.24705505371, 0)

NPC.Location ['rp_rockford_v2b'] = { Vector(-7391.5942382812, -2989.5939941406, 8.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0.11688213050365, -87.592796325684, 0) }

--Vector( -7391.5942382812, -2989.5939941406, 8.03125 ), Angle( 0.11688213050365, -87.592796325684, 0)

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 4 )
end

GAMEMODE:LoadNPC( NPC )
