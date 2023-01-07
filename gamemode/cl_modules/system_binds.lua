--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

net.Receive( "perp_spectate", function()
	local Entity = net.ReadEntity()

	if Entity ~= NULL and IsValid( Entity ) then
		PERP_SpectatingEntity = Entity
	else
		PERP_SpectatingEntity = nil
	end
end )

local UsedTime = 0
hook.Add( "Think", 'KeyCheck', function()
	if GAMEMODE.ChatBoxOpen then return end
	if UsedTime + 0.5 > CurTime() then return end

	if input.IsKeyDown( KEY_T ) then
		UsedTime = CurTime()
		return RunConsoleCommand( 'perp_tr' )
	elseif input.IsKeyDown( KEY_LBRACKET ) then
		UsedTime = CurTime()
		return RunConsoleCommand( 'perp_v_lal' )
	elseif input.IsKeyDown( KEY_RBRACKET ) then
		UsedTime = CurTime()
		return RunConsoleCommand( 'perp_v_ral' )
	elseif input.IsKeyDown( KEY_BACKSLASH ) then
		UsedTime = CurTime()
		return RunConsoleCommand( 'perp_v_td' )
	end
end)

local LastSpectating
function GM:PlayerBindPress( Player, Bind, Press )
	if string.find( string.lower( Bind ), "voicerecord" ) and not LocalPlayer():Alive() then return true end
	if string.find( string.lower( Bind ), "demorecord" ) then return true end
	if string.find( string.lower( Bind ), "zoom" ) then return true end

	if IsValid( PERP_SpectatingEntity ) and Press then
		if string.lower( Bind ) == "+jump" then
			RunConsoleCommand( "perp_a_ss" )

			return true
		elseif string.lower( Bind ) == "+attack" then
			local ToDo
			local GrabNext = false
			local First

			for _, v in pairs( player.GetAll() ) do
				if v == LocalPlayer() then continue end

				if not First then
					First = v
				end

				if GrabNext then
					ToDo = v
					break
				elseif v:UniqueID() == PERP_SpectatingEntity:UniqueID() then
					GrabNext = true
				end
			end

			if not ToDo then ToDo = First end
			LastSpectating = PERP_SpectatingEntity

			RunConsoleCommand( "perp_a_s", ToDo:UniqueID() )

			return true
		elseif string.lower( Bind ) == "+attack2" then
			if not IsValid( LastSpectating ) then return end

			RunConsoleCommand( "perp_a_s", LastSpectating:UniqueID() )

			return true
		end
	end

	local vT
	if LocalPlayer():InVehicle() then
		vT = lookForVT( LocalPlayer():GetVehicle() )
	end

	if Press and string.find( string.lower( Bind ), "+reload" ) then
		if LocalPlayer():InVehicle() and LocalPlayer():GetVehicle() then
			net.Start( "perp_v_su" ) net.SendToServer()
			return true
		end
	elseif Press and string.find( string.lower( Bind ), "+menu_context" ) and LocalPlayer():InVehicle() then
		RunConsoleCommand( "perp_v_y" )
	elseif Press and string.find( string.lower( Bind ), "impulse 201" ) and LocalPlayer():InVehicle() then
		RunConsoleCommand( "perp_v_ug" )
	elseif Press and string.find( string.lower( Bind ), "abuse_report_queue" ) then
		return
	end
end