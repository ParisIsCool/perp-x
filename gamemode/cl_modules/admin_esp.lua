--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

surface.CreateFont( "Font", { font = "Arial", size = 15, weight = 50, antialias = true, additive = false } )

local ESP = CreateClientConVar( "perp_esp", "0", true, false )
local ESP_d = CreateClientConVar( "perp_esp_d", "2000", true, false )

local black = Color(0,0,0,255)
local color_whitedown = Color(255,255,255,200)
local drawSimpleTextOutlined = draw.SimpleTextOutlined
local function DrawText( strText, strFont, tblColor, xPos, yPos )
	drawSimpleTextOutlined( strText, strFont, xPos, yPos, tblColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, black )
end

local color_whitelow = Color(255,255,255,10)
local color_redlow = Color(255,50,50,40)
local color_bluelow = Color(50,50,255,40)

hook.Add( "HUDPaint", "DrawAdminESP", function()
	if not LocalPlayer():IsSuperAdmin() then return end
	if ESP:GetInt() < 1 then return end

	local pos = Vector( 0, 0, 0 )

	if IsValid(PERP_SpectatingEntity) then pos = PERP_SpectatingEntity:GetPos() else pos = LocalPlayer():GetPos() end

	for _, v in pairs( ents.GetAll() ) do
		if not IsValid( v ) then continue end
		local class = v:GetClass()
		local conf_dist = ESP_d:GetInt()
		--if v:IsDormant() then return end
		if v:IsPlayer() then
			if v ~= LocalPlayer() and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then
				local mins, maxs = v:GetCollisionBounds(10,0)
				cam.Start3D()
				render.DrawWireframeBox( v:GetPos(), v:GetAngles(), mins, maxs, color_white )
				render.DrawLine( v:EyePos(), v:GetEyeTrace().HitPos, color_bluelow )
				cam.End3D()
				local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
				DrawText( v:Nick(), "Font", team.GetColor( v:Team() ), xPos, yPos )
				yPos = yPos + 13
				DrawText( v:SteamID(), "Font", color_white, xPos, yPos )
				yPos = yPos + 13
				DrawText( JOB_DATABASE[v:Team()].Name or "Unknown Class", "Font", color_white, xPos, yPos )
				yPos = yPos + 13
				DrawText( "HP: " .. v:Health(), "Font", color_white, xPos, yPos )
				yPos = yPos + 13
				DrawText( "A: " .. v:Armor(), "Font", color_white, xPos, yPos )
			end
		elseif v:GetClass() == "npc_vendor" then
			local mins, maxs = v:GetCollisionBounds(10,0)
			cam.Start3D()
			render.DrawWireframeBox( v:GetPos(), v:GetAngles(), mins, maxs, color_whitelow )
			cam.End3D()
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( v:GetNWString("Name") or "Unknown Name", "Font", color_white, xPos, yPos )
		end

		if v:IsVehicle() and IsValid( v:GetTrueOwner() ) and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then
			local mins, maxs = v:GetCollisionBounds(10,0)
			cam.Start3D()
			render.DrawWireframeBox( v:GetPos(), v:GetAngles(), mins, maxs, color_redlow )
			cam.End3D()
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( "Vehicle owned by " .. v:GetTrueOwner():Nick() .. " (" .. v:GetTrueOwner():SteamID() .. ")", "Font", color_whitedown, xPos, yPos )
		elseif class == "ent_weed" and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( "Weed Plant", "Font", color_white, xPos, yPos )
		elseif class == "ent_cocaine" and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( "Cocaine Plant", "Font", color_white, xPos, yPos )
		elseif class == "ent_shroom" and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( "Shroom", "Font", color_white, xPos, yPos )
		elseif class == "ent_meth" and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( "Meth", "Font", color_white, xPos, yPos )
		elseif class == "ent_roadspikes" and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( "Road Spikes", "Font", color_red, xPos, yPos )
			DrawText( "Owned by " .. v:GetGNWVar( "Owner" ):Nick() .. " (" .. v:GetGNWVar( "Owner" ):SteamID() .. ")", "Font", color_whitedown, xPos + 13, yPos + 13 )
		elseif class == "vc_spikestrip" and v:GetPos():DistToSqr( pos ) < (conf_dist*conf_dist) then //vcmod spikes
			local xPos, yPos = ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().x, ( v:GetPos() + Vector( 0, 0, 50 ) ):ToScreen().y
			DrawText( "Road Spikes", "Font", color_red, xPos, yPos )
			//vcmod spikes are not assigned an owner! :O
			//DrawText( "Owned by " .. v:GetGNWVar( "Owner" ):Nick() .. " (" .. v:GetGNWVar( "Owner" ):SteamID() .. ")", "Font", color_whitedown, xPos + 13, yPos + 13 )
		end
	end
end )
