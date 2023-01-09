module( "PulsarScoreboard", package.seeall )

surface.CreateFont( "ScoreboardName", { font = "Roboto", size = 22, weight = 100 } )
surface.CreateFont( "ScoreboardRank", { font = "Roboto Condensed", size = 18, weight = 200 } )
surface.CreateFont( "ScoreboardPing", { font = "Roboto Light", size = 20, weight = 200 } )

RegisterTab( "Players", 1, "ScoreboardPlayerList", true )

// ================ PLAYERS

PLAYERLIST = {}
PLAYERLIST.PlyHeight = 48

function PLAYERLIST:Init()

	self.Players = {}
	self.NextUpdate = 0.0

end

function PLAYERLIST:AddPlayer( ply )

	local panel = vgui.Create( "ScoreboardPlayer" )
	panel:SetParent( self )
	panel:SetPlayer( ply )
	panel:SetVisible( true )

	self.Players[ ply ] = panel

end

function PLAYERLIST:RemovePlayer( ply )

	if ValidPanel( self.Players[ ply ] ) then
		self.Players[ ply ]:Remove()
		self.Players[ ply ] = nil
	end

end

function PLAYERLIST:Paint( w, h ) end

function PLAYERLIST:Think()

	if CurTime() > self.NextUpdate then

		self:PopulatePlayers()
		self:InvalidateLayout()
		self.NextUpdate = CurTime() + 3.0

	end

end

function PLAYERLIST:PopulatePlayers()

	// Handle removing players
	for ply in pairs( self.Players ) do
		if !IsValid( ply ) then
			self:RemovePlayer( ply )
		elseif ply:GetNWBool("Disguise2") then 
			self:RemovePlayer( ply )
		end
	end

	// Handle adding players
	for _, ply in pairs( player.GetAll() ) do
		if ply:GetNWBool("Disguise2") then continue end -- Added by Paris
		if self.Players[ ply ] == nil then
			self:AddPlayer( ply )
		end
	end

end

function PLAYERLIST:PerformLayout()

	// Lay them out
	local PlayerSorted = self:GetSorted()
	local curY = 0

	for _, ply in pairs( PlayerSorted ) do

		ply.Panel:InvalidateLayout( true )
		ply.Panel:UpdatePlayer()
		ply.Panel:SetPos( 0, curY )
		ply.Panel:SetWide( self:GetWide() )

		ply.Panel.List = self // so we can call this again

		curY = curY + ply.Panel:GetTall() + 2

	end

	self:SetTall( curY )

end

local DisguiseRank = aSoc.Ranks[aSoc.DisguiseRank].Priority
function PLAYERLIST:GetSorted()

	local sort = {}

	for ply, panel in pairs( self.Players ) do
		if IsValid(ply) then
			ply.Panel = panel
			table.insert( sort, ply )
		end
	end

	// Sort that shit
	local nameSort = function( a, b )
		--local arank = a:GetGNWVar( "disguised" ) == 1 and 9 or a:IsAdmin()
		--local brank = b:GetGNWVar( "disguised" ) == 1 and 9 or b:IsAdmin()

		local arank = aSoc.Ranks[a:GetAsocRank()].Priority
		local brank = aSoc.Ranks[b:GetAsocRank()].Priority
		if a:GetGNWVar("disguised") then arank = DisguiseRank end
		if b:GetGNWVar("disguised") then brank = DisguiseRank end

		return arank < brank
	end
	table.sort( sort, nameSort )

	return sort

end

vgui.Register( "ScoreboardPlayerList", PLAYERLIST )



local PLAYER = {}
PLAYER.Padding = 8
PLAYER.InfoTall = 80
PLAYER.AvatarSize = 32

surface.CreateFont("securetext", {
	font = "Roboto Medium",
	size = 18,
	weight = 600
})
surface.CreateFont("securetext2", {
	font = "Roboto Medium",
	size = 25,
	weight = 600
})
surface.CreateFont("securetext3", {
	font = "Roboto Medium",
	size = 11,
	weight = 400
})



