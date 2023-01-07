--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- CLIENT
local Alpha = 0
local AlphaInfluence = 0
local LocalPlayer = LocalPlayer
local ScrW, ScrH = ScrW, ScrH
local draw_RoundedBox = draw.RoundedBox
local draw_SimpleText = draw.SimpleText
hook.Add("PostRenderVGUI", "BlackoutMenu", function()
    Alpha = Lerp(FrameTime()*8, Alpha, AlphaInfluence)
    if not (Alpha == 0) then
        draw_RoundedBox(0,0,0,ScrW(),ScrH(),Color(0,0,0,math.ceil(Alpha)))
    end
end)
net.Receive("BlackoutMenuOpacity", function()
    AlphaInfluence = net.ReadInt(16)
end)

stalls = stalls or {}
local stalls = stalls
stalls["rp_southside"] = {
    [1] = {
        trigger = Vector(-1730, 6227, 77),
    },
    [2] = {
        trigger = Vector(-1735,6661,13),
    },
}

stalls["rp_rockford_v2b"] = {
    [1] = {
        trigger = Vector(-7609,-1749,8),
    },
    [2] = {
        trigger = Vector(-8357,-1741,8),
    },
}

net.Receive("VehicleServiceInUse", function() stalls[game.GetMap()][net.ReadInt(4)].InUse = net.ReadBool() end)

local col = Color(22,22,22)
local col_white = Color(255,255,255)
local col_yellow = Color(164, 137, 56)
local col_black = Color(0,0,0)
local notif = Material("paris/notif.png")

local Alpha = 0
local AlphaInf = 0
local stalltocheck = stalls[game.GetMap()]
hook.Add("HUDPaint", "DoYouWantToEnter?", function()
    AlphaInf = 0
    for stallnum, stall in pairs(stalltocheck or {}) do
        if stall and not stall.InUse then
            for _, ent in pairs(ents.FindInSphere(stall.trigger,50)) do
                if ent:IsVehicle() and IsValid(ent:GetDriver()) and ent:GetDriver() == LocalPlayer() then
                    if input.IsKeyDown(KEY_ENTER) then
                        net.Start("ServiceVehicleEnterShop") net.WriteInt(stallnum,4) net.SendToServer()
                    end
                    AlphaInf = 255
                end
            end
        end
    end
    local w,h = ScrW(), ScrH()
    Alpha = Lerp(FrameTime()*5,Alpha,AlphaInf)
    surface.SetDrawColor(255,255,255,Alpha)
    surface.SetMaterial(notif)
    surface.DrawTexturedRectRotated(w/2,h*0.2,1642,459,0)
    col_yellow.a = Alpha
    col_black.a = Alpha
    draw.SimpleTextOutlined("Press ENTER to enter repair shop","CaptionIntro",w/2,h*0.2,col_yellow,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,2,col_black)
end)

surface.CreateFont("VehicleServiceFont", {
    font = "Roboto Medium",
    size = 25,
    weight = 300,
    antialias = true
})


