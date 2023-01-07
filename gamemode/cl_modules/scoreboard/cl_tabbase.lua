module( "PulsarScoreboard", package.seeall )

local TABBASE = {}
TABBASE.Order = 1

function TABBASE:Init()

	self:SetCursor( "hand" )

	if !ValidPanel( self.Label ) then

		self.Label = Label( self:GetText() )
		self.Label:SetParent( self )
		self.Label:SetFont( "ScoreboardTab" )
		self.Label:SetMouseInputEnabled( false )
		self.Label:SetTextColor( color_black )

	end

	self:SetMouseInputEnabled( true )
	self.Active = false

end

function TABBASE:GetText()
	return "TODO"
end

function TABBASE:CreateBody()
	error( "Implement me! " .. tostring( self:GetName() ) )
end

function TABBASE:InvalidateLayout()

	self.Label:SetText( self:GetText() )
	self.Label:SizeToContents()

	self:SetWide( SCOREBOARD.TabWidth )
	self.Label:Center()

end

function TABBASE:SetActive( active )

	if self.Active == active then
		return
	end

	self.Active = active

	if active then
		self:OnOpen()
		self:SetCursor( "default" )
	else
		self:OnClose()
		self:SetCursor( "hand" )
	end

end

function TABBASE:Think()

	if self.Active then
		self:SetCursor( "default" )
	else
		self:SetCursor( "hand" )
	end

end

function TABBASE:OnOpen()

	if ValidPanel( self.Body ) && self.Body.OnOpen then
		self.Body:OnOpen()
	end

end

function TABBASE:OnClose()
end

function TABBASE:GetBody()

	if !ValidPanel( self.Body ) then

		self.Scroll = vgui.Create( "DPanelListPE" )
		self.Body = self:CreateBody()

		if !ValidPanel( self.Body ) then
			error("Unable to create body for panel")
		end

		self.Scroll:EnableVerticalScrollbar()
		self.Scroll:EnableHorizontal( false )
		self.Scroll.Paint = function() end
		self.Scroll:SetVisible( false )
		self.Scroll:AddItem( self.Body )

	end

	return self.Scroll, self.Body

end

function TABBASE:Paint( w, h )

	// Seperators
	surface.SetDrawColor( 22, 22, 22, 255 )
	surface.DrawRect( self:GetWide() - 2, 0, 1, self:GetTall() - 2 ) // Last

	// Active
	if self.Active then

		// Active seperator
		surface.DrawRect( 0, 0, 1, self:GetTall() - 2 ) // First
		return
	end

	if self:IsMouseOver() then

		surface.SetDrawColor( 12, 12, 12, 200 )
		surface.SetMaterial( GradientUp )
		surface.DrawTexturedRect( 0, 0, self:GetWide() - 1, self:GetTall() - 2 )

	else

		surface.SetDrawColor( 12, 12, 12, 255 * .55 )
		surface.DrawRect( 0, 0, self:GetWide() - 1, self:GetTall() - 2 )

	end

end

function TABBASE:OnMousePressed()

	if self:GetParent().ActiveTab != self then
		self:GetParent():SetActiveTab( self )
	end

end

function TABBASE:IsMouseOver()

	local x,y = self:CursorPos()
	return x >= 0 and y >= 0 and x <= self:GetWide() and y <= self:GetTall()

end

vgui.Register( "ScoreboardTab", TABBASE )
