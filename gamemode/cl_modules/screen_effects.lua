--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local mat_Overlay = Material("models/props_c17/fisheyelens")
local effectlerp = 0
local effectlerpinf = 0
hook.Add( "RenderScreenspaceEffects", "ScreenEffects", function()
	if not IsValid( LocalPlayer() ) then return end

	effectlerp = Lerp(FrameTime()*5,effectlerp,effectlerpinf)

	if IsValid( LocalPlayer():GetVehicle() ) then
		local iMPH = LocalPlayer():GetVehicle():GetVelocity():Length() / 17.6
		if iMPH > 80 then
			DrawMotionBlur( 0.2, ( iMPH - 80 ) * 0.015, FrameTime() )
			effectlerpinf = -0.0005*( iMPH - 80 )
		end
		if iMPH > 60 then
			-- stolen from gmod source code
			if ( mat_Overlay == nil || mat_Overlay:IsError() ) then return end

			render.UpdateScreenEffectTexture()

			// FIXME: Changing refract amount affects textures used in the map/models.
			mat_Overlay:SetFloat( "$envmap", 0 )
			mat_Overlay:SetFloat( "$envmaptint", 0 )
			mat_Overlay:SetFloat( "$refractamount", effectlerp )
			mat_Overlay:SetInt( "$ignorez", 1 )

			render.SetMaterial( mat_Overlay )
			render.DrawScreenQuad( true )
		end
	end

	--DrawMotionBlur( 0.2, math.Clamp( ( 40 - LocalPlayer():Health() ) * 0.01, 0, 1 ), FrameTime() )
end )

/* Drowning effects, credits to HeX at UnitedHosts */

local MAX_AIR 		= 300
local DRAIN_RATE	= 0.5
local FILL_RATE		= 0.7

local MaxHigh = MAX_AIR - 1
hook.Add( "HUDPaint", "MonitorDrowning", function()
	local ply = LocalPlayer()
	if not ply:Alive() then return end
	
	local Hight = ScrH()
	local ypos	= 340 * ( Hight / 500 )
	local xpos	= ScrW() * 0.07 - ( 102 * ( Hight / 480 ) / 2 )
	local wide	= 10  * ( Hight / 480 )
	local tall	= 80  * ( Hight / 480 )
	
	if ply.BAir == nil 	then ply.BAir 	= MAX_AIR 	end
	if not ply.FadeO2 	then ply.FadeO2 = 0 		end
	
	--draw.RoundedBox( 4, xpos - 2.5, ypos - 2, wide + 5, tall + 5, Color( 0, 0, 0, ply.FadeO2 ) )
	--draw.RoundedBox( 2, xpos + 1, ypos + 1, wide - 4, ( tall - 2 ) * math.Clamp( ply.BAir, 5, MAX_AIR ) / MaxHigh, Color( 110, 255, 255, ply.FadeO2 ) )
	
	if ply.BAir < MaxHigh and ply.FadeO2 < 255 then --using
		ply.FadeO2 = ply.FadeO2 + 3
		
	elseif ply.BAir > MaxHigh and ply.FadeO2 > 0 then --full
		ply.FadeO2 = ply.FadeO2 - 3
	end
end )

local function Air_DoBubbles( v )
	local CurTime = CurTime()
	if not v.BubbleTimer then
		v.BubbleTimer = CurTime + 0.07
	end
	if v.BubbleTimer and CurTime >= v.BubbleTimer then
		v.BubbleTimer = CurTime + 0.07
		
		local vOffset = v:LocalToWorld( Vector( 0,0, v:OBBMins().z ) )
		local emitter = ParticleEmitter( vOffset)
			local bubble = emitter:Add( "effects/bubble", v:GetPos() + Vector( 0, 0, 50 ) )
				if v:KeyDown( IN_FORWARD ) then
					bubble:SetVelocity( v:GetForward() * 700 )
				else
					bubble:SetVelocity( v:GetForward() * 180 )
				end
				
				bubble:SetGravity( Vector( 0, 0, 180 ) )
				bubble:SetDieTime( 4 )
				bubble:SetStartAlpha( 255 )
				bubble:SetEndAlpha( 0 )
				bubble:SetStartSize( 2 )
				bubble:SetEndSize( 4 )
				bubble:SetRoll( math.Rand( -180, 180 ) )
				bubble:SetRollDelta( math.Rand( -0.2, 0.2) )
				bubble:SetColor( Color( 255, 255, 255 ) )
				bubble:SetAirResistance( math.Rand( 150, 600 ) )
				bubble:SetBounce( 0.5 )
			bubble:SetCollide( true )
		emitter:Finish()
	end
