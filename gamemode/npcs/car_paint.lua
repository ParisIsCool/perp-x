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

NPC.Name = "Paint Shop"
NPC.ID = 6

NPC.Model = Model( "models/humans/Group01/male_01.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_florida_v2'] = {Vector( -1630.3447265625, 4813.5947265625, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.16397908329964, 90.035942077637, 0)}

NPC.Location['rp_chaos_city_v33x_03'] = Vector(1676, -5838, -1868)
NPC.Angles['rp_chaos_city_v33x_03'] = Angle(0, -90, 0)

NPC.Location['rp_evocity2_v3p'] = Vector(1749.4393310547, -2465.1154785156, 76.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, -90, 0)

NPC.Location ['rp_rockford_v1b'] = { Vector(-5790.244141, -1959.968750, 4.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(5.720005, 88.689941, 0.000000) }

NPC.Location['rp_evocity_v33x'] = Vector( 4565, -3891, 64 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 180, 0 )

NPC.Location ['rp_rockford_v2b'] = { Vector(-5790.244141, -1959.968750, 4.031250) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(5.720005, 88.689941, 0.000000) }

NPC.Location['rp_evocity_v4b1'] = Vector( 4565, -3891, 64 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 180, 0 )

NPC.Location['rp_gta_city_v33x_03'] = {
	Vector( 1398.085693, -5720.198242, -1870.284912 )
	}
NPC.Angles['rp_gta_city_v33x_03'] = {
	Angle( 0, 133, 0 )
	}

	--Vector( -7740.0146484375, -9168.390625, 292.03125 ), Angle( 1.4090785980225, -0.019740305840969, -0)

NPC.Location['rp_paralake_city_v3'] = Vector( -7740.0146484375, -9168.390625, 292.03125 )
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 0, 0)


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()

	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local vehicleTable
	if (ourVehicle and IsValid(ourVehicle)) then
		vehicleTable = lookForVT(ourVehicle)
	end

	if vehicleTable and istable(vehicleTable) and vehicleTable.RGBColour then
		GAMEMODE.DialogPanel:Show()
		NPC.LightHop( true ) -- Skip the paintjobs, they arent used on those vehicles
		return true
	end

	GAMEMODE.DialogPanel:SetDialog( "'Ay G, what's happenin?" )

	GAMEMODE.DialogPanel:AddDialog( 'Erm... Hello, "G". Can I get a paint job?', NPC.Paint )
	GAMEMODE.DialogPanel:AddDialog( 'Do you do anything other than paint cars?', NPC.LightHop )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind...", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.PerformPaint( ID )
	local VehicleTable = lookForVT( LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL )

	if VehicleTable.RequiredClass then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)" )
		GAMEMODE.DialogPanel:AddDialog( "Oh, okay.", LEAVE_DIALOG )
		return
	end

	if LocalPlayer():GetCash() < VehicleTable.PaintJobCost then
		GAMEMODE.DialogPanel:SetDialog( "Are you sure you can pay for all of this?" )
		GAMEMODE.DialogPanel:AddDialog( "Not exactly...", LEAVE_DIALOG )
		return
	end

	GAMEMODE.DialogPanel:SetDialog( "<30 Minutes Later> There we go, it should be dried by now. That'll be $" .. util.FormatNumber( VehicleTable.PaintJobCost ) .. "." )
	GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )

	RunConsoleCommand( "perp_v_s", ID )

	GAMEMODE.Vehicles[ VehicleTable.ID ].PaintID = tonumber( ID )
end

function NPC.AntiTheftAlarm()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local VehicleTable = lookForVT( ourVehicle )

	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if (LocalPlayer():GetCash() < 25000) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?")
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)

		return
	end

	if GAMEMODE.Vehicles[ VehicleTable.ID ].AntiTheft == 1 then
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> There we go, I've removed your car's alarm system.")
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)

		GAMEMODE.Vehicles[VehicleTable.ID].AntiTheft = 0
	else
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> There we go, your car will be protected from theives! That'll be $" ..  util.FormatNumber( 25000 ) .. ".")
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)

		GAMEMODE.Vehicles[VehicleTable.ID].AntiTheft = 1
	end

	RunConsoleCommand("perp_v_ata")
end

function NPC.PerformLights ( ID )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local VehicleTable = lookForVT(ourVehicle)

	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if (LocalPlayer():GetCash() < (VehicleTable.PaintJobCost * 2)) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?")
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)

		return
	end

	GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> I hope you enjoy your new headlights. That'll be $" ..  util.FormatNumber( VehicleTable.PaintJobCost * 2 ) .. ".")
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)

	RunConsoleCommand("perp_v_l", ID)

	GAMEMODE.Vehicles[VehicleTable.ID].HeadLights = tonumber(ID)
