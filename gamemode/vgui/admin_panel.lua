--------

aSoc = aSoc or {}
aSoc.quickMenu = {}

local aSoc = aSoc

local Panel
local EssentialBox
local saved_lua_favorites

function aSoc.Command(type,ent,extra)
    net.Start("aSoc_Request")
    net.WriteString(type)
    net.WriteEntity(ent)
    net.WriteTable(extra or {})
    net.SendToServer()
end

aSoc.quickMenu.functions = {
    {
        ["Title"] = "Bring",
        ["func"] = function(ply) aSoc.Command( "aSoc_Bring", ply ) end
    },
    {
        ["Title"] = "Goto",
        ["func"] = function(ply) aSoc.Command( "aSoc_Goto", ply ) end
    },
    {
        ["Title"] = "Heal",
        ["func"] = function(ply) aSoc.Command( "aSoc_Heal", ply ) end
    },
    {
        ["Title"] = "Set Job",
        ["func"] = function(ply)
            local jobs = {}
            for k, v in pairs(JOB_DATABASE) do
                table.insert(jobs,{
                    ["Title"] = v.Name,
                    ["func"] = function(ply)
                        aSoc.Command( "aSoc_SetJob", ply, {id = v.ID} )
                        EssentialBox:ShowList(aSoc.quickMenu.functions)
                    end
                })
            end
            table.insert(jobs,{
                ["Title"] = "Back",
                ["func"] = function(ply) EssentialBox:ShowList(aSoc.quickMenu.functions) end
            })
            EssentialBox:ShowList(jobs)
        end
    },
    {
        ["Title"] = "Toggle Godmode",
        ["func"] = function(ply) aSoc.Command( "aSoc_Godmode", ply ) end
    },
    {
        ["Title"] = "Toggle Invisibility",
        ["func"] = function(ply) aSoc.Command( "aSoc_Invisibility", ply ) end
    },
    {
        ["Title"] = "Toggle Arrest",
        ["func"] = function(ply) aSoc.Command( "aSoc_Arrest", ply ) end
    },
    {
        ["Title"] = "Kill",
        ["func"] = function(ply) aSoc.Command( "aSoc_Kill", ply ) end
    },
    {
        ["Title"] = "Kick",
        ["func"] = function(ply) aSoc.Command( "aSoc_Kick", ply ) end
    },
    {
        ["Title"] = "Ban",
        ["func"] = function(ply)
            local luabox = vgui.Create("aSoc_ReasonPopup")
            luabox:SetFunction(function(text,pb)
                aSoc.Command( "aSoc_Ban", ply, {Reason = text} )
            end)
        end
    },
    {
        ["Title"] = "Spectate",
        ["func"] = function(ply) aSoc.Command( "aSoc_Spectate", ply ) end
    },
    {
        ["Title"] = "Set Rank",
        ["Rank"] = function(ply) return ply:IsManagementTeam() end,
        ["func"] = function(ply)
            local curRankPrio = LocalPlayer():GetRankPriority()
            local ranks = {}
            local internalranks = {}
            local n = 0
            for k, v in pairs(aSoc.Ranks) do
                n = n + 1
                internalranks[n] = v
                internalranks[n].internal = k
            end
            table.SortByMember(internalranks, "Priority", true)
            for k, v in ipairs(internalranks) do
                if v.Priority < curRankPrio then continue end
                table.insert(ranks,{
                    ["Title"] = v.Display,
                    ["func"] = function(ply)
                        aSoc.Command( "aSoc_SetRank", ply, {Rank = v.internal} )
                        EssentialBox:ShowList(aSoc.quickMenu.functions)
                    end
                })
            end
            table.insert(ranks,{
                ["Title"] = "Back",
                ["func"] = function(ply) EssentialBox:ShowList(aSoc.quickMenu.functions) end
            })
            EssentialBox:ShowList(ranks)
        end
    },
    {
        ["Title"] = "Run Function",
        ["Rank"] = function(ply) return ply:IsManagementTeam() end,
        ["func"] = function(ply)
            local funcs = {}
            local playerobject = FindMetaTable("Player")
            table.insert(funcs,{
                ["Title"] = "Run Lua",
                ["func"] = function(ply)
                    local luabox = vgui.Create("aSoc_LuaPopup")
                    luabox:SetLuaFunction(function(text,pb)
                        local lua = "aSoc_returned = nil local ply = player.GetBySteamID('"..ply:SteamID().."') aSoc_returned = "
                        lua = lua .. text
                        aSoc.Command( "aSoc_RunPlayerFunction", ply, {lua = lua} ) 
                    end)
                end
            })
            table.insert(funcs,{
                ["Title"] = "Dictionary",
                ["func"] = function(ply)
                    local dictionary = vgui.Create("aSoc_LuaDictionary")
                    dictionary:SetActivePlayer(ply)
                end
            })
            table.insert(funcs,{
                ["Title"] = "SetNWVar",
                ["func"] = function(ply)
                    local nw = {}
                    local nwtypes = {
                        ["SetNWAngle"] = true,      ["SetNWBool"] = true,   ["SetNWEntity"] = true,
                        ["SetNWFloat"] = true,      ["SetNWInt"] = true,    ["SetNWString"] = true,
                        ["SetNWVarProxy"] = true,   ["SetNWVector"] = true
                    }
                    for t, _ in pairs(nwtypes) do
                        table.insert(nw,{
                            ["Title"] = t,
                            ["func"] = function(ply)
                                local luabox = vgui.Create("aSoc_LuaPopup")
                                luabox:SetAutofill("ply:" .. t .. "( \"\",  )")
                                luabox:SetLuaFunction(function(text,pb)
                                    local lua = "aSoc_returned = nil local ply = player.GetBySteamID('"..ply:SteamID().."') aSoc_returned = "
                                    lua = lua .. text
                                    aSoc.Command( "aSoc_RunPlayerFunction", ply, {lua = lua} ) 
                                end)
                            end
                        })
                    end
                    table.insert(nw,{
                        ["Title"] = "Back",
                        ["func"] = function(ply) EssentialBox:ShowList(funcs) end
                    })
                    EssentialBox:ShowList(nw)
                end
            })
            for k, v in pairs(saved_lua_favorites or {}) do
                table.insert(funcs,{
                    ["Title"] = k,
                    ["func"] = function(ply)
                        local luabox = vgui.Create("aSoc_LuaPopup")
                        luabox.te:SetValue(v)
                        luabox:SetLuaFunction(function(text,pb)
                            local lua = "aSoc_returned = nil local ply = player.GetBySteamID('"..ply:SteamID().."') aSoc_returned = "
                            lua = lua .. text
                            aSoc.Command( "aSoc_RunPlayerFunction", ply, {lua = lua} ) 
                        end)
                    end
                })
            end
            table.insert(funcs,{
                ["Title"] = "Back",
                ["func"] = function(ply) EssentialBox:ShowList(aSoc.quickMenu.functions) end
            })
            EssentialBox:ShowList(funcs)
        end
    },
    {
        ["Title"] = "Close QuickMenu",
        ["func"] = function(ply) Panel:Remove() end
    },
}
aSoc.QM_Order = {}
for k, v in pairs(aSoc.quickMenu.functions) do
    aSoc.QM_Order[k] = k
