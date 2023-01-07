--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- config
local tolerance = 1.1 -- Wait 1.1 seconds before deciding a crash has happened
local beginPause = 5 -- Wait before starting (TODO: Why?) Because of shitty lagging clients on join. Those would like to reconnect itself otherwise.

local time = RealTime

-- Local Globals D:
local crashed = true
local lastPong

local umsgName = "\8P"
local hookName = "Crash_Ticker"

local pongs = 0
usermessage.Hook( umsgName, function()
	pongs = pongs + 1
	if pongs > beginPause then
		usermessage.Hook( umsgName, function()
			lastPong = time()
		end )
	end
end )

hook.Add( "Move", hookName, function()
	if lastPong then
		hook.Add( "Move", hookName, function()
			lastPong = time()
		end )
	end
end)

hook.Add( "Tick", hookName, function()
	if not lastPong then return end
	local timeout = time() - lastPong
	if timeout > ( IsValid( LocalPlayer():GetVehicle() ) and tolerance * 2 or tolerance ) then
		crashed = true
		disableReconnect = false
		hook.Call( "CrashTick", nil, true, timeout + tolerance )
	elseif crashed then
		crashed = false
		hook.Call( "CrashTick", nil, false )
	end
end)


--[[hook.Add("InitPostEntity", "CasinoRadio", function()
	local casino_station = nil
	sound.PlayURL ( "http://stream.simulatorradio.com/stream.mp3", "3d", function( station )
		if ( IsValid( station ) ) then
	
			station:SetPos( Vector( 1844, 1595, 667 ) )
		
			station:Play()
	
			-- Keep a reference to the audio object, so it doesn't get garbage collected which will stop the sound
			casino_station = station
		
		else
	
			print("An error occured trying to play stream at casino!")
	
		end
	end )
end)]]

surface.CreateFont("retro_font", {
	font='Retro Gaming',
	size=25, 
	weight=0, 
	antialias=false, 
	additive=false
})

local bg = Color(34,34,34)
local borderbg = Color(17,17,17)
local ball = Color(255,255,255)
local raincolor = Color(22,162,255)
local border = 35
local pinglogo = Material("paris/PING1.png")
local sadlogo = Material("paris/sad.png")