end

hook.Add( "Tick", "MonitorDrowning", function()
	local Player = LocalPlayer()

	if IsValid( Player ) then
		local Vehicle = LocalPlayer():GetVehicle() -- they're in a vehicle?

		if Player:Alive() then
			if not Player.BAir then
				Player.BAir = MAX_AIR
			end
			
			if ( IsValid( Vehicle ) and Vehicle:WaterLevel() or Player:WaterLevel() ) >= 3 then
				if Player.BAir >= 0 then
					Player.BAir = Player.BAir - DRAIN_RATE
				end
				
				if Player.BAir > 10 then
					Air_DoBubbles( Player )
				end
			else --Above water
				if Player.BAir < MAX_AIR then
					Player.BAir = Player.BAir + FILL_RATE
				end
			end
		else
			if Player.BAir ~= MAX_AIR then
				Player.BAir = nil --Reset, death
			end
		end
	end
end )

local function DrawBlur(Alpha)
	local Fraction = 0.3

	local matBlurScreen = Material( "pp/blurscreen" )
	surface.SetMaterial( matBlurScreen )
	surface.SetDrawColor( 255, 255, 255, Alpha )

	for i=0.33, 1, 0.33 do
		matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
		matBlurScreen:Recompute()
		if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
	end
	draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(255,255,255,Alpha*0.1))
end

local ZoomViews = {}
ZoomViews["rp_southside"] = {
	[1] = {pos=Vector(4088,5048,3062),ang=Angle(90,180,0)},
	[2] = {pos=Vector(4088,5048,1562),ang=Angle(90,180,0)},
	[3] = {pos=Vector(4475,3842,531),ang=Angle(14,134,0),extratime=2},
	["ZoomZone"] = {[1]=Vector(3428,4527,556),[2]=Vector(2321,5588,-22)}
}
ZoomViews["rp_rockford_v2b"] = {
	[1] = {pos=Vector(-4596,-5158,4506),ang=Angle(89,-90,0)},
	[2] = {pos=Vector(-4597,-5193,2527),ang=Angle(89,-90,0)},
	[3] = {pos=Vector(-3311,-6926,318),ang=Angle(0,136,0)},
	["ZoomZone"] = {[1]=Vector(3428,4527,556),[2]=Vector(2321,5588,-22)}
}

