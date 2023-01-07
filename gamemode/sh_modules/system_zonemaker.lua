--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local BigZones = BigZones

local StreetBlocks = StreetBlocks

local BuildingBlocks = BuildingBlocks

local CalculatedBlocks = CalculatedBlocks

if CLIENT then

	local cache = {}

	local EditZoneMode = false
	if EditZoneMode then
		local current = 0
		hook.Add( "PlayerButtonDown", "CheckForZonemakerButtons", function(ply, button)
			if not IsFirstTimePredicted() then return end
			if button == KEY_LALT then -- PRINT
				local str = "local testboxes = {"
				for k, v in pairs(cache) do
					str = str .. "\n\t{pos1=Vector("..v.pos1.x..","..v.pos1.y..","..v.pos1.z.."),pos2=Vector("..v.pos2.x..","..v.pos2.y..","..v.pos2.z..")},"
				end
				str = str .. "\n}"
				SetClipboardText(str)
			end
			if button == KEY_R then -- REMOVE
				local last = 0
				for k, v in ipairs(cache) do last = k end
				cache[last] = nil
			end
			if button == MOUSE_LEFT then -- ADD AT CURSOR
				if not cache[current] or table.Count(cache[current]) == 2 then
					current = table.insert(cache,{pos1=LocalPlayer():GetEyeTrace().HitPos})
				else
					cache[current]["pos2"] = LocalPlayer():GetEyeTrace().HitPos
				end
			end
			if button == MOUSE_RIGHT then -- ADD AT HEAD
				if not cache[current] or table.Count(cache[current]) == 2 then
					current = table.insert(cache,{pos1=LocalPlayer():EyePos()})
				else
					cache[current]["pos2"] = LocalPlayer():EyePos()
				end
			end
		end )

		local drawSimpleText = draw.SimpleText
		hook.Add( "PreDrawEffects", "PARIS_DrawBBoxVectors", function()
			--[[for k, v in pairs(BigZones) do
				render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), v.pos1, v.pos2, Color(82,255,226) )
			end
			for k, v in pairs(StreetBlocks) do
				render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), v.pos1, v.pos2, Color(255,255,255) )
			end
			for k, v in pairs(BuildingBlocks) do
				render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), v.pos1, v.pos2, Color(229,255,0) )
			end]]
			local pos = EyeAngles():Forward() * 50 + EyePos()
			render.SetColorMaterial()
			render.DrawBeam(pos, pos + Vector(5,0,0), 0.1, 1, 1, Color(255,0,0,255)) -- x
			render.DrawBeam(pos, pos + Vector(0,5,0), 0.1, 1, 1, Color(51,255,0)) -- y
			render.DrawBeam(pos, pos + Vector(0,0,5), 0.1, 1, 1, Color(0,153,255)) -- z
			cam.Start3D2D( pos, Angle(0,0,0), 0.1 )
				drawSimpleText( "Y", "perp_ZoneFont", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
			cam.End3D2D()
			cam.Start3D2D( pos, Angle(0,90,0), 0.1 )
				drawSimpleText( "X", "perp_ZoneFont", 0, 20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
			cam.End3D2D()
			for k, v in pairs(cache) do
				if v.pos1 and v.pos2 then
					render.DrawBox( Vector(0,0,0), Angle(0,0,0), v.pos1, v.pos2, color_white )
				else
					local pos = LocalPlayer():GetEyeTrace().HitPos
					if input.IsMouseDown( MOUSE_RIGHT ) then pos = EyePos() end
					render.DrawBox( Vector(0,0,0), Angle(0,0,0), v.pos1, pos, color_white )
				end
			end
		end)
	else
		hook.Remove( "PreDrawEffects", "PARIS_DrawBBoxVectors" )
		hook.Remove( "PlayerButtonDown", "CheckForZonemakerButtons" )
	end


end

if SERVER then
	local function BoxCheck()
		if not CalculatedBlocks then CalculatedBlocks = GAMEMODE.CalculatedBlocks end
		for _, v in ipairs( CalculatedBlocks ) do
			for _, ply in pairs(player.GetAll()) do
				if ply:GetPos():WithinAABox(v.pos1,v.pos2) then
					ply:SetNWString( "StreetBlocksName", v.name )
					ply:SetNWString( "SpeedLimit", GAMEMODE.CurrentSpeedLimits[v.streetid] or ""  )
				end
			end
		end
	end
	timer.Create( "BoxCheck", 0.5, 0, BoxCheck )
else
	surface.CreateFont( "perp_ZoneFont", {
		font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 22,
		weight = 500,
	})
	surface.CreateFont( "perp_ZoneFont_f", {
		font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 22,
		weight = 500,
		blursize = 1,
	})
	local drawSimpleText = draw.SimpleText
	local alpha = 0
	local lastloc
	local lastspeed
	hook.Add("HUDPaint", "DrawLocation", function()
		if not CalculatedBlocks then CalculatedBlocks = GAMEMODE.CalculatedBlocks end
		local safezone = GAMEMODE.Options_SafeZone:GetInt()
		if lastloc != LocalPlayer():GetNWString( "StreetBlocksName" ) then
			alpha = 1000
		end
		if lastspeed != LocalPlayer():GetNWString( "SpeedLimit" ) then
			alpha = 1000
		end
		if input.IsKeyDown(KEY_TAB) then
			alpha = 1000
		end
		alpha = alpha - (100*FrameTime())
		lastloc = LocalPlayer():GetNWString( "StreetBlocksName" )
		lastspeed = LocalPlayer():GetNWString( "SpeedLimit" )
		drawSimpleText( LocalPlayer():GetNWString( "StreetBlocksName" ), "perp_ZoneFont_f", ScrW() - safezone + 2, ScrH() - safezone - 60 + 2, Color( 0, 0, 0, alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
		drawSimpleText( LocalPlayer():GetNWString( "StreetBlocksName" ), "perp_ZoneFont", ScrW() - safezone, ScrH() - safezone - 60, Color( 255, 255, 255, alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )

		local text = LocalPlayer():GetNWString( "SpeedLimit" )
		if text != "" then text = text .. "MPH" end
		drawSimpleText( text, "perp_ZoneFont_f", ScrW() - safezone + 2, ScrH() - safezone - 120 + 2, Color( 0, 0, 0, alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
		drawSimpleText( text, "perp_ZoneFont", ScrW() - safezone, ScrH() - safezone - 120, Color( 255, 255, 255, alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
	end)
end


concommand.Add("speedlimit_editor", function()
	local frame = vgui.Create("perp_frame")
	frame:SetTitle("Speed Limit Editor")
	frame:SetSize(ScrW(),ScrH())
	frame:Center()
	local editor = vgui.Create("DButton",frame)
	editor:SetText("")
	editor:SetSize(ScrH(),ScrH())
	editor:SetPos((ScrW()/2)-(editor:GetWide()/2),(ScrH()/2)-(editor:GetTall()/2))
	local drawSimpleText = draw.SimpleText
	local closest = 0
	local mapmin,mapmax = game.GetWorld():GetModelBounds()
    local mapx = mapmax.x-mapmin.x
    local mapy = mapmax.y-mapmin.y
	local nomap = Vector(0,0,0)
	hook.Add( "PostDrawOpaqueRenderables", "SpeedLimitEditor", function()
		if paris.Mat then

			render.SetMaterial(paris.Mat)
			if not paris.Translate then
				paris.Translate = Vector(0,0,0)
			end

			render.DrawQuadEasy(Vector(0,0,0) + paris.Translate + Vector(0,0,250) + nomap, Vector(0,0,1)+nomap, mapx*(paris.ScaleX or 0), mapy*(paris.ScaleY or 0), paris.HUDColor, 90)

		end

		cam.IgnoreZ( true )
		local cpx,cpy = editor:LocalCursorPos()
		local cursorpos = Vector(((cpy/editor:GetWide())*-34000)+17000,((cpx/editor:GetTall())*-34000)+17000,400) + nomap
		for k, v in pairs(StreetBlocks) do
			render.DrawWireframeBox( Vector(0,0,0)+nomap, Angle(0,0,0), v.pos1, v.pos2, Color(255,255,255) )
			local center = v.pos1 + nomap
			if cursorpos:WithinAABox(v.pos1+nomap,v.pos2+nomap) then
				closest = k
			end
		end
		if StreetBlocks[closest] then
			local hovered = StreetBlocks[closest]
			render.SetColorMaterial()
			render.DrawBox( Vector(0,0,0) + nomap, Angle(0,0,0), hovered.pos1, hovered.pos2, Color(255,255,255) )
		end
		render.SetColorMaterial()
		render.DrawSphere(cursorpos,500,20,20,color_white)
		cam.IgnoreZ( false )

	end)
	function editor:Paint(w,h)
		local x, y = editor:GetPos()
		if paris.Mat then nomap = Vector(0,0,50000) end
		render.RenderView( {
			origin = Vector( 0, 0, 45000 ) + nomap,
			angles = Angle( 90, 0, 0 ),
			x = x, y = y,
			w = w, h = h,
			zfar = 60000,
			aspect = w/h,
			fov = 40,
		} )
		if StreetBlocks[closest] then
			local cpx,cpy = editor:LocalCursorPos()
			draw.SimpleTextOutlined( StreetBlocks[closest].name, "Default", cpx, cpy, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black )
			draw.SimpleTextOutlined( GAMEMODE.CurrentSpeedLimits[StreetBlocks[closest].streetid] or "ERROR" .. " MPH", "Default", cpx, cpy+20, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black )
		end
	end
	function editor:DoClick()
		local closest = closest
		local popup = vgui.Create("perp_frame")
		popup:SetTitle("Enter Speed Limit")
		popup:SetSize(200,160)
		popup:Center()
		local street = vgui.Create("perp_text",popup)
		street:SetSize(180,30)
		street:SetPos(10,40)
		street:SetText(StreetBlocks[closest].name)
		local textbox = vgui.Create("perp_textentry",popup)
		textbox:SetSize(50,30)
		textbox:SetPos((popup:GetWide()/2)-(textbox:GetWide()/2),80)
		function textbox:OnEnter()
			popup:Remove()
		end
		local button = vgui.Create("perp_button",popup)
		button:SetSize(100,30)
		button:SetPos(50,120)
		button:SetButtonText("Submit")
		button.DoClick = textbox.OnEnter
	end
	function frame:OnRemove()
		hook.Remove("PostDrawOpaqueRenderables", "SpeedLimitEditor")
	end
end)