end

function NPC.PerformUnderglow ( ID )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local VehicleTable = lookForVT(ourVehicle)

	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if not LocalPlayer().UnderglowLeFree then
		if LocalPlayer():GetCash() < VehicleTable.PaintJobCost * 2 then
			GAMEMODE.DialogPanel:SetDialog( "Are you sure you can pay for all of this?" )
			GAMEMODE.DialogPanel:AddDialog( "Not exactly...", LEAVE_DIALOG )

			return
		end

		GAMEMODE.DialogPanel:SetDialog( "<30 Minutes Later> I hope you enjoy your new underglow. That'll be $" ..  util.FormatNumber( VehicleTable.PaintJobCost * 2 ) .. "." )
	else
		GAMEMODE.DialogPanel:SetDialog( "<30 Minutes Later> I hope you enjoy your new underglow." )
	end

	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)

	LocalPlayer().UnderglowLeFree = nil

	RunConsoleCommand("perp_v_ugc", ID)

	GAMEMODE.Vehicles[VehicleTable.ID].UnderGlow = tonumber(ID)
end

function NPC.DixieHorn()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > CAR_PAINT_RANGE) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local vehicleTable = lookForVT(ourVehicle)

	if (vehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if GAMEMODE.Vehicles[vehicleTable.ID].DixieHorn == 1 then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you want me to remove your dixie horn? It'll cost full price to put them back on if you ever want to.")

		GAMEMODE.DialogPanel:AddDialog("Yes, I'm sure.", NPC.RemoveDixieHorn)
		GAMEMODE.DialogPanel:AddDialog("Let me think about it more.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Dixie horns cost $" .. "10,000 to install.")

		if (LocalPlayer():GetCash() >= 10000) then
			GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.PerformDixieHorn)
		end

		GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
	end
end

function NPC.RemoveDixieHorn()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local VehicleTable = lookForVT( ourVehicle )

	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> I've removed your dixie horn.")
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)

	RunConsoleCommand( "perp_v_dixie" )

	GAMEMODE.Vehicles[VehicleTable.ID].DixieHorn = 0
end

function NPC.PerformDixieHorn()
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	local VehicleTable = lookForVT( ourVehicle )

	if VehicleTable.RequiredClass then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if LocalPlayer():GetCash() < 10000 then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?")
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)

		return
	end

	GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> I hope you enjoy your new horn. That'll be $10,000.")
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)

	RunConsoleCommand("perp_v_dixie")

	GAMEMODE.Vehicles[VehicleTable.ID].DixieHorn = 1
end

function NPC.Paint ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > CAR_PAINT_RANGE) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local VehicleTable = lookForVT(ourVehicle)

	if VehicleTable.RequiredClass then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

		GAMEMODE.DialogPanel:SetDialog( ( VehicleTable.PaintText or "Nice " .. VehicleTable.Name ) .. " What color did you want on it? Either way, it'll be $" ..  util.FormatNumber( VehicleTable.PaintJobCost ) .. ". I only accept cash.")

		for k, v in pairs(VehicleTable.PaintJobs) do
			if v.color[2] and k ~= GAMEMODE.Vehicles[VehicleTable.ID].DixieHorn then
				GAMEMODE.DialogPanel:AddPaintOption(v.name, v.color[1], v.color[2], NPC.PerformPaint, k)
			else
				GAMEMODE.DialogPanel:AddPaintOption(v.name, v.color, nil, NPC.PerformPaint, k)
			end
		end

		GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
end

function NPC.Lights ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > CAR_PAINT_RANGE) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local VehicleTable = lookForVT(ourVehicle)

	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	GAMEMODE.DialogPanel:SetDialog("We have quite a few colors, which would you like? No matter what you choose, it'll be $" ..  util.FormatNumber( VehicleTable.PaintJobCost * 2 ) .. " to install.")

	for k, v in pairs(HEADLIGHT_COLORS) do
		if k == GAMEMODE.Vehicles[ VehicleTable.ID ].HeadLights then continue end
		if string.find( string.lower( v[3] ), "hunts" ) then
			if not LocalPlayer():SteamID() == "STEAM_0:1:19" then continue end
		end
		GAMEMODE.DialogPanel:AddPaintOption(v[3], v[2], nil, NPC.PerformLights, k)
	end

	GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
end

