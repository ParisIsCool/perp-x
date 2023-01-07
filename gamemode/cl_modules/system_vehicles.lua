--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.Vehicles = {}

net.Receive( "perp_vehicle_clear", function()
	GAMEMODE.Vehicles = {}
end )

net.Receive( "perp_vehicle_init", function()
	local CarID 		= net.ReadString()
	local PaintID 		= net.ReadInt(16) or 1
	local HeadLights 	= util.JSONToTable( net.ReadString() )
	local UnderGlow 	= util.JSONToTable( net.ReadString() )
	local DixieHorn 	= net.ReadInt(16) or 0
	local Hydraulics 	= net.ReadInt(16) or 0
	local AntiTheft 	= net.ReadInt(16) or 0
	local Disabled 		= net.ReadInt(16) or 0
	local License_Plate = util.JSONToTable( net.ReadString() )
	local Engine		= net.ReadInt(16) or 0
	local Turbo			= net.ReadInt(16) or 0
	local RGB 			= util.JSONToTable( net.ReadString() )
	local BodyGroups 	= util.JSONToTable( net.ReadString() )

	GAMEMODE.Vehicles[ CarID ] = { Turbo = Turbo, Engine = Engine, PaintID = PaintID, HeadLight = HeadLight, UnderGlow = UnderGlow, DixieHorn = DixieHorn, Hydraulics = Hydraulics, AntiTheft = AntiTheft, RGB = RGB, BodyGroups = BodyGroups, Disabled = Disabled, License_Plate = License_Plate }
end )

net.Receive( "perp_vehicle_toggle_state", function()
	local CarID 	= net.ReadString()
	local State		= net.ReadInt(16) or 0

	if not GAMEMODE.Vehicles[ CarID ] then return end
	GAMEMODE.Vehicles[ CarID ].Disabled = State
end )

net.Receive( "perp_vehicle_change", function()
	local ID 		= net.ReadString()
	local Key 		= net.ReadString()
	local State		= net.ReadInt(16) or 0

	if not GAMEMODE.Vehicles[ ID ] then return end
	GAMEMODE.Vehicles[ ID ][ Key ] = State
end )

net.Receive( "perp_vehicle_change_string", function()
	local ID 		= net.ReadString()
	local Key 		= net.ReadString()
	local State		= net.ReadString() or ""

	if not GAMEMODE.Vehicles[ ID ] then return end
	GAMEMODE.Vehicles[ ID ][ Key ] = State
end )

net.Receive( "perp_vehicle_change_table", function()
	local ID 		= net.ReadString()
	local Key 		= net.ReadString()
	local State		= net.ReadTable() or {}

	if not GAMEMODE.Vehicles[ ID ] then return end
	GAMEMODE.Vehicles[ ID ][ Key ] = State[1]
end )

/**************************************************
	VCMOD HELP IN CHAT (ON ENTRY OF VEHICLE) CL
**************************************************/

net.Receive("perp_vehicle_entered", function()
	local Player = net.ReadEntity()
	
	if not GAMEMODE.Options_ShowVCHelp:GetBool() then return end
		
	Player:PrintMessage( HUD_PRINTTALK, "-- Vehicle Information --")
	Player:PrintMessage( HUD_PRINTTALK, "F - Headlights")
	Player:PrintMessage( HUD_PRINTTALK, "F (Hold) - Aux lights.")
	Player:PrintMessage( HUD_PRINTTALK, "R - Start/Stop Vehicle")
	Player:PrintMessage( HUD_PRINTTALK, "N - Horn")
	Player:PrintMessage( HUD_PRINTTALK, "Alt + Arrow Keys - Indicators")
    Player:PrintMessage( HUD_PRINTTALK, "Radio - 'bind n +vehicles_radio_gui' in console.")
    Player:PrintMessage( HUD_PRINTTALK, "Modify controls - 'vcmod' in console.")
	Player:PrintMessage( HUD_PRINTTALK, "You can disable this message in your F1 Options menu.")
    Player:PrintMessage( HUD_PRINTTALK, "-------------------------")
end )

net.Receive( "vehicle_repair_msg", function()
	local CarID = net.ReadString()
	local Price = net.ReadInt(32)
	
	Derma_Query( "Appearantly your " .. VEHICLE_DATABASE[ CarID ].Name .. " is broken. Before you can spawn or put back your car you'll have to repair it.\n" ..
			"However, this would cost you $" .. util.FormatNumber( Price ) .. ".\n", "Your car is broken.",
			"Please repair my car. I'll pay you..", function() net.Start( "perp_v_rep" ) net.WriteString( CarID ) net.SendToServer() end )
end )

net.Receive( "vehicle_nothere_msg", function()
	Derma_Query( "You have to drive your current car back to the garage first.\n",
			"Where's your car?",
			"I'll get my car, one second..", function() end )
end )