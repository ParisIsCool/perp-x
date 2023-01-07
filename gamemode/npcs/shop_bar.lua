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

NPC.Name = "The Bar"
NPC.ID = 155

NPC.Model = Model( "models/humans/clanof06/male_06.mdl" )
NPC.Skin = 1
NPC.BodyGroups = {
    [1] = 1,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}
--
NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    {pos=Vector(4965,8183,144),ang=Angle(0,1,0)},
}

NPC.Location['rp_florida_v2'] = {Vector( -1974.4703369141, -5859.03125, 136.03125 ), Vector( -1755.2535400391, -5859.8784179688, 136.03125 ),}
NPC.Angles['rp_florida_v2'] = {Angle( 0.56652826070786, 89.779449462891, 0), Angle( 0.69852823019028, 89.779449462891, 0),}

NPC.Location['rp_evocity2_v3p'] = Vector(-7703.1943359375, 1245.8392333984, 148.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -7495, -6607, 72 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 90, 0 )


NPC.Location ['rp_evocity_v4b1'] = {
Vector(2597.521484375, -7105.8530273438, 104.03125),
Vector(2421.6474609375, -7391.0590820313, 104.03125),
Vector(5032.0859375, -7273.3002929688, 104.03125),
};

NPC.Angles ['rp_evocity_v4b1'] = {
Angle(0, 0, 0),
Angle(0, -90, 0),
Angle(0, 0, 0),
};


NPC.Location['rp_rockford_v1b'] = Vector( -9496.03125, -1075.2900390625, -287.96875 )
NPC.Angles['rp_rockford_v1b'] = Angle(-0.31145918369293, 0.13350173830986, 0)

NPC.Location['rp_rockford_v2b'] = Vector( -9496.03125, -1075.2900390625, -287.96875 )
NPC.Angles['rp_rockford_v2b'] = Angle(-0.31145918369293, 0.13350173830986, 0)


NPC.Location['rp_paralake_city_v3'] = Vector( -3495.96875, -5287.8813476563, 16.03125 )
NPC.Angles['rp_paralake_city_v3'] = Angle(0, -180, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = Vector( 3676, -9454, -1869 )
NPC.Angles[ "rp_chaos_city_v33x_03" ] = Angle( 0, 0, 0 )

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.OpenShop( 5 )
end

GAMEMODE:LoadNPC( NPC )
