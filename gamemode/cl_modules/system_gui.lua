

--[[//////////////////////////

    -   New GUI Styles
        By Paris

////////////////////////////]]

local styles = {}

-- // FONTS
local fonts = {
    ["Salatiga Regular"] = true,
    ["Balrog"] = true,
}

local defaultfont = "Balrog"

for k, v in pairs(fonts) do
    for i=8,1,-1 do
        local num = i*12
        surface.CreateFont( k..num, {
            font = k,
            size = num,
            weight = 0,
        } )
    end
end

-- // COLORS
local clear = Color(0,0,0,0)
local dark = Color(10,10,10,255)
local light = Color(244,244,244)
local highlight1 = Color(252, 115, 3)
local highlight2 = Color(11, 252, 3)
local fader = Color(244,244,244)

hook.Add("HUDPaint", "guifader", function()
    fader.a = math.abs(math.sin(CurTime()*4))*255
end)


--[[//////
    - Frame
///////]]--
local PANEL = {}
function PANEL:Init()
    self:MakePopup()
    if IsValid(self.btnClose) then self.btnClose:Remove() end
    if IsValid(self.btnMaxim) then self.btnMaxim:Remove() end
    if IsValid(self.btnMinim) then self.btnMinim:Remove() end
    if IsValid(self.lblTitle) then self.lblTitle:Remove() end
    self.closebtn = vgui.Create("perp_button",self)
    self.closebtn:SetSize(32,32)
    self.closebtn:SetButtonText("X")
    function self.closebtn.DoClick()
        self:Remove()
    end
    self.title = vgui.Create("perp_text",self)
    self.title:SetSize(50,32)
    self.title:SetText("Title")
end
function PANEL:SetTitle(title)
    self.title:SetSize(#title*9,32)
    self.title:SetText(title)
end
function PANEL:PerformLayout()
    local w,h = self:GetSize()
    self.closebtn:SetPos(w-32,0)
    self.title:SetPos(5,0)
end
function PANEL:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,dark)
end
vgui.Register("perp_frame", PANEL, "DFrame")

--[[//////
    - Text
///////]]--
local PANEL = {}
function PANEL:Init()
    self.font = defaultfont.."36"
    self.color = color_white
    self.alignx, self.aligny = TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER
    self.text = "Lorem Ipsum"
end
function PANEL:SetText(text)
    self.text = text
end
function PANEL:SetFont(font,size)
    if not fonts[font] then font = defaultfont end
    self.font = font..size
end
function PANEL:SetAlign(alignx,aligny)
    self.alignx, self.aligny = alignx, aligny
end
function PANEL:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,clear)
    local x, y = self:GetPos()
    if self.alignx == TEXT_ALIGN_CENTER then x = (w / 2) end
    if self.aligny == TEXT_ALIGN_CENTER then y = (h / 2) end
    if self.alignx == TEXT_ALIGN_RIGHT then x = w end
    draw.SimpleText(self.text,self.font,x,y,self.color,self.alignx,self.aligny)
end
vgui.Register("perp_text", PANEL, "Panel")
table.insert(styles,"perp_text")

--[[//////
    - Button
///////]]--
local PANEL = {}
function PANEL:Init()
    self:SetText("")
    self.font = defaultfont.."36"
    self.color = color_white
    self.alignx, self.aligny = TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
    self.text = "Lorem Ipsum"
    self.anim = 0
    self.highlight1 = highlight1
    self.highlight2 = highlight2
    self.flash = Color(255,255,255)
end
function PANEL:SetButtonText(text)
    self.text = text
end
function PANEL:SetFont(font,size)
    if not fonts[font] then font = defaultfont end
    self.font = font..size
end
function PANEL:SetAlign(alignx,aligny)
    self.alignx, self.aligny = alignx, aligny
end
function PANEL:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,clear)
    local x, y = self:GetPos()
    local ishovered = self:IsHovered()
    if self.alignx == TEXT_ALIGN_CENTER then x = (w / 2) end
    if self.aligny == TEXT_ALIGN_CENTER then y = (h / 2) end
    if self.alignx == TEXT_ALIGN_RIGHT then x = w end
    if ishovered then
        --flashes
        self.highlight1.a = math.Clamp(self.anim,0,255)
        self.highlight2.a = math.Clamp(self.anim,0,255)
        self.flash.a = (self.anim*0.15)-20
        if self.anim > 0 then
            draw.NoTexture()
            surface.SetDrawColor(self.highlight1)
            draw.SimpleText(self.text,self.font,x+1,y+1,self.highlight1,self.alignx,self.aligny)
            draw.SimpleText(self.text,self.font,x-1,y-1,self.highlight2,self.alignx,self.aligny)
            draw.RoundedBox(0,0,0,w,h,self.flash)
            self.anim = self.anim - 1000*FrameTime()
        end
        --border
        draw.RoundedBox(0,0,0,w,2,fader)
        draw.RoundedBox(0,0,h-2,w,2,fader)
        draw.RoundedBox(0,0,0,2,h,fader)
        draw.RoundedBox(0,w-2,0,2,h,fader)
    else
        self.anim = 500
    end
    draw.SimpleText(self.text,self.font,x,y,self.color,self.alignx,self.aligny)
end
vgui.Register("perp_button", PANEL, "DButton")
table.insert(styles,"perp_button")

--[[//////
    - TextEntry
///////]]--
local PANEL = {}
function PANEL:Init()
    self:SetDrawBackground(false)
    self:SetTextFont(defaultfont,"36")
    self:SetPlaceholder("Enter Text")
    timer.Simple(0.1, function()
        self:SetTextColor( color_white )
        self:SetCursorColor( color_white )
    end)
end
function PANEL:SetTextFont(font,size)
    self.font = font..tostring(size)
    self:SetFont(self.font)
end
function PANEL:SetPlaceholder(placeholder,color)
    self.placeholder = placeholder
    self.placeholdercolor = color or Color(255,255,255,50)
end
function PANEL:PaintOver(w,h)
    draw.RoundedBox(0,0,0,w,2,fader)
    draw.RoundedBox(0,0,h-2,w,2,fader)
    draw.RoundedBox(0,0,0,2,h,fader)
    draw.RoundedBox(0,w-2,0,2,h,fader)
    if self.placeholder and self:GetText() == "" then
        draw.SimpleText(self.placeholder,self.font,4,h/2,self.placeholdercolor,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end
end
vgui.Register("perp_textentry", PANEL, "DTextEntry")
table.insert(styles,"perp_textentry")

concommand.Add("guistyles", function()
    local frame = vgui.Create("perp_frame")
    frame:SetSize(1000,500)
    frame:Center()
    for k, v in pairs(styles) do
        local style = vgui.Create(v,frame)
        style:SetPos(15,30+(k*50))
        style:SetSize(300,40)
    end
end)