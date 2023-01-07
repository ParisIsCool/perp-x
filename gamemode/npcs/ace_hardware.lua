--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

//Supported Maps
//rp_rockford_v2b, rp_rockford_v1b, rp_evocity_v4b1, rp_evocity2_v3p, rp_evocity_v33x, rp_paralake_city_v3, rp_chaos_city_v33x_03

local NPC = {}

NPC.Name = "Ace Hardware"
NPC.ID = 17

NPC.Model = Model( "models/humans/clanof06/male_02.mdl" )
NPC.Skin = 1
NPC.BodyGroups = {
    [1] = 0,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    {pos=Vector(1299,-1572,-95),ang=Angle(2,89,0)},
}

NPC.Location['rp_chaos_city_v33x_03'] = { Vector( 5537, 1282, -1868 ) }
NPC.Angles['rp_chaos_city_v33x_03'] = { Angle( 0, -90, 0) }

NPC.Location['rp_evocity2_v3p'] = Vector(511.63497924805, -1441.7320556641, 76.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 90, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -6863.4150390625, -10492.34375, 72.03125 )
NPC.Angles['rp_evocity_v33x'] = Angle( 13.760, 33.156, 0.000 )

NPC.Location['rp_evocity_v4b1'] = Vector( -6841, -10456, 71 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 0, 0 )

NPC.Location ['rp_rockford_v1b'] = { Vector(-7573.087402, -3026.144287, 12.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, -18.477545, 0.000000) }

NPC.Location ['rp_rockford_v2b'] = { Vector(-7551.4702148438, -3021.3859863281, 8.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(-0.015103220939636, -40.756881713867, 0) }

--Vector( -7551.4702148438, -3021.3859863281, 8.03125 ), Angle( -0.015103220939636, -40.756881713867, 0)

NPC.Location ['rp_paralake_city_v3'] = { Vector( -8421.634765625, 12219.668945313, 292.03125 ) }
NPC.Angles ['rp_paralake_city_v3'] = { Angle(0, 90, 0.000000) }

NPC.Location ['rp_florida_v2'] = {Vector( 7809.2211914062, -4894.2197265625, 136.03125 ),}
NPC.Angles ['rp_florida_v2'] = {Angle( 0, -90, 0)}

function NPC:RunBehaviour(NPCEnt)
    return NPC_HOVER(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 2 )
end

GAMEMODE:LoadNPC( NPC )
