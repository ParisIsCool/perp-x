--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- Main content
paris = paris or {}
local paris = paris
steamworks.DownloadUGC( 2034472616, function( name, FileObject )
    if isstring(name) then
        game.MountGMA( name )
    end
end)

-- OPTIMIZATIONS
local render = render
local surface = surface
local staminalerp = 0

local Blips = {}

paris.GlobalScale = 0.1

timer.Create("GtaHUDAutoRefresh", 0.25, 0, function()
    local locply = LocalPlayer()
    if paris.HUDMaps then
        for k, v in pairs(paris.HUDMaps) do
            if v.Map == game.GetMap() then
                if !v.UseZones or !IsValid(locply) then
                    if paris.Zone != k then
                        paris.Mat = Material(v.Material..".png","smooth 1")
                    end
                    paris.Zone = "*"
                    if v.Zoom then
                        paris.HUDZoom = v.Zoom
                    else
                        paris.HUDZoom = 1
                    end
                    paris.Scale = v.Scale
                    paris.ScaleX, paris.ScaleY = v.ScaleX, v.ScaleY
                    paris.Translate = v.Translate
                else
                    for k, v in pairs(v.Zones) do
                        if k != "MAIN" then
                            for _, vectors in pairs(v.InsideZones) do
                                if locply:GetPos():WithinAABox(vectors[1],vectors[2]) then
                                    if paris.Zone != k then
                                        paris.Mat = Material(v.Material..".png","smooth 1")
                                    end
                                    paris.Zone = k
                                    if v.Zoom then
                                        paris.HUDZoom = v.Zoom
                                    else
                                        paris.HUDZoom = 1
                                    end
                                    paris.Scale = v.Scale
                                    paris.ScaleX, paris.ScaleY = v.ScaleX, v.ScaleY
                                    paris.Translate = v.Translate
                                    break
                                end
                            end
                        else
                            if paris.Zone != k then
                                paris.Mat = Material(v.Material..".png","smooth 1")
                            end
                            paris.Zone = k
                            if v.Zoom then
                                paris.HUDZoom = v.Zoom
                            else
                                paris.HUDZoom = 1
                            end
                            paris.Scale = v.Scale
                            paris.ScaleX, paris.ScaleY = v.ScaleX, v.ScaleY
                            paris.Translate = v.Translate
                        end
                    end
                end
            end
        end
    end
end)

