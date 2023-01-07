local PANEL = {}

function PANEL:Init()

	self:SetSize( 400, 150 )
    self:Center()
    self:SetTitle("Enter Lua")
    self:MakePopup()

    local Err = vgui.Create("DLabel",self)
    Err:SetSize(250,20)
    Err:SetPos(10,80)
    Err:SetText("")
    local ReturnedVal = vgui.Create("DLabel",self)
    ReturnedVal:SetSize(250,20)
    ReturnedVal:SetPos(10,110)
    ReturnedVal:SetText("")
    local TextEntry = vgui.Create("DTextEntry",self)
    self.te = TextEntry
    TextEntry:SetSize(380,20)
    TextEntry:SetPos(10,50)
    TextEntry:SetPlaceholderText("Enter Lua Function, EX: ply:SetPos(Vector(0,0,0))")
    TextEntry.OnEnter = function()
        if self.LuaFunction then self.LuaFunction(TextEntry:GetValue(), self) end
    end
    local Run = vgui.Create("DButton",self)
    Run:SetSize(80,20)
    Run:SetPos(400-(10+80),80)
    Run:SetText("Run")
    Run.DoClick = function()
        if self.LuaFunction then self.LuaFunction(TextEntry:GetValue(), self) end
    end
    local Favorite = vgui.Create("DButton",self)
    Favorite:SetSize(80,20)
    Favorite:SetPos(400-(10+80),110)
    Favorite:SetText("Favorite")
    Favorite.DoClick = function()
        local name = vgui.Create("aSoc_ReasonPopup")
        name:SetTitle("Enter Name")
        name.te:SetPlaceholderText("Enter Name Of Lua Favorite")
        function name.Function(fav)
            aSoc.AddLuaFavorite(fav,TextEntry:GetValue())
            name:Remove()
        end
    end
    net.Receive("aSoc_RunPlayerFunction_Response", function()
        local response = net.ReadTable()
        Err:SetText("Error: " .. tostring(response.error))
        ReturnedVal:SetText("Returned Values: " .. tostring(response.returned))
    end)

end

function PANEL:SetAutofill(text)
    self.te:SetText(text)
end

function PANEL:SetPlaceholder(text)
    self.te:SetPlaceholderText(text)
end

function PANEL:SetLuaFunction(func)
    self.LuaFunction = func
end

local bg = Color(51, 55, 64)
function PANEL:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,bg)
end

vgui.Register( "aSoc_LuaPopup", PANEL, "DFrame" )


local PANEL = {}

function PANEL:Init()

	self:SetSize( 400, 150 )
    self:Center()
    self:SetTitle("Enter Reason")
    self:MakePopup()

    local TextEntry = vgui.Create("DTextEntry",self)
    self.te = TextEntry
    TextEntry:SetTabPosition( 1 )
    TextEntry:SetSize(380,20)
    TextEntry:SetPos(10,50)
    TextEntry:SetPlaceholderText("Enter Reason")
    TextEntry.OnEnter = function()
        self:Remove()
        if self.Function then self.Function(TextEntry:GetValue(), self) end
    end

    local Okay = vgui.Create("aSoc_Button",self)
    Okay:SetSize(75,20)
    Okay:SetPos(100,80)
    Okay:SetText("Okay")
    Okay.DoClick = function()
        self:Remove()
        if self.Function then self.Function(TextEntry:GetValue(), self) end
    end

    local Cancel = vgui.Create("aSoc_Button",self)
    Cancel:SetSize(75,20)
    Cancel:SetPos(200,80)
    Cancel:SetText("Cancel")
    Cancel.DoClick = function()
        self:Remove()
    end

end

function PANEL:SetAutofill(text)
    self.te:SetText(text)
end

function PANEL:SetPlaceholder(text)
    self.te:SetPlaceholderText(text)
end

function PANEL:SetFunction(func)
    self.Function = func
end

local bg = Color(51, 55, 64)
function PANEL:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,bg)
end

vgui.Register( "aSoc_ReasonPopup", PANEL, "DFrame" )