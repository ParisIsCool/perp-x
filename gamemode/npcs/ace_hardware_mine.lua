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

NPC.Name = "Ace Hardware mine"
NPC.ID = 35

NPC.Sequence = 7;

NPC.Model = Model( "models/humans/Group01/male_06.mdl" )

NPC.Location, NPC.Angles = {}, {}

--[[NPC.Location['rp_evocity2_v3p'] = Vector(511.63497924805, -1441.7320556641, 76.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 90, 0)

NPC.Location['rp_evocity2_v5p'] = Vector(511.63497924805, -1441.7320556641, 76.03125)
NPC.Angles['rp_evocity2_v5p'] = Angle(0, 90, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -6841, -10456, 71 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 0, 0 )

NPC.Location['rp_evocity_hz_v4'] = Vector( -6841, -10456, 71 )
NPC.Angles['rp_evocity_hz_v4'] = Angle( 0, 0, 0 )

NPC.Location['rp_evocity_pulsar_v1'] = Vector( -6841, -10456, 71 )
NPC.Angles['rp_evocity_pulsar_v1'] = Angle( 0, 0, 0 )]]--

NPC.Location['rp_evocity_pulsar_v2'] = Vector( -6720.056641, -10600, 71 )
NPC.Angles['rp_evocity_pulsar_v2'] = Angle( 0, 90, 0 )

NPC.Location ['rp_rockford_v2b'] = { Vector(-7568.8051757812, -3179.0102539062, 8.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(-0.015103533864021, 0.52315580844879, 0) }
--Vector( -7568.8051757812, -3179.0102539062, 8.03125 ), Angle( -0.015103533864021, 0.52315580844879, 0)

NPC.Location ['rp_florida_v2'] = {Vector( 7802.666015625, -4699.1049804688, 136.03125 ),}
NPC.Angles ['rp_florida_v2'] = {Angle( 0, -90, 0)}

--[[NPC.Location['rp_evocity_v4b1'] = Vector(-6841.4838, -10456.2119, 71.0312)
NPC.Angles['rp_evocity_v4b1'] = Angle(0, 0, 0.000000)

NPC.Location['rp_paralake_city_v2'] = Vector(-7500, 3743, 308);
NPC.Angles['rp_paralake_city_v2'] = Angle(0, 90, 0.000000);

NPC.Location['rp_paralake_city_v3'] = Vector(-7170.295410, 3869.900391, 300);
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 90, 0.000000);

NPC.Location ['rp_rockford_v2b'] = { Vector(-7573.087402, -3026.144287, 12.031250) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(-0.062689, -18.477545, 0.000000) }

]]--

function NPC:RunBehaviour(NPCEnt)
    return NPC_HOVER(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 35 )
end

GAMEMODE:LoadNPC( NPC )