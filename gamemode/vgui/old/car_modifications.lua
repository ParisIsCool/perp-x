-- Taken from XLIB, funky stuff indeed
local function ToggleListing( Panel, Value )
	--Panel.TextEntry:SetEnabled( not Value )
	--Panel.TextEntry:SetPaintBackgroundEnabled( Value )
	Panel.DropButton:SetDisabled( Value )
	Panel.DropButton:SetMouseInputEnabled( not Value )
	Panel:SetMouseInputEnabled( not Value )
end

function ModifyVehicle( ID )
	if LocalPlayer():GetCash() < 10000 then return LocalPlayer():Notify( "You must have $10,000+ to modify your car." ) end
	local VTable = VEHICLE_DATABASE[ ID ]
	local DTable = GAMEMODE.Vehicles[ ID ]

	if not VTable then return Error( "Vehicle Database doesn't exist: '" .. ( ID or "nil" ) .. "'\n" ) end
	if not DTable then return Error( "You don't own this vehicle '" .. ( ID or "nil" ) .. "'\n" ) end

	net.Start( "perp_modify_vehicle" )
	net.WriteString(ID) -- id
	net.WriteString("start") -- modify type
	net.SendToServer()

	local BodyGroups = {}

	if not IsValid( car ) or car.value ~= ID then
		if IsValid( car ) then car:Remove() end -- derp car.value hmm

		local Details = VTable.PaintJobs[ GAMEMODE.Vehicles[ ID ].PaintID ]
		car = ClientsideModel( Details.model ) -- must be global or else is removed via garbagecollection
		car:SetSkin( Details.skin )

		if DTable.RGB then
			car:SetColor( DTable.RGB )
		end

		if DTable.BodyGroups then
			for k, v in pairs( DTable.BodyGroups ) do
				if isnumber(k) and isnumber(v) then
					car:SetBodygroup( k, v )
				end
			end
		end

		if game.GetMap():lower() == 'rp_evocity_v4b1' then
			car:SetPos( Vector( 4102, -3608, 64 ) )
			car:SetAngles( Angle( 0, 180, 0 ) )
		elseif game.GetMap():lower() == "rp_rockford_v2b" then
			car:SetPos( Vector( -3383, -836, 16 ) )
			car:SetAngles( Angle( 0, 180, 0 ) )
		elseif game.GetMap():lower() == "rp_florida_v2" then	
			car:SetPos( Vector( 6900.1918945312, -12247.592773438, 375.87533569336 ) )
			car:SetAngles( Angle( 0, -11, 0) )
		else
			car:SetPos( Vector( -242, 655, 1108 ) )
			car:SetAngles( Angle( 0, -60, 0 ) )
		end

		car:Spawn()
		car.value = ID
	end

	hook.Add( "CalcView", "CarEditor", function( Player, Pos, Angles, FOV )
		local View = {}
		if game.GetMap():lower() == 'rp_evocity_v4b1' then
			View.origin = Vector( 4100, -3811, 140 )
			View.angles = Angle( 10, 90, 0 )
		elseif game.GetMap():lower() == "rp_rockford_v2b" then
			View.origin = Vector( -3759.4282226563, -909.29840087891, 100 )
			View.angles = Angle( 20.744621276855, 12.269083976746, 0 )
		elseif game.GetMap():lower() == "rp_florida_v2" then
			View.origin = Vector( 7237.8647460938, -12257.012695312, 450.03463745117 )
			View.angles = Angle( -1.4839401245117, 179.19529724121, 0)
		else
			View.origin = Vector( 60, 428, 1234 )
			View.angles = Angle( 23, 143, 0 )
		end
		View.fov = FOV

		return View
	end )

	local BodyGroups = car:GetSortedBodyGroups()

	local DFrame = vgui.Create( "DFrame" )
		DFrame:SetSize( 200, 640 )
		DFrame:SetPos( 100, 100 )
		DFrame:SetTitle( "Car Modding - " .. VTable.Name )
		DFrame:SetVisible( true )
		DFrame:ShowCloseButton( false )
		DFrame:MakePopup()
	
	local PanelList = vgui.Create( "DPanelList", DFrame )
		PanelList:EnableHorizontal( false )
		PanelList:EnableVerticalScrollbar( true )
		PanelList:StretchToParent( 5, 25, 5, 5 )

	--[[             FRONT BUMPER                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 30 )
		DLabel:SetText( "Front Bumper" )
		DLabel:SetWide( 100 )
		if not BodyGroups.frontbumper or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		else
			DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		end
	
	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 50 )
		DComboBox:SetSize( 180, 20 )
		
		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.frontbumper == nil ) -- Disable feature

		if BodyGroups.frontbumper then
			for i = 1, BodyGroups.frontbumper.Values do
				DComboBox:AddChoice( "Custom #" .. i )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.frontbumper.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.frontbumper.ID ] = index - 1
				car:SetBodygroup( BodyGroups.frontbumper.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.frontbumper.ID, index - 1 )
			end
		end

	--[[             REAR BUMPER                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 70 )
		DLabel:SetText( "Rear Bumper" )
		if not BodyGroups.rearbumper or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		else
			DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		end
	
	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 90 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.rearbumper == nil ) -- Disable feature

		if BodyGroups.rearbumper then
			for i = 1, BodyGroups.rearbumper.Values do
				DComboBox:AddChoice( "Custom #" .. i )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.rearbumper.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.rearbumper.ID ] = index - 1
				car:SetBodygroup( BodyGroups.rearbumper.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.rearbumper.ID, index - 1 )
			end
		end

	--[[             SIDE SKIRTS                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 110 )
		DLabel:SetText( "Side Skirts" )
		if not BodyGroups.skirt or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		else
			DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		end
	
	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 130 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.skirt == nil ) -- Disable feature

		if BodyGroups.skirt then
			for i = 1, BodyGroups.skirt.Values do
				DComboBox:AddChoice( "Custom #" .. i )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.skirt.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.skirt.ID ] = index - 1
				car:SetBodygroup( BodyGroups.skirt.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.skirt.ID, index - 1 )
			end
		end

	--[[             BONNET                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 150 )
		DLabel:SetText( "Bonnet" )
		if not BodyGroups.hood or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		else
			DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		end
	
	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 170 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.hood == nil ) -- Disable feature

		if BodyGroups.hood then
			for i = 1, BodyGroups.hood.Values do
				DComboBox:AddChoice( "Custom #" .. i )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.hood.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.hood.ID ] = index - 1
				car:SetBodygroup( BodyGroups.hood.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.hood.ID, index - 1 )
			end
		end

	--[[             SPOILER                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 190 )
		DLabel:SetText( "Spoiler" )
		--if not BodyGroups.wing or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		--else
		--	DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		--end
	
	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 210 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.wing == nil ) -- Disable feature
