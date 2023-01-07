module( "PulsarScoreboard", package.seeall )

surface.CreateFont( "ScoreboardServerName", { font = "Roboto Bold Condensed", size = 24, weight = 200 } )
surface.CreateFont( "ScoreboardMapName", { font = "Roboto Condensed", size = 22, weight = 200 } )
surface.CreateFont( "ScoreboardTab", { font = "Roboto Condensed", size = 20, weight = 200 } )
surface.CreateFont( "ScoreboardHelp", { font = "Roboto Regular", size = 20, weight = 100 } )

TextureRoot = "pulsareffect/scoreboard/" // This relates to materials

MinBodyHeight = 360 // The minimum body height the scoreboard can be
MaxBodyHeight = ScrH() * .65 // The max body height the scoreboard can be
LastScrH = ScrH() // Store this to change for resolution

SCOREBOARD = {
	MinHeight = 512,
	MinWidth = 768,
	CurrentHeight = 256,
	TabHeight = 50,
	TabWidth = 768/4,
	TabMinWidth = 260,
}

Logo = {
	Texture = Material( "paris/perpscoreboard2.png" ),
	BackgroundTexture = Material( TextureRoot .. "logo_bg_1.png" ),
	TextureWidth = 499,
	TextureHeight = 124,
	Width = 500,
	Height = 100,
}

function SCOREBOARD:Init()

	self:SetZPos( 2 )
	self:SetSize( self.MinHeight, self.MinWidth )

	self.ServerName = vgui.Create( "ScoreboardServerName", self )
	self.ServerName:Update()

	self.Help = Label( "CLICK TO ACTIVATE YOUR MOUSE" )
	self.Help:SetFont( "ScoreboardHelp" )
	self.Help:SetColor( Color( 255, 255, 255, 255 ) )

	self:InitTabs()

end

function SCOREBOARD:InitTabs()

	self.Tabs = {}
	self.ActiveTab = nil

	// Add players tab (ALWAYS THERE)
	self.PlayerTab = vgui.Create( "ScoreboardPlayerListTab" )
	self:AddTab( self.PlayerTab )

	/*
		Look into the hook table for items to be added for the scoreboard
		Hook should return a panel that is inherited from the ScoreboardTab base class.
	*/
	local tabs = hook.GetTable()["ScoreboardTabs"]

	if tabs then

		for _, tabFunc in pairs( tabs ) do

			local success, tab = pcall( tabFunc )

			if success then

				if tab.AdminOnly && !LocalPlayer():IsAdmin() then continue end // Filter out admin only tabs
				self:AddTab( tab )

			end

		end

	end

	//If there is anything on the scoreboard, set the selected one!
	if #self.Tabs > 0 then
		self:SetActiveTab( self.Tabs[1] )
	end

end

function SCOREBOARD:AddTab( tab )

	table.insert( self.Tabs, tab )
	tab:SetParent( self )

end

function SCOREBOARD:SetActiveTab( tab )

	if ValidPanel( self.ActiveTab ) then

		self.ActiveTab:SetActive( false )
		local oldBody = self.ActiveTab:GetBody()

		oldBody:SetParent( nil )
		oldBody:SetVisible( false )

	end

	local newBody = tab:GetBody()

	self.ActiveTab = tab
	self.ActiveTab:SetActive( true )

	newBody:SetParent( self )
	newBody:SetVisible( true )

	self:InvalidateLayout()

end

local TabsGradientColor = Color(201, 182, 112)