function NPC.Underglow ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local vehicleTable = lookForVT(ourVehicle)

	if (vehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if GAMEMODE.Vehicles[vehicleTable.ID].UnderGlow >= 1 then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you want me to remove your underglow? It'll cost full price to put them back on if you ever want to.")

		GAMEMODE.DialogPanel:AddDialog("Yes, I'm sure.", NPC.DoUnderglow)
		GAMEMODE.DialogPanel:AddDialog("Let me think about it more.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Underglow cost $" ..  util.FormatNumber( COST_FOR_UNDERGLOW ) .. " to install.")

		if (LocalPlayer():GetCash() >= COST_FOR_UNDERGLOW) then
			GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.DoUnderglow)
		end

		GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
	end
end

function NPC.UnderglowColors ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local VehicleTable = lookForVT(ourVehicle)

	if (VehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if not LocalPlayer().UnderglowLeFree then
		GAMEMODE.DialogPanel:SetDialog("We have quote a few colors, which would you like? No matter what you choose, it'll be $" ..  util.FormatNumber( VehicleTable.PaintJobCost * 2 ) .. " to install.")
	else
		GAMEMODE.DialogPanel:SetDialog("We have quote a few colors, which would you like? It is free to install only this once.")
	end

	for k, v in pairs(UNDERGLOW_COLORS) do
		if string.find( string.lower( v[3] ), "hunts" ) then
			if not LocalPlayer():SteamID() == "STEAM_0:1:14" then continue end
		end
		if k == GAMEMODE.Vehicles[ VehicleTable.ID ].UnderGlow then continue end
		GAMEMODE.DialogPanel:AddPaintOption(v[3], v[2], nil, NPC.PerformUnderglow, k)
	end

	if not LocalPlayer().UnderglowLeFree then GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG) end
end

function NPC.DoUnderglow ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local vehicleTable = lookForVT(ourVehicle)

	if (vehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if GAMEMODE.Vehicles[vehicleTable.ID].UnderGlow >= 1 then
		RunConsoleCommand("perp_v_uga")
		GAMEMODE.Vehicles[vehicleTable.ID].UnderGlow = 0

		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> Alright, I've removed them for you. Have a good day.")
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> You'll have fun with this, I promise. That'll be $" ..  util.FormatNumber( COST_FOR_UNDERGLOW ) .. ".\n\n(You can activate your underglow with the g key.)")

		LocalPlayer().UnderglowLeFree = true

		GAMEMODE.DialogPanel:AddDialog("Thanks! (SET COLOUR)", NPC.UnderglowColors)

		GAMEMODE.Vehicles[vehicleTable.ID].UnderGlow = 1
		RunConsoleCommand("perp_v_uga")
	end
end

function NPC.DoHydraulics ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > CAR_PAINT_RANGE) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local vehicleTable = lookForVT(ourVehicle)

	if (vehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if GAMEMODE.Vehicles[vehicleTable.ID].Hydraulics == 1 then
		RunConsoleCommand("perp_v_j")
		GAMEMODE.Vehicles[vehicleTable.ID].Hydraulics = 0

		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> Alright, I've removed them for you. Have a good day.")
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("<30 Minutes Later> You'll have fun with this, I promise. That'll be $" ..  util.FormatNumber( COST_FOR_HYDRAULICS ) .. ".\n\n(You can activate your hydraulics with the C key.)")
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)

		if (LocalPlayer():GetCash() < COST_FOR_HYDRAULICS) then return end

		GAMEMODE.Vehicles[vehicleTable.ID].Hydraulics = 1
		RunConsoleCommand("perp_v_j")
	end
end

function NPC.Hydraulics ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > CAR_PAINT_RANGE) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local vehicleTable = lookForVT(ourVehicle)

	if (vehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if GAMEMODE.Vehicles[vehicleTable.ID].Hydraulics == 1 then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you want me to remove your hydraulics? It'll cost full price to put them back on if you ever want to.")

		GAMEMODE.DialogPanel:AddDialog("Yes, I'm sure.", NPC.DoHydraulics)
		GAMEMODE.DialogPanel:AddDialog("Let me think about it more.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Hydraulics cost $" ..  util.FormatNumber( COST_FOR_HYDRAULICS ) .. " to install.")

		if (LocalPlayer():GetCash() >= COST_FOR_HYDRAULICS) then
			GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.DoHydraulics)
		end

		GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
	end
end

function NPC.ATAQuery ( )
	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > CAR_PAINT_RANGE) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you with that. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local vehicleTable = lookForVT(ourVehicle)

	if (vehicleTable.RequiredClass) then
		GAMEMODE.DialogPanel:SetDialog("I don't think I can help you with that car...\n\n(You cannot modify government vehicles.)")
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return
	end

	if GAMEMODE.Vehicles[vehicleTable.ID].AntiTheft == 1 then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you want me to remove your car alarm system? It'll cost full price to put them back on if you ever want to.")

		GAMEMODE.DialogPanel:AddDialog("Yes, I'm sure.", NPC.AntiTheftAlarm)
		GAMEMODE.DialogPanel:AddDialog("Let me think about it more.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Car Alarm System costs $25,000 to install.")

		if (LocalPlayer():GetCash() >= 25000) then
			GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.AntiTheftAlarm)
		end

		GAMEMODE.DialogPanel:AddDialog("Ouch, that's too expensive for me.", LEAVE_DIALOG)
	end
