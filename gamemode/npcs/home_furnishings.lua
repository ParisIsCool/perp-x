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

NPC.Name = "Home Furnishings"
NPC.ID = 7

NPC.Model = Model( "models/humans/clanof06/male_04.mdl" )
NPC.Skin = 7
NPC.BodyGroups = {
    [1] = 0,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(1336,-1572,-96),ang=Angle(1,90,0)},
}

NPC.Location ['rp_florida_v2'] = {Vector( 7805.578125, -4310.7314453125, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 1.0879802703857, -89.580657958984, 0)}

NPC.Location['rp_chaos_city_v33x_03'] = { Vector( 5877, 1225, -1868 ) }
NPC.Angles['rp_chaos_city_v33x_03'] = { Angle( 0, 180, 0) }

NPC.Location['rp_evocity2_v3p'] = { Vector(959.9619140625, -1438.2583007813, 76.03125) }
NPC.Angles['rp_evocity2_v3p'] = { Angle(0, 90, 0) }

NPC.Location['rp_evocity_v33x'] = { Vector( -6865.5771484375, -9986.3330078125, 72.03125 ) }
NPC.Angles['rp_evocity_v33x'] = { Angle( 10.020, -30.864, 0.000 ) }

NPC.Location['rp_evocity_v4b1'] = { Vector( -6841, -10029, 71 ) }
NPC.Angles['rp_evocity_v4b1'] = { Angle( 0, 0, 0 ) }

NPC.Location ['rp_rockford_v1b'] = { Vector(-7486.739258, -3337.060547, 10.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, 18.482462, 0.000000) }

NPC.Location ['rp_rockford_v2b'] = { Vector(-7566.4970703125, -3336.9252929688, 8.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0.64481317996979, 28.807043075562, 0) }

--Vector( -7566.4970703125, -3336.9252929688, 8.03125 ), Angle( 0.64481317996979, 28.807043075562, 0)

NPC.Location['rp_paralake_city_v3'] = { Vector( -8041.658203125, 12215.668945313, 292.03125 ) }
NPC.Angles['rp_paralake_city_v3'] = { Angle(0, 90, 0) }



function NPC:RunBehaviour(NPCEnt)
    return NPC_HOVER(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 1 )
end

GAMEMODE:LoadNPC( NPC )
