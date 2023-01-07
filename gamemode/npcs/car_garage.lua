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

NPC.Name = "Garage"
NPC.ID = 5
NPC.ShowChatBubble = true

--NPC.Model = Model( "models/humans/Group01/female_03.mdl" )
-- NPC.Model = Model( "models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_03_hoodiepulloverjeans_npc.mdl" )
NPC.Model = Model( "models/humans/clanof06/male_06.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_florida_v2'] = {

Vector( 1801.9819335938, -645.87475585938, 136.03125 ),	--Parking Garage
Vector( -2915.3391113281, 5465.6127929688, 136.03125 ), --Car Dealership
Vector( 11316.088867188, 5451.7470703125, 136.03125 ), --Parking Lot (Sea Side)

}
NPC.Angles ['rp_florida_v2'] = {

Angle( 0, 0, 0), --Parking Garage
Angle( 0, 180, 0), --Car Dealership
Angle( 0, -90, 0), --Parking Lot (Sea Side)

}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(3983,4656,-56),ang=Angle(-3,-93,0)},
	{pos=Vector(-7096,1326,-40),ang=Angle(-1,-94,0)},
    {pos=Vector(-11838,9104,248),ang=Angle(0,90,0)}, -- Tunnel Garage
 }


NPC.Location ['rp_chaos_city_v33x_03'] = { Vector( 5506.3315429688, -5549.134765625, -1868.96875 ), Vector( 1423.3455810547, -5403.5302734375, -1868.96875 ) }

NPC.Angles ['rp_chaos_city_v33x_03'] = { Angle( 0, 0, 0 ), Angle( 0, 0, 0 ) }

NPC.Location ['rp_rockford_v1b'] = {
Vector(-7583.968750, -1586.289673, 452.038879),
Vector( -4023.9890136719, -1056.2808837891, 0.13125 ),
Vector(-3767.968750, -6448.840332, 5.031250),
Vector( -7150.474609375, -1921.5168457031, 0.044960021972656 ),
}

NPC.Angles ['rp_rockford_v1b'] = {
Angle(0, -1, 0),
Angle(0, 137, 0),
Angle(0, 16, 0),
Angle( 0, 52.760, 0 ),
}

NPC.Location ['rp_rockford_v2b'] = {
	--top garage
--Vector(-7583.968750, -1586.289673, 452.038879) ,
Vector( -4023.9890136719, -1056.2808837891, 0.13125 ),
Vector(-3767.968750, -6448.840332, 5.031250),
Vector( -11195.067382812, -3894.5173339844, -207.96875 ), --underground packing
}

NPC.Angles ['rp_rockford_v2b'] = {
--Angle(3, -1, 0),
Angle(3, 137, 0),
Angle(0, 16, 0),
Angle(0, -90, 0), --underground packing
}

NPC.Location['rp_evocity2_v3p'] = Vector(-2558.4768066406, -2015.1865234375, 76.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 180, 0)

NPC.Location['rp_evocity_v33x'] = {
	Vector( -5390, -10254, 71 ),
	Vector( 10416, 13253, 66 ),
	Vector( 5326, -5136, 64 ),
}

NPC.Angles['rp_evocity_v33x'] = {
	Angle( 0, 0, 0 ),
	Angle( 0, 90, 0 ),
	Angle( 0, -90, 0 )
}

NPC.Location['rp_evocity_v4b1'] = {
	Vector( -5390, -10254, 71 ),
	Vector( 10416, 13253, 66 ),
	Vector( 5326, -5136, 64 ),
}

NPC.Angles['rp_evocity_v4b1'] = {
	Angle( 0, 0, 0 ),
	Angle( 0, 90, 0 ),
	Angle( 0, -90, 0 )
}

NPC.Location['rp_paralake_city_v3'] = Vector(-8803.0048828125, -10561.681640625, 292.03125)
NPC.Angles['rp_paralake_city_v3'] = Angle(58.508987426758, 134.99356079102, 0)

NPC.Location['rp_paralake_city_v3'] = {
	Vector(-4602.7924804688, 2047.8348388672, 292.03125),
	Vector(-6520.6416015625, 9748.4853515625, 288.03125),
	Vector(-8803.0048828125, -10561.681640625, 292.03125)
}

NPC.Angles['rp_paralake_city_v3'] = {
	Angle(0, 90, 0),
	Angle(0, -140, 0),
	Angle(0, 144, 0)
}


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Can I help you?" )

	if LocalPlayer():Team() == TEAM_CITIZEN or LocalPlayer():Team() == TEAM_MAYOR or LocalPlayer():Team() == TEAM_SECRET_SERVICE or LocalPlayer():Team() == TEAM_DISPATCHER or LocalPlayer():Team() == TEAM_DETECTIVE then
		GAMEMODE.DialogPanel:AddDialog( "Yes, I've come to claim my car.", NPC.ClaimCar )
		GAMEMODE.DialogPanel:AddDialog( "I want to put my car in the garage.", NPC.HolsterCar )
		GAMEMODE.DialogPanel:AddDialog( "Where can I buy a vehicle?", NPC.BuyCar )
		GAMEMODE.DialogPanel:AddDialog( "I think I'm lost...", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:AddDialog( "No.", LEAVE_DIALOG )
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.BuyCar()
	GAMEMODE.DialogPanel:SetDialog( "Head to the Car Dealership! It's near the tunnel to Suburbia! Take a look at your map!" )

	GAMEMODE.DialogPanel:AddDialog( "Alright, thank you.", LEAVE_DIALOG )
end

function NPC.ClaimCar()
	GAMEMODE.ShowGarageView()
	LEAVE_DIALOG()
end

function NPC.HolsterCar()
	net.Start( "perp2_v_hol" ) net.SendToServer()
	LEAVE_DIALOG()
end

GAMEMODE:LoadNPC(NPC)
