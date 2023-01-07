--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //surface.set
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

surface.CreateFont( "DesktopText", { font = "Roboto Medium", size = 18, weight = 850, antialias = true, additive = false } )
surface.CreateFont( "DesktopIconText", { font = "Roboto Medium", size = 15, weight = 650, antialias = true, additive = false } )
local bg = Material("paris/desktopwallpaper.jpg")
local os_icon = Material("paris/desktop_icon.png")
local topbar = Color(0,0,0,180)
local DesktopIcons = {}
DesktopIcons[1] = {}
DesktopIcons[1].Name = "My Computer"
DesktopIcons[1].Material = Material("paris/laptop_icon2.png")
DesktopIcons[2] = {}
DesktopIcons[2].Name = "Recycling Bin"
DesktopIcons[2].Material = Material("paris/trashbin.png")
DesktopIcons[3] = {}
DesktopIcons[3].Name = "PERPLE"
DesktopIcons[3].Material = Material("paris/perple_icon128_s2.png")
DesktopIcons[4] = {}
DesktopIcons[4].Name = "Pong"
DesktopIcons[4].Material = Material("paris/laptop_icon2.png")
DesktopIcons[4].Click = function(panel) RunConsoleCommand("pong") end

local Screens = {}
Screens["Desktop"] = {}
Screens["Desktop"][1] = {}
Screens["Desktop"][1].Name = "DesktopBackground"
Screens["Desktop"][1].Class = "DPanel"
Screens["Desktop"][1].PosX = 0
Screens["Desktop"][1].PosY = 0
Screens["Desktop"][1].SizeX = 1
Screens["Desktop"][1].SizeY = 1
Screens["Desktop"][1].Paint = function(panel,w,h)
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(bg)
    surface.DrawTexturedRect(0,0,w,h)
    draw.RoundedBox(0,0,0,w,40,topbar)
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(os_icon)
    surface.DrawTexturedRect(0,0,40,40)
    draw.SimpleText(os.date("%I:%M:%S %p",os.time()),"DesktopText",50,20,color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
end
for k, v in pairs(DesktopIcons) do
    local NewIcon = v
    NewIcon.Class = "DButton"
    NewIcon.Material = v.Material
    NewIcon.Text = ""
    NewIcon.Name = v.Name
    NewIcon.PosX = 50
    NewIcon.PosY = 150*k
    NewIcon.PSizeX = 128
    NewIcon.PSizeY = 128
    NewIcon.Paint = function(panel,w,h)
        if panel.Selected then
            surface.SetDrawColor(255,255,255,20)
            draw.NoTexture()
            surface.DrawTexturedRect(0,0,w,h)
        end
        surface.SetDrawColor(255,255,255,255)
        surface.SetMaterial(NewIcon.Material)
        surface.DrawTexturedRect(0,0,w,h)
        DisableClipping(true)
        draw.SimpleText(NewIcon.Name,"DesktopIconText",w/2,h+5,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
        DisableClipping(false)
    end
    NewIcon.DoClick = function(panel,w,h)
        panel.Selected = not panel.Selected
    end
    NewIcon.DoDoubleClick = v.Click or function(panel,w,h)
        panel:GetParent():LoadScreen("PERPLE")
    end
    table.insert(Screens["Desktop"],NewIcon)
end
local bg = Material("paris/perple_wallpaper.png")
local logo = Material("paris/perple_icon.png")
local Panel = {}
Screens["PERPLE"] = {}
Screens["PERPLE"][1] = Panel
Panel.Name = "PerpleBackground"
Panel.Class = "DPanel"
Panel.PosX = 0
Panel.PosY = 0
Panel.SizeX = 1
Panel.SizeY = 1
Panel.Paint = function(panel,w,h)
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(bg)
    surface.DrawTexturedRect(0,0,w,h)
end
local Panel = {}
Screens["PERPLE"][2] = Panel
Panel.Name = "Loading"
Panel.Class = "DPanel"
Panel.SPosX = 0.25
Panel.SPosY = 0.25
Panel.SizeX = 0.5
Panel.SizeY = 0.5
Panel.AlphaTo = 0.5
Panel.Paint = function(panel,w,h)
    panel.load = panel.load or 0
    panel.load = panel.load + 0.35*FrameTime()
    if panel.load > 0.8 then
        panel:AlphaTo(0,0.2)
    end
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(logo)
    surface.DrawTexturedRect(w*0.25,0,w/2,w/2)
    surface.SetDrawColor(37,0,98,255)
    draw.NoTexture()
    surface.DrawTexturedRect(0,h-30,w,34)
    surface.SetDrawColor(96,0,255,255)
    surface.DrawTexturedRect(2,h-28,(w-4)*panel.load,26)
    if panel.load >= 0.98 then
        panel:Remove()
        panel:GetParent():LoadScreen("PERPLE_MAIN")
    end
end
surface.CreateFont( "Perple_Large", { font = "Roboto Bold", size = 30, weight = 700, antialias = true, additive = false } )
Screens["PERPLE_MAIN"] = {}
Screens["PERPLE_MAIN"][1] = Screens["PERPLE"][1]
local Panel = {}
Screens["PERPLE_MAIN"][2] = Panel
Panel.Name = "Background"
Panel.Class = "DPanel"
Panel.PosX = 0
Panel.PosY = 0
Panel.SizeX = 1
Panel.SizeY = 1
Panel.AlphaTo = 0.5
Panel.Paint = function(panel,w,h)
    panel.load = panel.load or 0
    panel.load = Lerp(FrameTime()*2,panel.load,1)
    surface.SetDrawColor(255,255,255,255)
    draw.NoTexture()
    surface.DrawTexturedRect(w*0.1,h*0.1,w*0.8,(h*0.8*panel.load))
    surface.SetDrawColor(37,0,98,255)
    surface.DrawTexturedRect(w*0.1,h*0.1,w*0.8,60)
    draw.SimpleText("PERPLE Dashboard","Perple_Large",(w*0.1)+10,(h*0.1)+30,color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
end
local Button = {}
Screens["PERPLE_MAIN"][3] = Button
Button.Name = "View Businesses"
Button.Class = "DButton"
Button.Text = ""
Button.SPosX = 0.375
Button.SPosY = 0.4
Button.SizeX = 0.25
Button.SizeY = 0.1
Button.AlphaTo = 0.5
Button.Paint = function(panel,w,h)
    draw.NoTexture()
    surface.SetDrawColor(37,0,98,255)
    surface.DrawTexturedRect(0,0,w,h)
    draw.SimpleText("View Businesses","Perple_Large",w*0.5,h*0.5,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end
Button.DoClick = function(panel)
    panel:Remove()
    panel:GetParent():LoadScreen("PERPLE_MAIN")
end
local Button = {}
Screens["PERPLE_MAIN"][4] = Button
Button.Name = "Buy Businesses"
Button.Class = "DButton"
Button.Text = ""
Button.SPosX = 0.375
Button.SPosY = 0.55
Button.SizeX = 0.25
Button.SizeY = 0.1
Button.AlphaTo = 0.5
Button.Paint = function(panel,w,h)
    draw.NoTexture()
    surface.SetDrawColor(37,0,98,255)
    surface.DrawTexturedRect(0,0,w,h)
    draw.SimpleText("Buy Businesses","Perple_Large",w*0.5,h*0.5,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end
Button.DoClick = function(panel)
    panel:Remove()
    panel:GetParent():LoadScreen("PERPLE_BUYBUSINESSES")
end

local BackButton = {}
BackButton.Name = "Back"
BackButton.Class = "DButton"
BackButton.Text = ""
BackButton.SPosX = 0.85
BackButton.SPosY = 0.1
BackButton.SizeX = 0.05
BackButton.SizeY = 0.06
BackButton.AlphaTo = 0.5
BackButton.Paint = function(panel,w,h)
    draw.NoTexture()
    if panel:IsHovered() then
        surface.SetDrawColor(96,0,255,255)
        surface.DrawTexturedRect(0,0,w,h)
    else
        surface.SetDrawColor(37,0,98,255)
        surface.DrawTexturedRect(0,0,w,h)
    end
    draw.SimpleText("Back","Perple_Large",w*0.5,h*0.5,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end
BackButton.DoClick = function(panel)
    panel:Remove()
    panel:GetParent():LoadScreen(panel:GetParent().LastScreen)
end


Screens["PERPLE_BUYBUSINESSES"] = {}
Screens["PERPLE_BUYBUSINESSES"][1] = Screens["PERPLE"][1]
local Panel = {}
Screens["PERPLE_BUYBUSINESSES"][2] = Panel
Panel.Name = "Background"
Panel.Class = "DPanel"
Panel.PosX = 0
Panel.PosY = 0
Panel.SizeX = 1
Panel.SizeY = 1
Panel.AlphaTo = 0.5
Panel.Paint = function(panel,w,h)
    panel.load = 1
    surface.SetDrawColor(255,255,255,255)
    draw.NoTexture()
    surface.DrawTexturedRect(w*0.1,h*0.1,w*0.8,(h*0.8*panel.load))
    surface.SetDrawColor(37,0,98,255)
    surface.DrawTexturedRect(w*0.1,h*0.1,w*0.8,60)
    draw.SimpleText("PERPLE Businesses","Perple_Large",(w*0.1)+10,(h*0.1)+30,color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
end
local ScrollP = {}
Screens["PERPLE_BUYBUSINESSES"][3] = ScrollP
ScrollP.Name = "ScrollPanel"
ScrollP.Class = "DScrollPanel"
ScrollP.SPosX = 0.1
ScrollP.SPosY = 0.2
ScrollP.SizeX = 0.8
ScrollP.SizeY = 0.7
ScrollP.AlphaTo = 0.5
Screens["PERPLE_BUYBUSINESSES"][4] = BackButton

local buffer = 0.01
local i = 0
local row = -1
for k, v in pairs(GAMEMODE.Businesses) do
    i = i + 1
    if (i-1) % 3 == 0 then
        row = row + 1
    end
    local column = ((i-1)%3)
    local wide = (0.8/3)-(buffer*2)
    local Button = {}
    local Mat = v.Icon
    table.insert(Screens["PERPLE_BUYBUSINESSES"],Button)
    Button.Parent = "ScrollPanel"
    Button.Name = v.Name
    Button.Class = "DButton"
    Button.Text = ""
    Button.SPosX = buffer+(column*buffer)+(column*wide)
    Button.SPosY = buffer+(row*buffer)+(row*wide*2)
    Button.SizeX = wide
    Button.SizeY = wide*2
    Button.AlphaTo = 0.5
    Button.Paint = function(panel,w,h)
        surface.SetMaterial(Mat)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(w*0.1,w*0.1,w*0.8,w*0.8)
        draw.SimpleText("$"..string.Comma(v.Cost),"Perple_Large",w*0.5,h*0.01,color_black,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
        draw.SimpleText(v.Name,"Perple_Large",w*0.5,h*0.9,color_black,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)
    end
    Button.DoClick = function(panel)
        panel:Remove()
        panel:GetParent():GetParent():GetParent():LoadScreen("PERPLE_BUSINESSESINFO_"..v.Name)
    end
    Screens["PERPLE_BUSINESSESINFO_"..v.Name] = {}
    Screens["PERPLE_BUSINESSESINFO_"..v.Name][1] = Screens["PERPLE"][1]
    local Panel = {}
    Screens["PERPLE_BUSINESSESINFO_"..v.Name][2] = Panel
    Screens["PERPLE_BUSINESSESINFO_"..v.Name][3] = BackButton
    Panel.Name = "BusinessInfoBackground"
    Panel.Class = "DPanel"
    Panel.PosX = 0
    Panel.PosY = 0
    Panel.SizeX = 1
    Panel.SizeY = 1
    Panel.AlphaTo = 0.5
    Panel.Paint = function(panel,w,h)
        panel.load = panel.load or 0
        panel.load = Lerp(FrameTime()*2,panel.load,1)
        surface.SetDrawColor(255,255,255,255)
        draw.NoTexture()
        surface.DrawTexturedRect(w*0.1,h*0.1,w*0.8,(h*0.8*panel.load))
        surface.SetDrawColor(37,0,98,255)
        surface.DrawTexturedRect(w*0.1,h*0.1,w*0.8,60)
        draw.SimpleText(v.Name,"Perple_Large",(w*0.1)+10,(h*0.1)+30,color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        surface.SetMaterial(Mat)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(w*0.15,w*0.15,w*0.3,w*0.3)
        draw.SimpleText("$"..string.Comma(v.Cost),"Perple_Large",w*0.5,h*0.3,color_black,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        draw.SimpleText(v.Description,"Perple_Large",w*0.5,h*0.38,color_black,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        draw.SimpleText(v.Description2,"Perple_Large",w*0.5,h*0.43,color_black,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        draw.SimpleText("Capacity: " .. v.Storage,"Perple_Large",w*0.5,h*0.52,color_black,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
    end
end

local PANEL = {}

function PANEL:LoadScreen(Screen)

    self.LastScreen = self.CurScreen
    self.CurScreen = Screen

    -- clear old screen
    for k, v in pairs(self.Screen) do
        v:Remove()
    end

    -- make new screen
    local w,h = self:GetSize()
    for k, v in pairs(Screens[Screen]) do
        if v.Parent then
            self.Screen[v.Name] = vgui.Create(v.Class,self.Screen[v.Parent])
        else
            self.Screen[v.Name] = vgui.Create(v.Class,self)
        end
        local p = self.Screen[v.Name]
        timer.Simple(0, function()
            if v.Class == "DButton" then p:SetText(v.Text or "") end
        end)
        if v.PosX then
            p:SetPos(v.PosX,v.PosY)
        elseif v.SPosX then
            p:SetPos(v.SPosX*w,v.SPosY*h)
        end
        if v.SizeX then
            p:SetSize(v.SizeX*w,v.SizeY*h)
        elseif v.PSizeX then
            p:SetSize(v.PSizeX,v.PSizeY)
        end
        if v.AlphaTo then
            p:SetAlpha(v.AlphaToStartAlpha or 0)
            p:AlphaTo(v.AlphaToAlpha or 255,v.AlphaTo,v.AlphaToDelay or 0, v.AlphaToCallback)
        end
        p.DoClick = v.DoClick or function() end
        p.DoDoubleClick = v.DoDoubleClick or function() end
        p.Paint = v.Paint or function() end
    end
end

function PANEL:Init()
    self:SetSize(ScrW(),ScrH())
    self:Center()
    self:MakePopup()
    self:SetTitle("")
    self.Screen = {}
    self:LoadScreen("Desktop")
end

function PANEL:Think()
    if not IsValid(self.Entity) then self:Remove() end
    if input.IsKeyDown(KEY_ESCAPE) then self:Remove() return end
end

vgui.Register("perp_laptop", PANEL, "DFrame")

net.Receive("perp_open_laptop", function()
    if IsValid(perp_laptop) then return end
    local panel = vgui.Create("perp_laptop")
    perp_laptop = panel
    panel.Entity = net.ReadEntity()
end)