local function ZoomInSpawn()

	local SpawnView = ZoomViews[game.GetMap()]
	local pos = LocalPlayer():GetPos()
	local Views = {
		[1] = {pos=pos+Vector(0,0,3500),ang=Angle(90,180,0)},
		[2] = {pos=pos+Vector(0,0,2800),ang=Angle(90,180,0)},
		[3] = {pos=pos+Vector(0,0,500),ang=Angle(90,180,0)},
	}
	if SpawnView and SpawnView.ZoomZone and pos:WithinAABox(SpawnView.ZoomZone[1],SpawnView.ZoomZone[2]) then
		Views = SpawnView
	end

	LocalPlayer():SetRenderMode(RENDERMODE_TRANSCOLOR)
	LocalPlayer():SetColor(Color(0,0,0,0))
	surface.PlaySound("paris/zoomzoom/wind2.wav")
	local wildangle = Angle(0,0,0)
	local wildangleinf = Angle(0,0,0)
	local view = Views[1]
	local viewnum = 1
	local alpha = 0
	local bluralpha = 255
	timer.Create("ShakeCameraLol", 0.5, 1000, function()
		wildangleinf = Angle(math.random(-6,6),math.random(-6,6),math.random(-6,6))
	end)
	timer.Simple(1, function()
		view = Views[2]
		viewnum = 2
		surface.PlaySound("paris/zoomzoom/1.wav")
		alpha = 255
		bluralpha = 255
	end)
	timer.Simple(2, function()
		view = Views[3]
		viewnum = 3
		zplus = 0
		surface.PlaySound("paris/zoomzoom/2.wav")
		alpha = 255
		bluralpha = 0
	end)
	timer.Simple(3 + (Views[3].extratime or 0), function()
		hook.Remove("PostRenderVGUI", "ZoomoutEffects")
		hook.Remove("ReceiveTimeSyncServer", "PostGamemodeLoaded")
		alpha = 255
		surface.PlaySound("paris/zoomzoom/3.wav")
		LocalPlayer():SetRenderMode(RENDERMODE_NORMAL)
		LocalPlayer():SetColor(Color(255,255,255,255))
	end)

	hook.Add("PostRenderVGUI", "ZoomoutEffects2", function()
		alpha = Lerp( 10 * FrameTime(), alpha, 0)
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(255,255,255,alpha))
	end)

	local lerpedview = view
	hook.Add( "PostRenderVGUI", "ZoomoutEffects", function()
	
		wildangle = LerpAngle( 0.1 * FrameTime(), wildangle , wildangleinf)
		if viewnum != 3 then
			lerpedview.pos = LerpVector(5*FrameTime(), lerpedview.pos, view.pos)
			lerpedview.ang = view.ang
		else
			lerpedview.pos = view.pos
			lerpedview.ang = view.ang
		end

		local viewdata = {
            x = 0,
            y = 0,
            w = ScrW(),
            h = ScrH(),
            type = "3D",
            origin = lerpedview.pos,
            angles = lerpedview.ang + wildangle,
            fov = 100,
            zfar = 50000,
			drawviewmodel = false,
			zfarviewmodel  = 50000
        }

        render.RenderView(viewdata)

		DrawBlur(bluralpha)

		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(255,255,255,alpha))
		
	end )
end

GM.ZoomInSpawn = ZoomInSpawn

concommand.Add("zoomzoom", function()
	ZoomInSpawn()
end)




local cin = false
local curshot = 1
local gameshots = {}
gameshots["rp_southside"] = {
	{
		{pos=Vector(-5226,-271,461),ang=Angle(11,61,30)},
		{pos=Vector(-3231,-442,461),ang=Angle(10,125,-10)},
	},
	{
		{pos=Vector(-1208,4270,39), ang=Angle(0,90,0)},
		{pos=Vector(-1205,3596,1717), ang=Angle(0,90,0)},
	},
	{
		{pos=Vector(-6812,12732,315),ang=Angle(3,-53,20)},
		{pos=Vector(-4745,12812,246),ang=Angle(4,-81,-5)},
	},
	{
		{pos=Vector(-2021,10205,738),ang=Angle(14,-21,-20)},
		{pos=Vector(-145,9417,463),ang=Angle(9,-23,0)},
	},
	--[[{
		{pos=Vector(1776,1207,2),ang=Angle(2,-129,0)},
		{pos=Vector(1748,549,-53),ang=Angle(-2,162,0)},
	},]]
	{
		{pos=Vector(-494,2632,16),ang=Angle(10,90,20)},
		{pos=Vector(-496,3179,-30),ang=Angle(13,88,10)},
	},
	{
		{pos=Vector(-725,9819,288),ang=Angle(3,-163,-20)},
		{pos=Vector(-1994,9577,219),ang=Angle(3,-137,20)},
	},
}
function GM:RollCinematics()
	cin = true
	local percent = 0
	local shots = gameshots[game.GetMap()] or {{{pos=Vector(0,0,600),ang=Angle(0,90,0)},{pos=Vector(0,0,800),ang=Angle(90,90,0)}}}
	GAMEMODE.DoNotDrawHUD = true
	hook.Add( "CalcView", "RollCinematics", function()
		percent = percent + (0.3*FrameTime())
		if percent > 1 then 
			percent = 0 
			curshot = curshot + 1
			if not shots[curshot] then
				curshot = 1
			end
		end
		if not shots[curshot] and percent < 1 then
			curshot = 1
		end
		local pos = shots[curshot][1].pos - ((shots[curshot][1].pos-shots[curshot][2].pos)*percent)
		local ang = shots[curshot][1].ang - ((shots[curshot][1].ang-shots[curshot][2].ang)*percent)
		local viewdata = {
            x = 0,
            y = 0,
            w = ScrW(),
            h = ScrH(),
            type = "3D",
            origin = pos,
            angles = ang,
            fov = 100,
            subrect = true, -- Maybe idk
            zfar = 50000,
            dopostprocess  = true,
            bloomtone  = true,
			drawviewmodel = false,
			drawhud = false,
			drawmonitors = false,
        }
		return viewdata
	end)
