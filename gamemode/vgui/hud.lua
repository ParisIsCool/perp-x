--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- This file has so many local variables for optimization.
-- Try not to add global any variables as the HUD is called every frame.

-- DOOR COLOR DATA IS NOW IN SH_MODULES/SYSTEM_PROPERTY
local DoorData = PERP_DoorData

-- THEME COLORS
local themecolor = Color(201, 182, 112)
local cashgreen = Color(98, 124, 101)
local genecolor = Color(140, 140, 140)
local grey = Color(110, 110, 110)
local speedyellowcolor = Color(255, 200, 0, 255)
local locply = LocalPlayer()
local color_red = Color(255,0,0)
local hungerbg = Color(0, 0, 0, 100)
local hungersliderbg = Color(92, 76, 34,255)
local hungerslider = Color(185, 153, 70,255)
local saturationslider = Color(73, 248, 132,255)
local moneytakered = Color(228,94,94)
local moneygivegreen = Color(84,255,96,255)

/**************************************************
		Fonts and shit
**************************************************/
local surface_CreateFont = surface.CreateFont
local surface_GetTextureID = surface.GetTextureID

surface_CreateFont( "PEChatFont", { size = ScreenScale(6.5), weight = 1000, antialias = true, bold = true, font = "Tahoma"})
surface_CreateFont( "PEChatFontShadow", { size = ScreenScale(6.5), weight = 1000, antialias = true, bold = true, font = "Tahoma", blursize = 1})
surface_CreateFont("PlayerNameFont", {font="Tahoma", size=20, weight=1000, antialias=true, additive=false})

local sizes = {18,20,24,30,40,50,60,80}
for _, v in pairs(sizes) do
	surface_CreateFont("perp2_opensans"..v, {font='Open Sans Condensed', size=v, weight=100, antialias=true, additive=false})
end

surface_CreateFont("perp2_RealtorFont", {
	font="Tahoma",
	size=ScaleToWideScreen(20),
})

surface_CreateFont("perp_playerinfo", {
	font = "PricedownGTAVInt",
	size = 42
})

surface_CreateFont("perp_playerinfo_small", {
	font = "PricedownGTAVInt",
	size = 37
})

local hudfonts = {[1]=65,[2]=50,[3]=40,[4]=30,[5]=16,[10]=100}
for k, v in pairs(hudfonts) do
	surface_CreateFont("hud_reputation_rank"..k, {
		font = "Roboto Bold",
		size = v,
		weight = 611,
	})
	surface_CreateFont("hud_reputation_rank"..k.."_s", {
		font = "Roboto Bold",
		size = v,
		weight = 611,
		blursize = 1
	})
end
local fontSmallH = draw.GetFontHeight("perp_playerinfo_small")

local RadioOnAlpha = 0

local Materials = {}
Materials["TypingText"] = surface_GetTextureID("PERP2/hud/typing")
Materials["Speedometer"] = Material("perp2/hud/speedometer.png")
Materials["SpeedometerNeedle"] = Material("perp2/hud/needle.png")
Materials["RadioMaterial"] = Material("paris/radio.png")
Materials["RadioGlowMaterial"] = Material("paris/radioglow.png")
Materials["Vignette"] = Material("paris/vignette.png")
Materials["Bloodsmear"] = Material("paris/Bloodsmear2.png")
Materials["ChatLogo"] = Material( "paris/asoclogosmall.png" )
Materials["GradientUp"] = Material( "gui/gradient_up" )
Materials["GradientDown"] = Material( "gui/gradient_down" )
Materials["GradientRight"] = Material("paris/gradient_right.png")
Materials["RP"] = Material("paris/rp.png")
Materials["RP128"] = Material("paris/rp128stroke.png")
local LevelUpAnim = {}
for i = 150,1,-1 do
	local n = i
	if n > 30 and n < 130 then
		n = 30
	end
	if n >= 130 then
		n = n - 90
	end
	LevelUpAnim[i] = Material("paris/anim_levelup/" .. string.format("%04d",n) .. ".png")
end
local aSocPNGIntro = {}
aSocPNGIntro.frame = 0
aSocPNGIntro.opacity = 500
aSocPNGIntro.pngs = {}
for i=80,1,-1 do
	aSocPNGIntro.pngs[i] = Material("paris/introasoc/asoclogo".. string.format("%02d",i-1) ..".png")
end

local Color = Color
local drawSimpleTextOutlined = draw.SimpleTextOutlined
local drawSimpleText = draw.SimpleText
local drawRoundedBox = draw.RoundedBox
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawRect = surface.DrawRect
local surface_SetTexture = surface.SetTexture
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local Lerp = Lerp
local surface_DrawPoly = surface.DrawPoly
local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize

local render = render

local oldspeed, oldrotation = 0, -180
local hunger, saturation = 0,0
local hungery, hungeryinf = 0, 0
local LastBank = 0
local LastBankAlpha = 0
local LastCash = 0
local LastCashText = ""
local LastCashColor = Color(84,255,96,255)
local LastCashAlpha = 0

local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local TEXT_ALIGN_LEFT = TEXT_ALIGN_LEFT
local TEXT_ALIGN_RIGHT = TEXT_ALIGN_RIGHT
local TEXT_ALIGN_TOP = TEXT_ALIGN_TOP
local TEXT_ALIGN_BOTTOM = TEXT_ALIGN_BOTTOM

local color_black = color_black
local strokeblack = Color(0,0,0)
local color_white = color_white

local FrameTime = FrameTime

local string = string
local mathRound = math.Round
local mathClamp = math.Clamp
local stringReplace = string.Replace
local IsValid = IsValid
local matBlurScreen = Material( "pp/blurscreen" )
local function DrawBlur(Fraction)

	surface_SetMaterial( matBlurScreen )
	surface_SetDrawColor( 255, 255, 255, Alpha )

	for i=0.33, 1, 0.33 do
		matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
		matBlurScreen:Recompute()
		if ( render ) then render.UpdateScreenEffectTexture() end
		surface_DrawTexturedRect( 0, 0, ScrW(), ScrH() )
	end
end

local lastKnownLevel
local animframe = false
if IsValid(LocalPlayer()) then
	LocalPlayer().lerpedrp = LocalPlayer():GetRP()
	lastKnownLevel = LocalPlayer():GetRPLevel()
end

RankUpAlpha = 1000

