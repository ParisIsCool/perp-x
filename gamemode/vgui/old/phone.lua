--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up

local PANEL = {}

surface.CreateFont( "PhoneFont", { font = "Tahoma", size = ScreenScale( 7 ), weight = 1000, antialias = true, additive = false } )
surface.CreateFont( "PhoneFontSmall", { font = "Tahoma", size = ScreenScale( 6 ), weight = 1000, antialias = true, additive = false } )

local phone_text_r = CreateClientConVar("perp2_phone_text_r", "0", true, false)
local phone_text_g = CreateClientConVar("perp2_phone_text_g", "0", true, false)
local phone_text_b = CreateClientConVar("perp2_phone_text_b", "0", true, false)

local phone_highlight_r = CreateClientConVar("perp2_phone_highlight_r", "0", true, false)
local phone_highlight_g = CreateClientConVar("perp2_phone_highlight_g", "0", true, false)
local phone_highlight_b = CreateClientConVar("perp2_phone_highlight_b", "255", true, false)

local phone_background_r = CreateClientConVar("perp2_phone_background_r", "255", true, false)
local phone_background_g = CreateClientConVar("perp2_phone_background_g", "255", true, false)
local phone_background_b = CreateClientConVar("perp2_phone_background_b", "255", true, false)

local phoneMaterial = surface.GetTextureID("perp2/cell_phone")
local phoneIcon = surface.GetTextureID("perp2/phone_icon")

function PANEL:Init ( )
	self.curSpot = 1
	self.startPos = 1
	self.level = 1
	self.lastScroll = 0
	self:SetAlpha(0)
end

function PANEL:PerformLayout ( )
	local W = ScrW() * .15
	local H = (W / 349) * 780
	
	self:SetPos(ScrW() - W - 30, ScrH() - 1)
	self:SetSize(W, H)
	
	surface.SetFont("PhoneFontSmall")
	self.smallX, self.smallY = surface.GetTextSize("Size")
end

local slideTime = 0.25
local percentShown = .8

