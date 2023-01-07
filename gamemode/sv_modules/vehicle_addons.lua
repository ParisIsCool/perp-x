--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local function EmitSoundTS( ent, snd, pch )
	ent:EmitSound( snd, 100, math.Clamp( GetConVarNumber( "host_timescale" ) * ( pch or 100 ), 1, 255 ) )
end

/*************************************************
	Command "perp_v_ug"
	Job: Turns underglow off/on
*************************************************/

concommand.Add( "perp_v_ug", function( Player, cmd, args )
	if not Player:InVehicle() then return end -- No vehicle
	if Player:GetVehicle().IsPassengerSeat then return end -- Not a real car :P
	if Player.DemoVehicle == Player:GetVehicle() then return end -- Demo vehicle

	local vehicleTable = Player:GetVehicle().vehicleTable
	if not vehicleTable then return end -- It's a chair

	local owner = Player:GetVehicle().Owner
	if not IsValid( owner ) then return end

	if not owner.Vehicles or not owner.Vehicles[ vehicleTable.ID ] then return end -- what the fuck ?

	if (not istable( owner.Vehicles[ vehicleTable.ID ][ "UnderGlow" ] )) or not owner.Vehicles[ vehicleTable.ID ][ "UnderGlow" ].r then return end -- not installed

	Player.lastUnderglowSwap = Player.lastUnderglowSwap or CurTime()
	if Player.lastUnderglowSwap > CurTime() then return end
	Player.lastUnderglowSwap = CurTime() + .25

	local UGPoses = {
		{Vector(0, 35, 9) },
		{Vector(0, -35, 9)}
	}

	if args[1] == "1" then 
		EmitSoundTS( Player:GetVehicle(), "buttons/lightswitch2.wav", 95 )
		for k, v in pairs( Player:GetVehicle().Underglow or {} ) do
			if IsValid( v ) then
				v:Remove()
			end
		end

		Player:GetVehicle().Underglow = nil
		Player:GetVehicle().UnderglowOn = nil
	end

	if not Player:GetVehicle().Underglow then
		Player:GetVehicle().Underglow = {}

		for k, v in pairs( Player:GetVehicle().vehicleTable.UnderglowPositions or UGPoses ) do
			local underglowLight = ents.Create( "light_dynamic" )
			underglowLight:SetParent( Player:GetVehicle() )
			underglowLight:SetLocalPos( v[1] )

			local realColor = Player:GetVehicle().UnderglowColor

			if not realColor or not realColor.r then return end

			underglowLight:SetKeyValue( "_light", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a or 0 )
			if owner:IsSuperAdmin() then
				underglowLight:SetKeyValue( "style", 11 )
			else
				underglowLight:SetKeyValue( "style", 0 )
			end
			underglowLight:SetKeyValue( "distance", 500 )
			underglowLight:SetKeyValue( "brightness", 6 )
			underglowLight:SetKeyValue( "_cone", 90 )
			underglowLight:SetKeyValue( "_inner_cone", 45 )
			underglowLight:SetKeyValue( "angles", "90 0 0" )
			underglowLight:SetKeyValue( "spotlight_radius", 120 )

			underglowLight:Spawn()

			table.insert( Player:GetVehicle().Underglow, underglowLight )
		end

		EmitSoundTS( Player:GetVehicle(), "buttons/lightswitch2.wav", 105 )
		Player:GetVehicle().UnderglowOn = true
	else
		EmitSoundTS( Player:GetVehicle(), "buttons/lightswitch2.wav", 95 )
		for k, v in pairs( Player:GetVehicle().Underglow ) do
			if IsValid( v ) then
				v:Remove()
			end
		end

		Player:GetVehicle().Underglow = nil
		Player:GetVehicle().UnderglowOn = nil
	end
end )

/*************************************************
	Command "perp_v_y"
	Job: Hydraluics
*************************************************/

concommand.Add( "perp_v_y", function( Player )
	if Player.nextHyd and Player.nextHyd > CurTime() then return end
	if not Player:InVehicle() then return end

	local vehicleTable = Player:GetVehicle().vehicleTable
	if not vehicleTable then return end

	local owner = Player:GetVehicle().Owner

	if not owner or not owner:IsPlayer() then return end
	if not owner.Vehicles or not owner.Vehicles[ vehicleTable.ID ] then return end
	if owner.Vehicles[ vehicleTable.ID ][ "Hydraulics" ] ~= 1 then return end

	Player:GetVehicle():GetPhysicsObject():ApplyForceCenter( Player:GetVehicle():GetUp() * Player:GetVehicle():GetPhysicsObject():GetMass() * 250 )

	Player.nextHyd = CurTime() + .5
end )

/* CONSTANT STEERING */

hook.Add( "PlayerLeaveVehicle", "ConstantSteering", function( Player, veh )
	veh.VC_Steer = 0
	if Player.VC_PESteer then
		for i=1, math.random( 28, 33 ) do
			veh:Fire( "Steer", Player.VC_PESteer )
		end
		veh.VC_Steer = Player.VC_PESteer
		Player.VC_PESteer = nil
	end
end )

hook.Add( "KeyPress", "SteeringPosition", function( Player, key )
	local veh = Player:GetVehicle()

	if IsValid( veh ) and veh:GetClass() == "prop_vehicle_jeep" then
		if key == IN_USE then
			if Player:KeyDown( IN_MOVERIGHT ) then
				Player.VC_PESteer = 1
			elseif Player:KeyDown( IN_MOVELEFT ) then
				Player.VC_PESteer = -1
			end
		end
	end
end )