end
local function aSocQMOrder(newOrder)
    for k, v in pairs(newOrder) do
        aSoc.QM_Order[k] = v
    end
end
local saved_qm_order = util.JSONToTable( file.Read("asoc_quickmenu.json","DATA") or "" )
if saved_qm_order then aSocQMOrder(saved_qm_order) end

saved_lua_favorites = util.JSONToTable( file.Read("asoc_luafavorites.json","DATA") or "" ) or {}
function aSoc.AddLuaFavorite(fav,lua)
    saved_lua_favorites[fav] = lua
    file.Write("asoc_luafavorites.json",util.TableToJSON(saved_lua_favorites,true))
end


aSoc.SelectedPlayer = LocalPlayer()
concommand.Add("+aSoc_qm", function()

    if not IsValid(aSoc.SelectedPlayer) then aSoc.SelectedPlayer = LocalPlayer() end
    if not LocalPlayer():IsAdmin() then return end
    if IsValid(Panel) then return end

    Panel = vgui.Create("DFrame")
    Panel:SetTitle("")
    Panel:ShowCloseButton(false)
    Panel:SetSize(200,550)
    Panel:Center()
    Panel:MakePopup()
    Panel:SetKeyboardInputEnabled(false)
    --Panel:SetAlpha(225)
    local bg = Color(51, 55, 64)
    local headerbg = Color(32, 34, 38, 255)
    local header = Material("materials/asoc/quickmenu/header.png")
    local version = aSoc.Version
    function Panel:Paint(w,h)
        draw.RoundedBox(0,0,0,w,h,bg)
        draw.RoundedBox(0,0,0,w,55,headerbg)
        surface.SetMaterial(header)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect( 0, 2, w, 50 )
        aSoc.DrawShadowedText("v" .. version, "aSoc_VersionFont", w-10, h-2, white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
    end

    local CurPlayer = vgui.Create("DLabel", Panel)
    CurPlayer:SetSize((Panel:GetWide()-20)*(2/3),25)
    CurPlayer:SetPos(10+(Panel:GetWide()-20)/3,60)
    CurPlayer:SetText(" Current: " .. aSoc.SelectedPlayer:Nick() )

    local SetPlayer = vgui.Create("DButton", Panel)
    SetPlayer:SetSize((Panel:GetWide()-20)/3,25)
    SetPlayer:SetPos(10,select(2,CurPlayer:GetPos()))
    SetPlayer:SetText("")
    SetPlayer:SetToolTip("Click to Set Player, Double Click to set player to you!")
    local alpha = 0
    local alphainf = 0.5
    local white = Color(255,255,255)
    local bg = Color(125, 130, 136)
    local galpha = 0
    local galphainf = 0
    function SetPlayer:Paint(w,h)
        if self:IsHovered() then alphainf = 1 else alphainf = 0.2 end
        alpha = Lerp( 4 * FrameTime(), alpha , alphainf)
        galpha = Lerp( 4 * FrameTime(), galpha , galphainf)
        draw.RoundedBox(0,0,0,w,h,bg)
        draw.RoundedBox(0,0,0,w,h,Color(68,68+(galpha*255),68,alpha*255))
        aSoc.DrawShadowedText("Set Player", "aSoc_GUIFontSmall", w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    SetPlayer.DoClick = function()
        local players = {}
        for k, v in pairs(player.GetAll()) do
            table.insert(players,{
                ["Title"] = v:Nick(),
                ["func"] = function(ply)
                    if not IsValid(v) then return end
                    aSoc.SelectedPlayer = v
                    CurPlayer:SetText(" Current: " .. aSoc.SelectedPlayer:Nick() )
                    EssentialBox:ShowList(aSoc.quickMenu.functions)
                end
            })
        end
        table.insert(players,{
            ["Title"] = "Back",
            ["func"] = function(ply) EssentialBox:ShowList(aSoc.quickMenu.functions) end
        })
        EssentialBox:ShowList(players)
    end
    SetPlayer.DoDoubleClick = function()
        if input.IsKeyDown(KEY_R) then
            file.Write("asoc_quickmenu.json", "")
            for k, v in pairs(aSoc.quickMenu.functions) do
                aSoc.QM_Order[k] = k
            end
            Panel:Remove()
        end
        EssentialBox:ShowList(aSoc.quickMenu.functions)
        aSoc.SelectedPlayer = LocalPlayer()
        CurPlayer:SetText(" Current: " .. aSoc.SelectedPlayer:Nick() )
        galpha = 0.5
    end

    EssentialBox = aSoc.DarkScrollPanel(Panel)
    EssentialBox:SetSize(180,Panel:GetTall()-(28+SetPlayer:GetTall()+select(2,SetPlayer:GetPos())))
    EssentialBox:SetPos(10,5+SetPlayer:GetTall()+select(2,SetPlayer:GetPos()))
    EssentialBox.p_layout = vgui.Create("DListLayout", EssentialBox)
    EssentialBox.p_layout:SetPos(0,0)
    EssentialBox.p_layout:SetSize(select(1,EssentialBox:GetSize()),select(2,EssentialBox:GetSize()))
    function EssentialBox.p_layout:OnModified()
        timer.Simple(0, function()
            local tab = {}
            local neworder = {}
            for k, v in pairs(self:GetChildren()) do
                if v.DnD_ID then
                    tab[v.DnD_ID] = v
                end
            end
            table.sort( tab, function(a, b) return select(2,a:GetPos()) < select(2,b:GetPos()) end )
            for k, v in ipairs(tab) do
                neworder[k] = v.DnD_ID
            end
            file.Write("asoc_quickmenu.json", util.TableToJSON(neworder,true))
            aSocQMOrder(neworder)
        end)
    end
    function EssentialBox:ShowList(list)

        self.p_layout:Clear()

        local newlist = table.Copy(list)
        if list == aSoc.quickMenu.functions then
            self.p_layout:MakeDroppable( "quickmenu" )
            for k, v in ipairs(aSoc.QM_Order) do
                newlist[k] = list[v]
            end
        end

        for k, v in ipairs(newlist) do

            if v.Rank then if not v.Rank(LocalPlayer()) then continue end end

            local Button = self.p_layout:Add("aSoc_Button")
            if list == aSoc.quickMenu.functions then
                Button.DnD_ID = aSoc.QM_Order[k]
            end
            Button.text = v.Title
            Button:SetSize(160,28)
            Button:Dock( TOP )
            Button:DockMargin( 0, 0, 0, 1 )
            Button:SetText(v.Title)
            Button.DoClick = function() v.func(aSoc.SelectedPlayer) end

        end
    end
    EssentialBox:ShowList(aSoc.quickMenu.functions)
    
end)

concommand.Add("-aSoc_qm", function()
    if IsValid(Panel) then Panel:Remove() end
end)

surface.CreateFont( "aSoc_Popup_Font", {
	font = "Arial",
	extended = false,
	size = 35,
	weight = 1000,
	antialias = true,
} )

local draw = draw
net.Receive("aSoc_SpaceToUnspectate", function()
    local w,h = ScrW(), ScrH()
    hook.Add("HUDPaint", "SpaceToUnspectate", function()
        draw.SimpleTextOutlined( "PRESS SPACE TO UNSPECTATE", "aSoc_Popup_Font", w/2, (h/2) - 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0) )
        if input.IsKeyDown( KEY_SPACE ) then
            net.Start("aSoc_SpaceToUnspectate")
            net.SendToServer()
            hook.Remove("HUDPaint", "SpaceToUnspectate")
        end
    end)
end)

local w,h = ScrW(), ScrH()
hook.Add("HUDPaint", "SpaceToUnspectate", function()
    --[[if LocalPlayer():GetColor().a == 0 then
        draw.SimpleTextOutlined( "INVISIBLE", "aSoc_Popup_Font", w/2, h-200, Color( 255, 50, 50, 200*math.abs(math.sin(CurTime()*4)) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0) )
    end
    if LocalPlayer():GetNWBool("HasGodMode") then
        draw.SimpleTextOutlined( "GODMODE", "aSoc_Popup_Font", w/2, h-230, Color( 255, 50, 50, 200*math.abs(math.sin(CurTime()*4)) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 0, 0, 0) )
    end]]
end)

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

// Dark Scroll Bar
function aSoc.DarkScrollPanel( Parent )
    local ScrollPanel = vgui.Create("DScrollPanel", Panel)
    ScrollPanel:SetParent( Parent )
    local sbar = ScrollPanel:GetVBar()
    function sbar:Paint( w, h )
        draw.RoundedBox( 10, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
    end
    function sbar.btnUp:Paint( w, h )
        draw.RoundedBox( 10, 0, 0, w, h, Color( 20, 20, 20, 100 ) )
    end
    function sbar.btnDown:Paint( w, h )
        draw.RoundedBox( 10, 0, 0, w, h, Color( 20, 20, 20, 100 ) )
    end
    function sbar.btnGrip:Paint( w, h )
        draw.RoundedBox( 10, 0, 0, w, h, Color( 15, 15, 15, 200 ) )
    end
    return ScrollPanel
end

local shadow = Color(5,5,5,150)
function aSoc.DrawShadowedText(text,font,x,y,col,al1,al2)
    draw.SimpleText(text, font.."_s", x+2, y+2, shadow, al1, al2)
    draw.SimpleText(text, font, x, y, col, al1, al2)
end

function aSoc.CreateFont(name,table)
    surface.CreateFont( name, table )
    table.blursize = 1
    name = name .. "_s"
    surface.CreateFont( name, table )
end

aSoc.CreateFont( "aSoc_GUIFont", {
	font = "Arial",
	extended = false,
	size = 18,
	weight = 1000,
} )
aSoc.CreateFont( "aSoc_GUIFontSmall", {
	font = "Arial",
	extended = false,
	size = 14,
	weight = 1000,
} )

aSoc.CreateFont( "aSoc_VersionFont", {
	font = "Roboto Medium",
	size = 11,
	weight = 400,
} )