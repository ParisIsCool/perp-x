-------------------------------------

surface.CreateFont( "SuperLoggerBig", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 35,
    weight = 500,
})
surface.CreateFont( "SuperLogger", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 22,
    weight = 500,
})
surface.CreateFont( "SuperLogger_f", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 22,
    weight = 500,
    blursize = 1,
})
surface.CreateFont( "SuperLogger_small", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 12,
    weight = 500,
})

local draw_RoundedBox = draw.RoundedBox
local draw_SimpleText = draw.SimpleText

local UpdateActivePanel

aSoc_Logs = aSoc_Logs or {}
local logs = aSoc_Logs
local logorder = {}
local function AddLogtype(name)
    logs[name] = {}
    table.insert(logorder,name)
end
AddLogtype("Kills")
AddLogtype("Chat")
AddLogtype("Trades")
AddLogtype("Car Spawns")
AddLogtype("AFK")
AddLogtype("Jobs")
AddLogtype("Misc")

net.Receive("SuperLoggerReceiveLog", function()
    local log = net.ReadTable()
    table.insert(logs[log.type], table.Copy(log.log))
    if UpdateActivePanel then
        UpdateActivePanel(log.type)
    end
end)

concommand.Add("superlogger", function()
    local Panel = vgui.Create("DFrame")
    Panel:SetTitle("Super Logger")
    Panel:SetSize(750,500)
    Panel:Center()
    Panel:MakePopup()
    function Panel:Paint(w,h)
        draw_RoundedBox(0,0,0,w,h,Color(22,22,22,255))
        --draw_SimpleText("Super Logger v0.1","SuperLoggerBig",w/2,10,Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
    function Panel:OnRemove()
        UpdateActivePanel = nil
    end

    local logspanel
    local logspanelbottom
    local sub2
    local function LoadLogs(logtype)
        local our_logs = logs[logtype]
        if IsValid(logspanelbottom) then logspanelbottom:Remove() end

        local curAmount = 50
        local curFilter = {}
        local function ShowLogPaint(amount,scrollto,filter)
            curAmount = amount
            if filter then curFilter = filter end
            if IsValid(logspanel) then logspanel:Remove() end
            logspanel = vgui.Create( "DScrollPanel", Panel )
            logspanel:SetSize(Panel:GetWide()-10-150,0)
            logspanel:Dock( RIGHT )
            logspanel:GetVBar():SetHideButtons(true)
            table.SortByMember( our_logs, "time" )
            for i, v in ipairs(our_logs) do
                if i > amount then break end
                if filter then
                    local shouldcontinue = false
                    for val, enabled in pairs(filter or {}) do
                        if enabled then
                            if not table.HasValue(v,val) then shouldcontinue = true end
                            if shouldcontinue then continue end
                        end
                    end
                    if shouldcontinue then continue end
                end
                local log = logspanel:Add( "DButton" )
                log:SetText("")
                log:SetSize(logspanel:GetWide(),25)
                log:Dock( TOP )
                log:DockMargin( 5, 0, 0, 1 )
                local textcolor
                local backcolor
                local textcolor_hovered =       Color(164,234,255)
                local backcolor_hovered =       Color(46,46,46,150)
                local textcolor_nonhovered =    Color(255,255,255)
                local backcolor_nonhovered =    Color(11,11,11,150)
                local backcolor_nonhovered2 =    Color(24,8,8,150)
                function log:Paint(w,h)
                    if self:IsHovered() then
                        backcolor = backcolor_hovered
                        textcolor = textcolor_hovered
                    else
                        if i % 2 == 0 then
                            backcolor = backcolor_nonhovered
                        else
                            backcolor = backcolor_nonhovered2
                        end
                        textcolor = textcolor_nonhovered
                    end
                    draw_RoundedBox(0,0,0,w,h,backcolor)
                    draw_SimpleText(os.date("%X",v.time),"SuperLogger_small",1,(h/2),textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw_SimpleText(v.text,"SuperLogger_small",40,(h/2),textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end
                function log:DoClick()
                    local frame = vgui.Create("DFrame")
                    frame:SetSize(500,25+(table.Count(v)*25))
                    frame:Center()
                    frame:MakePopup()
                    frame:SetTitle(os.date("%c",v.time))
                    frame:SetCursor("hand")
                    local w,h = frame:GetWide(),25
                    function frame:PaintOver()
                        local i = 0
                        for title, value in pairs(v) do
                            i=i+1
                            if i % 2 == 0 then
                                backcolor = backcolor_nonhovered
                            else
                                backcolor = backcolor_nonhovered2
                            end
                            textcolor = textcolor_nonhovered
                            draw_RoundedBox(0,0,i*h,w,h,backcolor)
                            draw_SimpleText(title,"SuperLogger_small",3,(i+0.5)*h,textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                            local valuetext = tostring(value)
                            if istable(value) then
                                valuetext = util.TableToJSON(value)
                            end
                            draw_SimpleText(valuetext,"SuperLogger_small",70,(i+0.5)*h,textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                        end
                    end
                    local label = vgui.Create("DButton", frame)
                    label:SetText("")
                    label:SetPos(0,h)
                    label:SetSize(w,frame:GetTall()-h)
                    function label:Paint() end
                    function label:DoClick()
                        local px,py = frame:LocalCursorPos()
                        if px < w and px > 0 and py < frame:GetTall() and py > 0 then
                            local i = 0
                            for title, value in pairs(v) do
                                i=i+1
                                if py < (i+1)*h and py > (i)*h then
                                    local valuetext = tostring(value)
                                    if istable(value) then
                                        valuetext = util.TableToJSON(value)
                                    end
                                    SetClipboardText(valuetext)
                                    break
                                end
                            end
                        end
                    end
                end
            end
            if scrollto then
                timer.Simple(0, function()
                    if not IsValid(logspanel) then return end
                    logspanel:GetVBar():SetScroll(scrollto)
                end)
            end
        end

        --[[function UpdateActivePanel(type)
            if type == logtype then
                -- we need to update discreetly
                ShowLogPaint(curAmount,logspanel:GetVBar():GetScroll()+25,curFilter)
            end
        end]]

        logspanelbottom = vgui.Create( "DPanel", Panel )
        logspanelbottom:SetSize(0,30)
        logspanelbottom:Dock( BOTTOM )
        local menuBar = vgui.Create( "DMenuBar", logspanelbottom )
        menuBar:DockMargin( 0, 0, 1, 0 )
        menuBar:SetPaintBackground(false)
        function menuBar:Paint() end

        local option1 = menuBar:AddMenu( "Show Amount" )
        option1:AddOption( "50", function() ShowLogPaint(50,logspanel:GetVBar():GetScroll()) end )
        option1:AddOption( "100", function() ShowLogPaint(100,logspanel:GetVBar():GetScroll()) end )
        option1:AddOption( "200", function() ShowLogPaint(200,logspanel:GetVBar():GetScroll()) end )
        option1:AddOption( "300", function() ShowLogPaint(300,logspanel:GetVBar():GetScroll()) end )
        option1:AddOption( "500", function() ShowLogPaint(500,logspanel:GetVBar():GetScroll()) end )
        option1:AddOption( "All", function() ShowLogPaint(99999999,logspanel:GetVBar():GetScroll()) end )

        local option2 = menuBar:AddMenu( "Filter" )
        local sub = option2:AddSubMenu( "Player" )
        sub:SetDeleteSelf( false ) -- Necessary so the sub menu is not automatically removed on close
        for k, v in pairs(player.GetAll()) do
            sub:AddOption( v:Nick(), function()
                local val = v:SteamID()
                curFilter[val] = true
                sub2:AddOption( val, function()
                    curFilter[val] = nil
                    ShowLogPaint(curAmount,logspanel:GetVBar():GetScroll(),curFilter)
                end )
                ShowLogPaint(curAmount,logspanel:GetVBar():GetScroll(),curFilter)
            end )
        end
        option2:AddOption( "Custom", function()
            local frame = vgui.Create("DFrame")
            frame:SetSize(200,50)
            frame:Center()
            frame:SetTitle("Type & Hit Enter")
            frame:MakePopup()
            local entry = vgui.Create("DTextEntry",frame)
            entry:SetSize(180,20)
            entry:SetPos(10,25)
            function entry:OnEnter()
                local val = entry:GetValue()
                curFilter[val] = true
                sub2:AddOption( val, function()
                    curFilter[val] = nil
                    ShowLogPaint(curAmount,logspanel:GetVBar():GetScroll(),curFilter)
                end )
                ShowLogPaint(curAmount,logspanel:GetVBar():GetScroll(),curFilter)
                frame:Remove()
            end
        end )
        sub2 = option2:AddSubMenu( "Remove from Filter" )
        sub2:SetDeleteSelf( false )
        ShowLogPaint(curAmount)
    end


    local sidepanel = vgui.Create( "DScrollPanel", Panel )
    sidepanel:SetSize(150,0)
    sidepanel:Dock( LEFT )

    for i,index in ipairs(logorder) do
        local k, v = index,logs[index]
        local sidebutton = sidepanel:Add( "DButton" )
        sidebutton:SetText( "" )
        sidebutton:SetSize(100,30)
        sidebutton:Dock( TOP )
        sidebutton:DockMargin( 0, 0, 0, 5 )
        function sidebutton:Paint(w,h)
            if self:IsHovered() then
                draw_RoundedBox(0,0,0,w,h,Color(46,46,46,150))
                draw_SimpleText(k,"SuperLogger_f",(w/2)+1,(h/2)+1,Color(11,11,11,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw_SimpleText(k,"SuperLogger",w/2,(h/2),Color(164,234,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw_RoundedBox(0,0,0,w,h,Color(11,11,11,150))
                draw_SimpleText(k,"SuperLogger",w/2,(h/2),Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
        function sidebutton:DoClick()
            LoadLogs(k)
        end
    end
    LoadLogs(logorder[1])
end)