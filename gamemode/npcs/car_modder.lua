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

NPC.Name = "Car Modifications"
NPC.ID = 25

NPC.Model = Model( "models/humans/group01/male_01.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	--{pos=Vector(-1679,6981,13),ang=Angle(2,1,0)},
}

NPC.Location ['rp_florida_v2'] = {Vector( -1530.1884765625, 4813.6577148438, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.4279790520668, 90.035942077637, 0)}

NPC.Location['rp_chaos_city_v33x_03'] = Vector(1550, -5832, -1868)
NPC.Angles['rp_chaos_city_v33x_03'] = Angle(0, -90, 0)

NPC.Location['rp_evocity2_v3p'] = Vector(1528, -2752, 76)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector( 4260, -3688, 64 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, -100, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( 4260, -3688, 64 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, -100, 0 )

NPC.Location ['rp_rockford_v1b'] =  Vector(-5521.555664, -1505.310425, 4.031250)
NPC.Angles ['rp_rockford_v1b'] =  Angle(0, 88.240005, 0.000000)

NPC.Location ['rp_rockford_v2b'] = { Vector(-5521.555664, -1505.310425, 4.031250) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(0.660002, 88.240005, 0.000000) }

--Vector( -7726.6508789063, -9453.8193359375, 292.03125 ), Angle( 2.9930808544159, -1.4057774543762, 0)

NPC.Location['rp_paralake_city_v3'] = Vector(-7713.2553710938, -9472.7353515625, 292.03125)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 0, 0)



function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "What can I do for you?" )

	GAMEMODE.DialogPanel:AddDialog( "I heard I can customize my car here", NPC.Customize )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind...", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.Customize()
	GAMEMODE.DialogPanel:SetDialog( "You've come to the right place!\nHowever we can only mod a certain amount of cars." )

	GAMEMODE.DialogPanel:AddDialog( "Can you mod this vehicle? (Select)", NPC.SelectVehicle )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind...", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.SelectVehicle()
	GAMEMODE.ShowGarageModView()
	LEAVE_DIALOG()
end

GAMEMODE:LoadNPC( NPC )