function PANEL:Paint ( )
	if (!self.ShowingTime and !self.CurUp) then return end
	
	local OX, OY = self:GetPos()
	if (self.CurrentlyShowing) then
		if (self.ShowingTime) then
			local percOpen = math.Clamp((CurTime() - self.ShowingTime) / slideTime, 0, 1)
			
			if (percOpen == 1) then self.ShowingTime = nil end
				
			self:SetPos(OX, (ScrH() - 1) - (percOpen * self:GetTall() * percentShown))
		end
	elseif (self.ShowingTime) then
		local percOpen = math.Clamp((self.ShowingTime - CurTime()) / slideTime, 0, 1)
			
		if (percOpen == 0) then
			self.ShowingTime = nil
			self:SetAlpha(0)
			
			if (self.demoSound) then
				self.demoSound:Stop()
				self.demoSound = nil
				self.demoPlaying = nil
				return
			end
		end
				
		self:SetPos(OX, (ScrH() - 1) - (percOpen * self:GetTall() * percentShown))
	end

	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetTexture(phoneMaterial)
	surface.DrawTexturedRect(0, 0, self:GetWide(), self:GetTall())
	
	-- Screen Stuff
	local screenX = self:GetWide() * 0.14453125
	local screenY = self:GetTall() * 0.19055944055944
	local screenW = (self:GetWide() * 0.85546875) - screenX
	local screenH = (self:GetTall() * 0.58391608391608) - screenY
	
	local tColor = Color(math.Clamp(phone_text_r:GetInt(), 0, 255), math.Clamp(phone_text_g:GetInt(), 0, 255), math.Clamp(phone_text_b:GetInt(), 0, 255), 255)
	
	surface.SetDrawColor(math.Clamp(phone_background_r:GetInt(), 0, 255), math.Clamp(phone_background_g:GetInt(), 0, 255), math.Clamp(phone_background_b:GetInt(), 0, 255), 150)
	surface.DrawRect(screenX, screenY, screenW, screenH)

	if (GAMEMODE.Call_Time) then
		if (GAMEMODE.PhoneText == "Calling") then
			if (!self.ringing) then
				self.ringing = CreateSound(LocalPlayer(), Sound("perp2.5/phone_ring.mp3"))
			end
		
			if (!self.lastRing or self.lastRing < CurTime()) then
				self.lastRing = CurTime() + SoundDuration("perp2.5/phone_ring.mp3") + 1
				self.ringing:Stop()
				self.ringing:Play()
			end
		elseif (self.ringing) then
			self.lastRing = nil
			self.ringing:Stop()
			self.ringing = nil
		end
	
		draw.SimpleText(GAMEMODE.PhoneText or "#ERROR", "PhoneFontSmall", screenX + screenW * .5, screenY + self.smallY, tColor, 1, 1)
		draw.SimpleText(GAMEMODE.Call_Player or "#ERROR", "PhoneFontSmall", screenX + screenW * .5, screenY + self.smallY * 2, tColor, 1, 1)
		
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetTexture(phoneIcon)
		local size = screenW * .8
		surface.DrawTexturedRect(screenX + screenW * .5 - size * .5, screenY + screenH * .5 - size * .5, size, size)
		
		local seconds = math.ceil(CurTime() - GAMEMODE.Call_Time)
		local minutes = math.floor(seconds / 60)
		local seconds = seconds - (minutes * 60)
		if (seconds < 10) then seconds = "0" .. seconds end
		if (minutes < 10) then minutes = "0" .. minutes end
		
		if (GAMEMODE.PhoneText == "Call From") then
			draw.SimpleText("Z To Answer", "PhoneFontSmall", screenX + screenW * .5, screenY + screenH - self.smallY * 1.5, tColor, 1, 1)
		else
			draw.SimpleText(minutes .. ":" .. seconds, "PhoneFontSmall", screenX + screenW * .5, screenY + screenH - self.smallY * 1.5, tColor, 1, 1)
		end
		
		if (!GAMEMODE.Call_Player) then
			GAMEMODE.Call_Time = nil
		end
		
		return
	elseif (self.ringing and self.lastRing) then
		self.lastRing = nil
		self.ringing:Stop()
	end
	
	self.toDisplayStuff = {}
	
	if (self.level == 1) then
		table.insert(self.toDisplayStuff, {"Contacts", 2})
		table.insert(self.toDisplayStuff, {"Settings", 3})
		
		if (GAMEMODE.Options_EuroStuff:GetBool()) then
			table.insert(self.toDisplayStuff, {"999", 911})
		else
			table.insert(self.toDisplayStuff, {"911", 911})
		end
	elseif (self.level == 2) then
		for k, v in pairs(GAMEMODE.Buddies) do
			table.insert(self.toDisplayStuff, {v[1], v[2]})
		end
		
		for k, v in pairs(self.toDisplayStuff) do
			for _, pl in pairs(player.GetAll()) do
				if (tostring(pl:UniqueID()) == tostring(v[2])) then
					v[1] = pl:GetRPName()
				end
			end	
		end
		
		for k, v in pairs(player.GetAll()) do
			if (v ~= LocalPlayer() and v:GetGNWVar("org", 0) == LocalPlayer():GetGNWVar("org", 0) and v:GetGNWVar("org", 0) ~= 0) then
				local alreadyInList = false
				
				for k, l in pairs(self.toDisplayStuff) do
					if (tostring(l[2]) == tostring(v:UniqueID())) then
						alreadyInList = true
					end
				end
			
				if (!alreadyInList) then
					table.insert(self.toDisplayStuff, {v:GetRPName(), v:UniqueID()})
				end
			end
		end
	elseif (self.level == 3) then
		table.insert(self.toDisplayStuff, {"Ringtones", 4})
		
		if (GAMEMODE.Options_EuroStuff:GetBool()) then
			table.insert(self.toDisplayStuff, {"Backlight Colour", 5})
			table.insert(self.toDisplayStuff, {"Highlight Colour", 6})
			table.insert(self.toDisplayStuff, {"Text Colour", 7})
		else
			table.insert(self.toDisplayStuff, {"Backlight Color", 5})
			table.insert(self.toDisplayStuff, {"Highlight Color", 6})
			table.insert(self.toDisplayStuff, {"Text Color", 7})
		end
	elseif (self.level == 4) then
		for k, v in pairs(GAMEMODE.Ringtones) do
			if (!v[3] or LocalPlayer()[v[3]](LocalPlayer())) then
				table.insert(self.toDisplayStuff, v)
			end
		end

		-- Check to see if we should play a demo.
		if (CurTime() - self.lastScroll > 1 and self.toDisplayStuff[self.curSpot] and (!self.demoPlaying or self.demoPlaying ~= self.curSpot)) then
			if (self.demoSound) then
				self.demoSound:Stop()
				self.demoSound = nil
				self.demoPlaying = nil
			end
			
			self.demoSound = CreateSound(LocalPlayer(), Sound("perp2.5/ringtones/" .. self.toDisplayStuff[self.curSpot][2]))
			self.demoSound:Play()
			self.demoPlaying = self.curSpot
		end
	else
		table.insert(self.toDisplayStuff, {"Black", Color(0, 0, 0, 255)})
		table.insert(self.toDisplayStuff, {"White", Color(255, 255, 255, 255)})
		table.insert(self.toDisplayStuff, {"Red", Color(255, 0, 0, 255)})
		table.insert(self.toDisplayStuff, {"Blood Red", Color(150, 0, 0, 255)})
		table.insert(self.toDisplayStuff, {"Green", Color(0, 255, 0, 255)})
		table.insert(self.toDisplayStuff, {"Forest Green", Color(0, 150, 0, 255)})
		table.insert(self.toDisplayStuff, {"Blue", Color(0, 0, 255, 255)})
		table.insert(self.toDisplayStuff, {"Ocean Blue", Color(0, 0, 150, 255)})
		table.insert(self.toDisplayStuff, {"Purple", Color(255, 0, 255, 255)})
		table.insert(self.toDisplayStuff, {"Yellow", Color(255, 255, 255, 255)})
		table.insert(self.toDisplayStuff, {"Orange", Color(255, 165, 0, 255)})
		table.insert(self.toDisplayStuff, {"Teal", Color(0, 255, 255, 255)})
		table.insert(self.toDisplayStuff, {"Pink", Color(255, 105, 180, 255)})
		table.insert(self.toDisplayStuff, {"Brown", Color(150, 75, 0, 255)})
	end
	
	if (self.curSpot < 1) then
		self.curSpot = #self.toDisplayStuff
		self.startPos = math.Clamp(self.curSpot - 4, 1, #self.toDisplayStuff)
	elseif (self.curSpot > #self.toDisplayStuff) then
		self.curSpot = 1
		self.startPos = 1
	end
			
	local perArea = screenH * .2
	
	local curArea = 0
	
	if (self.level == 1) then
		local hours, mins = 0, 0
		local text
		if (GAMEMODE.Options_EuroStuff:GetBool()) then
			if (mins < 10) then mins = "0" .. mins end
			text = hours .. ":" .. mins
		else
			local a = "AM"
			if (hours > 11) then a = "PM" end
		
			if (hours > 12) then
				hours = hours - 12
			elseif (hours == 0) then
				hours = 12
			end
			
			if (mins < 10) then mins = "0" .. mins end
			text = hours .. ":" .. mins .. " " .. a
		end
		
		//draw.SimpleText(text, "PhoneFontSmall", screenX + screenW * .5, screenY + self.smallY, tColor, 1, 1)
		
		screenY = screenY + self.smallY * 2
	end
	
	for i = self.startPos, self.startPos + 4 do
		if (self.toDisplayStuff[i]) then
			local prefix = ""
			
			if (self.level == 4 and i == LocalPlayer():GetGNWVar("ringtone", 1)) then prefix = "> " end

			if (self.level == 5 and self.toDisplayStuff[i][2].r == phone_background_r:GetInt() and self.toDisplayStuff[i][2].g == phone_background_g:GetInt() and self.toDisplayStuff[i][2].b == phone_background_b:GetInt()) then prefix = "> " end
			if (self.level == 6 and self.toDisplayStuff[i][2].r == phone_highlight_r:GetInt() and self.toDisplayStuff[i][2].g == phone_highlight_g:GetInt() and self.toDisplayStuff[i][2].b == phone_highlight_b:GetInt()) then prefix = "> " end
			if (self.level == 7 and self.toDisplayStuff[i][2].r == phone_text_r:GetInt() and self.toDisplayStuff[i][2].g == phone_text_g:GetInt() and self.toDisplayStuff[i][2].b == phone_text_b:GetInt()) then prefix = "> " end
			
			if (i == self.curSpot) then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawRect(screenX, screenY + perArea * curArea, screenW, perArea)
				
				surface.SetDrawColor(math.Clamp(phone_highlight_r:GetInt(), 0, 255), math.Clamp(phone_highlight_g:GetInt(), 0, 255), math.Clamp(phone_highlight_b:GetInt(), 0, 255), 200)
				surface.DrawRect(screenX, screenY + perArea * curArea, screenW, perArea)
			end
			
			draw.SimpleText(prefix .. self.toDisplayStuff[i][1], "PhoneFont", screenX + 5, screenY + (perArea * (curArea + .5)), tColor, 0, 1)
		end
		
		curArea = curArea + 1
	end
end

function PANEL:GoUp ( )
	self.CurrentlyShowing = true
	self.ShowingTime = CurTime()
	self:SetAlpha(255)
	self.CurUp = true
	self.lastScroll = CurTime()
	
	if (self.demoSound) then
		self.demoSound:Stop()
		self.demoSound = nil
		self.demoPlaying = nil
	end
	
	self:MakePopup()
	self:SetMouseInputEnabled()
end

function PANEL:GoDown ( )
	self.CurrentlyShowing = nil
	self.ShowingTime = CurTime() + slideTime
	self.CurUp = nil
	
	self:SetKeyboardInputEnabled()
end

local rewindNumbers = {}
rewindNumbers[2] = 1
rewindNumbers[3] = 1
rewindNumbers[4] = 3
rewindNumbers[5] = 3
rewindNumbers[6] = 3
rewindNumbers[7] = 3

function PANEL:OnKeyCodePressed ( Key )		
	if (Key == GAMEMODE.GetPhoneKey()) then
		self:GoDown()
	elseif (Key == KEY_S or Key == KEY_DOWN) then
		self.curSpot = self.curSpot + 1
		self.lastScroll = CurTime()
		
		if (self.demoSound) then
			self.demoSound:Stop()
			self.demoSound = nil
			self.demoPlaying = nil
		end
		
		if (self.curSpot - 4 > self.startPos) then self.startPos = self.curSpot - 4 end
	elseif (Key == KEY_W or Key == KEY_UP) then
		self.curSpot = self.curSpot - 1
		self.lastScroll = CurTime()
		
		if (self.demoSound) then
			self.demoSound:Stop()
			self.demoSound = nil
			self.demoPlaying = nil
		end
		
		if (self.curSpot < self.startPos) then self.startPos = self.curSpot end
	elseif (Key == KEY_D or Key == KEY_RIGHT or Key == KEY_SPACE) then
		if (self.level == 2 or (self.level == 1 and self.toDisplayStuff[self.curSpot][2] == 911)) then
			if (!GAMEMODE.Call_Time and self.toDisplayStuff[self.curSpot]) then
				surface.PlaySound(Sound("perp2.5/phone_dial.mp3"))
				
				local pd = SoundDuration("perp2.5/phone_dial.mp3")
				local pe = SoundDuration("perp2.5/phone_error.mp3")
				
				local playerExists
				if (self.level == 1) then
					if (team.NumPlayers(TEAM_DISPATCHER) ~= 0) then
						for k, v in pairs(team.GetPlayers(TEAM_DISPATCHER)) do
							playerExists = v
							break
						end
					end
					
					if (GAMEMODE.Options_EuroStuff:GetBool()) then
						GAMEMODE.Call_Player = "000"
					else
						GAMEMODE.Call_Player = "911"
					end
				else
					for k, v in pairs(player.GetAll()) do
						if (tostring(v:UniqueID()) == tostring(self.toDisplayStuff[self.curSpot][2])) then
							playerExists = v
							break
						end
					end
					
					if (playerExists) then
						GAMEMODE.Call_Player = playerExists:GetRPName()
					else
						GAMEMODE.Call_Player = self.toDisplayStuff[self.curSpot][1]
					end
				end
				
				GAMEMODE.Call_Time = CurTime()
				GAMEMODE.PhoneText = "Calling"
				
				self:SetKeyboardInputEnabled()
				
				if (playerExists and playerExists ~= LocalPlayer()) then
					timer.Simple(pd + .5, function() RunConsoleCommand( "perp_dp", playerExists:UniqueID() ) end )
					
					self.lastRing = CurTime() + pd + .5
				else
					self.lastRing = CurTime() + 50000
					timer.Simple(pd + .5, function() surface.PlaySound( Sound( "perp2.5/phone_error.mp3" ) ) end )
					timer.Simple(pd + .5, function () GAMEMODE.PhoneText = "Connected To" end )
					timer.Simple(pd + .5 + pe, function () if GAMEMODE.Call_Player then GAMEMODE.Phone:GoDown() end GAMEMODE.Call_Player = nil GAMEMODE.Call_Time = nil end )
				end
			end
		elseif self.level < 4 then
			self.level = self.toDisplayStuff[ self.curSpot ][2]
			self.curSpot = 1
			self.startPos = 1
		elseif self.level == 4 then
			RunConsoleCommand( "perp_rt", self.curSpot )
		else
			local prefix
			if (self.level == 5) then prefix = "perp2_phone_background_" end
			if (self.level == 6) then prefix = "perp2_phone_highlight_" end
			if (self.level == 7) then prefix = "perp2_phone_text_" end
			
			local col = self.toDisplayStuff[self.curSpot][2]
			RunConsoleCommand(prefix .. "r", col.r)
			RunConsoleCommand(prefix .. "g", col.g)
			RunConsoleCommand(prefix .. "b", col.b)
		end
	elseif (Key == KEY_A or Key == KEY_LEFT) then
		if (!rewindNumbers[self.level]) then return end
		
		self.level = rewindNumbers[self.level]
		self.curSpot = 1
		self.startPos = 1
		
		if (self.demoSound) then
			self.demoSound:Stop()
			self.demoSound = nil
			self.demoPlaying = nil
		end
	end
end

vgui.Register( "perp2_phone", PANEL )