--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


concommand.Add("addvect", function()
    local pos = LocalPlayer():GetPos()
    local ang = LocalPlayer():GetAngles()
    --print("{ Vector( " .. math.Round(pos.x) .. ", " .. math.Round(pos.y) .. ", " .. math.Round(pos.z) .. " ), Angle( " .. math.Round(ang.p) .. ", " .. math.Round(ang.y) .. ", " .. math.Round(ang.r) .. " )},")
    print("{ Vector( " .. math.Round(pos.x) .. ", " .. math.Round(pos.y) .. ", " .. math.Round(pos.z) .. " ), Angle( 0, " .. math.Round(ang.y) .. ", 0 ) },")
end)

local function FormatTime(time)
    local formattedTime = "0 Seconds"
    local timePlayed = math.Round(time)

    local r, years, months, weeks, days, hours, minutes, seconds
    r = timePlayed % 31536000
    years = (timePlayed - r) / 31536000
    r = timePlayed % 2628000
    months = (timePlayed - r) / 2628000
    r = timePlayed % 604800
    weeks = (timePlayed - r) / 604800
    r = timePlayed % 86400
    days = (timePlayed - r) / 86400
    r = timePlayed % 3600
    hours = (timePlayed - r) / 3600
    r = timePlayed % 60
    minutes = (timePlayed - r) / 60
    seconds = r

   if years > 0 then
        formattedTime = years .. " Year" .. ( years ~= 1 and "s" or "" )
    elseif months > 0 then
        formattedTime = months .. "  Month" .. ( months ~= 1 and "s" or "" )
    elseif weeks > 0 then
        formattedTime = weeks .. " Week" .. ( weeks ~= 1 and "s" or "" )
    elseif days > 0 then
        formattedTime = days .. " Day" .. ( days ~= 1 and "s" or "" )
    elseif hours > 0 then
        formattedTime = hours .. " Hour" .. ( hours ~= 1 and "s" or "" )
    elseif minutes > 0 then
        formattedTime = minutes .. " Minute" .. ( minutes ~= 1 and "s" or "" )
    else
        formattedTime = seconds .. " Second" .. ( seconds ~= 1 and "s" or "" )
    end

    return formattedTime

end

local Background = Material("paris/xmas/background.png")
local Circle = Material("paris/xmas/wheel.png")
local Pointer = Material("paris/xmas/pointer.png")

surface.CreateFont( "XmasSantaFont", {
    font = "Roboto Thin",
    antialias = true,
	extended = false,
	size = 20,
})

surface.CreateFont( "XmasSantaFontLarge", {
    font = "Roboto Bold",
    antialias = true,
    extended = false,
    weight = 1500,
	size = 36,
})

GradientUp = Material( "gui/gradient_up" )
GradientDown = Material( "gui/gradient_down" )