function paris:LoadHUD()
    if IsValid(paris.HUDPanel) then paris.HUDPanel:Remove() end
    local locply = LocalPlayer()
    paris.HUDPanel = vgui.Create("DPanel")
    hook.Add("Think", "GTAHudPanelHider", function()
        if GAMEMODE.Options_DrawHUD:GetInt() == 0 or GAMEMODE.DoNotDrawHUD or GAMEMODE.Options_UseBasicHUD:GetInt() == 1 then 
            paris.HUDPanel:Hide()
        else
            paris.HUDPanel:Show()
        end
    end)
    paris.HUDPanel:SetSize(300,200)
    paris.HUDPanel:SetPos(25,ScrH()-25)
    local OutLine = Material("paris/hudoutlinehd.png")
    paris.HUDColor = Color(255,255,255,200)
    function paris.HUDPanel:Paint(w,h)
        
        if paris.Maximized then
            paris.HUDPanel:SetSize(600,600)
            paris.HUDPanel:SetPos(25,ScrH()-(600+25))
        else
            paris.HUDPanel:SetSize(300,200)
            paris.HUDPanel:SetPos(25,ScrH()-25)
        end

        local x, y = self:LocalToScreen( 0, 0 )

        local Fraction = 1.9 * (40/100)

        local matBlurScreen = Material( "pp/blurscreen" )
        surface.SetMaterial( matBlurScreen )
        surface.SetDrawColor( 255, 255, 255, 255 )

        for i=0.33, 1, 0.33 do
            matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
            matBlurScreen:Recompute()
            if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
            surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
        end

        surface.SetDrawColor( 100, 100, 100, 0 )
        surface.DrawRect( x * -1, y * -1, ScrW(), ScrH() )

        local safezone = GAMEMODE.Options_SafeZone:GetInt()
        paris.HUDPanel:SetPos(safezone,ScrH()-(h+safezone))

        DisableClipping(true)
        surface.SetMaterial(OutLine)
        surface.SetDrawColor(0, 0, 0, 200)
        local x,y = 0,0
        local safezonex = (25*w)/300
        local safezoney = (25*h)/200
        surface.DrawTexturedRect((safezonex*-1), safezoney*-1, w+(safezonex*2), h+(safezoney*2))
        DisableClipping(false)

    end




    --[[                 LERP System                 ]]
    -- This interpolates when you enter/exit vehicles

    local CarLerpAng = 0
    local MainAngInfluence = 90
    local CamHeightLerp = 0
    local CamHeightInfluence = 5000
    local ForwardLerp = 100
    local ForwardLerpInfluence = 100
    local FOVLerp = 0
    local FOVLerpInfluence = 0
    local HudZoom = 1
    paris.HUDZoom = 1 -- This one is the influence
    local HealthAlphaLERP = 0
    local HealthAlphaLERPInfluence = 0

    -- 3d
    local lookang
    local campos
    local fov

    local mapmin,mapmax = game.GetWorld():GetModelBounds()
    local mapx = mapmax.x-mapmin.x
    local mapy = mapmax.y-mapmin.y

    hook.Add("PARIS_DamageTaken", "AddBloodStainToRadar", function(amount)
        HealthAlphaLERP = amount
    end)

    if IsValid(locply) and IsValid(locply:GetVehicle()) then
        MainAngInfluence = 28
        CamHeightInfluence = 3000
        ForwardLerpInfluence = 400
    end

    local function PlayerEnteredVehicle()
        MainAngInfluence = 28
        CamHeightInfluence = 3000
        ForwardLerpInfluence = 400
    end

    local function PlayerLeaveVehicle()
        CamHeightInfluence = 5000
        ForwardLerpInfluence = 100
    end

    net.Receive("PlayerEnteredVehicle", PlayerEnteredVehicle)
    net.Receive("PlayerLeaveVehicle", PlayerLeaveVehicle)

    --[[                LOWER HUD                ]]
    --            The Health/Ammo Boxes

    local PointA = 100
    local PointB = 100
    local TimeSince = CurTime()
    hook.Add("PARIS_DamageTaken", "AddBloodStainToHealth", function(taken, healthbefore)
        PointA = healthbefore - taken
        PointB = healthbefore
        TimeSince = CurTime()
    end)


    paris.HUDPanelOverlay = vgui.Create("DPanel", paris.HUDPanel)
    paris.HUDPanelOverlay:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())
    paris.HUDPanelOverlay:SetPos(0,0)
    paris.HUDPanelOverlay.GradientRight = Material( "paris/gradient_right.png" )
    local BloodSplash = Material("paris/bloodinside.png")
    local BottomColor = Color(5,5,5,220)
    local HealthBackground = Color(47, 81, 51,255)
    local HealthColor = Color(85, 153, 79,255)
    local HealthLowBackground = Color(95, 9, 13,255)
    local ArmorBackground = Color(17, 53, 75,255)
    local ArmorColor = Color(109, 191, 227,255)
    local StaminaBackground = Color(185, 153, 70,50)
    local StaminaColor = Color(185, 153, 70,255)
    local drawRoundedBox = draw.RoundedBox
    function paris.HUDPanelOverlay:Paint(w,h)

        self:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())
        // Bottom shit
        drawRoundedBox(0, 0, h-23, w, 23, BottomColor)

        if IsValid(locply) then

            local health = math.Clamp(locply:Health(), 0, 100)
            if health > 30 then
                drawRoundedBox(0, 0, h-18, (w/2)-2, 10, HealthBackground)
                drawRoundedBox(0, 0, h-18, ((w/2)-2) * (health/100), 10, HealthColor)
            else
                drawRoundedBox(0, 0, h-18, (w/2)-2, 10, HealthLowBackground)
                drawRoundedBox(0, 0, h-18, ((w/2)-2) * (health/100), 10, Color(165, 33, 44,255*math.abs(math.sin(CurTime()*5))))
            end

            surface.SetMaterial(paris.HUDPanelOverlay.GradientRight)
            surface.SetDrawColor(150, 20, 20, 255-((CurTime()-TimeSince)*255))
            surface.DrawTexturedRect(((w/2)-2) * (health/100), h-18, PointA-PointB, 10)

            surface.SetMaterial(BloodSplash)
            local HealthAlpha = (HealthAlphaLERP*-1)
            if HealthAlpha > 10 then
                HealthAlpha = 10
            end
            surface.SetDrawColor(255, 50, 50, (HealthAlpha*40))
            surface.DrawTexturedRect( 0, 0, w,h - 18 )

            local armor = math.Clamp(locply:Armor(), 0, 100)
            drawRoundedBox(0, (w/2)+2, h-18, (w/2)-2, 10, ArmorBackground)
            drawRoundedBox(0, (w/2)+2, h-18, ((w/2)-2) * (armor/100), 10, ArmorColor)

            // Add Stamina-Support here
            local stamina = 0
            local supported = false
            if locply:GetNWFloat("Stamina") then // PERP Stamina
                stamina = math.Clamp(locply:GetNWFloat("Stamina"), 0, 100)
                supported = true
            end
            staminalerp = Lerp(FrameTime()*1, staminalerp, stamina)

            if supported then
                drawRoundedBox(0, 2, h-5, (w)-4, 3, StaminaBackground)
                drawRoundedBox(0, 2, h-5, ((w)-4) * (staminalerp/100), 3, StaminaColor)
            end

        end
    end



    --[[                BLIPS                ]]
    --       The entire system for blips

    if IsValid(paris.HUDBlipOverlay) then paris.HUDBlipOverlay:Remove() end
    paris.HUDBlipOverlay = vgui.Create("DPanel")
    paris.HUDBlipOverlay:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())
    paris.HUDBlipOverlay:SetPos(0,0)

    local halfcircle = Material("paris/blips/halfcircle.png")
    local Lerp = Lerp

    function paris.HUDBlipOverlay:Paint()

        locply = LocalPlayer()
        local GAMEMODE = GAMEMODE
        if !IsValid(locply) then return end
        if GAMEMODE.Options_DrawHUD:GetInt() == 0 or GAMEMODE.Options_UseBasicHUD:GetInt() == 1 then return end
        if GAMEMODE.DoNotDrawHUD then return end

        local ScreenWide = ScrW()
    
        -- 2d
        local scrw,scrh = ScrW(), ScrH()
        local w,h = paris.HUDPanel:GetSize()
        h = h - 23
        local x,y = paris.HUDPanel:GetPos()
    
        if IsValid(locply) then
    
            if IsValid(locply:GetVehicle()) then
                MainAngInfluence = 28
                CamHeightInfluence = 3000
                ForwardLerpInfluence = 400
            elseif not IsValid(locply:GetVehicle()) then
                MainAngInfluence = 90
                CamHeightInfluence = 5000
                ForwardLerpInfluence = 100
            end
    
            -- Soo much LERP :I
    
            CarLerpAng = Lerp( 4 * FrameTime() , CarLerpAng , MainAngInfluence)
            CamHeightLerp = Lerp( 4 * FrameTime() , CamHeightLerp , CamHeightInfluence)
            ForwardLerp = Lerp( 4 * FrameTime() , ForwardLerp , ForwardLerpInfluence)
            FOVLerp = Lerp( 4 * FrameTime() , FOVLerp , FOVLerpInfluence)
            HealthAlphaLERP = Lerp( 4 * FrameTime() , HealthAlphaLERP , HealthAlphaLERPInfluence)
            HudZoom = Lerp( 4 * FrameTime() , HudZoom , paris.HUDZoom)
    
            fov = math.Clamp(60+FOVLerp, 0, 140 )
    
            local MaximizeZoom = 1
            if paris.Maximized then
                MaximizeZoom = 3
            end
    
    
            --[[     CAMERA CONTROLLER     ]]--
    
            local plypos = locply:GetPos()
            local plyang = locply:EyeAngles()
            local plyeyeang = locply:EyeAngles()
    
            local OfficialLookAng = Angle(0,0,0)
            local CamPos = Vector(0,0,0)
    
            if locply:InVehicle() then
    
                if locply:InVehicle() then
                    plyang = plyang + locply:GetAngles() + Angle(0,-90,0)
                    FOVLerpInfluence = (locply:GetVehicle():GetVelocity():Length()/120)
                else
                    FOVLerpInfluence = math.abs(locply:GetVelocity():Length()/60)
                end
    
                CamPos = (Vector(plypos.x,plypos.y,CamHeightLerp*HudZoom*MaximizeZoom)-(Angle(0,plyang.y,0):Forward()*ForwardLerp*HudZoom*MaximizeZoom*11))
            else
                FOVLerpInfluence = math.abs(locply:GetVelocity():Length()/60)
                CamPos = ((Vector(plypos.x,plypos.y,CamHeightLerp*HudZoom*MaximizeZoom))+(Angle(0,plyang.y,0):Forward()*ForwardLerp*HudZoom*8))
            end
    
            OfficialLookAng = Angle(CarLerpAng,plyang.y,0) 
    
            lookang = OfficialLookAng
    
            campos = CamPos
    
        end
    
        cam.Start({
            x = x,
            y = y,
            w = w,
            h = h,
            type = "3D",
            origin = campos,
            angles = lookang,
            fov = fov,
            aspect = (w/h),
            subrect = true, -- Maybe idk
            zfar = 1000000,
        })
    
            for k, v in pairs(Blips or {}) do
                local initial = Vector(0,0,0)
                if isvector(v.VectorOrEntity) then
                    initial = v.VectorOrEntity
                elseif isentity(v.VectorOrEntity) and IsValid(v.VectorOrEntity) then
                    initial = v.VectorOrEntity:GetPos()
                end
                initial.z = 0 -- We don't want z value :P
                local Pos = LocalToWorld(initial, Angle(), Vector(0,0,0), Angle(0,0,0))
                local Output = Pos:ToScreen()
                if k == "LocalPlayer" then
                    Blips[k].x = ScreenWide/2
                else
                    Blips[k].x = Lerp( 120 * FrameTime() , Blips[k].x , Output.x)
                end
                Blips[k].y = Lerp( 120 * FrameTime() , Blips[k].y , Output.y)
            end
    
            if paris.Mat then
                render.SetMaterial(paris.Mat)
            end

            if not paris.Translate then
                paris.Translate = Vector(0,0,0)
            end

            render.DrawQuadEasy(Vector(0,0,0) + paris.Translate, Vector(0,0,1), mapx*(paris.Scale or 1)*(paris.ScaleX or 0), mapy*(paris.Scale or 1)*(paris.ScaleY or 0), paris.HUDColor, 90)

            render.SetColorMaterial()
    
        cam.End3D()

        paris.HUDBlipOverlay:SetPos(x,y)
        paris.HUDBlipOverlay:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())

        for k, v in pairs(Blips) do

            if !isvector(v.VectorOrEntity) and !IsValid(v.VectorOrEntity) then 
                Blips[k] = nil
                return 
            end

            local function DrawBlip()

                if IsValid(v.VectorOrEntity) and (v.VectorOrEntity:IsPlayer()) then
                    v.FadeDist = 4000
                end
                if v.VectorOrEntity == locply then
                    v.FadeDist = nil
                end
                local DrawOthers = true
                if not DrawOthers and isentity(v.VectorOrEntity) and (v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot())) then 
                    if v.VectorOrEntity != locply then return end
                end

                if v.FadeDist then
                    local dist = 0
                    local OurVector = Vector(locply:GetPos().x,locply:GetPos().y,0)
                    if isvector(v.VectorOrEntity) then
                        dist = math.Distance(OurVector.x, OurVector.y, v.VectorOrEntity.x, v.VectorOrEntity.y)
                    elseif isentity(v.VectorOrEntity) then
                        dist = math.Distance(OurVector.x, OurVector.y, v.VectorOrEntity:GetPos().x, v.VectorOrEntity:GetPos().y)
                    end
                    v.LastDist = dist
                    surface.SetDrawColor(v.col.r,v.col.g,v.col.b, (v.FadeDist - dist))
                else
                    surface.SetDrawColor(v.col.r,v.col.g,v.col.b,v.col.a)
                end

                if (IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot())) and v.VectorOrEntity:GetNWInt("WantedLevel") != 0 and v.VectorOrEntity != locply then
                    surface.SetDrawColor(240,0,0,v.col.a)
                end

                local RatX = v.x/ScrW()
                local RatY = v.y/ScrH()
                local x = (RatX*paris.HUDPanel:GetWide())
                if x > paris.HUDPanel:GetWide() then
                    x = paris.HUDPanel:GetWide()
                elseif x < 0 then
                    x = 0
                end
                local y = (RatY*(paris.HUDPanel:GetTall()-17))
                if y > paris.HUDPanel:GetTall() - (v.Scale) then
                    y = paris.HUDPanel:GetTall() - (v.Scale)
                elseif y < (v.Scale)*-0.1 then
                    y = (v.Scale)*-0.1
                end
    
                local Rot = 0
    
                if v.followang then
                    if IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot()) then
                        if IsValid(v.VectorOrEntity:GetVehicle()) and v.VectorOrEntity != locply then
                            Rot = (locply:EyeAngles().y*-1) + v.VectorOrEntity:GetVehicle():GetAngles().y + 90
                        elseif IsValid(v.VectorOrEntity:GetVehicle()) and v.VectorOrEntity == locply then
                            Rot = (locply:EyeAngles().y*-1) + 90
                        elseif IsValid(locply:GetVehicle()) then
                            Rot = v.VectorOrEntity:EyeAngles().y - locply:EyeAngles().y - locply:GetVehicle():GetAngles().y
                        else
                            Rot = v.VectorOrEntity:EyeAngles().y - locply:EyeAngles().y
                        end
                    elseif (IsValid(v.VectorOrEntity)) then
                        if IsValid(locply:GetVehicle()) then
                            Rot = v.VectorOrEntity:EyeAngles().y - locply:EyeAngles().y - locply:GetVehicle():GetAngles().y
                        else
                            Rot = v.VectorOrEntity:EyeAngles().y - locply:EyeAngles().y
                        end
                    end
                end

                if v.Spinning then
                    Rot = CurTime()*540
                end

                local doDraw = true
                local drawCount = false
                local count = 1

                if (IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot())) and v.VectorOrEntity:GetColor().a < 10 then return end

                if v.followang and IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and IsValid(v.VectorOrEntity:GetVehicle()) and IsValid(v.VectorOrEntity:GetVehicle():GetParent()) then
					if not (IsValid(locply:GetVehicle()) and locply:GetVehicle() == v.VectorOrEntity:GetVehicle()) then
                    	-- There vehicle is a seat DO NOT DRAW IT, the main draws it
                    	doDraw = false
                    end
                elseif v.followang and IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and IsValid(v.VectorOrEntity:GetVehicle()) then
                    -- First we check if the vehicle has seat children
                    if locply == v.VectorOrEntity then
                        drawCount = false
                    else
                        for _, child in pairs(v.VectorOrEntity:GetVehicle():GetChildren()) do
                            if IsValid(child) and child:IsVehicle() then
                                for _, ply in pairs(player.GetAll()) do
                                    if ply:GetVehicle() == child then
                                        if not (IsValid(locply) or IsValid(v.VectorOrEntity)) then return end
                                        drawCount = true
                                        Rot = v.VectorOrEntity:GetAngles().y - locply:EyeAngles().y - locply:GetVehicle():GetAngles().y
                                        count = count + 1
                                    end
                                end
                            end
                        end
                    end
                end
                -- the case if there is a car with no driver but passengers
                if v.followang and IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and IsValid(v.VectorOrEntity:GetVehicle()) and IsValid(v.VectorOrEntity:GetVehicle():GetParent()) then
                    local veh = v.VectorOrEntity:GetVehicle():GetParent()
                    local driverValid = false
                    for _, ply in pairs(player.GetAll()) do
                        if ply:GetVehicle() == veh then -- if theres a driver then we stop
                            driverValid = true
                        end
                    end
                    if !driverValid then
                        doDraw = true
                    end
                end


                if doDraw then
                    DisableClipping(true)
                        local color = surface.GetDrawColor()
                        surface.SetDrawColor(51, 255, 238, color.a)
                        surface.SetMaterial(halfcircle)

                        if IsValid(v.VectorOrEntity) and isentity(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and v.VectorOrEntity:GetFriendStatus() == "friend" and v.VectorOrEntity != locply then
                            surface.DrawTexturedRectRotated( x, y, v.Scale * 1.0, v.Scale * 1.0, 0 )
                        end

                        surface.SetDrawColor(color.r, color.g, color.b, color.a)
                        surface.SetMaterial(v.Mat)

                        surface.DrawTexturedRectRotated( x, y, v.Scale, v.Scale, Rot )
                        if drawCount then
                            draw.SimpleText(count, "DermaDefault", x, y - 1, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                    DisableClipping(false)
                end

            end


            local DrawOnlySeen = true
            if IsValid(v.VectorOrEntity) and isentity(v.VectorOrEntity) and DrawOnlySeen and v.VectorOrEntity != locply and !v.AlwaysThruWalls then
                local trace = {}
                trace.start = locply:GetShootPos()
                trace.endpos = v.VectorOrEntity:GetPos() + Vector(0,0,10)
                if v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot()) then
                    trace.endpos = v.VectorOrEntity:GetShootPos()
                end
                trace.filter = {locply, v.VectorOrEntity}
                if v.GetVehicle and IsValid(v:GetVehicle()) then 
                    table.insert(trace.filter, v.VectorOrEntity:GetVehicle()) 
                end
                if IsValid(locply:GetVehicle()) then 
                    table.insert(trace.filter, locply:GetVehicle()) 
                end
                local tr = util.TraceLine( trace )
                if (!tr.Hit) and (v.Zone=="*" or v.Zone==paris.Zone) then
                    DrawBlip()
                end
            elseif (v.Zone=="*" or v.Zone==paris.Zone) then
                DrawBlip()
            end
            if !IsValid(v.VectorOrEntity) and !isvector(v.VectorOrEntity) then Blips[k] = nil end
        end


    end

    function AddMapBlip(Mat,VectorOrEntity,ID,Scale,col,FadeDist,Zone,followang,AlwaysThruWalls,Spinning,MapConfigBlip)
        local x,y = 0,0
        if Blips[ID] and Blips[ID].x and Blips[ID].y then
            x,y = Blips[ID].x, Blips[ID].y
        end
        local matstr = Mat
        if not string.EndsWith(Mat, ".png") then
            matstr = Mat .. ".png"
        end
        Blips[ID] = {
            ID = ID,
            Mat = Material(matstr),
            VectorOrEntity = VectorOrEntity,
            Scale = Scale,
            col = col,
            followang = followang,
            FadeDist = FadeDist,
            Zone = Zone,
            AlwaysThruWalls = AlwaysThruWalls,
            x = x,
            y = y,
            MapConfigBlip = MapConfigBlip,
            Spinning = Spinning,
        }
        paris.Blips = Blips
        return Blips[ID]
    end

    for k, v in pairs(player.GetAll()) do
        if v != locply then
            AddMapBlip("paris/blips/playerblip.png",v,v:UniqueID(),25,color_white,4000,"*", true)
        end
    end

    hook.Add("Think", "PlayerZoneChanger", function()
        for _, blip in pairs(Blips) do
            if IsValid(blip.VectorOrEntity) and IsEntity(blip.VectorOrEntity) and blip.VectorOrEntity:IsPlayer() then
                for k, v in pairs(paris.HUDMaps or {}) do
                    if v.Map == game.GetMap() then
                        if not v.UseZones or not IsValid(locply) then
                            blip.Zone = "*"
                        else
                            for k, v in pairs(v.Zones) do
                                if k != "MAIN" then
                                    for _, vectors in pairs(v.InsideZones) do
                                        if blip.VectorOrEntity:GetPos():WithinAABox(vectors[1],vectors[2]) then
                                            blip.Zone = k
                                        end
                                    end
                                else
                                    blip.Zone = k
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    AddMapBlip("paris/blips/hudarrow.png",locply,"LocalPlayer", 25, color_white,true,"*", true, true)

    net.Receive("SendBlipsToClient", function()

        local tab = net.ReadTable()

        for k, v in pairs(tab) do // Set IDS
            tab[k].ID = k
        end

        paris.MapBlips = tab

        for k, v in pairs(Blips) do // Removes old ones
            if v.MapConfigBlip then
                Blips[k] = nil
            end
        end

        for k, v in pairs(tab) do // Adds the new config
            if !v.Scale then
                v.Scale = 30
            end
            AddMapBlip(v.Icon,Vector(v.Pos.x,v.Pos.y,v.Pos.z),k, v.Scale, v.Color or Color(255,255,255),v.FadeDistance,v.Zone or "*", false, true, false, true)
        end

        paris.Blips = Blips

    end)

    net.Receive("PARIS_AddBlipTOHUD", function()
        local data = net.ReadTable()
        local fadedist = 4000
        if data.FadeDist then
            fadedist = data.FadeDist
        end
        if data.VectorOrEntity == locply then return end
        if data.Mat == "_playerMaterial" then 
            data.Mat = "paris/blips/playerblip.png"
            data.Color = color_white
        end
        local blip = AddMapBlip(data.Mat,data.VectorOrEntity,data.ID, data.Scale, data.Color, fadedist,data.Zone, data.Follow)
        blip.TrueMat = data.Mat
    end)

    net.Receive("PARIS_RemoveBlipFROMHUD", function()
        local data = net.ReadTable()
        Blips[data.ID] = nil
    end)

    net.Start("RequestNewBlips")
    net.SendToServer()

    hook.Add("Think", "DeadDrawerThinker", function()
        for k, v in pairs(Blips or {}) do
            if IsValid(v.VectorOrEntity) and not v.VectorOrEntity:IsDormant() and isentity(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (IsValid(v.VectorOrEntity) and v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot()) then
                if v.VectorOrEntity:Alive() then
                    if v.OriginalMat then
                        v.Mat = v.OriginalMat
                        v.Scale = v.OriginalScale
                        v.OriginalMat = nil
                    end
                    if v.VectorOrEntity:GetPos().z - locply:GetPos().z > 400 then
                        AddMapBlip("paris/blips/playerblip_higher",v.VectorOrEntity,"UpperLower"..v.VectorOrEntity:UniqueID(),25,color_white,4000,"*",false)
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].x = Blips[v.VectorOrEntity:UniqueID()].x
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].y = Blips[v.VectorOrEntity:UniqueID()].y
                    elseif v.VectorOrEntity:GetPos().z - locply:GetPos().z < -400 then
                        AddMapBlip("paris/blips/playerblip_lower",v.VectorOrEntity,"UpperLower"..v.VectorOrEntity:UniqueID(),25,color_white,4000,"*",false)
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].x = Blips[v.VectorOrEntity:UniqueID()].x
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].y = Blips[v.VectorOrEntity:UniqueID()].y
                    else
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()] = nil
                    end
                else
                    if not v.OriginalMat then
                        v.OriginalMat = v.Mat
                        v.OriginalScale = v.Scale
                        v.Mat = Material("paris/blips/dead.png")
                        v.Scale = 16
                    end
                end
            end
        end
    end)

    --[[                FINISHED                ]]
    --       No, seriously thats everything

end

paris.Binds = {}

paris.Binds["MaximizeMap"] = {
    button = KEY_M,
    OnPush = function()
        paris.Maximized = true
    end,
    OnNotPush = function()
        paris.Maximized = false
    end
}

hook.Add("Think", "BindPressedCheck", function()
    if GAMEMODE.ChatBoxOpen then return end
    for k, v in pairs(paris.Binds) do
        if input.IsButtonDown(v.button) and !v.pressed and !gui.IsGameUIVisible() then
            v.pressed = true
            v.OnPush()
        elseif !input.IsButtonDown(v.button) and v.pressed then
            v.pressed = false
            v.OnNotPush()
        end
    end
end)

hook.Add("InitPostEntity", "LoadGTAHUD_Paris", function()
    
    local Health = LocalPlayer():Health()
    hook.Add("Think", "HealthDamageIsTaken", function()
        if LocalPlayer():Health() < Health then
            hook.Run("PARIS_DamageTaken", (LocalPlayer():Health() - Health), Health)
        end
        Health = LocalPlayer():Health()
    end)
    
    timer.Simple(5, function()
        paris:LoadHUD()
        paris.HUDLoadFromNowOn = true
    end)
end)

if paris.HUDLoadFromNowOn then
    paris:LoadHUD()
end