local function createButton(panel)
	local button = vgui.Create("DButton", panel)
	button:SetText("")
	function button:Paint(w,h)
		-- background
		draw.RoundedBox(0,0,0,w,h,Color(100,100,100,255*math.abs(math.sin(CurTime()*4))))
		draw.RoundedBox(0,5,5,w-(5*2),h-(5*2),bg)
		draw.SimpleText(self.text or "", "retro_font", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	return button
end

local Rounds = {
	[1] = {speed = 1, maxspeed=1.3},
	[2] = {speed = 1, maxspeed=1.5},
	--[[[3] = {speed = 1.4, maxspeed=1.7},
	[4] = {speed = 1.3, maxspeed=1.5},
	[5] = {speed = 1.2, maxspeed=1.6},
	[6] = {speed = 1.2, maxspeed=0.9},
	[7] = {speed = 1, maxspeed=2.1},
	[8] = {speed = 1.3, maxspeed=1.7},
	[9] = {speed = 1.0, maxspeed=1.3},
	[10] = {speed = 1.0, maxspeed=2.7},]]
}
local rain = {}
concommand.Add("pong", function()
	local panel = vgui.Create("DFrame")
	panel:SetSize(800,640)
	panel:MakePopup()
	panel:Center()
	panel:SetTitle("Pong!")
	local px,py = 60, 640/2
	local vx, vy = 1, math.random(-1,1)
	local wallheight = 250
	local lpx, lpy = 0,0
	local lwx, lwy = 0,0
	local score = 0
	local diff = 1
	local round = 1
	local status
	local station
	local button
	function panel:OnClose()
		if IsValid(station) then station:Stop() end
	end
	local function ChangeStatus(stat)
		if stat == status then return end
		status = stat
		if IsValid(button) then button:Remove() end
		if stat == "gamemover" then
			if IsValid(station) then station:Stop() end
			surface.PlaySound("paris/pong/eplode.wav")
			sound.PlayFile( "sound/paris/pong/sadgameover.mp3", "", function( staton, errCode, errStr ) station = staton station:EnableLooping(true) end)
			button = createButton(panel)
			button:SetSize(200,40)
			button:SetPos((panel:GetWide()/2)-(button:GetWide()/2), panel:GetTall()*0.64)
			button.text = "MAIN MENU"
			function button:DoClick() panel:Remove() RunConsoleCommand("pong") if IsValid(station) then station:Stop() end end
		end
		if stat == "Menu" then
			if IsValid(station) then station:Stop() end
			sound.PlayFile( "sound/paris/pong/menu.mp3", "", function( staton, errCode, errStr ) station = staton station:EnableLooping(true) end)
			button = createButton(panel)
			button:SetSize(200,40)
			button:SetPos((panel:GetWide()/2)-(button:GetWide()/2), panel:GetTall()*0.65)
			button.text = "START"
			function button:DoClick() ChangeStatus("Game") end
		end
		if stat == "Game" then
			if IsValid(station) then station:Stop() end
		end
	end
	ChangeStatus("Menu")
	function panel:Paint(w,h)

		if status == "Menu" then
			-- background
			local bgrainbow = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			bgrainbow.a = 5
			draw.RoundedBox(0,0,0,w,h,bg)
			draw.RoundedBox(0,border,border,w-(border*2),h-(border*2),borderbg)
			draw.RoundedBox(0,border,border,w-(border*2),h-(border*2),bgrainbow)
			surface.SetMaterial(pinglogo)
			surface.SetDrawColor(255,255,255,255)
			local sinCool = 50*math.abs(math.sin(CurTime()*4))
			surface.DrawTexturedRectRotated(w/2,h*0.4,425+sinCool,153+sinCool,0)
			draw.SimpleText("Developed by Paris", "retro_font", border+5, h-5-border, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			draw.SimpleText("Version 1.0", "retro_font", w-(border+5), h-5-border, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
		elseif status == "Game" then
			-- background
			draw.RoundedBox(0,0,0,w,h,bg)
			draw.RoundedBox(0,border,border,w-(border*2),h-(border*2),borderbg)

			-- thinking
			local wx, wy = 10+border, select(2,input.GetCursorPos())-select(2,self:GetPos()) - (wallheight/2)
			if wy < border then wy = border end
			if wy+wallheight > h-border then wy = h-border-wallheight end

			math.Clamp(vx,-4,4)
			math.Clamp(vx,-4,4)

			local round = math.floor(score/250) + 1

			if round > #Rounds then 
				draw.SimpleText("YOU WIN!", "retro_font", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				return
			end

			px = px + (vx * FrameTime()*350*diff)
			py = py + (vy * FrameTime()*350*diff)
			if px > (w-5-border) then vx = -1 surface.PlaySound("paris/pong/wallhit.wav") score = score + 10 end
			if px < (wx+5) then
				if py > wy + wallheight or py < wy or (px < (10+border+(vx * FrameTime()*350*diff))) then -- GAME OVER
					ChangeStatus("gamemover")
					return
				else -- hit
					vx = 1
					vy = math.Clamp((((lwy-wy)*FrameTime()*-100)) + (vy*1.5),-3,3)
					surface.PlaySound("paris/pong/wallhit2.wav")
				end
			end
			if py < (5+border-(vy * FrameTime()*350*diff)) then vy = vy*-1 surface.PlaySound("paris/pong/wallhit.wav") score = score + 10 end
			if py > (h-5-border-(vy * FrameTime()*350*diff)) then vy = vy*-1 surface.PlaySound("paris/pong/wallhit.wav") score = score + 10 end

			lpx, lpy = px, py
			lwx, lwy = wx, wy

			local r = Rounds[round]
			diff = r.speed + ((r.maxspeed - r.speed) * (score/(round*250)))

			-- ball
			draw.RoundedBox(10,px,py,10,10,ball)

			-- wall
			draw.RoundedBox(0,wx,wy,5,wallheight,ball)

			-- Score
			draw.SimpleText("SCORE: " .. score, "retro_font", border, h-5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			draw.SimpleText("LEVEL: " .. round, "retro_font", w-border, h-5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

		elseif status == "gamemover" then
			draw.RoundedBox(0,0,0,w,h,bg)
			draw.RoundedBox(0,border,border,w-(border*2),h-(border*2),borderbg)

			for k, v in pairs(rain) do
				v[2] = v[2] + (FrameTime()*500)
				if v[2] > h then table.remove(rain,k) end
				draw.RoundedBox(0,v[1],v[2],5,50,raincolor)
			end

			surface.SetMaterial(sadlogo)
			surface.SetDrawColor(255,255,255,255)
			surface.DrawTexturedRectRotated(w/2,h*0.4,180,175,0)

			if math.random(30,70) == 69 then table.insert(rain,{math.random(0,w),0}) end

			draw.SimpleText("GAME OVER", "retro_font", w/2, h*0.6, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end)