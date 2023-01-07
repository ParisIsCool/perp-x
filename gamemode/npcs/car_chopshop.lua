--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local NPC = {};

NPC.Name = "Chop Shop";
NPC.ID = 134;

NPC.Model = Model("models/bala/gangboi.mdl")
NPC.Invisible = false;

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-3764,5539,48),ang=Angle(4,35,0)},
}

NPC.NoTalkSequence = true

NPC.Location ['rp_florida_v2'] = {Vector( -484.99530029297, 9146.341796875, 138.97186279297 ),}
NPC.Angles ['rp_florida_v2'] = {Angle( 2.0118193626404, -36.838005065918, 0)}

NPC.Location['rp_chaos_city_v33x_03'] = { Vector( -9440.1474609375, 14922.927734375, -1485.5725097656 ) }
NPC.Angles['rp_chaos_city_v33x_03'] = { Angle( 0, 42, 0) }

NPC.Location['rp_evocity_v4b1'] = Vector( 3835.0043945313, 6844.3500976563, 68.03125 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, -133.280, 0.000 )

NPC.Location['rp_rockford_v1b'] = Vector( -10296.544921875, 3381.7104492188, 8.03125 )
NPC.Angles['rp_rockford_v1b'] = Angle( 0, 9.577, 0.000 )

--Vector( -8808.8671875, -1289.3298339844, 8.03125 ), Angle( 1.1214500665665, 0.71586906909943, 0)

//Vector( -10272.725585938, 3386.2624511719, 8.03125 ), Angle( -0.36400723457336, 6.0865440368652, 0)


NPC.Location['rp_rockford_v2b'] = Vector(-10272.725585938, 3386.2624511719, 8.03125)
NPC.Angles['rp_rockford_v2b'] = Angle(-0.36400723457336, 6.0865440368652, 0)

NPC.Location['rp_paralake_city_v3'] = Vector(-12525.6875, 5751.7016601563, 8.0312538146973)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 140, 0)


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog( "'Ay G, what's happenin?" );

	GAMEMODE.DialogPanel:AddDialog( 'Hey man, will you take this car off my hands?', NPC.Chop )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind...", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show();
end

function NPC.Chop ( )
	local stolenVehicle;
	--//v4b1
	--for k, ent in pairs( ents.FindInSphere( Vector( 3835.0043945313, 6844.3500976563, 68.03125 ), 250 ) ) do
	--rockfordVector( -8600.2138671875, -1248.0665283203, 8.03125 ), Angle( 11.945461273193, 154.23178100586, 0)

	for k, ent in pairs( ents.FindInSphere( Vector(-3764,5539,48), 600 ) ) do

		if ent:IsValid() and ent:IsVehicle() and ent:GetClass() == "prop_vehicle_jeep" then
			stolenVehicle = ent;
		end
	end

	if ( !stolenVehicle || !IsValid( stolenVehicle ) ) then
		GAMEMODE.DialogPanel:SetDialog( "Uhm, what car?" );
		GAMEMODE.DialogPanel:AddDialog( "Oh, right. Let me go get it.", LEAVE_DIALOG );
		return;
	end

	GAMEMODE.DialogPanel:SetDialog( "Yeah I could do that." );

	GAMEMODE.DialogPanel:AddDialog( "Sounds fair lets do it.", NPC.ChopCar )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind.", LEAVE_DIALOG )
end

function NPC.ChopCar( )
	net.Start( "perp_pechop_car" ) net.SendToServer()
	LEAVE_DIALOG()
end

GAMEMODE:LoadNPC(NPC);
