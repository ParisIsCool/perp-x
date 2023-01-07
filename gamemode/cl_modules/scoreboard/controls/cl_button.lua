--[[   _                                
	( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

--]]

local PANEL = {}

surface.CreateFont( "ScoreboardButton", { font = "Open Sans Condensed", size = 20, weight = 400 } )

function PANEL:Init()

	self.BaseClass.Init( self )
	self:SetFont( "ScoreboardButton" )
	self:FadeOut()

end

function PANEL:Think()

	if self.NoMouseOver then return end

	if self:IsMouseOver() then
		self:FadeIn()
	else
		self:FadeOut()
	end

end

function PANEL:FadeOut()
	self:SetTextColor( Color( 100, 100, 100 ) )
end

function PANEL:FadeIn()
	self:SetTextColor( Color( 255, 255, 255 ) )
end

function PANEL:Paint( w, h )
end

function PANEL:IsMouseOver()

	local x,y = self:CursorPos()
	return x >= 0 and y >= 0 and x <= self:GetWide() and y <= self:GetTall()

end

derma.DefineControl( "DButtonPE", "", PANEL, "DButton" )