function GM:HUDPaint( )

	-- These variables are checked before every frame.
	local Width = ScrW()
	local Height = ScrH()

	locply = LocalPlayer()
	local GAMEMODE = GAMEMODE
	local safezone = GAMEMODE.Options_SafeZone:GetInt()
	local infoX = Width - safezone
	local infoY = safezone
	if GAMEMODE.Options_DrawHUD:GetInt() == 0 then return end
	local CurTime = CurTime()
	local RP_Ranks = GAMEMODE.RP_Ranks

	if locply:GetActiveWeapon() ~= NULL and (locply:GetActiveWeapon():GetClass() == "gmod_camera" or locply:GetActiveWeapon():GetClass() == "camera")  then return end
	if GAMEMODE.DoNotDrawHUD then return end

	local offset = 0

	/**************************************************
		Tooltips
	**************************************************/	
	if locply.tooltip and locply.tooltiptime > CurTime then
		local tooltip = locply.tooltip
		local lines = {}
		local longest = 0
		surface_SetFont("perp2_opensans20")
		for s in string.gmatch(tooltip, "[^\n]+") do
			table.insert(lines,s)
			local w,h = surface_GetTextSize(s)
			if w > longest then
				longest = w
			end
		end
		local lines_done = {}
		for k, str in pairs(lines) do
			lines_done[k] = {}
			local x = 0
			for n, p in pairs(string.Explode("[", str)) do
				local endofbutton = string.find(p,"]")
				if endofbutton then
					local btntext = string.Left(p,endofbutton-1)
					local rest = string.Right(p,#p-endofbutton)
					if #p == endofbutton then
						rest = ""
					end
					local w,h = surface_GetTextSize(btntext)
					table.insert(lines_done[k],{
						text = btntext,
						w = w,
						h = h,
						x = x,
						isButton = true
					})
					x = x + w
					local w,h = surface_GetTextSize(rest)
					table.insert(lines_done[k],{
						text = rest,
						w = w,
						h = h,
						x = x,
						isButton = false
					})
					x = x + w
				else
					local w,h = surface_GetTextSize(p)
					table.insert(lines_done[k],{
						text = p,
						w = w,
						h = h,
						x = x,
						isButton = false
					})
					x = x + w
				end
			end
		end
		local tw, th = 20+longest,20+#lines*20
		drawRoundedBox(2,safezone,safezone,tw,th,Color(5,5,5,210))
		for k, v in pairs(lines_done) do
			for _, str in pairs(v) do
				local col = color_white
				if str.isButton then
					col = color_black
					drawRoundedBox(3,safezone+10+str.x,safezone+10+((k-1)*20),str.w,20,color_white)
				end
				drawSimpleText(str.text, "perp2_opensans20", safezone+10+str.x, safezone+10+(k*20), col, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			end
		end
	end

	/**************************************************
		aSoc loading icon
	**************************************************/	
	if aSocPNGIntro.frame >= 80 then
		aSocPNGIntro.frame = 80
		aSocPNGIntro.backwards = true
	elseif aSocPNGIntro.frame <= 1 then
		aSocPNGIntro.frame = 1
		aSocPNGIntro.backwards = false
	end
	if aSocPNGIntro.backwards then
		aSocPNGIntro.frame = (aSocPNGIntro.frame) - (120*FrameTime())
	else
		aSocPNGIntro.frame = (aSocPNGIntro.frame) + (120*FrameTime())
	end
	if aSocPNGIntro.frame >= 80 then
		aSocPNGIntro.frame = 80
		aSocPNGIntro.backwards = true
	elseif aSocPNGIntro.frame <= 1 then
		aSocPNGIntro.frame = 1
		aSocPNGIntro.backwards = false
	end
	aSocPNGIntro.opacity = aSocPNGIntro.opacity - (150*FrameTime())
	if aSocPNGIntro.opacity > 0 then
		local frame = aSocPNGIntro.pngs[math.Round(aSocPNGIntro.frame)]
		surface_SetMaterial(frame)
		surface_SetDrawColor(255,255,255,aSocPNGIntro.opacity)
		surface_DrawTexturedRectRotated( infoX - 24, Height - infoY - 24, 48, 48, 0 )
	end

	/**************************************************
		Reputation
	**************************************************/	
	local Wide = 350
	infoY = infoY + 30
	if input.IsKeyDown(KEY_TAB) then
		RankUpAlpha = 500
	end
	RankUpAlpha = RankUpAlpha - (200*FrameTime())
	color_black.a = RankUpAlpha
	color_white.a = RankUpAlpha
	local function DrawLevel(x,y,level)
		surface_SetMaterial(Materials["RP128"])
		surface_SetDrawColor(themecolor.r, themecolor.g, themecolor.b,RankUpAlpha)
		surface_DrawTexturedRectRotated( x, y, 64, 64, 0 )
		local rplevel = tostring(level)
		local font = "hud_reputation_rank"..mathClamp(#rplevel,1,4)
		
		drawSimpleText(rplevel, font.."_s", x, y, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		drawSimpleText(rplevel, font, x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	local rplevel = locply:GetLerpedRPLevel()
	local rp = locply:GetRP()
	if rp != locply.lerpedrp then RankUpAlpha = 500 end
	if not locply.lerpedrp then locply.lerpedrp = 0 end
	if locply.lerpedrp < rp then locply.lerpedrp = locply.lerpedrp + 250*FrameTime() end
	if locply.lerpedrp > rp then locply.lerpedrp = rp end
	DrawLevel((Width/2)+(Wide/2)+50,infoY,rplevel+1)
	if rplevel > 0 then
		DrawLevel((Width/2)-((Wide/2)+50),infoY,rplevel)
	end
	local BoxWidth = (Wide/10) - 5
	themecolor.a = 50*(RankUpAlpha/255)
	for i=10,1,-1 do
		drawRoundedBox(0,((Width/2)-(Wide/2))+(((BoxWidth+5))*(i-1)),infoY-3,BoxWidth,6,themecolor)
	end
	themecolor.a = RankUpAlpha
	local lastlevel = RP_Ranks[math.floor(rplevel)] or 0
	local nextlevel = RP_Ranks[math.floor(rplevel+1)]
	if not nextlevel then nextlevel = RP_Ranks[math.floor(rplevel)] end
	local ratio = (locply.lerpedrp-lastlevel)/(nextlevel-lastlevel)
	for i=10,1,-1 do
		local r = mathClamp((ratio*10)-(i-1),0,1)
		drawRoundedBox(0,((Width/2)-(Wide/2))+(((BoxWidth+5))*(i-1)),infoY-3,BoxWidth*r,6,themecolor)
	end
	drawSimpleTextOutlined(tostring(mathRound(locply.lerpedrp)) .. "/" .. tostring(nextlevel), "hud_reputation_rank5", Width/2, infoY + 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)
	if lastKnownLevel and rplevel > lastKnownLevel and ( rplevel - lastKnownLevel ) == 1 then
		animframe = 1
		surface.PlaySound("paris/rankup3.mp3")
	end
	if isnumber(animframe) then
		local offsetY = 200
		local a = 255
		if animframe < 15 then
			a = (animframe/15) * 255
		end
		if animframe > 135 then
			a = ((((animframe-135)/15)*-1)+1) * 255
		end
		color_black.a = a
		color_white.a = a
		surface_SetMaterial(LevelUpAnim[math.Round(animframe)])
		surface_SetDrawColor(themecolor.r, themecolor.g, themecolor.b,255)
		surface_DrawTexturedRectRotated( Width/2, offsetY, 256, 256, 0 )
		drawSimpleText(rplevel, "hud_reputation_rank10_s", Width/2, offsetY, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		drawSimpleText(rplevel, "hud_reputation_rank10", Width/2, offsetY, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		animframe = animframe + 30*FrameTime()
		if math.Round(animframe) >= 150 then animframe = false end
	end
	color_black.a = 255
	color_white.a = 255
	themecolor.a = 255
	lastKnownLevel = rplevel
	infoY = infoY - 30

	/**************************************************
		Arrested
	**************************************************/	

	if (locply.isArrested) then
		surface_SetDrawColor( 0, 0, 0, 255 )
		surface_SetMaterial(Materials["GradientDown"])
		surface_DrawTexturedRect(0,0,Width,300)
		drawSimpleTextOutlined( "You Are Currently Restrained", "perp_playerinfo", ( Width / 2 ), ( Height - Height) + 10, color_white, TEXT_ALIGN_CENTER, 0, 2, color_red)
	end

	/**************************************************
			HUD Info (Time Played, Money, Ammo, Gun, etc.)
	**************************************************/		

	--[[
		Cash and Bank
	]]
	
	local plybank = locply:GetBank()
	drawSimpleTextOutlined("Bank $"..plybank, "perp_playerinfo", infoX, infoY + offset, color_white, 2, 0, 2, color_black)
	
	offset = offset + fontSmallH + 5
	
	if LastBank != plybank then
		local num = LastBank - plybank
		if LastBankAlpha > 0 then
			local oldnum = stringReplace(LastBankText,"+","")
			oldnum = tonumber(stringReplace(oldnum," $","")) or 0
			if (oldnum < 0 and (LastBank - plybank) > 0) or (oldnum > 0 and (LastBank - plybank) < 0) then
				num = (oldnum*-1) + LastBank - plybank
			end
		end
		if num > 0 then
			LastBankColor = moneytakered
			LastBankText = "- $" .. tostring(num)
		else
			LastBankColor = moneygivegreen
			num = num * -1
			LastBankText = "+ $" .. tostring(num)
		end
		LastBankAlpha = 1000
	end
	if LastBankAlpha > 0 then
		LastBankColor.a = LastBankAlpha
		strokeblack.a = LastBankAlpha
		drawSimpleTextOutlined(LastBankText, "perp_playerinfo", infoX, infoY + offset, LastBankColor, 2, 0, 2, strokeblack)
		offset = offset + fontSmallH + 5
		LastBankAlpha = LastBankAlpha - (200*FrameTime())
	end
	LastBank = plybank
	
	local plycash = locply:GetCash()
	drawSimpleTextOutlined("Cash $"..plycash, "perp_playerinfo", infoX, infoY + offset, cashgreen, 2, 0, 2, color_black)
	
	offset = offset + fontSmallH + 5
	
	if LastCash != plycash then
		local num = LastCash - plycash
		if LastCashAlpha > 0 then
			local oldnum = stringReplace(LastCashText,"+","")
			oldnum = tonumber(stringReplace(oldnum," $","")) or 0
			if (oldnum < 0 and (LastCash - plycash) > 0) or (oldnum > 0 and (LastCash - plycash) < 0) then
				num = (oldnum*-1) + LastCash - plycash
			end
		end
		if num > 0 then
			LastCashColor = moneytakered
			LastCashText = "- $" .. tostring(num)
		else
			LastCashColor = moneygivegreen
			num = num * -1
			LastCashText = "+ $" .. tostring(num)
		end
		LastCashAlpha = 1000
	end
	if LastCashAlpha > 0 then
		LastCashColor.a = LastCashAlpha
		strokeblack.a = LastBankAlpha
		drawSimpleTextOutlined(LastCashText, "perp_playerinfo", infoX, infoY + offset, LastCashColor, 2, 0, 2, strokeblack)
		offset = offset + fontSmallH + 5
		LastCashAlpha = LastCashAlpha - (200*FrameTime())
	end
	LastCash = plycash
	
	--[[
		Playtime
	]]
	
	drawSimpleTextOutlined(string.NiceTime(mathRound(locply:GetTimePlayed())).." Played", "perp_playerinfo_small", infoX, infoY + offset, themecolor, 2, 0, 2, color_black)
	
	offset = offset + fontSmallH + 5
	
	--[[
		Genes
	]]
	
	if locply:GetPNWVar("Genes") then 
		local FreeGenes = locply:GetPNWVar("Genes").FreeGenes
		if (FreeGenes != 0) then
			drawSimpleTextOutlined("Genes "..FreeGenes, "perp_playerinfo_small", infoX, infoY + offset, gene_color, 2, 0, 2, color_black)
			offset = offset + fontSmallH + 5
		end
	end
	
	--[[
		Ammo
	]]

	local weapon = locply:GetActiveWeapon()
	if IsValid(weapon) then
		local weaponClip = weapon:Clip1()
		local weaponPrimary = locply:GetAmmoCount(weapon:GetPrimaryAmmoType())
		local weaponSecondary = locply:GetAmmoCount(weapon:GetSecondaryAmmoType())
		
		if weapon:GetPrimaryAmmoType() > 0 or weapon:GetClass() == "weapon_medkit" then
			if weaponClip < 0 then
				drawSimpleTextOutlined(weaponPrimary, "perp_playerinfo_small", infoX, infoY + offset, grey, 2, 0, 2, color_black)
			else
				drawSimpleTextOutlined(weaponPrimary .. " - " .. weaponClip, "perp_playerinfo_small", infoX, infoY + offset, grey, 2, 0, 2, color_black)
			end
			
		end
		
		if weapon:GetSecondaryAmmoType() > 0 and weaponSecondary > 0 then
			drawSimpleTextOutlined(weaponSecondary, "perp_playerinfo_small", infoX, infoY + offset, grey, 2, 0, 2, color_black)
		end
	end

	--[[
		Hunger
	]]

	local w,h = 275,30
	local supported = false
	if locply.GetHunger and locply.GetSaturation then
		supported = true
		hunger = Lerp(FrameTime() * 2, hunger, mathClamp(locply:GetHunger(), 0, 100) )
		saturation = Lerp(FrameTime() * 2, saturation, mathClamp(locply:GetSaturation(), 0, 100) )
		hungry = Lerp(FrameTime() * 5, hungry or 0, hungeryinf or 0 )
	end
	if supported then
		surface_SetMaterial(Materials["GradientRight"])
		surface_SetDrawColor(0,0,0,255)
		if IsValid(locply:GetVehicle()) then
			hungeryinf = 215
		else
			hungeryinf = 0
		end
		surface_DrawTexturedRect( infoX-w, Height - infoY - h - hungry, w, h )
		drawRoundedBox(0, infoX-w, Height - infoY - h - hungry, w, h, hungerbg)

		drawSimpleTextOutlined("HUNGER", "perp2_opensans24", infoX-w+10, Height - infoY - (h/2) - hungry, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
		
		surface_SetFont("perp2_opensans24")
		local tx, ty = surface_GetTextSize("HUNGER")
		
		local boxwid = w-tx-30
		local box_x = infoX-w+tx+20
		drawRoundedBox(0, box_x, Height - infoY - 20 - hungry, boxwid, 10, hungersliderbg)
		drawRoundedBox(0, box_x, Height - infoY - 20 - hungry, boxwid * (hunger/100), 10, hungerslider)
		drawRoundedBox(0, box_x, Height - infoY - 20 - hungry, boxwid * (saturation/100), 10, saturationslider)
	end

/**************************************************
		Speedometer and Gas meter
		-- Borrowed from SCars --
**************************************************/

	if locply:InVehicle() then
		local Vehicle = locply:GetVehicle()

		local Tbl = Vehicle:GetGNWVar("vehicleTable")
		
		if Tbl then
			local CurFuel = Vehicle:GetGNWVar( "Fuel", 10000 ) / 10000

			local MoveX = -70

			surface_SetDrawColor(134, 138, 144, 255)
			surface_DrawRect(MoveX+infoX - 248, (Height-infoY) - 78, 160, 30)

			surface_SetDrawColor(255, 255, 255, 255)
			surface_DrawRect(MoveX+infoX - 202.5, (Height-infoY) - 74, 115 * CurFuel, 23)
				
			surface_SetMaterial( Materials["Speedometer"] )
			surface_SetDrawColor( 255, 255, 255, 255 )
			surface_DrawTexturedRect( MoveX+infoX - 300, (Height-infoY) - 200, 231, 166 )

			local fader = ( CurFuel * 10000 ) <= 1100 and math.abs(math.sin(CurTime * 2)) or 1
			drawSimpleText(string.upper("FUEL " .. math.floor( CurFuel * 100 ) .. "%"), "perp2_opensans24", MoveX+infoX - 200, (Height-infoY) - 75, Color(12, 21, 32, 255*fader), TEXT_ALIGN_LEFT)

			local Phys = Vehicle:GetPhysicsObject()
			local vel = 0
			if IsValid( Phys ) then
				vel = Phys:GetVelocity():Length() //mathRound(10 * 17.6)
			else
				vel = Vehicle:GetVelocity():Length()
			end

			local rotation = (vel * -0.11) - 180

			if rotation <= (-420) then
				rotation = -420
			end

			rotation = math.Approach( oldrotation, rotation, 2 )

			oldrotation = rotation

			surface_SetMaterial( Materials["SpeedometerNeedle"] )
			surface_SetDrawColor( 255, 255, 255, 255 )
			surface_DrawTexturedRectRotated( MoveX+infoX - 217, (Height-infoY) - 120, 4, 100, oldrotation)

			local speed = mathRound( vel * 5 / 88 )
			speed = math.Approach( oldspeed, speed, 2 )

			local c = color_white

			local limit = tonumber(locply:GetNWString( "SpeedLimit" ))

			if isnumber(limit) then

				if speed > limit then
					c = speedyellowcolor
					if speed > limit + 10 then
						c = color_red
					end
				end

			end

			drawSimpleText(oldspeed, "perp2_opensans60", MoveX+infoX - 125, (Height-infoY) - 135, c, TEXT_ALIGN_RIGHT)

			oldspeed = speed
		end
	end 

/**************************************************
		TYPING, NAME, STUFF	
**************************************************/

	local FadePoint = ChatRadius_Local^2
	local RealDist = (ChatRadius_Local^2) * 1.5
	
	if (locply:InVehicle()) then
		RealDist = RealDist * 2
	end
	
	surface_SetFont("PlayerNameFont")
	local w, h = surface_GetTextSize("Player Name")
	
	local ourPos = locply:GetPos()
	if (IsValid(PERP_SpectatingEntity)) then ourPos = PERP_SpectatingEntity:GetPos() end
	
	local shootPos = locply:GetShootPos()
	if (IsValid(PERP_SpectatingEntity)) then shootPos = PERP_SpectatingEntity:GetPos() end
	
	for k, v in pairs(player.GetAll()) do
		
		local c = v:GetColor()
		local r,g,b,a = c.r, c.g, c.b, c.a
		
		if (v != locply && v:Alive() && a > 0) then
			local dist = v:GetPos():DistToSqr(ourPos)
			
			if (dist <= RealDist) then
				local trace = {}
				trace.start = shootPos
				trace.endpos = v:GetShootPos()
				trace.filter = {locply, v}
				
				if (v:InVehicle()) then table.insert(trace.filter, v:GetVehicle()) end
				if (locply:InVehicle()) then table.insert(trace.filter, locply:GetVehicle()) end
				
				if IsValid(PERP_SpectatingEntity) then table.insert(trace.filter, PERP_SpectatingEntity) end

				local tr = util.TraceLine( trace ) 
				
				if (!tr.Hit) then
					local Alpha = 255
					
					if (dist >= FadePoint) then
						local moreDist = RealDist - dist
						local percOff = moreDist / (RealDist - FadePoint)
						
						Alpha = 255 * percOff
					end
					
					local AttachmentPoint = v:GetAttachment(v:LookupAttachment('eyes'))
					if !AttachmentPoint then AttachmentPoint = v:GetAttachment(v:LookupAttachment('head')) end
					
					if (AttachmentPoint) then 
						local realPos = Vector(v:GetPos().x, v:GetPos().y, AttachmentPoint.Pos.z + 10)
						local screenPos = realPos:ToScreen()
						
						if (v:GetGNWVar("typing", 0) == 1) then						
							local pointDown = (realPos + Vector(0, 0, math.sin(CurTime * 2) * 3)):ToScreen()
							local pointUp = (realPos + Vector(0, 0, 20 + math.sin(CurTime * 2) * 3)):ToScreen() 
							
							local Size = math.abs(pointDown.y - pointUp.y)
							
							surface_SetDrawColor(255, 255, 255, Alpha)
							surface_SetTexture(Materials["TypingText"])
							surface_DrawTexturedRect(pointUp.x - Size * .5, pointUp.y, Size, Size)
						elseif GAMEMODE.Options_ShowNames:GetBool() then
							local color = team.GetColor(v:Team())
							local nameText
							
							if v:GetRPName() == "John Doe" then
								nameText = "Loading..."
							while nameText == "Loading..." do
								nameText = v:GetRPName()
							end
							elseif (v:Team() == TEAM_POLICE || v:Team() == TEAM_SWAT ) then
							nameText = "Officer " ..	v:GetLastName()
							else
								nameText = v:GetRPName()
								if nameText == "Loading..." then
								nameText = v:GetRPName()
								end
							end
							
							local white_with_alpha = Color(255, 255, 255, Alpha)

							drawSimpleTextOutlined(nameText, "PlayerNameFont", screenPos.x, screenPos.y - h, Color(color.r, color.g, color.b, Alpha), 1, 1, 1, Color(0, 0, 0, Alpha));

							
							if (v:InVehicle() && v:GetVehicle():GetClass() == "prop_vehicle_jeep") then
								if (locply:Team() == TEAM_POLICE || locply:Team() == TEAM_DETECTIVE || locply:Team() == TEAM_CHIEF) then
									local Speed = tostring(mathRound(v:GetVehicle():GetVelocity():Length() / 17.6));
									drawSimpleTextOutlined(SpeedText(Speed), "PlayerNameFont", screenPos.x, screenPos.y - h * 2, white_with_alpha, 1, 1, 1, Color(0, 0, 255, Alpha));
								end
							else
								local orgName = v:GetOrganizationName();
								if (orgName && orgName != '' and orgName != 'New Organization') or v:IsBot() then
									if v:IsBot() then 
										local col = HSVToColor( CurTime % 6 * 60, 1, 1 )
										col.a = Alpha
										drawSimpleTextOutlined("BOT", "PlayerNameFont", screenPos.x, screenPos.y - h * 2, white_with_alpha, 1, 1, 1, col);
									else
										drawSimpleTextOutlined(orgName, "PlayerNameFont", screenPos.x, screenPos.y - h * 2, white_with_alpha, 1, 1, 1, Color(255, 0, 0, Alpha));
									end
								end
							end
							if (v:IsWarrented()) then
								drawSimpleTextOutlined("Arrest Warrant", "PlayerNameFont", screenPos.x, screenPos.y, white_with_alpha, 1, 1, 1, Color(color.r, color.g, color.b, Alpha));
							end
						end
					end
				end
			end
		end
	end

/**************************************************
		Gas Can Shit	
**************************************************/	
	for k, v in pairs(ents.FindInSphere(ourPos, 300)) do
		if (v:IsValid() && (v:GetClass() == "ent_fuelcan")) then

			local Pos = v:LocalToWorld(v:OBBCenter()):ToScreen();
			local Name;
			if v.CurrentCar then
				Name =	tostring(Entity(v.CurrentCar:GetGNWVar( "Owner" )):GetRPName()).. "'s Car."
			else
				Name = "None"
			end

			local white_with_alpha = Color(255, 255, 255, Alpha)
			local gren_with_alpha = Color(0, 100, 0, Alpha)
			
			drawSimpleTextOutlined('Ready To Fuel:', "perp2_opensans24", Pos.x, Pos.y-50 , white_with_alpha, 1, 1, 1, gren_with_alpha);
			drawSimpleTextOutlined(Name, "perp2_opensans24", Pos.x, Pos.y-30, white_with_alpha, 1, 1, 1, gren_with_alpha);

		end
	end

	
/**************************************************
		Doors and vehicles (Text on doors and cars)
**************************************************/

	FadePoint = FadePoint * .05
	RealDist = RealDist * .25
	
	local eyeTrace = locply:GetEyeTrace()
	local eyeTraceEntClass = ""
	if IsValid(eyeTrace.Entity) then
		eyeTraceEntClass = eyeTrace.Entity:GetClass()
	end

	if IsValid( eyeTrace.Entity ) and eyeTrace.Entity:GetPos():DistToSqr( ourPos ) <= (200*200) and ( eyeTrace.Entity:GetClass() == "ent_cocaine" or eyeTrace.Entity:GetClass() == "ent_weed" ) then
		local timeleft = 1
		local name = "N/A"
		if not eyeTrace.Entity.SpawnTime then -- unsyncing issues :/
			eyeTrace.Entity.SpawnTime = eyeTrace.Entity:GetGNWVar( "SpawnTime" )
		end

		local GrowTime = 0
		local ready = "Not Ready"

		if eyeTraceEntClass == "ent_cocaine" then
			timeleft = math.max( 0, ( eyeTrace.Entity.SpawnTime or CurTime ) + COCAINE_GROW_TIME - CurTime )
			GrowTime = COCAINE_GROW_TIME
			name = "Cocaine"
		elseif eyeTraceEntClass == "ent_weed" then
			timeleft = math.max( 0, ( eyeTrace.Entity.SpawnTime or CurTime ) + WEED_GROW_TIME - CurTime )
			GrowTime = WEED_GROW_TIME
			name = "Weed"
		end

		local Pos = eyeTrace.Entity:LocalToWorld(eyeTrace.Entity:OBBCenter()):ToScreen()
		local RatioDone = ((timeleft/GrowTime)*-1) + 1
		if RatioDone >= 1 then
			ready = "Ready to Pick"
			RatioDone = 1
		end

		local w, h = 200, 40
		local x, y = Pos.x+(w/2), Pos.y+(h/4)

		-- Cool Outline Stuff
		drawRoundedBox( 0, x - w - h + 8, y - 8, w + h, h, Color( 12, 12, 12, 150 ) )
	
		surface_SetDrawColor( 22, 22, 22, 255 )
		surface_SetMaterial( Materials["GradientRight"] )
		surface_DrawTexturedRect( x - w - h + 8, y - 8, w + h, h ) 
	
		surface_SetDrawColor( 201, 182, 112 )
		surface_SetMaterial( Materials["GradientRight"] )
		surface_DrawTexturedRect( x - w - h + 8, y-8, w, 1 ) 
	
		drawRoundedBox( 0, x - w - h + 8, y-8, 1, h, themecolor )
	
		surface_SetDrawColor( 201, 182, 112 )
		surface_SetMaterial( Materials["GradientRight"] )
		surface_DrawTexturedRect( x - w - h + 8, y+h-8, w, 1 ) 
		
		-- Draw Icon
		surface_SetDrawColor( 255, 255, 255 )
		surface_SetMaterial( Materials["ChatLogo"] )
		surface_DrawTexturedRect( x - w - h + 16, y - 4, h - 8, h - 8 ) 

		-- Text and bars
		drawRoundedBox(1, Pos.x-(100-16), Pos.y+28, (200-16), 10, Color(99, 89, 55))
		drawRoundedBox(1, Pos.x-(100-16), Pos.y+28, (200-16)*RatioDone, 10, Color(themecolor.r, themecolor.g, themecolor.b, 255 * math.abs(math.sin(CurTime*3))))
		drawSimpleText(name .. ": " .. ready , "perp2_opensans20", Pos.x-(100-16),Pos.y+2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	end

	
/**************************************************
		Door Info
**************************************************/
	
	if (!locply:InVehicle() && GAMEMODE.Options_ShowNames:GetBool() && eyeTrace.Entity && IsValid(eyeTrace.Entity) && (eyeTrace.Entity:IsDoor() || eyeTrace.Entity:IsVehicle())) then
		local dist = eyeTrace.Entity:GetPos():DistToSqr(ourPos);
		
		if (dist <= RealDist) then
			local Alpha = 255;
					
			if (dist >= FadePoint) then
				local moreDist = RealDist - dist;
				local percOff = moreDist / (RealDist - FadePoint);
						
				Alpha = 255 * percOff;
			end
			
			
			if (eyeTrace.Entity:IsDoor()) then
				local Pos = eyeTrace.Entity:LocalToWorld(eyeTrace.Entity:OBBCenter()):ToScreen();
				local doorTable = eyeTrace.Entity:GetPropertyTable();

				if (doorTable) then			
					local doorOwner = eyeTrace.Entity:GetDoorOwner();

					local white_alpha = Color(255, 255, 255, Alpha)
					
					if (!doorOwner || !IsValid(doorOwner)) then
						locply:SendToolTip("This property is for sale! Visit the bank\nto purchase this property.",2)
						drawSimpleTextOutlined('For Sale', "perp2_RealtorFont", Pos.x, Pos.y, white_alpha, 1, 1, 1, Color(0, 100, 0, Alpha));
						drawSimpleTextOutlined(doorTable.Name, "perp2_RealtorFont", Pos.x, Pos.y + 25, white_alpha, 1, 1, 1, Color(0, 100, 0, Alpha));
					else
						drawSimpleTextOutlined('Owned By ' .. doorOwner:GetRPName(), "perp2_RealtorFont", Pos.x, Pos.y, white_alpha, 1, 1, 1, Color(255, 0, 0, Alpha));
						drawSimpleTextOutlined(doorTable.Name, "perp2_RealtorFont", Pos.x, Pos.y + 25, white_alpha, 1, 1, 1, Color(255, 0, 0, Alpha));
						if doorOwner:GetNWInt("unraidable_until") and GAMEMODE:Time() < doorOwner:GetNWInt("unraidable_until") then
							drawSimpleTextOutlined("Unraidable for " .. mathRound((doorOwner:GetNWInt("unraidable_until") - GAMEMODE:Time())/3600,2) .. " hours", "perp2_RealtorFont", Pos.x, Pos.y - 25, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha))
						end
					end
				else
					local found
					for k, v in pairs(DoorData) do
						if isfunction(eyeTrace.Entity[k]) and eyeTrace.Entity[k](eyeTrace.Entity) then
							found = true
							local col = Color(v.o.r,v.o.g,v.o.b,Alpha)
							if v.o2 then
								local fader = (1 + math.sin(CurTime*4))/2
								col = Color((v.o.r*(fader))+(v.o2.r*math.abs(fader-1)),(v.o.g*(fader))+(v.o2.g*math.abs(fader-1)),(v.o.b*(fader))+(v.o2.b*math.abs(fader-1)),Alpha)
							end
							drawSimpleTextOutlined(v.t, "perp2_RealtorFont", Pos.x, Pos.y, Color(v.c.r,v.c.g,v.c.b,Alpha), 1, 1, 1, col)
						end
					end
					if not found then
						local v = DoorData["Unknown"]
						drawSimpleTextOutlined(v.t, "perp2_RealtorFont", Pos.x, Pos.y, Color(v.c.r,v.c.g,v.c.b,Alpha), 1, 1, 1, Color(v.o.r,v.o.g,v.o.b,Alpha))
					end

				end
			elseif (eyeTrace.Entity:GetTrueOwner() && IsValid(eyeTrace.Entity:GetTrueOwner()) && eyeTrace.Entity:GetTrueOwner().GetRPName) then
				local Pos = eyeTrace.Entity:LocalToWorld(Vector(eyeTrace.Entity:OBBCenter().x, eyeTrace.Entity:OBBCenter().y, eyeTrace.Entity:OBBMaxs().z + 15)):ToScreen();
				drawSimpleTextOutlined('Owned By ' .. eyeTrace.Entity:GetTrueOwner():GetRPName(), "perp2_RealtorFont", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(0, 0, 255, Alpha));
			end
		end
	end
	
/**************************************************
		NPC - HIT E TO INTERACT
**************************************************/	
	
	if GetConVar( "perp2_shownpchelp" ):GetInt() == 1 and IsValid( eyeTrace.Entity ) and eyeTrace.Entity:GetPos():DistToSqr( ourPos ) <= 150*150 and ( eyeTraceEntClass == "npc_vendor") then
		local Pos = eyeTrace.Entity:LocalToWorld(eyeTrace.Entity:OBBCenter() + Vector(0,0,math.sin(CurTime * 5) + 42)):ToScreen()
		drawSimpleTextOutlined( "Hit [E] to interact", "perp2_opensans24", Pos.x, Pos.y, Color(255, 255, 255, 255 + (math.sin(CurTime * 5) * 205)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1.2, Color(0, 0, 0,255) )
	end
	
/**************************************************
		HUD
**************************************************/

	if GAMEMODE.Options_UseBasicHUD:GetBool() then
		
		drawRoundedBox(0, safezone, Height-30-safezone, 260, 30, Color(10,10,10,220))

		local health = mathClamp(locply:Health(), 0, 100) * 1.19
		surface_SetDrawColor(47, 81, 51)
		surface_DrawRect(10 + safezone, Height-23-safezone, 119, 9)

		surface_SetDrawColor(92, 136, 96)
		surface_DrawRect(10 + safezone, Height-23-safezone, health, 9)

		local armor = mathClamp(locply:Armor(), 0, 100) * 1.19
		surface_SetDrawColor(17, 53, 75)
		surface_DrawRect(131 + safezone, Height-23-safezone, 119, 9)

		surface_SetDrawColor(109, 191, 227)
		surface_DrawRect(131 + safezone, Height-23-safezone, armor, 9)

		local staminaMeter = mathClamp(locply.Stamina or 100, 0, 100) * 2.40
		surface_SetDrawColor(90,62,18)
		surface_DrawRect(10 + safezone, Height-12-safezone, 240, 4)

		surface_SetDrawColor(229,156,45)
		surface_DrawRect(10 + safezone, Height-12-safezone, staminaMeter, 4)

	end

/**************************************************
		Restart Timer
**************************************************/

	if GAMEMODE.RestartingIn then
		local w = 120
		local h = 60
		offset = offset + 5
		drawRoundedBox( 0, infoX - 200, infoY + offset, 200, 60, Color(34, 34, 34, 225) )
		drawRoundedBox( 0, infoX - 200, infoY + offset, 200, 18, themecolor )
		drawSimpleText("RESTARTING IN", "perp2_opensans24", infoX - 100, infoY + offset - 3, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER);
		drawSimpleText( GAMEMODE.RestartingIn > os.time() and TimeToString( GAMEMODE.RestartingIn - os.time() ) or "A Moment" , "perp2_opensans24", infoX - 100, infoY + 25 + offset, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER);
	end

/**************************************************
		Knocked Out
**************************************************/	

	--Knocked out / Unconcious

	if not locply:Alive() then
		if not SerCurTimeSync then return end

		local sercurtime = locply:GetNWFloat("RespawnTime") - (locply:GetNWFloat("RespawnTimeCurTime") - (SerCurTimeSync - CurTime))
		local rat = sercurtime / (locply:GetNWFloat("RespawnTime")-locply:GetNWFloat("RespawnTimeCurTime"))
		drawRoundedBox(0,0,0,Width,Height,Color(97*rat,13*rat,13*rat,(mathClamp(100/rat,0,255)-65)))
		DrawBlur(1.5)
		surface_SetMaterial(Materials["Vignette"])
		surface_SetDrawColor(255,255,255,255)
		surface_DrawTexturedRect(0,0,Width, Height)
		surface_SetMaterial(Materials["Bloodsmear"])
		surface_DrawTexturedRect((Width/2)-240, (Height/2)-280, 455, 734)

		drawSimpleTextOutlined( mathRound(sercurtime), "perp2_opensans80", ( Width / 2 ), ( Height / 2 ), color_white, 1, 1, 2, color_black)
		drawSimpleTextOutlined( "RESPAWNING IN", "perp2_opensans18", ( Width / 2 ), ( Height / 2 ) - 75, color_white, 1, 1, 1, color_black)
	end

/**************************************************
		Gov. Radio
**************************************************/
	
	if JOB_DATABASE[locply:Team()] and JOB_DATABASE[locply:Team()].GovOfficial then
		if locply:GetGNWVar("tradio", false) then
			RadioOnAlpha = Lerp(FrameTime()*5, RadioOnAlpha, 150)
		else
			RadioOnAlpha = Lerp(FrameTime()*5, RadioOnAlpha, 0)
		end
		surface_SetDrawColor(255, 255, 255, RadioOnAlpha)
		surface_SetMaterial(Materials["RadioGlowMaterial"])
		surface_DrawTexturedRect(safezone+10, safezone, Height * .15, Height * .15)
		surface_SetDrawColor(255, 255, 255, 255)
		surface_SetMaterial(Materials["RadioMaterial"])
		surface_DrawTexturedRect(safezone+10, safezone, Height * .15, Height * .15)
	end
	
/**************************************************
		Chat
**************************************************/

	local widthPer = (Width / 7);
	local heightPer = widthPer * .33;
	local xBuffer = 175 + safezone
	local ChatFont = "PEChatFont"
	local ChatFontShadow = "PEChatFontShadow"
	
	surface_SetFont(ChatFont);
	local _, y = surface_GetTextSize("what");
	local startY = Height - (25+150) - heightPer - y - safezone;

	if GAMEMODE.Options_UseBasicHUD:GetBool() then
		xBuffer = 150 + safezone
		startY = Height - (25) - heightPer - y - safezone;
	end
	
	local chatRecord = GAMEMODE.chatRecord

	local ChatBoxOpen = GAMEMODE.ChatBoxOpen
	if (ChatBoxOpen) then
		local ourType = "Local";
		if (GAMEMODE.chatBoxIsOOC) then ourType = "OOC"; end
		
		local drawText = GAMEMODE.chatBoxText;
		
		for k, v in pairs(GAMEMODE.chatPrefixes) do
			if (string.match(string.lower(GAMEMODE.chatBoxText), "^[ \t]*[!/]" .. string.lower(k))) then
				
				ourType = v;
				drawText = string.Trim(string.sub(string.Trim(drawText), string.len(k) + 2));
				
				break;
			end
		end
	
		surface_SetFont(ChatFont);
		local x, y = surface_GetTextSize(ourType .. ": " .. drawText);
		
		--drawRoundedBox(0, xBuffer, startY, x + 14, y, Color(0, 0, 0, 200))

		-- Cool Outline Stuff
		drawRoundedBox( 0, xBuffer, startY-2, x + 14, y+4, Color( 12, 12, 12, 150 ) )

		surface_SetDrawColor( 22, 22, 22, 255 )
		surface_SetMaterial( Materials["GradientRight"] )
		surface_DrawTexturedRect( xBuffer, startY-2, x + 14, y+4 ) 
	
		surface_SetDrawColor( 201, 182, 112 )
		surface_SetMaterial( Materials["GradientRight"] )
		surface_DrawTexturedRect( xBuffer, startY-2, x + 14, 1 ) 
	
		drawRoundedBox( 0, xBuffer, startY-2, 1, y+4, themecolor )
	
		surface_SetDrawColor( 201, 182, 112 )
		surface_SetMaterial( Materials["GradientRight"] )
		surface_DrawTexturedRect( xBuffer, startY+y+2, x + 14, 1 ) 
		
		-- Draw Icon
		surface_SetDrawColor( 255, 255, 255 )
		surface_SetMaterial( Materials["ChatLogo"] )
		surface_DrawTexturedRect( xBuffer - 36, startY - 8, y+16, y+16 ) 
		
		if (math.sin(CurTime * 5) * 10) > 0 then
			drawRoundedBox(0, xBuffer+x+6, startY+1, 2, y-2, color_white)
		end
		
		drawSimpleText(ourType .. ": " .. drawText, ChatFont, xBuffer + 4, startY + y * .5, color_white, 0, 1);
	end
	
	if (#chatRecord > 0) then

		for i = mathClamp(#chatRecord - GAMEMODE.linesToShow, 1, #chatRecord), #chatRecord do
			local tab = chatRecord[i];
			
			if (ChatBoxOpen || tab[1] + 15 >= CurTime) then
				local Alpha = 255;
				
				if (!ChatBoxOpen && tab[1] + 10 < CurTime) then
					local TimeLeft = tab[1] + 15 - CurTime;
					Alpha = (255 / 5) * TimeLeft;
				end

				local posX, posY = xBuffer, startY - y * (1.5 + (#chatRecord - i));
				
				if tab[3] then
					local col = Color(tab[3].r, tab[3].g, tab[3].b, Alpha);
					local black_alpha = Color(0, 0, 0, Alpha)
					
					drawSimpleText(tab[2] .. ": ", ChatFontShadow, posX + 1, posY + 1, black_alpha, 2);
					drawSimpleText(tab[2] .. ": ", ChatFontShadow, posX + 1, posY + 1, black_alpha, 2);
					
					if (tab[6]) then
						local Cos = math.abs(math.sin(CurTime * 2));
						
						drawSimpleTextOutlined(tab[2] .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, mathClamp(Alpha * Cos, 0, 255)));
						drawSimpleTextOutlined(tab[2] .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, mathClamp(Alpha * Cos, 0, 255)));
					else
						drawSimpleText(tab[2] .. ": ", ChatFont, posX, posY, col, 2);
						drawSimpleText(tab[2] .. ": ", ChatFont, posX, posY, col, 2);
					end
				end
				
				local col = Color( tab[ 5 ].r or 0, tab[ 5 ].g or 255, tab[ 5 ].b or 0, Alpha ) or Color(255,255,255,Alpha)
				local black_alpha = Color(0, 0, 0, Alpha)
				drawSimpleText(tab[4], ChatFontShadow, posX + 1, posY + 1, black_alpha);
				drawSimpleText(tab[4], ChatFontShadow, posX + 1, posY + 1, black_alpha);
				drawSimpleText(tab[4], ChatFont, posX, posY, col);
				drawSimpleText(tab[4], ChatFont, posX, posY, col);
			end
		end
	end

	/**************************************************
			Tased and Progress bar
	**************************************************/	

	-- Tased 
	if locply:GetNWBool("tase") == true then
		timer.Create("tasetime", 12, 1, function()
		
		end)
	end

	local timee = timer.TimeLeft("tasetime")

	if timee != nil then
		if not locply:Alive() then return end
		-- Tased Text & Boxes
		local h = 100
		local w = 300

		surface_SetDrawColor( 34, 34, 34, 225 )
		surface_DrawRect( ( Width / 2 ) - ( w / 2 ), ( Height * 0.75 ) , w, h )

		drawSimpleTextOutlined( "YOU ARE BEING", "perp_playerinfo_small", ( Width / 2 ), ( Height * 0.76 ), Color(240, 240, 240), TEXT_ALIGN_CENTER, 0, 2, Color(0, 0, 0))
		drawSimpleTextOutlined( "TASED", "perp_playerinfo_small", ( Width / 2 ), ( Height * 0.8 ), Color(98, 193, 241), TEXT_ALIGN_CENTER, 0, 2, Color(0, 0, 0))
		
		-- Tased Loading Bar
		local h = 25
		local w = 720
		
		surface_SetDrawColor( 0, 0, 0, 255 )
		surface_DrawRect( ( Width / 2 ) - ( w / 2 ), ( Height / 2 ) - ( h - 250 ), w, h )
		surface_SetDrawColor( 98, 193, 241, 255 )
		surface_DrawRect( ( Width / 2 ) - ( w / 2 ), ( Height / 2 ) - ( h - 250 ), timee * 60, h )
		
		drawSimpleTextOutlined( "Time left:", "perp_playerinfo_small", ( Width / 2 ) - ( w / 2 ), ( Height / 2 ) - ( h - 200 ), Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color(0, 0, 0) )
		drawSimpleTextOutlined( math.Truncate( timee, 2 ), "perp_playerinfo_small", ( Width / 2 ) + 280, ( Height / 2 ) - ( h - 200 ), Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color(0, 0, 0))
	end

	/**************************************************
		Invisible / Godmode notification for admins
	**************************************************/	
	if locply.IsAdmin and not locply:IsAdmin() then return end
    local flash = Color( CurTime * 255 % 255, 0, 0, 255 ) //Flashes from black to red
    
    if locply:IsInvisible() then
        drawSimpleText( "INVISIBLE", "perp2_opensans40", ScrW() * 0.5, ScrH() * 0.92, flash, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
    end
    if locply:HasGod() then
        drawSimpleText( "GOD MODE", "perp2_opensans40", ScrW() * 0.5, ScrH() * 0.95, flash, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
    end

end

---------------------------------[[
	-- 	MISC. HUD LIBRARIES
---------------------------------]]

function BetterScreenScale(size)
	return size * math.max(0.5, Height / 1200)
end

SerCurTimeSync = SerCurTimeSync

net.Receive("SerCurTimeSync", function()
	SerCurTimeSync = CurTime()
end)

net.Receive("perp_loading", function()
	aSocPNGIntro.opacity = 700
end)

surface_CreateFont("MainFont", {
	font = "Chalet",
	extended = false,
    size = 30,
} )


local checkx = Material("hud/checkpoint.png")
local circle = Material("hud/circle.png")
local function RemoveCheckmarker()
    hook.Remove("PostDrawOpaqueRenderables", "WaypointSystem")
    hook.Remove("HUDPaint", "WaypointSystem")
end
local function AddCheckmarker(vector, color, removewhenclose)
    local alpha = 255
    hook.Add("HUDPaint", "WaypointSystem", function()
        local dist = vector:DistToSqr(locply:GetPos())
        local FadePoint = 700*700
        local RealDist = 300*300

        if (dist > RealDist) then
            Alpha = 255
            if (dist >= RealDist) then
                local moreDist = FadePoint - dist
                local percOff = ((moreDist / (FadePoint - RealDist)) * -1) + 1
                Alpha = math.floor(255 * percOff)
            end
        elseif removewhenclose then
            RemoveCheckmarker()
            net.Start("CheckmarkRemovedClose")
            net.SendToServer()
        end

        local pos = vector:ToScreen()
        drawRoundedBox(4, pos.x-2, pos.y-101, 4, 101, Color(132, 0, 255, Alpha))
        surface_SetDrawColor(132, 0, 255, Alpha)
        surface_SetMaterial(checkx)
        surface_DrawTexturedRect(pos.x-32, pos.y-164, 64, 64)
        drawSimpleText(string.Comma(mathRound(dist/100)) .. "m", "MainFont", pos.x, pos.y-166, Color(255,255,255,Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    end)

    hook.Add("PostDrawOpaqueRenderables", "WaypointSystem", function()
        cam.Start3D2D( vector + Vector(0,0,4 ), Angle(0,90,0), 0.2 )
        surface_SetDrawColor(132, 0, 255, Alpha)
        surface_SetMaterial(circle)
        surface_DrawTexturedRect(-200, -200, 400, 400)
        cam.End3D2D()
    end)
end

local event_data
net.Receive("event_scorecard", function()
	event_data = net.ReadTable()
end)

local normalbg = Color(0, 0, 0,50)
local normal = Color(109, 30, 156)
local first = Color(255, 175, 71)
local second = Color(105, 105, 105)
local third = Color(92, 57, 25)
hook.Add("HUDPaint", "EventManager", function()
	if not event_data or not event_data.name then return end
	local wide,tall = ScrW(), ScrH()
	local safezone = GAMEMODE.Options_SafeZone:GetInt()
	local w, h = 340,300
	local function DrawBox(order,col,text,text2)
		local y = (tall/2)-(h * 0.2 * order)
		drawRoundedBox(0, safezone, y, w, h*0.18, normalbg)
		surface_SetMaterial(Materials["GradientRight"])
		surface_SetDrawColor(col)
		surface_DrawTexturedRect( safezone, y, w, h*0.18 )

		drawSimpleTextOutlined(text, "perp2_opensans20", safezone+15, y+(h*0.09), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
		drawSimpleTextOutlined(text2, "perp2_opensans20", safezone-15+w, y+(h*0.09), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, color_black)
	end
	DrawBox(5,normal,"EVENT",event_data.name)
	DrawBox(4,normal,string.ToMinutesSeconds(event_data.timeleft),event_data.info)
	local places = {"1st ","2nd ","3rd "} local colors = {first,second,third}
	for n=3,1,-1 do
		local i = (n*-1) + 4
		if event_data.score and event_data.score[i] and event_data.units then
			local ply = player.GetBySteamID(event_data.score[i].sid)
			local name = "Player"
			if IsValid(ply) then
				name = ply:Name()
			end
			DrawBox(n,colors[i],places[i] .. name,math.Round(event_data.score[i].score,2) .. event_data.units)
		end
	end
end)

net.Receive("event_sound", function()
	local s = net.ReadString()
	if s and s != "" then
		surface.PlaySound(s)
	end
end)