/*
		if BodyGroups.wing then
			for i = 1, BodyGroups.wing.Values do
				DComboBox:AddChoice( "Custom #" .. i )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.wing.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.wing.ID ] = index - 1
				car:SetBodygroup( BodyGroups.wing.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.wing.ID, index - 1 )
			end
		end
*/
	--[[             RIMS                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 230 )
		DLabel:SetText( "Rims" )
		if not BodyGroups.wheel or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		else
			DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		end

	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 250 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.wheel == nil ) -- Disable feature

		if BodyGroups.wheel then
			for i = 1, BodyGroups.wheel.Values do
				DComboBox:AddChoice( "Custom #" .. i )
			end

			if VTable.ID == "D" then -- Audi TT rims are fucked.
				if BodyGroups.wheel.ID == 1 then
					DComboBox:ChooseOptionID( 0 )
					car:SetBodygroup( BodyGroups.wheel.ID, 0 )
				else
					DComboBox:ChooseOptionID( 1 )
					car:SetBodygroup( BodyGroups.wheel.ID, 1 )
				end
			else
				DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.wheel.ID ) + 1 )
			end

			function DComboBox:OnSelect( index, value, data )
				if VTable.ID == "D" then -- Audi TT rims are fucked.
					if index - 1 == 0 then
						index = 2
					else
						index = 1
					end
				end

				BodyGroups[ BodyGroups.wheel.ID ] = index - 1
				car:SetBodygroup( BodyGroups.wheel.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.wheel.ID, index - 1 )
			end
		end

	--[[             HEADLIGHTS                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 270 )
		DLabel:SetText( "Head lights" )
		if not BodyGroups.headlight or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		else
			DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		end

	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 290 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.headlight == nil ) -- Disable feature

		if BodyGroups.headlight then
			for i = 1, BodyGroups.headlight.Values do
				DComboBox:AddChoice( "Custom - #" .. i )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.headlight.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.headlight.ID ] = index - 1
				car:SetBodygroup( BodyGroups.headlight.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.headlight.ID, index - 1 )
			end
		end

	--[[             REAR LIGHTS                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 310 )
		DLabel:SetText( "Rear lights" )
		if not BodyGroups.rearlight or not LocalPlayer():IsVIP() then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		else
			DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		end

	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 330 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, BodyGroups.rearlight == nil ) -- Disable feature
		
		if BodyGroups.rearlight then
			for i = 1, BodyGroups.rearlight.Values do
				DComboBox:AddChoice( "Custom #" .. i )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.rearlight.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.rearlight.ID ] = index - 1
				car:SetBodygroup( BodyGroups.rearlight.ID, index - 1 )

				--RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.rearlight.ID, index - 1 )
			end
		end

	--[[             PAINT JOB                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 350 )
		DLabel:SetText( "Vehicle Skin" )
		--if not BodyGroups.rearlight then
			DLabel:SetColor( Color( 255, 0, 0, 255 ) )
		--else
		--	DLabel:SetColor( Color( 0, 255, 0, 255 ) )
		--end

	local DComboBox = vgui.Create( "DComboBox", DFrame )
		DComboBox:SetPos( 10, 370 )
		DComboBox:SetSize( 180, 20 )

		DComboBox:SetText( "Stock" )
		DComboBox:AddChoice( "Stock" )

		ToggleListing( DComboBox, true ) -- Disable feature
		
		--[[if BodyGroups.rearlight then
			for i = 1, BodyGroups.rearlight.Values do
				DComboBox:AddChoice( "Custom #" .. i + 1 )
			end

			DComboBox:ChooseOptionID( car:GetBodygroup( BodyGroups.rearlight.ID ) + 1 )

			function DComboBox:OnSelect( index, value, data )
				BodyGroups[ BodyGroups.rearlight.ID ] = index - 1
				car:SetBodygroup( BodyGroups.rearlight.ID, index - 1 )

				RunConsoleCommand( "perp_modify_vehicle", car.value, "modify", BodyGroups.rearlight.ID, index - 1 )
			end
		end]]

	--[[             COLOR CAR                ]]

	local DLabel = vgui.Create( "DLabel", DFrame )
		DLabel:SetPos( 10, 390 )
		DLabel:SetText( "Vehicle Color" )
		DLabel:SetColor( Color( 0, 255, 0, 255 ) )

	local InitColor
	local DColorMixer = vgui.Create( "DColorMixer", DFrame )
		DColorMixer:SetSize( 180, 120 )
		DColorMixer:SetPos( 10, 410 )
		DColorMixer:SetColor( car:GetColor() )
		DColorMixer.PaintOver = function()
			if not InitColor then -- some reason it gives a different colour without this.
				InitColor = true

				DColorMixer:SetColor( car:GetColor() )
			end
			car:SetColor( DColorMixer:GetColor() )
		end

	local RandomsLOL = { "Spinny spin spin", "Spin me", "Rotate me", "You spin me right round" }
	
	local DNumSlider = vgui.Create( "DNumSliderOld", DFrame )
		DNumSlider:SetPos( 10, 540 )
		DNumSlider:SetWide( 180 )
		DNumSlider:SetText( RandomsLOL[ math.random( #RandomsLOL ) ] )
		DNumSlider:SetMin( 0 )
		DNumSlider:SetMax( 360 )
		DNumSlider:SetValue( car:GetAngles().y or 45 )
		DNumSlider:SetDecimals( 0 ) 
		DNumSlider.ValueChanged = function( pSelf, fValue )
			local Angles = car:GetAngles() -- pitch, yaw, roll
			car:SetAngles( Angle( Angles.p, fValue, Angles.r ) )
		end

	--[[             BUTTONS                ]]
	
	local DButton = vgui.Create( "DButton", DFrame )
		DButton:SetSize( 180, 20 )
		DButton:SetPos( 10, 580 )
		DButton:SetText( "Finish" )
		DButton.DoClick = function( DButton )
			Derma_Query( "Are you sure you're done? This will be $10,000.", "Vehicle Customize",
			"No...", function() end,
			"Yeah, I'm done.", function()
				DFrame:Remove()
				hook.Remove( "CalcView", "CarEditor" )

				local Color = DColorMixer:GetColor()
				GAMEMODE.Vehicles[ car.value ].RGB = { r = Color.r, g = Color.g, b = Color.b, a = 255 }

				net.Start( "perp_modify_vehicle" ) 
				net.WriteString(car.value) -- id
				net.WriteString("save") -- modify type
				net.WriteTable({ r = Color.r, g = Color.g, b = Color.b, a = 255 } )
				net.WriteTable(BodyGroups)
				net.SendToServer()

				for k, v in pairs( BodyGroups ) do
					GAMEMODE.Vehicles[ car.value ].BodyGroups = GAMEMODE.Vehicles[ car.value ].BodyGroups or {}
					GAMEMODE.Vehicles[ car.value ].BodyGroups[ k ] = v
				end

				car:Remove()
				car = nil
			end )
		end
	
	local DButton = vgui.Create( "DButton", DFrame )
		DButton:SetSize( 180, 20 )
		DButton:SetPos( 10, 605 )
		DButton:SetText( "Cancel" )
		DButton.DoClick = function( DButton )
			DFrame:Remove()
			hook.Remove( "CalcView", "CarEditor" )

			net.Start( "perp_modify_vehicle" )
			net.WriteString(car.value) -- id
			net.WriteString("cancel") -- modify type
			net.SendToServer()
			car:Remove()
			car = nil
		end
end