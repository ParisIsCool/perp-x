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

NPC.Name = "Mr. Blackjack"
NPC.ID = 24

NPC.Model = Model( "models/humans/Group01/male_02.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.Location['rp_florida_v2'] = {
Vector( 163.22326660156, -5672.4702148438, 152.03125 ),
Vector( 160.96536254883, -5488.03125, 152.03125 ),
Vector( 1043.9278564453, -4515.0883789062, 152.03125 ),
Vector( 1044.9483642578, -4324.3852539062, 152.03125 ),
}
NPC.Angles['rp_florida_v2'] = {
Angle( -0.88517069816589, 0.70132195949554, 0),
Angle( -0.88517069816589, 0.70132195949554, 0),
Angle( -0.48917055130005, 179.69325256348, 0),
Angle( -0.48917055130005, 179.69325256348, 0),
}

NPC.Location['rp_evocity_v33x'] = {
	Vector( -3647, -6458, 198 ), -- Table Left
	Vector( -3510, -6458, 198 ) -- Table Right
}

NPC.Angles['rp_evocity_v33x'] = {
	Angle( 0, -90, 0 ),
	Angle( 0, -90, 0 )
}

NPC.Location['rp_evocity_v4b1'] = {
	Vector( -3647, -6458, 198 ), -- Table Left
	Vector( -3510, -6458, 198 ) -- Table Right
}

NPC.Angles['rp_evocity_v4b1'] = {
	Angle( 0, -90, 0 ),
	Angle( 0, -90, 0 )
}

NPC.Location ['rp_rockford_v2b'] = { 
	Vector(1871.5994873047, 1771.96875, 544.03125),
	Vector(1679.0498046875, 1771.96875, 544.03125),	
};
NPC.Angles ['rp_rockford_v2b'] = { 
	Angle(0, -90, 0),
	Angle(0, -90, 0) 
};


--Vector( 1871.5994873047, 1771.96875, 544.03125 ), Angle( 1.201154589653, -90.940475463867, 0)
--Vector( 1679.0498046875, 1771.96875, 544.03125 ), Angle( 1.201154589653, -90.940475463867, 0)


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() ~= TEAM_CITIZEN then
		LocalPlayer():Notify( "Government officials cannot play blackjack." )
		LocalPlayer():ClearForcedEyeAngles()
		return false
	end
	
	GAMEMODE.BlackJackWindow = vgui.Create( "perp_blackjack" )
end

GAMEMODE:LoadNPC( NPC )