end
function GM:StopCinematics()
	cin = false
	hook.Remove("CalcView", "RollCinematics")
	GAMEMODE.DoNotDrawHUD = false
end




-- intro

local station
sound.PlayFile( "sound/paris/intro.mp3", "noplay", function( s, errCode, errStr )
	station = s
end )

local intro = false

concommand.Add("intro", function()
	if intro then GAMEMODE:StopIntro() else GAMEMODE:RollIntro() end
end)

local gtalogo = Material("paris/gtalogo.png")
local notif = Material("paris/notif.png")
local gtalogoglow = Material("paris/gtalogoglow.png")
local shots
surface.CreateFont( "CaptionIntro", { font = "pricedown bl", size = 100, weight = 800, antialias = true, additive = false } )

local aSocPNGIntro = {}
for i=80,1,-1 do
	aSocPNGIntro[i] = Material("paris/introasoc/asoclogo".. string.format("%02d",i-1) ..".png")
end

function GM:RollIntro()

	local curshot = 1
	gameshots = {}
	gameshots["rp_southside"] = {
		{
			{pos=Vector(-12834,-568,91),ang=Angle(90,0,0)},
			{pos=Vector(-8500,-557,91),ang=Angle(0,0,0)},
			speed = 0.15,
			fov=60,
			init = function()
				local startpos, endpos, time, curt = Vector(-13696,-613,-48), Vector(8332,-545,-103), 25, CurTime()
				local veh = ClientsideModel( "models/lonewolfie/ferrari_laferrari.mdl" )
				veh:SetPos(startpos)
				veh:SetAngles(Angle(0,-90,0))
				veh:Spawn()
				timer.Simple(2, function() sound.PlayFile( "sound/paris/introcar1.mp3","", function() end) end)
				hook.Add("PostRenderVGUI", "CarIntro", function()
					veh:SetPos(LerpVector( (CurTime()-curt)/(time), startpos, endpos ))
				end)
				timer.Create( "CarIntro", time, 1, function() veh:Remove() hook.Remove("PostRenderVGUI", "CarIntro") end )
			end
		},
		{
			{pos=Vector(-8500,-557,91),ang=Angle(0,0,0)},
			{pos=Vector(-4000,-557,91),ang=Angle(-30,0,0)},
			fov=60,
			speed = 0.2,
			logoalpha = 800,
			glowalpha = 300,
		},
		{
			{pos=Vector(-1208,4270,39), ang=Angle(0,90,0)},
			{pos=Vector(-1205,3596,1717), ang=Angle(0,90,0)},
			text = "Buy & Sell Real Estate",
		},
		{
			{pos=Vector(-1591,-1550,88),ang=Angle(9,-14,15)},
			{pos=Vector(-488,-1815,97),ang=Angle(16,-157,-15)},
			text = "Create & Expand your Corporate Empire",
		},
		{
			{pos=Vector(-1779,1632,453),ang=Angle(-10,97,-10)},
			{pos=Vector(-2426,2083,557),ang=Angle(-5,30,20)},
			speed = 0.2,
			text = "Create, Utilize, or Sell Weapons",
		},
		{
			{pos=Vector(-494,2632,16),ang=Angle(10,90,20)},
			{pos=Vector(-496,3179,-30),ang=Angle(13,88,10)},
			text = "Organize Heists",
		},
		{
			{pos=Vector(-11387,385,27),ang=Angle(0,95,10)},
			{pos=Vector(-11514,10029,400),ang=Angle(0,88,-20)},
			speed=0.15,
			text = "Street Race your Ride",
		},
		{
			{pos=Vector(3195,4900,275),ang=Angle(7,37,-10)},
			{pos=Vector(3193,5200,254),ang=Angle(3,-40,10)},
			speed=0.18,
			text = "Play the Game of Politics",
		},
		{
			{pos=Vector(6134,6249,644),ang=Angle(13,55,14)},
			{pos=Vector(6818,8039,328),ang=Angle(4,-19,-4)},
			text = "Protect the City",
		},
		{
			{pos=Vector(-8064,2934,3),ang=Angle(-4,-7,0)},
			{pos=Vector(-2933,2326,371),ang=Angle(-9,-6,0)},
			speed = 0.065,
			logoalpha = 1640,
			asocalpha = 2200,
			glowalpha = 300,
			fadeblack = -2200,
			asocvideo = -320
		}
	}
	gameshots["rp_rockford_v2b"] = {
		{
			{pos=Vector(-6706,9560,483),ang=Angle(90,-90,0)},
			{pos=Vector(-6702,2086,118),ang=Angle(-10,-90,0)},
			speed = 0.15,
			fov=95,
			init = function()
				local startpos, endpos, time, curt = Vector(-6713,9800,0), Vector(-6743,-5769,0), 12.3, CurTime()
				local veh = ClientsideModel( "models/lonewolfie/ferrari_laferrari.mdl" )
				veh:SetPos(startpos)
				veh:SetAngles(Angle(0,180,0))
				veh:Spawn()
				timer.Simple(2, function() sound.PlayFile( "sound/paris/introcar1.mp3","", function() end) end)
				hook.Add("PostRenderVGUI", "CarIntro", function()
					veh:SetPos(LerpVector( (CurTime()-curt)/(time), startpos, endpos ))
				end)
				timer.Create( "CarIntro", time, 1, function() veh:Remove() hook.Remove("PostRenderVGUI", "CarIntro") end )
			end
		},
		{

			{pos=Vector(-6702,2086,118),ang=Angle(-10,-90,0)},
			{pos=Vector(-6717,-3185,81),ang=Angle(-25,-90,0)},
			fov=95,
			speed = 0.2,
			logoalpha = 800,
			glowalpha = 300,
		},
		{
			{pos=Vector(7399,8154,1607),ang=Angle(1,-42,10)},
			{pos=Vector(7404,5057,1561),ang=Angle(0,-63,-5)},
			text = "Buy & Sell Real Estate",
		},
		{
			{pos=Vector(2884,3904,602),ang=Angle(1,179,0)},
			{pos=Vector(2879,1572,602),ang=Angle(1,179,0)},
			text = "Create & Expand your Corporate Empire",
			fov = 100,
			speed = 0.185
		},
		{
			{pos=Vector(12607,-11744,1000),ang=Angle(-1,77,-10)},
			{pos=Vector(13299,-2437,386),ang=Angle(-2,91,5)},
			speed = 0.19,
			text = "Create, Utilize, or Sell Weapons",
			fov = 100
		},
		{
			{pos=Vector(-4206,-3321,240),ang=Angle(2,-60,10)},
			{pos=Vector(-3866,-3852,280),ang=Angle(22,-120,-5)},
			text = "Organize Heists",
			speed = 0.18
		},
		{
			{pos=Vector(-14894,13101,596),ang=Angle(-3,0,0)},
			{pos=Vector(-1046,13198,1087),ang=Angle(32,-2,0)},
			speed=0.188,
			text = "Street Race your Ride",
		},
		{
			{pos=Vector(-4462,-4589,166),ang=Angle(-1,-153,-10)},
			{pos=Vector(-5146,-4945,216),ang=Angle(25,144-360,5)},
			speed=0.184,
			text = "Play the Game of Politics",
		},
		{
			{pos=Vector(-9341,-6163,41),ang=Angle(-5,37,10)},
			{pos=Vector(-9295,-4653,6),ang=Angle(-17,-49,-6)},
			fov = 90,
			text = "Protect the City",
		},
		{
			{pos=Vector(-1227,-2761,124),ang=Angle(-1,170,0)},
			{pos=Vector(-7010,-2084,180),ang=Angle(0,174,0)},
			speed = 0.065,
			logoalpha = 1500,
			asocalpha = 2200,
			glowalpha = 300,
			fadeblack = -2200,
			asocvideo = -300
		}
	}

	local shots = gameshots[game.GetMap()] or {{{pos=Vector(0,0,600),ang=Angle(0,90,0)},{pos=Vector(0,0,800),ang=Angle(90,90,0)},text="UNCONFIGURED INTRO! screen_effects.lua",speed=0.05}}
	curshot = 1
	sound.PlayFile( "sound/paris/intro.mp3", "noplay", function( s, errCode, errStr )
		station = s
		s:Play()
	end )
	intro = true
	local percent = 0
	local w,h = ScrW(), ScrH()
	local begginalpha = 500
	if shots[curshot].init then shots[curshot].init() end
	hook.Add( "PostRenderVGUI", "RollIntro", function()
		
		if not shots[curshot] then GAMEMODE:StopIntro() return end

		percent = percent + ((shots[curshot].speed or 0.2)*FrameTime())
		if percent > 1 then 
			percent = 0 
			curshot = curshot + 1
			if not shots[curshot] then
				GAMEMODE:StopIntro(true)
				return
			else
				if shots[curshot].init then shots[curshot].init() end
			end
		end
		local pos = shots[curshot][1].pos - ((shots[curshot][1].pos-shots[curshot][2].pos)*percent)
		local ang = shots[curshot][1].ang - ((shots[curshot][1].ang-shots[curshot][2].ang)*percent)
		local viewdata = {
            x = 0,
            y = 0,
            w = ScrW(),
            h = ScrH(),
            type = "3D",
            origin = pos,
            angles = ang,
            fov = shots[curshot].fov or 80,
            subrect = false, -- Maybe idk
            zfar = 100000,
            dopostprocess  = true,
            bloomtone  = true,
			drawviewmodel = false,
			drawhud = false,
			drawmonitors = false,
        }

        render.RenderView(viewdata)
	
		--return view
	end )
	local color_yellow = Color(164, 137, 56)
	hook.Add("PostRenderVGUI", "IntroRoll", function()
		begginalpha = begginalpha - (130*FrameTime())
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,begginalpha))
		if not shots[curshot]then
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,255))
			return
		end
		if shots[curshot].fadeblack then
			shots[curshot].fadeblack = shots[curshot].fadeblack + (250*FrameTime())
			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,shots[curshot].fadeblack))
		end
		if shots[curshot].logoalpha then
			if shots[curshot].glowalpha > 50 or shots[curshot].logoalpha < 255 then
				shots[curshot].glowalpha = shots[curshot].glowalpha - (150*FrameTime())
			end
			shots[curshot].logoalpha = shots[curshot].logoalpha - (150*FrameTime())
			surface.SetDrawColor(255,255,255,shots[curshot].glowalpha)
			surface.SetMaterial(gtalogoglow)
			surface.DrawTexturedRectRotated(w/2,h/2,523,438,0)
			surface.SetDrawColor(255,255,255,shots[curshot].logoalpha)
			surface.SetMaterial(gtalogo)
			surface.DrawTexturedRectRotated(w/2,h/2,432,347,0)
		end
		if shots[curshot].text then
			surface.SetDrawColor(255,255,255,255)
			surface.SetMaterial(notif)
			surface.DrawTexturedRectRotated(w/2,h*0.8,1642,459,0)
			draw.SimpleTextOutlined(shots[curshot].text,"CaptionIntro",w/2,h*0.8,color_yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,2,color_black)
		end
		if shots[curshot].asocvideo then
			shots[curshot].asocalpha = shots[curshot].asocalpha - (150*FrameTime())
			shots[curshot].asocvideo = shots[curshot].asocvideo + 30*FrameTime()
			if shots[curshot].asocvideo > 80 then shots[curshot].asocvideo = 80 end
			if shots[curshot].asocvideo >= 0 and shots[curshot].asocvideo <= 80 then
				surface.SetDrawColor(255,255,255,shots[curshot].asocalpha)
				surface.SetMaterial(aSocPNGIntro[math.Round(shots[curshot].asocvideo)])
				surface.DrawTexturedRectRotated(w*0.5,h*0.5,512,512,0)
			end
		end
	end)
end
function GM:StopIntro(doZoom)
	for i=20,1,-1 do
		timer.Simple(0.25*i, function()
			if IsValid(station) then station:SetVolume((20-i)/20) end
			if i==20 then 
				station:Stop()
				hook.Remove("PostRenderVGUI", "IntroRoll")
				if doZoom then
					ZoomInSpawn()
				end
				surface.PlaySound("paris/zoomzoom/3.wav")
			end
		end)
	end
	hook.Remove("PostRenderVGUI", "RollIntro")
	intro = false
	if shots then
		curshot = #shots
	end
end