end

function NPC.LightHop( skipIntro )

	local ourVehicle = LocalPlayer():GetGNWVar( "Vehicle" ) and Entity( LocalPlayer():GetGNWVar( "Vehicle" ) ) or NULL

	if (!ourVehicle or !IsValid(ourVehicle) or ourVehicle:GetPos():Distance(LocalPlayer():GetPos()) > CAR_PAINT_RANGE) then
		GAMEMODE.DialogPanel:SetDialog("I'll need to see your car to help you. Where is it?")
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)

		return
	end

	local vehicleTable
	if (ourVehicle and IsValid(ourVehicle)) then
		vehicleTable = lookForVT(ourVehicle)
	end

	if (LocalPlayer():IsVIP()) then
		if skipIntro then
			if (!vehicleTable) then
				GAMEMODE.DialogPanel:SetDialog("'Ay im G! I install custom hydraulics, underglow, headlights, and now even an Car Alarm system! But I'll need to see your car first before I can give you any prices.")
				GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)
				return true
			elseif (vehicleTable.RequiredClass) then
				GAMEMODE.DialogPanel:SetDialog("'Ay im G! I install custom hydraulics, underglow, headlights, and now even an Car Alarm system!! But I can't install it on that car.\n\n(You cannot modify government vehicles.)")
				GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
				return true
			else
				GAMEMODE.DialogPanel:SetDialog("'Ay im G! I install custom hydraulics, underglow, headlights, and Car Alarm system!")
			end
		else
			if (!vehicleTable) then
				GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom hydraulics, underglow, headlights, and now even an Car Alarm system! But I'll need to see your car first before I can give you any prices.")
				GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG)
				return true
			elseif (vehicleTable.RequiredClass) then
				GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom hydraulics, underglow, headlights, and now even an Car Alarm system!! But I can't install it on that car.\n\n(You cannot modify government vehicles.)")
				GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
				return true
			else
				GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom hydraulics, underglow, headlights, and Car Alarm system!")
			end
		end

		if GAMEMODE.Vehicles[ vehicleTable.ID ].UnderGlow >= 1 then
			GAMEMODE.DialogPanel:AddDialog( "Can I change the color of my headlights?", NPC.Lights )
		else
			GAMEMODE.DialogPanel:AddDialog('How much do custom headlights cost?', NPC.Lights)
		end

		if GAMEMODE.Vehicles[ vehicleTable.ID ].UnderGlow >= 1 then
			GAMEMODE.DialogPanel:AddDialog( "Can I change the colour of my underglow lights?", NPC.UnderglowColors )
			GAMEMODE.DialogPanel:AddDialog('Can you remove this underglow for me?', NPC.Underglow)
		else
			GAMEMODE.DialogPanel:AddDialog('How much does underglow cost?', NPC.Underglow)
		end

		if GAMEMODE.Vehicles[ vehicleTable.ID ].Hydraulics == 1 then
			GAMEMODE.DialogPanel:AddDialog('Can you remove these hydraulics for me?', NPC.Hydraulics)
		else
			GAMEMODE.DialogPanel:AddDialog('How much do hydraulics cost?', NPC.Hydraulics)
		end

		if GAMEMODE.Vehicles[ vehicleTable.ID ].DixieHorn == 1 then
			GAMEMODE.DialogPanel:AddDialog('Can you remove my dixie horn for me?', NPC.DixieHorn)
		else
			//GAMEMODE.DialogPanel:AddDialog('How much does a dixie horn cost?', NPC.DixieHorn)
		end

		if GAMEMODE.Vehicles[ vehicleTable.ID ].AntiTheft == 1 then
			GAMEMODE.DialogPanel:AddDialog( "Can you remove my Car Alarm system for me?", NPC.ATAQuery )
		else
			GAMEMODE.DialogPanel:AddDialog( "How much is an Car Alarm system?", NPC.ATAQuery )
		end

		GAMEMODE.DialogPanel:AddDialog("Nevermind.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Of course. We also install custom headlights, hydraulics and now even underglow! But we don't do that for everybody that walks in here only for the people who give off an aura of awesomeness, which you aren't doing right now.\n\n(You must be a VIP member to further customize your vehicle.)")

		GAMEMODE.DialogPanel:AddDialog("Oh... Nevermind, then...", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show()
end

GAMEMODE:LoadNPC(NPC)
