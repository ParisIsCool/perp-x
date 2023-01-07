include("shared.lua")

local cvar_enabled = CreateConVar("whk_mediaenabled", "1", FCVAR_ARCHIVE)
local cvar_vol = CreateConVar("whk_mediavolume", "1", FCVAR_ARCHIVE)
local cvar_useToView = CreateConVar("whk_usetoview", "1", FCVAR_ARCHIVE)

function ENT:ShouldMediaPlay()
	return cvar_enabled:GetBool() and not self:IsDormant() and LocalPlayer():EyePos():Distance(self:GetPos()) < 1024
end

function ENT:Think()
	local link = self:GetUrl()
	local shouldPlay = self:ShouldMediaPlay()

	if IsValid(self.Media) and (not shouldPlay or not link) then
		self.Media:stop()
		self.Media = nil
	elseif shouldPlay and (not IsValid(self.Media) or self.Media:getUrl() ~= link) then
		if IsValid(self.Media) then
			self.Media:stop()
			self.Media = nil
		end

		if link ~= "" then
			local service = whk.medialib.load("media").guessService(link)

			-- attempt to fallback on webradio, if we get this far the url is prob. provided directly
			if not service then
				service = whk.medialib.load("media").service("webradio")
			end

			local mediaclip = service:load(link, {use3D = true, ent3D = self})

			mediaclip:play()
			mediaclip:seek(CurTime() - self:GetMediaStartTime())
			self.Media = mediaclip
		end
	end

	if IsValid(self.Media) then
		self.Media:setVolume(cvar_vol:GetFloat())

		-- if local media is significantly ahead of server media, restart the whole media clip; chances are video was re-queued
		local sv_elapsed = CurTime() - self:GetMediaStartTime()
		if self.Media:getTime() > sv_elapsed + 5 then
			self.Media:stop()
			self.Media = nil
		end
	end
end

local PANEL = {}

AccessorFunc(PANEL, "_callback", "Callback")

function PANEL:GetDefaultHTML()
	return [[
    <!DOCTYPE html>
    <html>
    	<head>
    		<meta charset="utf-8">
    		<style>
    			body {
    				background-color: white;
    			}
    		</style>
    	</head>
    	<body>
            <h1>Medialib video selector</h1>
            <a href="http://youtube.com">Youtube</a>
    	</body>
    </html>
	]]
end

function PANEL:Init()
	self.browser = vgui.Create("DHTML", self)
	self.browser:Dock(FILL)
	self.browser:SetHTML(self:GetDefaultHTML())

	-- GarryHTML has a weird Paint which flashes during loads. This fixes it
	self.browser.Paint = function() end

	-- Get rid of useless console messages
	local oldcm = self.browser.ConsoleMessage
	self.browser.ConsoleMessage = function(pself, msg, ...)
		if msg then
			if string.find(msg, "XMLHttpRequest") then return end
			if string.find(msg, "Unsafe JavaScript attempt to access") then return end
		end

		return oldcm(pself, msg, ...)
	end

	-- Needed because eg. youtube does non-documentreloading updates
	self.browser.UrlChanged = function()end
	self.browser:AddFunction("medialib", "CurrentUrl", function(curl)
		if curl ~= self.browser._lastcurl then
			self.browser:UrlChanged(curl)
			self.browser._lastcurl = curl
		end
	end)
	function self.browser:RequestCurrentUrl()
		self:RunJavascript("medialib.CurrentUrl(window.location.href);")
	end

	self.controls = vgui.Create("Panel", self)
	self.controls:Dock(TOP)

	local back = vgui.Create("DImageButton", self.controls)
	back:Dock(LEFT)
	back:SetSize(24, 24)
	back:SetMaterial("gui/HTML/back")
	back.DoClick = function() self.browser:GoBack() end

	local fwd = vgui.Create("DImageButton", self.controls)
	fwd:Dock(LEFT)
	fwd:SetSize(24, 24)
	fwd:SetMaterial("gui/HTML/forward")
	fwd.DoClick = function() self.browser:GoForward() end

	local refresh = vgui.Create("DImageButton", self.controls)
	refresh:Dock(LEFT)
	refresh:SetSize(24, 24)
	refresh:SetMaterial("gui/HTML/refresh")
	refresh.DoClick = function() self.browser:Refresh() end

	local url = vgui.Create("DTextEntry", self.controls)
	url:Dock(FILL)
	url.OnEnter = function() self.browser:OpenURL(url:GetText()) end

	local currentUrl

	local req = vgui.Create("DButton", self.controls)
	req:Dock(RIGHT)
	req:SetWide(150)
	req:SetText("Request Url")
	req.DoClick = function()
		self:GetCallback()(currentUrl)
	end
	req:SetEnabled(false)

	local function UrlChanged(u)
		currentUrl = u

		if vgui.GetKeyboardFocus() ~= url then
			url:SetText(u)
		end

		local vid = whk.medialib.load("media").GuessService(u)
		local enabled = vid ~= nil
		req:SetEnabled(enabled)
	end

	self.browser.OnDocumentReady = function(s, u)
		UrlChanged(u:find("^data:text") and "home" or u)
	end
	self.browser.UrlChanged = function(s, u)
		UrlChanged(u)
	end
	self.browser.OnChangeTitle = function(s, u) self.browser:RequestCurrentUrl() end
