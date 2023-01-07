--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

surface.CreateFont("paris_phonedermalarge", {
    font = "Roboto Thin",
    weight = 0,
	size = 30
})

surface.CreateFont("paris_phonedermasmall", {
    font = "Roboto",
    weight = 1000,
	size = 18,
	antialias = true
})

surface.CreateFont("paris_phonedermamedium", {
    font = "Roboto Thin",
    weight = 0,
	size = 20
})

surface.CreateFont("paris_phonedermamediumbold", {
    font = "Roboto Bold",
	size = 22
})

sound.Add( {
	name = "internal_ringing",
	channel = CHAN_STATIC,
	volume = 0.2,
	level = 80,
	pitch = { 100, 101 },
	sound = "paris/internalringing.mp3"
} )

sound.Add( {
	name = "phone_busy",
	channel = CHAN_STATIC,
	volume = 0.8,
	level = 80,
	pitch = { 100, 101 },
	sound = "paris/busy.mp3"
} )

local GradientUp = Material( "gui/gradient_up" )
local GradientDown = Material( "gui/gradient_down" )
local PhoneBorder = Material( "paris/phoneborder3.png" )
local BatteryIcon = Material( "paris/battery-icon.png" )

local function RegisterPhoneDerma()
    local PANEL = {}

    function PANEL:Init()
        self:SetSize( 260, 530 )
        self:SetPos(ScrW()-400, ScrH())
        self.InitialY = ScrH()
        self.SetY = ScrH()-(self:GetTall()+13)
        self:MakePopup()
        self:SetMouseInputEnabled( true )
        self:SetKeyboardInputEnabled(false)
    end

	local BorderColor = Color( 128, 128, 128)
	local MainBackgroundColor = Color( 54, 54, 54)
	local Background = Material("paris/phonebackgrounds/street.png")
    function PANEL:Paint( w, h )
        local InitX, Y = self:GetPos()
        self.InitialY = Lerp( 10 * FrameTime() , self.InitialY , self.SetY)
        self:SetPos( InitX, self.InitialY )
        draw.RoundedBox( 0, 0, 0, w, h, MainBackgroundColor )
		surface.SetDrawColor( 255,255,255,255 )
		surface.SetMaterial( Background )
		surface.DrawTexturedRect( 0, 0, w, h )
        surface.SetDrawColor( 0,0,0, 200 )
		surface.SetMaterial( GradientUp )
        surface.DrawTexturedRect( 0, 0, w, h )
        surface.DrawTexturedRect( 0, 0, w, 30 )
        surface.SetDrawColor( 255,255,255,255 )
		surface.SetMaterial( PhoneBorder )
		DisableClipping(true)
        surface.DrawTexturedRect( -16, -12, w+31, h+24 )
		DisableClipping(false)
		surface.SetMaterial( BatteryIcon )
		surface.DrawTexturedRect( w-44, 13, 24, 12 )
        if StormFox then
		    draw.SimpleText(StormFox.GetRealTime(StormFox.GetTime(),false), "paris_phonedermasmall", 34, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        end
        local x, y = self:LocalCursorPos()
        local x2, y2 = self:GetSize()
        if input.IsMouseDown(MOUSE_LEFT) and not (x<x2 and y<y2 and x>0 and y>0)  then
            self:SetMouseInputEnabled( false )
        else
            self:SetMouseInputEnabled( true )
        end
    end
    function PANEL:SmoothRemove()
        if self.EndCallOnClose then
            LocalPlayer():StopSound("internal_ringing")
            net.Start("paris_endcall")
            net.SendToServer()
        end
        self.SetY = ScrH()+20
        self:SetMouseInputEnabled( false )
        timer.Simple(0.5, function()
            if IsValid(self) then
                self:Remove()
            end
        end)
    end
    PANEL.Buttons = {}
    function PANEL:AddButton(memorypart, text, func, icon, updatetextfunc)
        if !self.ScrollPanel then
            self.ScrollPanel = vgui.Create("DScrollPanel")
            self.ScrollPanel:SetParent(self)
            self.ScrollPanel:SetPos(0,30)
            self.ScrollPanel:SetSize(self:GetWide(),self:GetTall()-60)
        end
        local m = memorypart
        if !self.Buttons[m] then self.Buttons[m] = {} end
        local n = #self.Buttons[m] + 1
        self.Buttons[m][n] = vgui.Create("DButton", self.ScrollPanel)
        self.Buttons[m][n]:SetSize( self:GetWide(), 50 )
        self.Buttons[m][n]:SetPos(0,((#self.Buttons[m] - 1)*self.Buttons[m][n]:GetTall()+(#self.Buttons[m])))
        self.Buttons[m][n]:SetText("")
        self.Buttons[m][n].Text = tostring(text)
		local btnbg = Color( 22, 22, 22, 250 )
		local btnhighlight = Color(186, 255, 255)
		local btnwhite = Color(200, 200, 200)
        self.Buttons[m][n].Paint = function()
            local fader = math.abs(math.sin(CurTime() * 1.5))
            draw.RoundedBox( 0, 0, 0, self.Buttons[m][n]:GetWide(), self.Buttons[m][n]:GetTall(), btnbg )
            local text = self.Buttons[m][n].Text
            if isfunction(updatetextfunc) then
                text = updatetextfunc()
            end
			local buffer = 50
			if not icon then buffer = 0 end
            if self.Buttons[m][n]:IsHovered() then
                draw.SimpleText(text, "paris_phonedermamedium", 10 + buffer, self.Buttons[m][n]:GetTall()/2, btnhighlight, 0, 1)
                surface.SetDrawColor( 255,255,255,150*fader )
                surface.SetMaterial( GradientUp )
                surface.DrawTexturedRect( 0, 0, self:GetWide(), self:GetTall() )
            else
                draw.SimpleText(text, "paris_phonedermamedium", 10 + buffer, self.Buttons[m][n]:GetTall()/2, btnwhite, 0, 1)
            end
			if icon then
				surface.SetDrawColor( 255,255,255,255 )
				surface.SetMaterial( icon )
				surface.DrawTexturedRect( 6, 2, 45, 45 )
			end
        end
        self.Buttons[m][n].DoClick = func
    end
    function PANEL:AddSelectButton(memorypart, text, func, rightclickfunc)
        if !self.ScrollPanel then
            self.ScrollPanel = vgui.Create("DScrollPanel")
            self.ScrollPanel:SetParent(self)
            self.ScrollPanel:SetPos(0,0)
            self.ScrollPanel:SetSize(self:GetWide(),self:GetTall()-60)
        end
        local m = memorypart
        if !self.Buttons[m] then self.Buttons[m] = {} end
        local n = #self.Buttons[m] + 1
        self.Buttons[m][n] = vgui.Create("DButton", self.ScrollPanel)
        self.Buttons[m][n]:SetSize( self:GetWide(), 50 )
        self.Buttons[m][n]:SetPos(0,((#self.Buttons[m]-1)*self.Buttons[m][n]:GetTall()+(#self.Buttons[m])))
        self.Buttons[m][n]:SetText("")
        self.Buttons[m][n].Text = tostring(text)
		local highlightcol = Color(186, 255, 255)
		local col2 = Color(200, 200, 200)
        self.Buttons[m][n].Paint = function()
            local fader = math.abs(math.sin(CurTime() * 1.5))
            draw.RoundedBox( 0, 0, 0, self.Buttons[m][n]:GetWide(), self.Buttons[m][n]:GetTall(), Color( 22, 22, 22, 230 ) )
            if self.Buttons[m][n]:IsHovered() then
                draw.SimpleText(self.Buttons[m][n].Text, "paris_phonedermamedium", 10, self.Buttons[m][n]:GetTall()/2, highlightcol, 0, 1)
                surface.SetDrawColor( 255,255,255,150*fader )
                surface.SetMaterial( GradientUp )
                surface.DrawTexturedRect( 0, 0, self:GetWide(), self:GetTall() )
            else
                draw.SimpleText(self.Buttons[m][n].Text, "paris_phonedermamedium", 10, self.Buttons[m][n]:GetTall()/2, col2, 0, 1)
            end
            if self.Buttons[m][n].Selected then
                surface.SetDrawColor( 20,100,20,50*fader )
                surface.SetMaterial( GradientDown )
                surface.DrawTexturedRect( 0, 0, self:GetWide(), self.Buttons[m][n]:GetTall() )
            end
        end
        self.Buttons[m][n].DoClick = func
        self.Buttons[m][n].DoRightClick = rightclickfunc
        return self.Buttons[m][n]
    end
    function PANEL:ClearButtons(mempart, delete)
        if self.Buttons[mempart] then
            for k, v in pairs(self.Buttons[mempart]) do
                if IsValid(v) then
                    if delete then
                        v:Remove()
                        self.Buttons[mempart][k] = nil
                    else
                        v:Hide()
                    end
                end
            end
        end
    end
    function PANEL:ShowMemory(mempart)
        if self.Buttons[mempart] then
            for k, v in pairs(self.Buttons[mempart]) do
                if IsValid(v) then
                    v:Show()
                end
            end
        end
    end
    function PANEL:ClearMemory()
        self.Buttons = {}
    end
    function PANEL:PrintAllMemory()
        PrintTable(self.Buttons)
    end
    vgui.Register( "PARIS_PhoneMain", PANEL, "Panel" )
end
RegisterPhoneDerma()

local function OpenMessageBox(name, thing)
    if IsValid(MESSAGE) then MESSAGE:Remove() end
    MESSAGE = vgui.Create("PARIS_MessageMenu")
    MESSAGE.Func = thing
    MESSAGE.Name = name
    MESSAGE:MakePopup()
    MESSAGE:SetMouseInputEnabled( true )
end

local function OpenPhone( PersonCalling )
    if IsValid(MainPhone) then MainPhone:Remove() end
    MainPhone = vgui.Create("PARIS_PhoneMain")
    MainPhone:ClearMemory()
    if PersonCalling and IsValid(PersonCalling) then
        MainPhone:AddButton("main", "Call From " .. PersonCalling:GetRPName(), function() end)
        MainPhone:AddButton("main", "Answer", function()
            MainPhone:ClearButtons("main", true)
            net.Start("paris_pickupcall")
            net.SendToServer()
            local StartTime = CurTime()
            MainPhone:AddButton("call", "", function() end, Material("paris/phoneicon.png"), function() return math.floor(CurTime() - StartTime) end)
            MainPhone:AddButton("call", "End Call", function()
                net.Start("paris_endcall")
                net.SendToServer()
                LocalPlayer():StopSound("internal_ringing")
                MainPhone:ClearButtons("call", true)
                MainPhone:SmoothRemove()
            end)
        end)
        MainPhone:AddButton("main", "Deny", function()
            LocalPlayer():StopSound("internal_ringing")
            net.Start("paris_endcall")
            net.SendToServer()
            MainPhone:SmoothRemove()
        end)
        return
    end
    MainPhone:AddButton("main", "Phone", function()
        MainPhone:ClearButtons("main")
        MainPhone:AddButton("phone", "Back", function()
            MainPhone:ClearButtons("phone", true)
            MainPhone:ShowMemory("main")
        end)
        for k, v in pairs(player.GetAll()) do
            if v==LocalPlayer() then continue end
            MainPhone:AddButton("phone", v:GetRPName(), function()
                net.Start("paris_startcall")
                    net.WriteEntity(v)
                net.SendToServer()
                LocalPlayer():EmitSound("internal_ringing")
                MainPhone:ClearButtons("phone", true)
                MainPhone.EndCallOnClose = true
                MainPhone:AddButton("call", "End Call", function()
                    net.Start("paris_endcall")
                    net.SendToServer()
                    LocalPlayer():StopSound("internal_ringing")
                    MainPhone:ClearButtons("call", true)
                    MainPhone:ShowMemory("main")
                end)
                net.Receive("paris_serverpickupcall", function()
                    MainPhone:ClearButtons("call", true)
                    LocalPlayer():StopSound("internal_ringing")
                    local StartTime = CurTime()
                    MainPhone:AddButton("call", "", function() end, Material("paris/phoneicon.png"), function() return math.floor(CurTime() - StartTime) end)
                    MainPhone:AddButton("call", "End Call", function()
                        net.Start("paris_endcall")
                        net.SendToServer()
                        LocalPlayer():StopSound("internal_ringing")
                        MainPhone:ClearButtons("call", true)
                        MainPhone:ShowMemory("main")
                    end)
                end)
            end)
        end
    end, Material("paris/phoneicon.png") )
    MainPhone:AddButton("main", "Messages", function()
        MainPhone:ClearButtons("main")
        MainPhone:AddButton("msgs", "Back", function()
            MainPhone:ClearButtons("msgs", true)
            MainPhone:ShowMemory("main")
        end)
        for k, v in pairs(player.GetAll()) do
            if v==LocalPlayer() then continue end
            MainPhone:AddButton("msgs", v:GetRPName(), function()
                OpenMessageBox(v:GetRPName(), function(text)
                    --[[net.Start("paris_sendtextmessage")
                        net.WriteEntity(v)
                        net.WriteString(text)
                    net.SendToServer()]]
                    LocalPlayer():ConCommand("say \"/pm " .. string.Replace(v:GetRPName()," ",".") .. " " .. text .. "\"")
                end)
            end)
        end
    end, Material( "paris/messageicon.png" ))
    MainPhone:AddButton("main", "Settings", function()
        MainPhone:ClearButtons("main")
        MainPhone:AddButton("stngs", "Text Tone", function()
            MainPhone:ClearButtons("stngs")

            // TEXT tones

            local tones = {
                {Name = "Aurora", Path ="paris/phone/Aurora.mp3"},
                {Name = "Bamboo", Path ="paris/phone/Bamboo.mp3"},
                {Name = "Chord", Path ="paris/phone/Chord.mp3"},
                {Name = "Circles", Path ="paris/phone/Circles.mp3"},
                {Name = "Complete", Path ="paris/phone/Complete.mp3"},
                {Name = "Export", Path ="paris/phone/Export.mp3"},
                {Name = "Hello", Path ="paris/phone/Hello.mp3"},
                {Name = "Input", Path ="paris/phone/Input.mp3"},
                {Name = "Keys", Path ="paris/phone/Keys.mp3"},
                {Name = "Note", Path ="paris/phone/Note.mp3"},
                {Name = "Popcorn", Path ="paris/phone/Popcorn.mp3"},
                {Name = "Synth", Path ="paris/phone/Synth.mp3"},
            }
            for k, v in pairs(tones) do
                local b = MainPhone:AddSelectButton("texttones", v.Name, function()
                    MainPhone:ClearButtons("texttones", true)
                    MainPhone:ShowMemory("stngs")
                    local oldsettings = util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or "") or {}
                    oldsettings.TextTone = v
                    oldsettings.TextToneK = k
                    net.Start("paris_sendtexttones")
                    net.WriteInt(k,16)
                    net.SendToServer()
                    file.Write("paris_phonesettings.txt", util.TableToJSON(oldsettings))
                end,
                function()
                    surface.PlaySound(v.Path)
                end)
                local tone = (util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or ""))

                if ((tone and tone.TextTone and tone.TextTone.Name) or "Export") == v.Name then b.Selected = true end
            end
        end)
        MainPhone:AddButton("stngs", "Ring Tone", function()
            MainPhone:ClearButtons("stngs")
            for k, v in ipairs(phoneRingTones) do
                local b = MainPhone:AddSelectButton("ringtones", v[2], function()
                    MainPhone:ClearButtons("ringtones", true)
                    MainPhone:ShowMemory("stngs")
                    local oldsettings = util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or "") or {}
                    oldsettings.RingTone = k
                    net.Start("paris_sendringtones")
                        local tone = (util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or ""))
                        net.WriteInt(oldsettings.RingTone or 1,16)
                    net.SendToServer()
                    file.Write("paris_phonesettings.txt", util.TableToJSON(oldsettings))
                end,
                function()
                    surface.PlaySound(v[1] .. ".mp3")
                end)
                local tone = (util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or ""))

                if ((tone and tone.RingTone) or 1) == k then b.Selected = true end
            end
            --MainPhone:ClearButtons("stngs", true)
            --MainPhone:ShowMemory("main")
        end)
        MainPhone:AddButton("stngs", "Back", function()
            MainPhone:ClearButtons("stngs", true)
            MainPhone:ShowMemory("main")
        end)
    end, Material( "paris/settingsicon.png" ))
end

net.Receive("paris_callnotice", function()
    local ent = net.ReadEntity()
    if !IsValid(ent) then return end
    OpenPhone( ent )
end)

net.Receive("paris_serverendcall", function()
    LocalPlayer():StopSound("internal_ringing")
    MainPhone:SmoothRemove()
end)
net.Receive("paris_busytone", function()
    LocalPlayer():StopSound("internal_ringing")
    LocalPlayer():EmitSound("phone_busy")
    if IsValid(MainPhone) then 
        MainPhone:SmoothRemove()
    end
    timer.Simple(3, function()
        LocalPlayer():StopSound("phone_busy")
    end)
end)

net.Start("paris_sendringtones")
    local tone = (util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or "")) or {}
    net.WriteInt(tone.RingTone or 1,16)
net.SendToServer()

net.Start("paris_sendtexttones")
    local tone = (util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or "")) or {}
    net.WriteInt(tone.TextToneK or 1,16)
