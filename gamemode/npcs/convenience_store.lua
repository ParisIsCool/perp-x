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

NPC.Name = "Ching's Convenience Store"
NPC.ID = 18
NPC.ShowChatBubble = true

NPC.Model = Model( "models/humans/clanof06/male_06.mdl" )
NPC.Skin = 1
NPC.BodyGroups = {
    [1] = 1,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(445,14005,128),ang=Angle(2,-2,0)},
    {pos=Vector(-5901,1540,-16),ang=Angle(0,-90,0)},
}


NPC.Location ['rp_florida_v2'] = {
Vector( 4957.8583984375, -105.5177154541, 136.03125 ), --City BP
Vector( -4166.9072265625, 8408.5244140625, 136.03125 ), --Country BP
}
NPC.Angles ['rp_florida_v2'] = { 
Angle( 0, -90, 0), --City BP
Angle( 0, 0, 0) --Country BP
}

NPC.Location['rp_evocity2_v3p'] = Vector(-7703.1943359375, 1245.8392333984, 148.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -7495, -6607, 72 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 90, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( -7495, -6607, 72 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 90, 0 )

NPC.Location ['rp_rockford_v1b'] = {

Vector(1004.031250, 3916.277344, 560.031250),
Vector(-14636.031250, 2623.693115, 405.031250),
Vector(-1159.968750, 5769.802246, 556.031250)
}

NPC.Angles ['rp_rockford_v1b'] = {
Angle(0, 179.559952, 0),
Angle(0, -0.119637, 0),
Angle(0, 179.745041, 0)
}

NPC.Location ['rp_rockford_v2b'] = {
--shell subs malls
Vector(1004.031250, 3916.277344, 560.031250),
-- shell long road
Vector(-14636.031250, 2623.693115, 405.031250),

--Vector(-1159.968750, 5769.802246, 556.031250)
}

NPC.Angles ['rp_rockford_v2b'] = {
--shell subs malls
Angle(4.180008, 179.559952, 0),
-- shell long road
Angle(3.079983, -0.119637, 0),

--Angle(7.199183, 179.745041, 0)
}
		

NPC.Location ['rp_paralake_city_v3'] = {
Vector( -11423.96875, 10698.861328125, 64.03125 ),
Vector( -6575.369140625, 1071.96875, 292.03125 ),
Vector( -8728.787109375, -7247.96875, 292.03125 ),
}

NPC.Angles ['rp_paralake_city_v3'] = {
Angle(0, -180, 0),
Angle( 0, -90, 0),
Angle( 0, -90, 0),
}

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 3229.8757324219, 454.95874023438, -1868.96875 ), Vector( -7840.2055664062, 5400.03125, -1481.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, 90, 0 ), Angle( 0, -90, 0 ) }

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 3 )
end

GAMEMODE:LoadNPC( NPC )
