--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

surface.CreateFont("GModNotify", {font="Helvetica", size=16, weight=900, antialias=true, additive=false})

NOTIFY_GENERIC			= 0
NOTIFY_ERROR			= 1
NOTIFY_UNDO			= 2
NOTIFY_HINT			= 3
NOTIFY_CLEANUP			= 4

local NoticeMaterial = {}
NoticeMaterial[ NOTIFY_GENERIC ] 	= Material( "paris/asoc32.png" )
NoticeMaterial[ NOTIFY_ERROR ] 		= surface.GetTextureID( "vgui/notices/error" )
NoticeMaterial[ NOTIFY_UNDO ] 		= surface.GetTextureID( "vgui/notices/undo" )
NoticeMaterial[ NOTIFY_HINT ] 		= Material( "paris/rpicon.png" )
NoticeMaterial[ NOTIFY_CLEANUP ] 	= surface.GetTextureID( "vgui/notices/cleanup" )

local HUDNote_c = 0
local HUDNote_i = 1
local HUDNotes = {}

net.Receive( "perp_notify", function()
	local Message = net.ReadString()
	AddNotify( Message, NOTIFY_GENERIC, 15 )
end )

net.Receive( "perp_rp_notify", function()
	local Message = net.ReadString()
	AddNotify( Message, NOTIFY_HINT, 7, true )
end )

function AddNotify( str, type, length, hideSound )
	Msg( str .. "\n" )
	
	if not hideSound then
		surface.PlaySound( "ambient/water/drip" .. math.random( 1, 4 ) .. ".wav")
	end
	
	local tab = {}
	tab.text 	= str
	tab.recv 	= SysTime()
	tab.len 	= length
	tab.velx	= -5
	tab.vely	= 0
	tab.x		= ScrW() + 200
	tab.y		= ScrH()
	tab.a		= 255
	tab.type	= type
	
	table.insert( HUDNotes, tab )
	
	HUDNote_c = HUDNote_c + 1
	HUDNote_i = HUDNote_i + 1
end

local GradientRight = Material("paris/gradient_right.png")