local Frame
local GatewayLogo = Material("paris/gatewaytire.png")
local Buttons = {}
local Mixer
local colbg = Color(1,1,1,255)
local col = Color(22,22,22,100)
local bg = Color(53,53,53)
local theme = Color(201, 182, 112)
local function MakeButton(text,func,price,x,y)
    for k, v in pairs(Buttons) do
        if v.text == text then
            v.DoClick = func
            return
        end
    end
    local b = vgui.Create("DButton", Frame)
    table.insert(Buttons,b)
    b:SetText("")
    b.text = text
    b:SetSize(Frame:GetWide(),40)
    b:SetPos(x or 0,y or (133+(#Buttons-1)*(b:GetTall()+1)))
    function b:Paint(w,h)
        if self:IsHovered() then
            draw_RoundedBox(0,0,0,w,h,theme)
            draw_RoundedBox(0,0,0,w,h,Color(255, 255, 255,math.abs(120*math.sin(CurTime()*4))))
            draw_RoundedBox(0,4,4,w-8,h-8,col)
            draw_RoundedBox(0,0,0,w,h,Color(0,0,0,self.lalpha))
            draw.SimpleText(text or "", "VehicleServiceFont", 15, h/2, colbg, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(price or "", "VehicleServiceFont", w-15, h/2, colbg, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        else
            draw_RoundedBox(0,0,0,w,h,col)
            draw_RoundedBox(0,0,0,w,h,Color(0,0,0,self.lalpha))
            draw.SimpleText(text or "", "VehicleServiceFont", 15, h/2, theme, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(price or "", "VehicleServiceFont", w-15, h/2, theme, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end
        if self:IsHovered() then
            self.lalpha = Lerp(FrameTime()*6, self.lalpha or 100, 100)
        else
            self.lalpha = Lerp(FrameTime()*6, self.lalpha or 100, 0)
        end
    end
    b.DoClick = func
end

local lerpy = 0
local lerpyinf = 0
game.AddParticles( "particles/train_steam.pcf" )
PrecacheParticleSystem( "steam_train" )
local bg = Color(22,22,22,200)
local function MainFrame()
    Frame = vgui.Create("DFrame")
    Frame:SetSize(500,700)
    Frame:SetPos(100,100)
    Frame:SetTitle("Vehicle Service Menu")
    Frame:MakePopup()
    function Frame:Paint(w,h)
        local x, y = self:LocalToScreen( 0, 0 )

        local Fraction = 2.2
    
        local matBlurScreen = Material( "pp/blurscreen" )
        surface.SetMaterial( matBlurScreen )
        surface.SetDrawColor( 255, 255, 255, 255 )
    
        for i=0.33, 1, 0.33 do
          matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
          matBlurScreen:Recompute()
          if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
          surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
        end
        draw_RoundedBox(0, 0, 0, ScrW(), ScrH(), bg)
    end
    function Frame:PaintOver(w,h)
        surface.SetMaterial(GatewayLogo)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(0,0,w,133)
    end
    function Frame:Think()
        local x, y = self:LocalCursorPos()
        local x2, y2 = self:GetSize()
        if input.IsMouseDown(MOUSE_LEFT) and not (x<x2 and y<y2 and x>0 and y>0)  then
            self:SetMouseInputEnabled( false )
        else
            self:SetMouseInputEnabled( true )
        end
    end
    function Frame:OnClose()
        net.Start("ServiceVehicleLeaveShop") net.SendToServer()
        //hook.Remove("CalcView", "VC_Ruleofthird")
        lerpyinf = 0
    end
    return Frame
end

net.Receive("VehicleServiceStartMenu", function()
    lerpyinf = 1
    hook.Add("CalcView", "VC_Ruleofthird", function(ply, pos, ang, fov)  
        if not VCMod1 then return end
        if !VC.getSetting("Enabled") then return end  
        local ent, View = ply:GetVehicle(), nil   
        local drawChairs = true   
        lerpy = Lerp(FrameTime()*4, lerpy, lerpyinf)
        if IsValid(ent) then  
            if VC.LastCar != ent and ent.SetThirdPersonMode then 
                ent:SetThirdPersonMode(VC.IsInThirdPerson) 
            end  VC.LastCar = ent  
            VC.IsInThirdPerson = ent.GetThirdPersonMode and ent:GetThirdPersonMode()   
            local Veh = VC.getMainVehicle(ent)  
            if (drawChairs or ent.VC_IsNotPrisonerPod or ent.VC_ExtraSeat) then   
                local IsNotPod = VC.isVCModCompatible(ent) 
                local VSC = IsNotPod or 
                Veh:GetNWBool("VC_HasWeapon", false)  
                if VC.HandleView then  
                    local View = VC.HandleView(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov)  
                    if View then
                        View.origin = View.origin - ((ang:Right()*60)*lerpy)
                    end
                    if View and table.Count(View) > 0 then  
                        VC.DM_Menu_EyePos = View.origin  
                        return View  
                    end  
                end  
            end  
        else  
            VC.velAvgData = nil  
        end 
    end)
    local status = net.ReadString()
    if status == "Repair" then
        Buttons = {}
        Frame = MainFrame()
        local function RedoButtons()
            for k, v in pairs(Buttons) do v:Remove() end
            Buttons = {}
            local repaircost = math.Round(100+(#LocalPlayer():GetVehicle():VC_getDamagedParts()*30)+((100-LocalPlayer():GetVehicle():VC_getHealth())*3))
            if repaircost > 100 then 
                MakeButton("Repair Vehicle",function()
                    if LocalPlayer():GetCash() < repaircost then return surface.PlaySound("vo/npc/male01/sorry0"..math.random(1,3)..".wav") end
                    surface.PlaySound("paris/mechanic.mp3")
                    net.Start("ServiceVehicleRepairVehicle") net.SendToServer()
                end, "$"..string.Comma(repaircost))
            else
                local v = GAMEMODE.Vehicles[ LocalPlayer():GetVehicle():GetGNWVar( "vehicleTable" ).ID ]
                local t, price = "Add Underglow", "$" .. string.Comma(COST_FOR_UNDERGLOW)
                if v then
                    if istable(v["UnderGlow"]) and v["UnderGlow"].r then
                        t = "Remove Underglow"
                        price = ""
                    end
                    if not LocalPlayer():IsVIP() then price = "VIP" end
                    MakeButton(t,function()
                        if LocalPlayer():GetCash() < COST_FOR_UNDERGLOW then return surface.PlaySound("vo/npc/male01/sorry0"..math.random(1,3)..".wav") end
                        surface.PlaySound("paris/mechanic.mp3")
                        net.Start("perp_v_uga") net.SendToServer()
                    end, price)
                    t, price = "Add Hydraulics","$" .. string.Comma(COST_FOR_HYDRAULICS)
                    if v["Hydraulics"] == 1 then
                        t = "Remove Hydraulics"
                        price = ""
                    end
                    if not LocalPlayer():IsVIP() then price = "VIP" end
                    MakeButton(t,function()
                        if LocalPlayer():GetCash() < COST_FOR_HYDRAULICS then return surface.PlaySound("vo/npc/male01/sorry0"..math.random(1,3)..".wav") end
                        surface.PlaySound("paris/mechanic.mp3")
                        net.Start("perp_v_j") net.SendToServer()
                    end, price)
                    t, price = "Add Anti-Theft", "$" .. string.Comma(COST_FOR_ANTITHEFT)
                    if v["AntiTheft"] == 1 then
                        t = "Remove Anti-Theft"
                        price = ""
                    end
                    if not LocalPlayer():IsVIP() then price = "VIP" end
                    MakeButton(t,function()
                        if LocalPlayer():GetCash() < COST_FOR_ANTITHEFT then return surface.PlaySound("vo/npc/male01/sorry0"..math.random(1,3)..".wav") end
                        surface.PlaySound("paris/mechanic.mp3")
                        net.Start("perp_v_ata") net.SendToServer()
                    end, price)
                    t, price = "Add Turbo","$" .. string.Comma(COST_FOR_TURBO)
                    if v["Turbo"] == 1 then
                        t = "Remove Turbo"
                        price = ""
                    end
                    if not LocalPlayer():IsVIP() then price = "VIP" end
                    MakeButton(t,function()
                        if LocalPlayer():GetCash() < COST_FOR_TURBO then return surface.PlaySound("vo/npc/male01/sorry0"..math.random(1,3)..".wav") end
                        surface.PlaySound("paris/mechanic.mp3")
                        net.Start("perp_v_t") net.SendToServer()
                    end, price)
                    MakeButton("Upgrade Engine",function()
                        for k, v in pairs(Buttons) do v:Remove() end
                        Buttons = {}
                        for i=5,1,-1 do
                            local num = (i*-1)+5 -- make backwards
                            local Price = "$" .. string.Comma(5000*num)
                            if v["Engine"] == num then
                                Price = "(Owned)"
                            end
                            local text = "EMS Upgrade, Level " .. num
                            if num == 0 then
                                text = "STOCK ENGINE"
                            end
                            MakeButton(text,function()
                                if LocalPlayer():GetCash() < 5000*num then return surface.PlaySound("vo/npc/male01/sorry0"..math.random(1,3)..".wav") end
                                surface.PlaySound("paris/mechanic.mp3")
                                net.Start("ServiceVehicleChangeEngineUpgrade") net.WriteInt(num,8) net.SendToServer()
                            end, Price)
                        end
                        MakeButton("Back",function()
                            RedoButtons()
                        end)
                    end)
                end
            end
            MakeButton("Leave",function()
                Frame:Remove()
                net.Start("ServiceVehicleLeaveShop") net.SendToServer()
                lerpyinf = 0
            end)
        end
        RedoButtons()
        net.Receive("ServiceVehicleDoneRequest", function() RedoButtons() end)
    elseif status == "Paint" then
        Buttons = {}
        Frame = MainFrame()
        local function RedoButtons(Screen, Donefunc)
            for k, v in pairs(Buttons) do v:Remove() end
            Buttons = {}
            if IsValid(Mixer) then Mixer:Remove() end
            if Screen == "Main" then
                local v = GAMEMODE.Vehicles[ LocalPlayer():GetVehicle():GetGNWVar( "vehicleTable" ).ID ]
                MakeButton("Change Paint Color",function()
                    RedoButtons("Mixer", function(col)
                        surface.PlaySound("spray.mp3")
                        local v = LocalPlayer():GetVehicle()
                        local ps = CreateParticleSystem( v, "steam_train", 0, 0 )
                        ps:SetControlPointForwardVector(0, v:GetRight())
                        local ps = CreateParticleSystem( v, "steam_train", 0, 0, v:GetForward()*100)
                        ps:SetControlPointForwardVector(0, v:GetRight())
                        local ps = CreateParticleSystem( v, "steam_train", 0, 0, v:GetForward()*-100)
                        ps:SetControlPointForwardVector(0, v:GetRight())
                        net.Start("ServiceVehicleTryColor") net.WriteColor(col) net.SendToServer()
                    end)
                end)
                MakeButton("Change Headlight Color",function()
                    RedoButtons("Mixer", function(col)
                        surface.PlaySound("paris/mechanic.mp3")
                        net.Start("ServiceVehicleTryHLColor") net.WriteColor(col) net.SendToServer()
                    end)
                end)
                if v then
                    if istable(v["UnderGlow"]) and v["UnderGlow"].r then
                        MakeButton("Change Underglow Color",function()
                            RedoButtons("Mixer", function(col)
                                surface.PlaySound("paris/mechanic.mp3")
                                net.Start("ServiceVehicleTryUGColor") net.WriteColor(col) net.SendToServer()
                            end)
                        end)
                    end
                end
                MakeButton("Change License Plate",function()
                    GAMEMODE:ChangeLicensePlate()
                end)
                MakeButton("Leave",function()
                    Frame:Remove()
                    net.Start("ServiceVehicleLeaveShop") net.SendToServer()
                    lerpyinf = 0
                end)
            elseif Screen == "Mixer" then
                Mixer = vgui.Create("DColorMixer", Frame)
                Mixer:SetSize(Frame:GetWide()-20, 200)
                Mixer:SetPos(10, 145)
                Mixer:SetColor(LocalPlayer():GetVehicle():GetColor())
                Mixer:SetPalette(false)
                Mixer:SetAlphaBar(false)
                Mixer:SetWangs(false)
                MakeButton("Try Color", function() Donefunc(Color(Mixer:GetColor().r,Mixer:GetColor().g,Mixer:GetColor().b)) end, "", 0, 380)
                MakeButton("Back",function()
                    RedoButtons("Main")
                end, "", 0, 420)
            end
        end
        RedoButtons("Main")
        net.Receive("ServiceVehicleDoneRequest", function()
            local Keep = net.ReadString()
            local cost = net.ReadInt(16)
            MakeButton("Keep Color",function()
                if LocalPlayer():GetCash() < cost then return surface.PlaySound("vo/npc/male01/sorry0"..math.random(1,3)..".wav") end
                net.Start(Keep) net.SendToServer()
                RedoButtons("Main")
            end, "$" .. cost, 0, 460)
        end)
    else
        if IsValid(Frame) then Frame:Remove() end
    end
end)

surface.CreateFont( "perp_license_plates_editor", {
	font = "Roboto Bold",
	size = 124,
	weight = 1000,
	--antialias = true,
	shadow = true,
})


function GM:ChangeLicensePlate()
    local F = vgui.Create("DFrame")
    F:SetSize(600,400)
    F:SetTitle("Change License Plate")
    F:Center()
    F:MakePopup()
    local c = Color(22,22,22,255)
    local plate = table.Copy(LocalPlayer():GetVehicle():GetGNWVar("License_Plate"))
    local sizex, sizey = 1280*0.4, 646*0.4
    local Plates = {
        Material( "paris/plates/newyork1.png" ),
        Material( "paris/plates/newyork2.png" ),
        Material( "paris/plates/newyork3.png" ),
        Material( "paris/plates/newyork4.png" ),
    }
    local PlatesColors = {
        Color(3, 41, 89),
        Color(3, 41, 89),
        Color(3, 41, 89),
        Color(232, 178, 88),
    }    
    function F:Paint(w,h)
        draw.RoundedBox(0,0,0,w,h,c)
        surface.SetMaterial( Plates[plate.Plate] )
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect((w/2)-(sizex/2),50,sizex,sizey)
        draw.SimpleText(plate.Text,"perp_license_plates_editor",w/2,50+(sizey/2),PlatesColors[plate.Plate],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    local T = vgui.Create("paris_TextEntry", F)
    T:SetSize(300,40)
    T:SetPos( 600-450, 400-50 )
    T:SetValue( "" )
    T:SetPlaceholderText( "Type License Plate" )
    T:RequestFocus()
    T:SetUpdateOnType(true)
    function T:AllowInput(stringValue)
        if #T:GetValue() >= 7 then print("over 7") return true end
    end
    local confirmstatus = "Loading"
    local confirm
    function T:OnChange()
        plate.Text = string.upper(T:GetValue())
        local c = T:GetCaretPos()
        T:SetText(plate.Text)
        T:SetCaretPos(c)
        timer.Create("DoCheckLicensePlate",1,1,function()
            net.Start("ServiceVehicleTryLicensePlate")
            net.WriteTable(plate)
            net.SendToServer()
        end)
        confirmstatus = "Loading"
        confirm:SetTooltip("Checking if this plate is available...")
    end
    function T:OnEnter(value)
        Derma_Query( "Custom License Plate: $7,500 are you sure you want to pay?", "License Plate: " .. plate.Text,
        "No...", function() end,
        "Yes", function() net.Start("ServiceVehicleKeepLicensePlate") net.WriteTable(plate) net.SendToServer() F:Remove() end )
    end
    local L = vgui.Create("DLabel", F)
    L:SetSize(200,20)
    L:SetPos(600-450,400-70)
    L:SetText("Press ENTER to APPLY!")
    confirm = vgui.Create("DButton", F)
    confirm:SetSize(32,32)
    confirm:SetPos(450+10,400-45)
    confirm:SetText("")
    confirm:SetTooltip("Checking if this plate is available...")
    local Mats = {}
    Mats["Loading"] = Material("paris/loading.png")
    Mats[true] = Material("paris/good.png")
    Mats[false] = Material("paris/error.png")
    local rot = 0
    function confirm:Paint(w,h)
        if confirmstatus == "Loading" then rot = CurTime()*-500 else rot = 0 end
        surface.SetDrawColor(255,255,255,255)
        surface.SetMaterial(Mats[confirmstatus])
        surface.DrawTexturedRectRotated(16,16,w,h,rot)
    end
    net.Receive("ServiceVehicleTryLicensePlate", function()
        confirmstatus = not net.ReadBool()
        if confirmstatus then
            confirm:SetTooltip("This plate is available!")
        else
            confirm:SetTooltip("This plate is not available!")
        end
    end)
    local LeftArrow = vgui.Create("asoc_Button",F)
    LeftArrow:SetPos(5,150)
    LeftArrow:SetSize(30,30)
    LeftArrow:SetText("")
    LeftArrow.Text = ("<")
    function LeftArrow:DoClick()
        plate.Plate = plate.Plate - 1
        if plate.Plate < 1 then
            plate.Plate = 4
        end
    end
    local RightArrow = vgui.Create("asoc_Button",F)
    RightArrow:SetPos(F:GetWide()-35,150)
    RightArrow:SetSize(30,30)
    RightArrow:SetText("")
    RightArrow.Text = (">")
    function RightArrow:DoClick()
        plate.Plate = plate.Plate + 1
        if plate.Plate > 4 then
            plate.Plate = 1
        end
    end
end