net.SendToServer()

local NoKeyDown = false

hook.Add("Think", "PARIS_BindThinkPhone", function()
	if not LocalPlayer():Alive() then return end
	if GAMEMODE.ChatBoxOpen then return end
	if GAMEMODE.MayorPanel and GAMEMODE.MayorPanel.IsVisible and GAMEMODE.MayorPanel:IsVisible() then return end
	if GAMEMODE.OrgPanel and GAMEMODE.OrgPanel.IsVisible and GAMEMODE.OrgPanel:IsVisible() then return end
	if GAMEMODE.HelpPanel and GAMEMODE.HelpPanel.IsVisible and GAMEMODE.HelpPanel:IsVisible() then return end
    if gui.IsGameUIVisible() then return end
	if not LocalPlayer():HasItem("item_phone") then return end
    if input.IsKeyDown(KEY_Z) then
        if !IsValid(MainPhone) and NoKeyDown then
            OpenPhone()
        else
            if NoKeyDown then
                MainPhone:SmoothRemove() -- Make a transition function instead later
            end
        end
        NoKeyDown = false
    else
        NoKeyDown = true
    end
end)




local PANEL = {}
local Notifications = {}

function PANEL:Init()
    self:SetSize( 400, 100 )
    self:SetPos(ScrW(), 0)
    self:MakePopup()
    self.InitialX = ScrW()
    self.SetX = ScrW()-(self:GetWide() + 5)
    self.DeathTime = CurTime() + 5
    self:SetMouseInputEnabled( false )
    self:SetKeyboardInputEnabled(false)