local function DrawNotice( self, k, v, i )
	local H = ScrH() / 1024
	local x = (v.x - 75 * H) - GAMEMODE.Options_SafeZone:GetInt()
	local y = (v.y - 300 * H) - GAMEMODE.Options_SafeZone:GetInt()
	
	if not v.w then
		surface.SetFont( "GModNotify" )
		v.w, v.h = surface.GetTextSize( v.text )
	end
	
	local w = v.w
	local h = v.h
	
	w = w + 20
	h = h + 20

	-- Outline & Background

	draw.RoundedBox( 0, x - w - h + 8, y - 8, w + h, h, Color( 12, 12, 12, v.a * 0.2 ) )
	--draw.RoundedBox( 0, x - w - h + 8, y, w, 2, Color( 30, 30, 30, v.a * 0.4 ) )

	surface.SetDrawColor( 22, 22, 22, v.a*0.9 )
	surface.SetMaterial( GradientRight )
	surface.DrawTexturedRect( x - w - h + 8, y - 8, w + h, h ) 

	surface.SetDrawColor( 201, 182, 112, v.a )
	surface.SetMaterial( GradientRight )
	surface.DrawTexturedRect( x - w - h + 8, y-8, w, 1 ) 

	draw.RoundedBox( 0, x - w - h + 8, y-8, 1, h, Color( 201, 182, 112, v.a ) )

	surface.SetDrawColor( 201, 182, 112, v.a )
	surface.SetMaterial( GradientRight )
	surface.DrawTexturedRect( x - w - h + 8, y+h-8, w, 1 ) 
	
	-- Draw Icon
	
	surface.SetDrawColor( 255, 255, 255, v.a )
	if isnumber(NoticeMaterial[ v.type ]) then
		surface.SetTexture( NoticeMaterial[ v.type ] )
	else
		surface.SetMaterial( NoticeMaterial[ v.type ] )
	end
	surface.DrawTexturedRect( x - w - h + 16, y - 4, h-8, h-8 ) 

	--[[draw.SimpleText( v.text, "GModNotify", x + 1, y + 1, Color( 0, 0, 0, v.a * 0.8), TEXT_ALIGN_RIGHT )
	draw.SimpleText( v.text, "GModNotify", x - 1, y - 1, Color( 0, 0, 0, v.a * 0.5), TEXT_ALIGN_RIGHT )
	draw.SimpleText( v.text, "GModNotify", x + 1, y - 1, Color( 0, 0, 0, v.a * 0.6), TEXT_ALIGN_RIGHT )
	draw.SimpleText( v.text, "GModNotify", x - 1, y + 1, Color( 0, 0, 0, v.a * 0.6), TEXT_ALIGN_RIGHT )]]
	draw.SimpleText( v.text, "GModNotify", x+1, y+1, Color( 0, 0, 0, v.a), TEXT_ALIGN_RIGHT )
	draw.SimpleText( v.text, "GModNotify", x, y, Color( 255, 255, 255, v.a), TEXT_ALIGN_RIGHT )
	
	local ideal_y = ScrH() - ( HUDNote_c - i ) * ( h + 4 )
	local ideal_x = ScrW()
	
	local timeleft = v.len - ( SysTime() - v.recv )
	
	-- Cartoon style about to go thing
	if timeleft < 0.8 then
		ideal_x = ScrW() - 50
	end
	 
	-- Gone!
	if timeleft < 0.5 then
		ideal_x = ScrW() + w * 2
	end
	
	local spd = RealFrameTime() * 15
	
	v.y = v.y + v.vely * spd
	v.x = v.x + v.velx * spd
	
	local dist = ideal_y - v.y
	v.vely = v.vely + dist * spd * 1
	if math.abs( dist ) < 2 and math.abs( v.vely ) < 0.1 then v.vely = 0 end
	local dist = ideal_x - v.x
	v.velx = v.velx + dist * spd * 1
	if math.abs( dist ) < 2 and math.abs( v.velx ) < 0.1 then v.velx = 0 end
	
	-- Friction.. kind of FPS independant.
	v.velx = v.velx * ( 0.95 - RealFrameTime() * 8 )
	v.vely = v.vely * ( 0.95 - RealFrameTime() * 8 )
end

hook.Add( "HUDPaint", "PaintNotes", function()
	if ( !HUDNotes ) then return end
		
	local i = 0
	for k, v in pairs( HUDNotes ) do
		if ( v ~= 0 ) then
			i = i + 1
			DrawNotice( self, k, v, i)		
		end
	end
	
	for k, v in pairs( HUDNotes ) do
		if ( v ~= 0 and v.recv + v.len < SysTime() ) then
			HUDNotes[ k ] = 0
			HUDNote_c = HUDNote_c - 1
			
			if HUDNote_c == 0 then HUDNotes = {} end
		end
	end
end )

local X, Y = 30, 200
local ShowLastMessage = 0

local RecentMessages = {}

hook.Add( "HUDPaint", "AdminNotify", function()
	for k, v in pairs( RecentMessages ) do
		if not v.Sent or v.Sent ~= 1 then
			if ShowLastMessage and ShowLastMessage + .5 > CurTime() then return end
			ShowLastMessage = CurTime()

			v.Sent = 1
			v.dietime = CurTime() + 10
		end

		if CurTime() >= v.dietime then
			table.remove( RecentMessages, k )
		else
			local remaining = math.ceil( v.dietime - CurTime() )
			local fade = math.Clamp( ( remaining * 255 ) / 2, 0, 255 )

			surface.SetFont( "Trebuchet18" )

			surface.SetTextColor( v.colour.r, v.colour.g, v.colour.b, fade )
			surface.SetTextPos( X, Y * k / 15 ) 
			surface.DrawText( v.text )
		end
	end
end )

net.Receive( "AdminNotify", function()
	local Text = net.ReadString()
	local Date = os.date( "*t" )

	local Message = {}
	Message.colour = net.ReadColor()
	Message.text = Format( "[%02i:%02i:%02i] %s", Date.hour, Date.min, Date.sec, Text )

	table.insert( RecentMessages, Message )
	Msg( Message.text .. "\n" )
end )