local PANEL = {}

function PANEL:Init()

    self:SetSize(400,700)
    self:Center()
    self:MakePopup()
    self:SetTitle("Player Function Dictionary")

    local EssentialBox = vgui.Create("DScrollPanel", self)
    EssentialBox:SetSize(380,600)
    EssentialBox:SetPos(10,60)
    function EssentialBox:ShowList(list)

        self:Clear()

        for k, v in ipairs(list) do
            local Button = vgui.Create("DButton", self)
            Button:SetSize(380,28)
            Button:Dock( TOP )
            Button:DockMargin( 0, 0, 0, 1 )
            Button:SetText("")
            Button.DoClick = function() v.func() end
            self:AddItem(Button)

            local alpha = 0
            local alphainf = 0.5
            local white = Color(236,235,227)
            function Button:Paint(w,h)
                if self:IsHovered() then alphainf = 1 else alphainf = 0.2 end
                alpha = Lerp( 4 * FrameTime(), alpha , alphainf)
                draw.RoundedBox(3,0,0,w,h,Color(68,68,68,alpha*255))
                draw.SimpleText(v.Title, "aSoc_GUIFont", w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

        end
    end
    local playerobject = FindMetaTable("Player")
    net.Start("aSoc_RequestPlayerDictionary") net.SendToServer()
    local dict = {}
    local function Search(st)
        local found = {}
        local n = 0
        for k, v in pairs(dict) do
            if string.find(string.lower(k), string.lower(st)) then
                n = n + 1
                found[n] = {
                    ["Title"] = k,
                    ["func"] = function()
                        self:Remove()
                        if not IsValid(self.ply) then return end
                        local ply = self.ply
                        local luabox = vgui.Create("aSoc_LuaPopup")
                        luabox:SetLuaFunction(function(text,pb)
                            local lua = "aSoc_returned = nil local ply = player.GetBySteamID('"..ply:SteamID().."') aSoc_returned = "
                            lua = lua .. text
                            aSoc.Command( "aSoc_RunPlayerFunction", ply, {lua = lua} ) 
                        end)
                        luabox:SetAutofill("ply:" .. k .. "()")
                    end
                }
            end
        end
        table.sort(found, function(a, b) return a.Title:lower() < b.Title:lower() end)
        EssentialBox:ShowList(found)
    end
    net.Receive("aSoc_RequestPlayerDictionary", function() dict = net.ReadTable() Search("") end)
    local SearchBox = vgui.Create("DTextEntry",self)
    SearchBox:SetSize(380,20)
    SearchBox:SetPos(10,30)
    SearchBox:SetPlaceholderText("Search")
    function SearchBox:OnChange()
        Search(self:GetValue())
    end

end

function PANEL:SetActivePlayer(ply)
    self.ply = ply
end

local bg = Color(22,22,22)
function PANEL:Paint(w,h)
    draw.RoundedBox(10,0,0,w,h,bg)
end

vgui.Register( "aSoc_LuaDictionary", PANEL, "DFrame" )