function SCOREBOARD:Paint( w, h )

	// Background
	surface.SetDrawColor( 44, 45, 48, 255 )
	surface.DrawRect( 0, 0, self:GetSize() )

	--[[surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Logo.BackgroundTexture )
	surface.DrawTexturedRect( 0, 0, self:GetWide(), Logo.TextureHeight )]]


	// Logo
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Logo.Texture )
	surface.DrawTexturedRect( ( self:GetWide() / 2 ) - ( Logo.TextureWidth / 2 ), 0, Logo.TextureWidth, Logo.TextureHeight )

	// Tabs Gradient
	--[[surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( GradientTabs )
	surface.DrawTexturedRect( 0, Logo.Height - 2, self:GetWide(), self.TabHeight - 2 )]]
	draw.RoundedBox(0, 0, Logo.Height - 2, self:GetWide(), self.TabHeight - 2, TabsGradientColor)

end

function SCOREBOARD:Think()

	// Update height limit
	if LastScrH != ScrH() then
		MaxBodyHeight = ScrH() * .65
	end

	self.Help:SetVisible( !self.MouseEnabled )

	local targetHeight = Logo.Height + self.TabHeight

	// Resize for active tab
	if ValidPanel( self.ActiveTab ) then
		local body, panel = self.ActiveTab:GetBody()

		local tall = panel:GetTall()
		//if tall < MinBodyHeight then tall = MinBodyHeight end
		if tall > MaxBodyHeight then tall = MaxBodyHeight end

		body:SetTall( tall )

		targetHeight = targetHeight + body:GetTall() + 6
	end

	// Animate that bitch
	local curTall = math.Clamp( self.MinHeight, targetHeight, ScrH() * .8 )
	self.CurrentHeight = math.Approach( self.CurrentHeight, curTall, FrameTime() * 400 )

	self:SetTall( self.CurrentHeight )

end

function SCOREBOARD:PerformLayout()

	self:Center()

	self.ServerName:SetWide( self:GetWide() )
	self.ServerName:SetTall( 28 )
	self.ServerName:SetPos( 0, 65 )
	self.ServerName:CenterHorizontal()

	self.Help:SizeToContents()
	self.Help:CenterHorizontal()
	self.Help:SetPos( self.Help.x, self.y + self:GetTall() + 10 )

	self:PreformTabLayout( Logo.Height - 2 )

end

function SCOREBOARD:PreformTabLayout( offset )

	// Sort their order
	table.sort( self.Tabs, function( a, b )
		if a.Order == b.Order then
			return a:GetText() < b:GetText()
		end

		return a.Order < b.Order
	end )

	local position = 0
	local width = 0

	// Set their positions and size
	for _, tab in pairs( self.Tabs ) do

		tab:SetTall( self.TabHeight )
		tab:InvalidateLayout( true )

		tab:SetPos( position, offset )
		position = position + tab:GetWide()
		width = width + tab:GetWide()

	end

	self:SetWide( math.max( width, self.MinWidth ) )

	// Layout active tab
	if ValidPanel( self.ActiveTab ) then

		local body, panel = self.ActiveTab:GetBody()
		panel:InvalidateLayout( true )
		body:SetPos( 0, offset + self.TabHeight )
		body:SetWide( self:GetWide() )
		body:CenterHorizontal()

	end

end

vgui.Register( "PulsarScoreboard", SCOREBOARD )

local SERVERNAME = {}
SERVERNAME.Padding = 18

function SERVERNAME:Init()

	self.Name = Label( "Unknown", self )
	self.Name:SetFont( "ScoreboardServerName" )
	self.Name:SetColor( Color( 255, 255, 255, 0 ) )

	self.MapName = Label( "Unknown", self )
	self.MapName:SetFont( "ScoreboardMapName" )
	self.MapName:SetColor( Color( 255, 255, 255 ) )

end

function SERVERNAME:Update()

	self.Name:SetText( GetHostName() )
	self.MapName:SetText( game.GetMap() )

end

function SERVERNAME:PerformLayout()

	self.Name:SizeToContents()
	self.Name:AlignLeft( self.Padding )
	self.Name:AlignTop( 1 )

	self.MapName:SizeToContents()
	self.MapName:AlignRight( self.Padding )
	self.MapName:AlignTop( 4 )

end

vgui.Register( "ScoreboardServerName", SERVERNAME )