end

vgui.Register("WHK_MedialibVideoSelector", PANEL, "Panel")

concommand.Add("whk_mediachooser", function(ply, cmd, args)
	local ent = Entity(tonumber(args[1]))

	local fr = vgui.Create("DFrame")
	fr:SetSkin("WHKSkin")
	fr:SetTitle("Media")
	fr:SetSize(500, 190)
	fr:Center()
--https://www.youtube.com/watch?v=oFhWIzPMpbo

	local form = vgui.Create("DForm", fr)
	form:Dock(FILL)
	form:SetName("Settings")

	form:NumSlider("Volume", "whk_mediavolume", 0, 1, 1)

	local lockcb = form:CheckBox("Lock entity (prevents others from setting media)")
	lockcb:SetValue(ent:GetNWBool("WHK_LockSetMedia", false))
	lockcb.OnChange = function(_, val)
		net.Start("whk_mediaentconfig")
		net.WriteEntity(ent)
		net.WriteString("lock")
		net.WriteBool(val)
		net.SendToServer()
	end

	if ent:CanInteract(LocalPlayer()) and ent.CanSetUrl then

		local loopcb = form:CheckBox("Loop media")
		loopcb:SetValue(ent:GetNWBool("WHK_LoopMedia", false))
		loopcb.OnChange = function(_, val)
			net.Start("whk_mediaentconfig")
			net.WriteEntity(ent)
			net.WriteString("loop")
			net.WriteBool(val)
			net.SendToServer()
		end

		local function req(text)
			local ufr = fr
			local fr = vgui.Create("DFrame")
			fr:SetSkin("WHKSkin")

			local vidsel = fr:Add("WHK_MedialibVideoSelector")
			vidsel:SetCallback(function(url)
				ufr:Close()
				fr:Close()

				net.Start("whk_setmedia")
				net.WriteEntity(ent)
				net.WriteString(url)
				net.SendToServer()
			end)
			vidsel:Dock(FILL)

			vidsel.browser:OpenURL(text or "http://www.youtube.com")

			fr:SetSize(ScrW() * 0.8, ScrH() * 0.8)
			fr:Center()
			fr:MakePopup()
		end

		local btn = form:Button("Set media (or press Ctrl+V to add url from clipboard)")
		btn.DoClick = function()
			req()
		end

		-- Add invisible textentry which listens to keypresses and opens
		-- media adder popup if key events received
		local invis_entry = fr:Add("DTextEntry")
		invis_entry:SetSize(0, 0)
		invis_entry:RequestFocus()
		invis_entry.OnChange = function(self)
			if not self:GetText():match("^http") then return end

			req(self:GetText())
			self:SetText("")
		end
	end

	fr:MakePopup()
end)