end

local ButtonColor = Color(22,22,22,230)
function PANEL:Paint( w, h )
    local X, InitY = self:GetPos()
    self.InitialX = Lerp( 10 * FrameTime() , self.InitialX , self.SetX)
    local bonusY = ScrH()
    if IsValid(MainPhone) then
        _, bonusY = MainPhone:GetPos()
    end
    self:SetPos( self.InitialX, (ScrH()-200-(110*(self.Number-1))) + (bonusY - ScrH()) )
    if CurTime() > self.DeathTime then
        self.SetX = ScrW()
        if math.abs(X - ScrW()) < 2 then
            Notifications[self.Number] = nil
            for k, v in pairs(Notifications) do
                if k > self.Number then
                    k = k - 1
                end
            end
            self:Remove()
        end
    end
    draw.RoundedBox( 0, 0, 0, w, h, ButtonColor )
    draw.SimpleText(self.TopText, "paris_phonedermalarge", 15, self:GetTall()*0.3, color_white, 0, 1)
    draw.SimpleText(self.Text, "paris_phonedermamedium", 15, self:GetTall()*0.6, color_white, 0, 1)
end
vgui.Register( "PARIS_PhoneNotification", PANEL, "DPanel" )

function SendPhoneNotification(toptext, text)
    local tone = (util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or ""))
    local path = "paris/phone/Export.mp3"
    if tone and tone.TextTone and tone.TextTone.Path then path = tone.TextTone.Path end
    surface.PlaySound(path)
    local highest = 0
    for k, v in pairs(Notifications) do
        if k > highest then highest = k end
        if !IsValid(v) then
            v:Remove()
        end
    end
    local tab = {}
    local n = #Notifications+1
    if highest then
        for i=highest+1,1,-1 do
            if !Notifications[i] or !IsValid(Notifications[i]) then
                n = i
            end
        end
    end
    // find highest number in it, go from lowest to highest and find the first empty slot
    Notifications[n] = vgui.Create("PARIS_PhoneNotification")
    Notifications[n].Number = n
    Notifications[n].TopText = tostring(toptext)
    Notifications[n].Text = tostring(text)