local function SantaScript()

    local GradientUp = Material( "gui/gradient_up" )

    local Panel = vgui.Create("paris_Frame")
    Panel:SetSize(700,500)
    Panel:Center()
    Panel:MakePopup()
    Panel:SetTitle("Santa's Gifts")

    if LocalPlayer():GetNWInt("SantaSpin") and LocalPlayer():GetNWInt("SantaSpin") > GetServerTime() then

        local snow = {}
        
        function Panel:Paint(w,h)

            draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,255))

            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Background)
            surface.DrawTexturedRect(0, 0, w, h)

            draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,70))

            surface.SetDrawColor(math.abs(math.sin(CurTime()*4)) * 100, 0, 0, 150)
            surface.SetMaterial(GradientUp)
            surface.DrawTexturedRect(0, 0, w, h)

            table.insert(snow, {x=math.random(-300, w), y=0})
            for k, v in pairs(snow) do
                v.x = v.x + (30*FrameTime())
                v.y = v.y + (60*FrameTime())
                if v.x > w or v.y > h then
                    snow[k] = nil
                    continue
                end
                draw.RoundedBox(4, v.x-2, v.y-2, 4, 4, Color(255,255,255,255))
            end

            draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,200))

            draw.SimpleTextOutlined("SPIN NOT AVAIALABLE", "XmasSantaFontLarge", w/2, 100, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0,0,0,255))

            local spintime = os.date("%x %X",LocalPlayer():GetNWInt("SantaSpin"))
            draw.SimpleTextOutlined("Next spin: " .. spintime .. " (Local to Server)" , "XmasSantaFont", w/2, 150, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0,0,0,255))

            draw.SimpleTextOutlined("Time Remaining: " .. FormatTime(LocalPlayer():GetNWInt("SantaSpin") - GetServerTime()), "XmasSantaFont", w/2, 170, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0,0,0,255))
            
        end

    else

        local xcenter = Panel:GetWide()/2
        local xcenterinfluence = xcenter
        local radius = 400

        local rotinftype = "slowspin"
        local rotlerp = 0
        local rotlerpinf = 0
        local winningrot
        local winningrottime = 0

        local last = 0

        local lastrot = 0

        local speed = 0
        local speedlerp = 0

        local snow = {}

        function Panel:Paint(w,h)

            draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,255))

            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Background)
            surface.DrawTexturedRect(0, 0, w, h)

            draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,70))

            table.insert(snow, {x=math.random(-300, w), y=0})
            for k, v in pairs(snow) do
                v.x = v.x + (30*FrameTime())
                v.y = v.y + (60*FrameTime())
                if v.x > w or v.y > h then
                    snow[k] = nil
                    continue
                end
                draw.RoundedBox(4, v.x-2, v.y-2, 4, 4, Color(255,255,255,255))
            end

            draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,150))


            if rotinftype == "slowspin" then
                rotlerpinf = rotlerpinf + (FrameTime()*50)
            end

            if rotinftype == "fastspin" then
                rotlerpinf = rotlerpinf + (FrameTime()*400)
            end

            rotlerp = Lerp( 0.5 * FrameTime() , rotlerp , rotlerpinf)
            xcenter = Lerp(10 * FrameTime(), xcenter, xcenterinfluence)

            local remainder = (rotlerp%(360/#XmasPrizes))
            if ((rotlerp/(360/#XmasPrizes))-remainder) - last > 10 then
                surface.PlaySound("paris/clickwheel.wav")
            end
            last = ((rotlerp/(360/#XmasPrizes))-remainder)

            speed = rotlerp - lastrot
            speedlerp = Lerp( 4 * FrameTime() , speedlerp , speed)

            local centery = h/2

            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Circle)
            surface.DrawTexturedRectRotated(xcenter, centery, radius, radius, rotlerp)

            local fad = math.abs(math.sin(CurTime()*2))

            local num=#XmasPrizes
            for i=num,1,-1 do
                local radius = radius - 10
                local equaldist = (360/num) * i
                local calcx, calcy = xcenter + (radius/2*math.cos(math.rad(rotlerp+equaldist))), centery - (radius/2*math.sin(math.rad(rotlerp+equaldist)))
                surface.SetDrawColor(200, 200, 200, (200*fad) + 5)
                surface.DrawLine(xcenter, centery, calcx, calcy)


                local radius = radius - 70
                local equaldist = ((360/num) * i) - ((360/num)/2)
                local calcx, calcy = xcenter + (radius/2*math.cos(math.rad(rotlerp+equaldist))), centery - (radius/2*math.sin(math.rad(rotlerp+equaldist)))
                surface.SetDrawColor(255,255,255,255)
                surface.SetMaterial(XmasPrizes[i].LoadedMat)
                surface.DrawTexturedRectRotated((calcx), (calcy), 32, 32, rotlerp+equaldist-90)
            end

            if winningrot and (winningrot - rotlerp) < 1 and winningrottime < CurTime() then
                net.Start("xmas_clientready")
                net.SendToServer()
                Panel:Remove()
                winningrot = nil
            end

            surface.SetDrawColor(255,255,255,255)
            surface.SetMaterial(Pointer)
            surface.DrawTexturedRectRotated(xcenter, centery-(radius/2), 10, 40,  - ((rotlerp%(360/#XmasPrizes))/(360/#XmasPrizes))*15 )

            lastrot = rotlerp

        end

        local Spin = vgui.Create("DButton",Panel)
        Spin:SetSize(70,40)
        Spin:SetPos((xcenter)-(Spin:GetWide()/2), (Panel:GetTall()/2)-(Spin:GetTall()/2))
        Spin:SetText("")
        function Spin:Paint(w,h)
            Spin:SetPos((xcenter)-(Spin:GetWide()/2), (Panel:GetTall()/2)-(Spin:GetTall()/2))
            if self:IsHovered() then
                draw.RoundedBox( 0, 0, 0, w, h, Color(22,22,22,230))
                local col = Color(200,200,200,255 * (math.abs(math.sin(CurTime()*4))))
                draw.RoundedBox( 0, 0, 0, 1, h, col)
                draw.RoundedBox( 0, w-1, 0, 1, h, col)
                draw.RoundedBox( 0, 0, 0, w, 1, col)
                draw.RoundedBox( 0, 0, h-1, w, 1, col)
                draw.RoundedBox( 0, 0, 0, w, h, Color(55,55,55,100 * (math.abs(math.sin(CurTime()*4)))))
                draw.SimpleText("SPIN", "Paris_Derma", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.RoundedBox( 0, 0, 0, w, h, Color(22,22,22,250))
                draw.SimpleText("SPIN", "Paris_Derma", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
        function Spin:DoClick()

            self:Remove()

            Panel:ShowCloseButton(false)

            net.Start("xmas_startspin")
            net.SendToServer()

            timer.Simple(8, function()
                surface.PlaySound("paris/win2.wav")
            end)

            local received = false
            timer.Simple(8, function()
                if not received then 
                    Panel:Remove()
                end
            end)
            
            net.Receive("xmas_startspin", function()

                received = true
                local winner = net.ReadInt(8)
                
                rotinftype = "fastspin"
                timer.Create("SpinCycleEnd", 4, 1, function()
                    rotinftype = ""
                    local remainder = (rotlerpinf%360)
                    local dif = rotlerpinf - rotlerp
                    rotlerp = (360/(#XmasPrizes))*(winner+0.5) - dif + 90
                    rotlerpinf = ( (360/(#XmasPrizes))*(winner+0.5) ) + 90
                    winningrot = ( (360/(#XmasPrizes))*(winner+0.5) ) + 90
                    winningrottime = CurTime() + 5
                end)

            end)
        end

        local Info = vgui.Create("DButton",Panel)
        Info:SetSize(86,Panel:GetTall()-45)
        Info:SetPos(10, 35)
        Info:SetText("")

        local sorted = {}
        for k, v in pairs(XmasPrizes) do
            if sorted[v.Name] then
                sorted[v.Name].Count = sorted[v.Name].Count + 1
            else
                sorted[v.Name] = {}
                sorted[v.Name].Count = 1
                sorted[v.Name].Icon = Material(v.Mat)
            end
        end
        
        table.SortByMember( sorted, "Count" )

        function Info:Paint(w,h)

            Info:SetSize(86 + (xcenter-(Panel:GetWide()*0.5)), Panel:GetTall()-45)
            draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,250))

            surface.SetDrawColor( 255, 120, 71, 244 )
            surface.SetMaterial( GradientRight )
            surface.DrawTexturedRect( 0, h-1, w, 1 ) 
        
            surface.SetDrawColor( 255, 120, 71, 244 )
            surface.SetMaterial( GradientRight )
            surface.DrawTexturedRect( 0, 0, w, 1 ) 
        
            surface.SetDrawColor( 255, 120, 71, 244 )
            surface.SetMaterial( GradientRight )
            surface.DrawTexturedRect( 0, 0, 1, h ) 

            local n = 0
            for k, v in pairs(sorted) do
                surface.SetDrawColor( 255, 255, 255, 255 )
                surface.SetMaterial( v.Icon )
                surface.DrawTexturedRect( 2, 2 + (n*34), 32, 32 ) 
                if xcenter > Panel:GetWide()*0.505 then
                    draw.SimpleText(v.Count .. "/" .. #XmasPrizes .. " " .. k, "XmasSantaFont", 38, 16 + (n*34), Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(v.Count .. "/" .. #XmasPrizes, "XmasSantaFont", 38, 16 + (n*34), Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end
                n = n + 1
            end

        end
        function Info:DoClick()
            if not Info.Active then
                Info.Active = true
                xcenterinfluence = Panel:GetWide()*0.7
            else
                Info.Active = false
                xcenterinfluence = Panel:GetWide()*0.5
            end
        end

    end



end

net.Receive("StartSantaScripts", function()
    SantaScript()
end)


net.Receive("OpenVIPChoosePlayerPanel", function()
    local RankLevel =   net.ReadString()
    local Length =      net.ReadInt(32)
    local Time =        net.ReadInt(32)

    local Panel = vgui.Create("paris_Frame")
    --Panel:ShowCloseButton(false)
    Panel:SetTitle("Give VIP to Another Player")
    Panel:SetSize(700,500)
    Panel:Center()
    Panel:SetSizable(true)
    Panel:ShowCloseButton(false)
    Panel:MakePopup()

    function Panel:PaintOver(w,h)

        local timestring = os.date( "Expires %H:%M:%S - %B %d, %Y" , Time )

        draw.SimpleText(RankLevel, "XmasSantaFont", w/2, 40, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText(timestring, "XmasSantaFont", w/2, 70, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

        draw.SimpleText("Insert Custom STEAMID", "XmasSantaFont", w/2, 110, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

        draw.SimpleText("Choose from Server", "XmasSantaFont", w/2, 170, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local steamid = vgui.Create("paris_TextEntry", Panel)
    steamid:SetPlaceholderText("STEAM:")
    
    local ChoosePlayer = vgui.Create("DPanel", Panel)
	ChoosePlayer.Paint = function(w,h)
		draw.RoundedBox(5, 0, 0, ChoosePlayer:GetWide(), ChoosePlayer:GetTall(), Color(66,66,66,200))
	end

	ChoosePlayer.ScrollPanel = vgui.Create("DScrollPanel", ChoosePlayer)
	ChoosePlayer.ScrollPanel.Paint = function(w,h)
		draw.RoundedBox(5, 0, 0, ChoosePlayer.ScrollPanel:GetWide(), ChoosePlayer.ScrollPanel:GetTall(), Color(66,66,66,200))
	end

	ChoosePlayer.layout = vgui.Create("DListLayout", ChoosePlayer.ScrollPanel)

	local GradientUp = Material( "gui/gradient_up" )
    local confirm

	ChoosePlayer.PlayerBlock = {}
    for k, v in pairs(player.GetAll()) do
        --if v:IsVIP() then continue end
		ChoosePlayer.PlayerBlock[k] = vgui.Create("DButton", ChoosePlayer.layout)
		ChoosePlayer.PlayerBlock[k]:SetText("")
		ChoosePlayer.PlayerBlock[k].Paint = function()
			if ChoosePlayer.PlayerBlock[k]:IsHovered() then
				draw.RoundedBox(0, 0, 0, ChoosePlayer.PlayerBlock[k]:GetWide(), ChoosePlayer.PlayerBlock[k]:GetTall(), Color( 255, 255, 255, 20 * math.abs(math.sin(CurTime()*3)) ))
				draw.RoundedBox(0, 0, 0, ChoosePlayer.PlayerBlock[k]:GetWide(), ChoosePlayer.PlayerBlock[k]:GetTall(), Color( 30, 30, 30, 200 ))
			else
				draw.RoundedBox(0, 0, 0, ChoosePlayer.PlayerBlock[k]:GetWide(), ChoosePlayer.PlayerBlock[k]:GetTall(), Color( 30, 30, 30, 200 ))
			end
			surface.SetDrawColor( 20,20,20,200 )
			surface.SetMaterial( GradientUp )
			surface.DrawTexturedRect( 0, 0, ChoosePlayer.PlayerBlock[k]:GetWide(), ChoosePlayer.PlayerBlock[k]:GetTall() )

            draw.SimpleText("Name: " .. v:Nick() , "XmasSantaFont", 50, ChoosePlayer.PlayerBlock[k]:GetTall()/4, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText("SteamID: " .. v:SteamID() , "XmasSantaFont", 50, (ChoosePlayer.PlayerBlock[k]:GetTall()/4) * 3, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            
            if util.SteamIDTo64( steamid:GetValue() ) == "0" then
                confirm:SetDisabled(true)
                confirm:SetAlpha(0)
            else
                confirm:SetDisabled(false)
                confirm:SetAlpha(255)
            end

        end

        local AvatarButton = vgui.Create( "DButton", ChoosePlayer.PlayerBlock[k] )
        AvatarButton:SetSize( 40, 40 )
        AvatarButton:SetPos( 5, 5 )
        AvatarButton.DoClick = function() 
            if not IsValid(v) then ChoosePlayer.PlayerBlock[k]:Remove() return end
            v:ShowProfile()
         end

        local Avatar = vgui.Create( "AvatarImage", AvatarButton )
        Avatar:SetSize( AvatarButton:GetSize() )
        Avatar:SetPlayer( v, 64 )
        Avatar:SetMouseInputEnabled( false )

		ChoosePlayer.PlayerBlock[k].DoClick = function()
            if not IsValid(v) then ChoosePlayer.PlayerBlock[k]:Remove() return end
            steamid:SetText(v:SteamID())
        end
        
        local function confirmfunc(name)
            Panel:Remove()
            net.Start("OpenVIPChoosePlayerPanel")
            net.WriteString(steamid:GetValue())
            net.WriteString(name)
            net.SendToServer()
        end

        confirm = vgui.Create("paris_Button", Panel)
        confirm:SetText("Give VIP")
        function confirm:DoClick()
            steamworks.RequestPlayerInfo( util.SteamIDTo64( steamid:GetValue() ), function(steamName)
                local qury = Derma_Query("Are you sure you want to give VIP to " .. steamName .. "?", "Are you sure?", "Yes", function() confirmfunc(steamName) end, "No", function() if IsValid(qury) then qury:Remove() end end )
            end )
        end

    end
    
    function Panel:PerformLayout(w, h)

        steamid:SetSize(200,30)
        steamid:SetPos((Panel:GetWide()/2)-(steamid:GetWide()/2), 130)

        ChoosePlayer:SetSize(self:GetWide()*0.8,self:GetTall()*0.45)
        ChoosePlayer:SetPos((self:GetWide()*0.5)-(ChoosePlayer:GetWide()/2),200)

        ChoosePlayer.ScrollPanel:SetSize(ChoosePlayer:GetWide()*0.9,ChoosePlayer:GetTall()*0.9)
        ChoosePlayer.ScrollPanel:SetPos(ChoosePlayer:GetWide()*0.05,ChoosePlayer:GetTall()*0.05)

        ChoosePlayer.layout:SetSize(ChoosePlayer.ScrollPanel:GetWide(), 50)
        ChoosePlayer.layout:SetPos(0, 0)
        
        for k, v in pairs(ChoosePlayer.PlayerBlock) do
            v:SetSize(ChoosePlayer.layout:GetWide(), ChoosePlayer.layout:GetTall())
        end

        confirm:SetSize(200,30)
        confirm:SetPos((Panel:GetWide()/2)-(confirm:GetWide()/2), h-40)

    end

end)