local GradientRight = Material("paris/gradient_right.png")
function PLAYER:Init()

	self:SetText("")
	self:SetTall( PLAYERLIST.PlyHeight )

	self.Background = vgui.Create("DHTML", self)
	self.Background:SetSize(self:GetSize())
	local col = Color(0,0,0,150)
	function self.Background:PaintOver(w,h)
		surface.SetDrawColor( 12, 12, 12, 255 )
		surface.SetMaterial( GradientRight )
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( GradientRight )
		surface.DrawTexturedRectRotated( w*0.75, h*0.5, w*0.5, h, 180 )
		surface.SetMaterial( GradientDown )
		surface.DrawTexturedRect( 0, 0, w, h )
		draw.RoundedBox(0,0,0,w,h,col)
	end
	--self.Background:OpenURL( "wiki.facepunch.com/gmod" )

	self.AvatarContainer = vgui.Create( "DButton", self )
	self.AvatarContainer:SetSize( self.AvatarSize, self.AvatarSize )
	self.AvatarContainer:SetMouseInputEnabled( true )
	self.AvatarContainer.DoClick = function()
		if self.Player then
			self.Player:ShowProfile()
		end
	end

	self.Avatar = vgui.Create( "AvatarImage", self.AvatarContainer )
	self.Avatar:SetSize( self.AvatarSize, self.AvatarSize )
	self.Avatar:SetMouseInputEnabled( false )
	self.Avatar:SetVisible( false )

	self.Name = vgui.Create("DPanel", self)
	self.Name.Font = "ScoreboardName"
	self.Name.Color = Color( 255, 255, 255 )
	function self.Name:Paint(w,h)
		DisableClipping(true)
		if not self.Rainbow then
			draw.SimpleText( self.Text, self.Font, 0, 0, self.Color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		else
			DrawRainbowText( 0, 0, self.Text, self.Font, self.Color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, 1 )
		end
		DisableClipping(false)
	end

	self.Rank = Label( "Unknown", self )
	self.Rank:SetFont( "ScoreboardRank" )
	self.Rank:SetColor( Color( 255, 255, 255, 255 ) )
	self.Rank:SetPos( 0, 8 )

	self.Ping = vgui.Create( "ScoreboardPlayerPing", self )

	self.aSocket = vgui.Create( "DButton", self )
	self.aSocket:SetSize( 70, PLAYERLIST.PlyHeight )
	self.aSocket:SetZPos( 1 )
	self.aSocket:SetMouseInputEnabled( true )
	self.aSocket:SetText("")
	local glowcolor = Color(201, 182, 112,100)
	local bg = Color(55,55,55,150)
	function self.aSocket:Paint(w,h)
		glowcolor.a = math.abs(math.sin(CurTime()*4))*50
		if self:IsHovered() then
			bg.a = (glowcolor.a*-1)+50
			draw.RoundedBox(0,0,0,w,h,bg)
		end
		draw.SimpleTextOutlined("aSocket","securetext",w/2,3,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,1,glowcolor)
		draw.SimpleTextOutlined("VPN","securetext2",w/2,h/2 + 1,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,2,glowcolor)
		draw.SimpleTextOutlined("CONNECTED","securetext3",w/2,h-5,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM,1,glowcolor)
	end
	function self.aSocket:DoClick()
		gui.OpenURL("https://asocket.net/checkout/perpx")
	end

	self.Info = vgui.Create( "ScoreboardPlayerInfo", self )
	self.Info:SetSize( self:GetWide(), self.InfoTall )
	self.Info:SetVisible( false )
	self.Info:SetMouseInputEnabled( true )

	self.Lerp = PLAYERLIST.PlyHeight
	self.LerpInfluence = self.Lerp
	self.RightClickLerp = 0

end

function PLAYER:UpdatePlayer()

	local text = self.Player:Nick()

	if (GAMEMODE.FolderName != 'gtaonline' and GAMEMODE.FolderName != 'perp') then
	--if (GAMEMODE.FolderName != 'gtamrp') then
		text = self.Player:Nick()
	elseif (LocalPlayer():IsAdmin()) then
		local class = JOB_DATABASE[ self.Player:Team() ].Name
		if not class then
			class = "Unknown Class";
		end

		text = self.Player:Nick() .. ' [' .. self.Player:GetRPName() .. '] [' .. class .. ']'
	end

	self.Name.Text = text
	local AFKText = ""
	if self.Player:GetNWBool("isAFK") then
		AFKText = " | ( AFK )"
	end
	if self.Player:GetGNWVar( "disguised" ) and self.Player:IsAdmin() then
		self.Rank:SetText( string.upper( aSoc.Ranks[aSoc.DisguiseRank].Display ) .. AFKText  )
	else
		self.Rank:SetText( string.upper( self.Player:GetRankName() .. AFKText ) )
	end
	self.Ping:Update()
	if self.Player:GetNWString("BackgroundURL") then
		self.Background:OpenURL(self.Player:GetNWString("BackgroundURL"))
	end

end

function PLAYER:SetPlayer( ply )

	self.Player = ply

	if ply:GetNWBool("aSocket") then
		self.aSocket:SetWide(70)
	else
		self.aSocket:SetWide(0)
	end

	self.Avatar:SetPlayer( ply, 64 )
	self.Avatar:SetVisible( true )

	self.Ping:SetPlayer( ply )
	self.Info:SetPlayer( ply )

	self:UpdatePlayer()

end


function PLAYER:PerformLayout()

	self.Background:SetPos(0,0)
	self.Background:SetSize(self:GetSize())

	self.AvatarContainer:AlignTop( self.Padding )
	self.AvatarContainer:AlignLeft( self.Padding )

	self.Name:SizeToContents()
	self.Name:AlignTop( self.Padding / 2 )
	self.Name:AlignLeft( self.AvatarContainer:GetWide() + 16 )

	self.Rank:SizeToContents()
	self.Rank:AlignTop( self.Name:GetTall() )
	self.Rank:AlignLeft( self.AvatarContainer:GetWide() + 16 )

	self.aSocket:AlignRight( self.Padding )
	self.aSocket:AlignTop( 0 )

	self.Ping:InvalidateLayout()
	self.Ping:SizeToContents()
	self.Ping:AlignTop( self.Name:GetTall() / 2 )
	self.Ping:AlignRight( self.aSocket:GetWide() + ( self.Padding * 2 ) )

	self.Info:InvalidateLayout()
	self.Info:AlignTop( PLAYERLIST.PlyHeight )

	if self.Info:IsVisible() then
		self.LerpInfluence = PLAYERLIST.PlyHeight + self.Info:GetTall()
		self.Background:Hide()
	else
		self.LerpInfluence = PLAYERLIST.PlyHeight
		self.Background:Show()
	end

end

local backgroundcolor = Color(22,22,22)
local themecolor = Color(201, 182, 112)
local rpmat = Material("paris/rp128stroke.png")
function PLAYER:Paint( w, h )

	self.Lerp = Lerp( 20 * FrameTime() , self.Lerp , self.LerpInfluence)
	self:SetTall( self.Lerp )
	self.RightClickLerp = Lerp( 5 * FrameTime() , self.RightClickLerp , 0)

	surface.SetDrawColor( 12, 12, 12, 255 )
	surface.DrawRect( 0, 0, self:GetSize() )

	surface.SetDrawColor( 0, 255, 42, 100 * self.RightClickLerp )
	surface.SetMaterial( GradientUp )
	surface.DrawTexturedRect( 0, 0, self:GetWide(), PLAYERLIST.PlyHeight )

	if self:IsMouseOver() && !self.aSocket.Hovered && !self.AvatarContainer.Hovered then

		surface.SetDrawColor( 44, 45, 48, 150 )
		surface.SetMaterial( GradientUp )
		surface.DrawTexturedRect( 0, 0, self:GetWide(), PLAYERLIST.PlyHeight )

	end

	if self.Info && self.Info:IsVisible() then

		draw.RoundedBox(0, -2, -2, self:GetWide() + 4, self:GetTall(), backgroundcolor)
		--surface.SetDrawColor( 255, 255, 255, 100 )
		--surface.SetMaterial( GradientTabs )
		--surface.DrawTexturedRect( -2, -2, self:GetWide() + 4, self:GetTall() )

	end

	local Colour 	= Color( 255, 255, 255, 255 )
	local Alpha 	= 10 + ( 200 * math.abs( math.sin( CurTime() * 2 ) ) )

	if self.Player && IsValid(self.Player) then
		if self.Player:GetNWBool("RainbowName") then
			self.Name.Rainbow = true
		end
		if not self.Player:GetGNWVar( "disguised" ) and self.Player:IsAdmin() then
			Colour = Color( self.Player:GetRankColor().r, self.Player:GetRankColor().g, self.Player:GetRankColor().b, Alpha )
		else
			if self.Player:GetGNWVar( "disguised" ) and self.Player:IsAdmin() then
				Colour = aSoc.Ranks[aSoc.DisguiseRank].Color
			else
				Colour = self.Player:GetRankColor()
			end
		end
	end

	self.Name.Color = Colour

end

function PLAYER:PaintOver(w,h)
    local rplevel = self.Player:GetRPLevel()
	local pingx,_ = self.Ping:GetPos()
    local x,y = pingx-12,24
    surface.SetMaterial(rpmat)
    surface.SetDrawColor(themecolor.r, themecolor.g, themecolor.b,150)
    surface.DrawTexturedRectRotated( x, y, 48, 48, 0 )
    local font = "hud_reputation_rank"..math.Clamp(#tostring(rplevel)+1,1,4)

    draw.SimpleText(rplevel, font.."_s", x+1, y+1, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(rplevel, font, x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function PLAYER:Think()

	if !IsValid(self.Player) then return end

	if self:IsMouseOver() then
		self:SetCursor( "hand" )
	else
		self:SetCursor( "default" )
	end

end

function PLAYER:DoClick()
	if !LocalPlayer():IsAdmin() then return end
	self.Info:Toggle()

	// Invalidate all the layouts...
	self:InvalidateLayout()

	if self.List then
		self.List:InvalidateLayout()

		if self.List:GetParent() then
			self.List:GetParent():InvalidateLayout()
		end
	end
end

local function ChangeBackground()
	local F = vgui.Create("DFrame")
	F:SetSize(400,230)
	F:Center()
	F:MakePopup()
	F:SetTitle("Change Scoreboard Background")
	local T = vgui.Create("paris_TextEntry", F)
    T:SetSize(300,40)
    T:SetPos( 50, 200-50 )
    T:SetValue( "Insert Web URL" )
	function T:OnEnter(value)
        Derma_Query( "Are you sure you want to change your scoreboard background?", value,
        "No...", function() end,
        "Yes!", function() net.Start("ChangeScoreboardBackground") net.WriteString(value) net.SendToServer() F:Remove() end )
    end
	local L = vgui.Create("DLabel", F)
    L:SetSize(300,20)
    L:SetPos(50,200-70)
    L:SetText("Press ENTER to APPLY!")
	local L = vgui.Create("DLabel", F)
    L:SetSize(300,80)
    L:SetPos(50,200-140)
    L:SetText("IMAGES MUST BE SAFE FOR WORK AND SMALL!\nAdmins may revoke your permission!\nUpload image to imgur.com, and right click copy image address!\n768x48 Recommended!\n ")
end

function PLAYER:DoRightClick()
	local function SetAsocPlayer()
		if aSoc and IsValid(self.Player) then
			aSoc.SelectedPlayer = self.Player
			self.RightClickLerp = 0.6
		end
	end
	if LocalPlayer():IsAdmin() and self.Player != LocalPlayer() then 
		SetAsocPlayer()
	elseif LocalPlayer():IsAdmin() then
		local menu = DermaMenu() 
		menu:AddOption( "Select Player", function() SetAsocPlayer() end )
		menu:AddOption( "Change Background", function() ChangeBackground() end )
		menu:Open()
	else
		ChangeBackground()
	end

end

function PLAYER:IsMouseOver()

	if !Gui.MouseEnabled then return end

	local x,y = self:CursorPos()
	return x >= 0 and y >= 0 and x <= self:GetWide() and y <= PLAYERLIST.PlyHeight

end

vgui.Register( "ScoreboardPlayer", PLAYER, "DLabel" )



local PLAYERPING = {}
PLAYERPING.Padding = 8

function PLAYERPING:Init()

	self:SetMouseInputEnabled( false )

	self.Ping = Label( "99", self )
	self.Ping:SetFont( "ScoreboardPing" )
	self.Ping:SetColor( Color( 255, 255, 255 ) )

	self.Heights = { 3, 6, 9 }
	self.PingAmounts = { 300, 200, 100 }
	self.BaseSpacing = 5
	self.PingVal = 0

end

function PLAYERPING:Update()

	local ping = self.Player:Ping()

	self.Ping:SetText( ping )
	self.PingVal = ping

end

function PLAYERPING:SetPlayer( ply )

	self.Player = ply
	self:Update()

end

function PLAYERPING:PerformLayout()

	self.Ping:SizeToContents()
	self.Ping:AlignRight()
	self.Ping:AlignTop( self.Padding / 2 )

end

function PLAYERPING:Paint( w, h )

	local height = self.Ping:GetTall()
	local xpos = 40 - 20
	local x = xpos

	// BG
	surface.SetDrawColor( 255, 255, 255, 10 )

	for _, h in pairs( self.Heights ) do
		surface.DrawRect( x, height - h, 3, h )
		x = x + 4
	end

	// Lit/Main
	x = xpos
	surface.SetDrawColor( 255, 255, 255, 255 )

	for i=1, #self.Heights do

		local h = self.Heights[i]

		if self.PingVal < self.PingAmounts[i] then
			surface.DrawRect( x, height - h, 3, h )
		end

		x = x + 4

	end


	surface.SetTextColor( 255, 255, 255, 10 )
	surface.SetFont( "ScoreboardPing" )

	local zeros = "000"
	if self.PingVal >= 0 then zeros = "00" end
	if self.PingVal >= 10 then zeros = "0" end
	if self.PingVal >= 100 then zeros = "" end

	local w, h = surface.GetTextSize( zeros )
	surface.SetTextPos( self.Ping.x - w - 1, self.Ping.y )
	surface.DrawText( zeros )

end

vgui.Register( "ScoreboardPlayerPing", PLAYERPING )