end

net.Receive("paris_receivetextmessage", function()
    local Person = net.ReadEntity()
    local Text = net.ReadString()
    SendPhoneNotification(tostring(Person:GetRPName()) .. ":", Text)
    chat.AddText(Color(255,40,40), "[PM] " , Color(40,255,40), tostring(Person:GetRPName()) .. ": ", Color(80,255,80), Text )
end)

local function RegisterMessageMenuDerma()
    local PANEL = {}

    function PANEL:Init()
        self:SetSize( 600, 180 )
        self:Center()
        self:SetTitle("")
        self:ShowCloseButton(false)
        self:SetDraggable(true)
        self.CloseButton = vgui.Create("DButton", self)
        self.CloseButton:SetSize( 30, 30 )
        self.CloseButton:SetPos(self:GetWide()-self.CloseButton:GetWide(),0)
        self.CloseButton:SetText("X")
        self.CloseButton:SetTextColor(Color(255,255,255,255))
		local bg = Color( 22, 22, 22, 230 )
        function self.CloseButton:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, bg )
        end
        self.CloseButton.DoClick = function()
            self:Remove()
        end
        self.EnterButton = vgui.Create("DButton", self)
        self.EnterButton:SetSize( 150, 40 )
        self.EnterButton:SetPos((self:GetWide()/2)-(self.EnterButton:GetWide()/2),110)
        self.EnterButton:SetText("")
		local highlightcolor = Color(186, 255, 255)
        function self.EnterButton:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, bg )
            if self:IsHovered() then
                draw.SimpleText("Send", "paris_phonedermamedium", self:GetWide()/2, self:GetTall()/2, highlightcolor, 1, 1)
            else
                draw.SimpleText("Send", "paris_phonedermamedium", self:GetWide()/2, self:GetTall()/2, color_white, 1, 1)
            end
        end
        self.EnterButton.DoClick = function()
            self:Remove()
            self.Func(self.TextEntry:GetValue())
        end
        self.TextEntry = vgui.Create( "DTextEntry", self)
        self.TextEntry:RequestFocus()
        self.TextEntry:SetSize( 500, 45 )
        self.TextEntry:SetPos((self:GetWide()/2)-(self.TextEntry:GetWide()/2),50)
        self.TextEntry:SetPlaceholderText("Message")
        self.TextEntry:SetUpdateOnType(true)
        self.TextEntry:SetFont("paris_phonedermamedium")
        self.TextEntry:SetDrawBackground(false)
        self.TextEntry:SetTextColor(Color(255,255,255))
        self.TextEntry:SetCursorColor(Color(255,255,255))
        self.TextEntry.OldPaint = self.TextEntry.Paint
		local col = Color(22,22,22,150)
        self.TextEntry.Paint = function()
			self.TextEntry:SetTextColor(Color(255,255,255))
			self.TextEntry:SetCursorColor(Color(255,255,255))
            self.TextEntry:OldPaint(self.TextEntry:GetWide(), self.TextEntry:GetTall())
            draw.RoundedBox( 2, 0, 0, self.TextEntry:GetWide(), self.TextEntry:GetTall(), col)
        end
        self.TextEntry.OnEnter = function()
            self:Remove()
            self.Func(self.TextEntry:GetValue())
        end
    end

    PANEL.MovingThing = 0

    local matBlurScreen = Material( "pp/blurscreen" )
	local StaticColor = Color( 46, 46, 46, 255 )
	local HighlightColor = Color( 255, 255, 0, 255 )
    function PANEL:Paint( w, h )
        local x, y = self:LocalToScreen( 0, 0 )
        surface.SetMaterial( matBlurScreen )
        surface.SetDrawColor( 255, 255, 255, 255 )
        DisableClipping(true)
        for i=0.33, 1, 0.33 do
            matBlurScreen:SetFloat( "$blur", 0.8 * 5 * i )
            matBlurScreen:Recompute()
            if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
            surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
        end
        surface.SetDrawColor( 10, 10, 10, 150 )
        surface.DrawRect( x * -1, y * -1, ScrW(), ScrH() )
        DisableClipping(false)

        draw.RoundedBox( 0, 0, 0, w, h, StaticColor )
        surface.SetDrawColor( 0,0,0, 200 )
		surface.SetMaterial( GradientUp )
        surface.DrawTexturedRect( 0, 0, self:GetWide(), self:GetTall() )
        surface.DrawTexturedRect( 0, 0, self:GetWide(), 30 )
        surface.SetDrawColor( 255,255,255, 30 )
        draw.RoundedBox( 0, 0, 0, w, 30, HighlightColor )
        draw.SimpleText("Message to " .. self.Name, "paris_phonedermamediumbold", 10, 15, color_black, 0, 1)
        --surface.DrawTexturedRectRotated( self:GetWide() + self.MovingThing, 15, 30, self:GetWide(), 90 )
    end

    vgui.Register( "PARIS_MessageMenu", PANEL, "DFrame" )

end

RegisterMessageMenuDerma()

net.Start("paris_phonesyssendringtone")
net.WriteString("paris/phone/Ringtones/Trap.mp3")
net.SendToServer()