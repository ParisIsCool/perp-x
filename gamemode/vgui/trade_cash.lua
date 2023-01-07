--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local PANEL = {}

function PANEL:Init()
	self.lastSendCash = 0

	self.theirCashOffer = vgui.Create( "DTextEntry", self )
		self.theirCashOffer:SetNumeric( true )
		self.theirCashOffer:SetEditable( false )
		self.theirCashOffer:SetText( "0" )

	self.ourCashOffers = vgui.Create( "DTextEntry", self )
		self.ourCashOffers:SetNumeric( true )
		self.ourCashOffers:SetText( "0" )	
	
	self:MakePopup()
	self:ShowCloseButton( false )
	self:SetTitle( "" )
	self:SetDraggable( false )
end

function PANEL:PerformLayout()	
	local bufferSize = 5
	
	local spaceAllotedPer = ( self:GetWide() - ( bufferSize * 4 ) ) / 3
	
	local x, y = self:GetPos()
	self.ourCashOffers:SetPos( bufferSize * 2 + spaceAllotedPer * 1.5, bufferSize * 1.5 )
	self.ourCashOffers:SetSize( spaceAllotedPer * .5 - bufferSize, self:GetTall() - bufferSize * 3 )
	
	self.theirCashOffer:SetPos( bufferSize * 3 + spaceAllotedPer * 2.5, bufferSize * 1.5 )
	self.theirCashOffer:SetSize( spaceAllotedPer * .5 - bufferSize, self:GetTall() - bufferSize * 3 )
end

function PANEL:Paint( w, h )
	SKIN:PaintFrame( self, w, h )
	
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 4, 4, self:GetWide() - 8, self:GetTall() - 8 )
	
	surface.SetDrawColor( 54, 54, 54, 255 )
	surface.DrawRect( 5, 5, self:GetWide() - 10, self:GetTall() - 10 )

	draw.SimpleText( "Trading With: " .. GAMEMODE.TradingWith:GetRPName(), "DefaultSmall", 10, self:GetTall() * .5, Color( 255, 255, 255, 255 ), 0, 1 )
	
	local spaceAllotedPer = ( self:GetWide() - 20 ) / 3
	
	draw.SimpleText( "Your Cash Offer: ", "DefaultSmall", 5 + spaceAllotedPer * 1.5, self:GetTall() * .5, Color( 255, 255, 255, 255 ), 2, 1 )
	draw.SimpleText( "Their Cash Offer: ", "DefaultSmall", 10 + spaceAllotedPer * 2.5, self:GetTall() * .5, Color( 255, 255, 255, 255 ), 2, 1 )
	
	local ourVal = tonumber( self.ourCashOffers:GetValue() or 0 ) or 0
	if ourVal > LocalPlayer():GetCash() or ourVal > MAX_CASH then
		self.ourCashOffers:SetTextColor( Color( 255, 0, 0, 255 ) )
	elseif ourVal < 0 then
		self.ourCashOffers:SetTextColor( Color( 255, 0, 0, 255 ) )
	elseif math.ceil( ourVal ) ~= math.floor( ourVal ) then
		self.ourCashOffers:SetTextColor( Color( 255, 0, 0, 255 ) )
	elseif not self.lastSendCash or self.lastSendCash ~= ourVal then
		self.lastSendCash = ourVal
		GAMEMODE.OurOffer_Cash = ourVal
		RunConsoleCommand( "perp_t_d", ourVal )
		
		GAMEMODE.Trade_WeAccepted 		= nil
		GAMEMODE.Trade_TheyAccepted 	= nil
	
		self.ourCashOffers:SetTextColor( Color( 0, 0, 0, 255 ) )
	else
		self.ourCashOffers:SetTextColor( Color( 0, 0, 0, 255 ) )
	end
end

vgui.Register( "perp2_trade_cash", PANEL, "DFrame" )