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

surface.CreateFont( "CardFont", { font = "Tahoma", size = ScreenScale( 12 ), weight = 800, antialias = true, additive = false } )
surface.CreateFont( "BlackJackFont", { font = "Tahoma", size = ScreenScale( 7 ), weight = 800, antialias = true, additive = false } )
surface.CreateFont( "VeryBigBJFont", { font = "Tahoma", size = ScreenScale( 40 ), weight = 1000, antialias = true, additive = false } )

function PANEL:Init()
	self.CloseButton = vgui.Create( "DButton", self )
	self.CloseButton:SetSize( 100, 32 )
	self.CloseButton:SetText( "Leave Table" )
	
	self.HitButton = vgui.Create( "DButton", self )
	self.HitButton:SetSize( 100, 32 )
	self.HitButton:SetText( "Hit" )
	self.HitButton:SetVisible( false )
	
	self.StandButton = vgui.Create("DButton", self)
	self.StandButton:SetSize( 100, 32 )
	self.StandButton:SetText( "Stand" )
	self.StandButton:SetVisible( false )
	
	self.DealButton = vgui.Create( "DButton", self )
	self.DealButton:SetSize( 100, 32 )
	self.DealButton:SetText( "Deal" )
	self.DealButton:SetVisible( false )
	
	self.ChoseBet = false
	
	function self.CloseButton:DoClick()
		if GAMEMODE.BlackJackWindow.DisplayBet then
			RunConsoleCommand( "perp_bj_q" )
		end
		
		LocalPlayer():ClearForcedEyeAngles()
		GAMEMODE.BlackJackWindow:Remove()
		GAMEMODE.BlackJackWindow = nil
	end
	
	function self.HitButton:DoClick()
		RunConsoleCommand( "perp_bj_h" )
	end
	
	function self.StandButton:DoClick()
		RunConsoleCommand( "perp_bj_s" )
		
		self:SetVisible( false )
		GAMEMODE.BlackJackWindow.HitButton:SetVisible( false )
	end
	
	function self.DealButton:DoClick()
		if LocalPlayer():GetCash() >= GAMEMODE.BlackJackWindow.CurrentBet then
			RunConsoleCommand( "perp_bj_d" )
		else
			LocalPlayer():Notify( "Not enough cash." )
			LocalPlayer():ClearForcedEyeAngles()
			GAMEMODE.BlackJackWindow:Remove()
			GAMEMODE.BlackJackWindow = nil
				
			return false
		end
	end
	
	self.BetSelector_50 = vgui.Create( "DImageButton", self )
	self.BetSelector_50:SetImage( "perp/casino/chip_blue" )
	
	self.BetSelector_250 = vgui.Create( "DImageButton", self )
	self.BetSelector_250:SetImage( "perp/casino/chip_red" )
	
	self.BetSelector_500 = vgui.Create( "DImageButton", self )
	self.BetSelector_500:SetImage( "perp/casino/chip_black" )
	
	self.BetSelector_50:SetSize( 100, 100 )
	self.BetSelector_250:SetSize( 100, 100 )
	self.BetSelector_500:SetSize( 100, 100 )
	
	self.CardsInDeck = 54
	
	function self.BetSelector_50:DoClick()
		if LocalPlayer():GetCash() >= 50 then
			GAMEMODE.BlackJackWindow.CurrentBet = 50
			RunConsoleCommand( "perp_bj_d", "50" )
		else
			LocalPlayer():Notify( "Not enough cash." )
			return false
		end
	
		GAMEMODE.BlackJackWindow.DisplayBet = surface.GetTextureID( "perp/casino/chip_blue" )
		GAMEMODE.BlackJackWindow.DisplayStartPos_X, GAMEMODE.BlackJackWindow.DisplayStartPos_Y = self:GetPos()
		GAMEMODE.BlackJackWindow.BetPopTime = CurTime()
				
		GAMEMODE.BlackJackWindow.BetSelector_250:Remove()
		GAMEMODE.BlackJackWindow.BetSelector_50:Remove()
		GAMEMODE.BlackJackWindow.BetSelector_500:Remove()
	end
	
	function self.BetSelector_250:DoClick()
		if LocalPlayer():GetCash() >= 250 then
			GAMEMODE.BlackJackWindow.CurrentBet = 250
			RunConsoleCommand( "perp_bj_d", "250" )
		else
			LocalPlayer():Notify( "Not enough cash." )
			return false
		end
	
		GAMEMODE.BlackJackWindow.DisplayBet = surface.GetTextureID( "perp/casino/chip_red" )
		GAMEMODE.BlackJackWindow.DisplayStartPos_X, GAMEMODE.BlackJackWindow.DisplayStartPos_Y = self:GetPos()		
		GAMEMODE.BlackJackWindow.BetPopTime = CurTime()
		
		GAMEMODE.BlackJackWindow.BetSelector_500:Remove()
		GAMEMODE.BlackJackWindow.BetSelector_50:Remove()
		GAMEMODE.BlackJackWindow.BetSelector_250:Remove()
	end
	
	function self.BetSelector_500:DoClick()
		if LocalPlayer():GetCash() >= 500 then
			GAMEMODE.BlackJackWindow.CurrentBet = 500
			RunConsoleCommand( "perp_bj_d", "500" )
		else
			LocalPlayer():Notify( "Not enough cash." )
			return false
		end
	
		GAMEMODE.BlackJackWindow.DisplayBet = surface.GetTextureID( "perp/casino/chip_black" )
		GAMEMODE.BlackJackWindow.DisplayStartPos_X, GAMEMODE.BlackJackWindow.DisplayStartPos_Y = self:GetPos()
		GAMEMODE.BlackJackWindow.BetPopTime = CurTime()
		
		GAMEMODE.BlackJackWindow.BetSelector_500:Remove()
		GAMEMODE.BlackJackWindow.BetSelector_250:Remove()
		GAMEMODE.BlackJackWindow.BetSelector_50:Remove()
	end
	
	self:MakePopup()
end

function PANEL:PerformLayout()
	self.CardSize_W, self.CardSize_H = ScrW() * .08, ScrW() * .08 * 1.4
	
	self:SetSize( self.CardSize_W * 5 + 70 + self.CloseButton:GetWide(), ScrH() * .5 )
	self:SetPos( ScrW() * .25, ScrH() * .25 )

	local ButtonPadding = 10
	local ButtonSpacing = 4

	self.CloseButton:SetPos( self:GetWide() - ButtonPadding - self.CloseButton:GetWide(), self:GetTall() - ButtonPadding - self.CloseButton:GetTall() )
	self.DealButton:SetPos( self:GetWide() - ButtonPadding - self.CloseButton:GetWide(), self:GetTall() - ButtonPadding - ButtonSpacing - self.CloseButton:GetTall() * 2 )
	self.StandButton:SetPos( self:GetWide() - ButtonPadding - self.CloseButton:GetWide(), self:GetTall() - ButtonPadding - ButtonSpacing - self.CloseButton:GetTall() * 2 )
	self.HitButton:SetPos( self:GetWide() - ButtonPadding - self.CloseButton:GetWide(), self:GetTall() - ButtonPadding - ButtonSpacing * 2 - self.CloseButton:GetTall() * 3 )
	
	if IsValid( self.BetSelector_50 ) then
		self.BetSelector_50:SetPos( self:GetWide() * .3 - 50, self:GetTall() * .5 - 50 )
		self.BetSelector_250:SetPos( self:GetWide() * .5 - 50, self:GetTall() * .5 - 50 )
		self.BetSelector_500:SetPos( self:GetWide() * .7 - 50, self:GetTall() * .5 - 50 )
	end
end

function PANEL:Paint( w, h )
	draw.RoundedBox( 12, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 255 ) )
	draw.RoundedBox( 12, 2, 2,self:GetWide() - 4, self:GetTall() - 4, Color( 255, 255, 255, 255 ) )
	
	if self.DisplayBet then
		local Bet_Size = 100
		local BetDispZone_X, BetDispZone_Y = self:GetWide() - Bet_Size - 10, 10
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetTexture( self.DisplayBet )
		
		if self.BetPopTime then
			local Percent = math.Clamp( 1 - ( ( self.BetPopTime + .15 - CurTime() ) / .15 ), 0, 1 )
			
			local Difference_X = BetDispZone_X - self.DisplayStartPos_X
			local Difference_Y = self.DisplayStartPos_Y - BetDispZone_Y
				
			surface.DrawTexturedRect( self.DisplayStartPos_X + ( Difference_X * Percent ), self.DisplayStartPos_Y - ( Difference_Y * Percent ), Bet_Size, Bet_Size )
			
			if Percent >= 1 then
				self.BetPopTime = nil
				self.DisplayStartPos_X = nil
				self.DisplayStartPos_Y = nil
				
				self.StandButton:SetVisible( true )
				self.HitButton:SetVisible( true )
			end
		else
			surface.DrawTexturedRect( BetDispZone_X, BetDispZone_Y, Bet_Size, Bet_Size )
			
			draw.SimpleText( "Cards In Deck: " .. ( self.CardsInDeck or 0 ), "BlackJackFont", self:GetWide() - 82, 120, Color( 0, 0, 0, 100 ), 1, 1 )
			draw.SimpleText( "Your Count: " .. ( self.PlayerCount or 0 ), "BlackJackFont", self:GetWide() - 72, 135, Color( 0, 0, 0, 100 ), 1, 1 )
			draw.SimpleText( "Dealer's Count: " .. ( self.DealerCount or 0 ), "BlackJackFont", self:GetWide() - 82, 150, Color( 0, 0, 0, 100 ), 1, 1 )
			
			if self.MiddleText then
				draw.SimpleText( self.MiddleText, "BlackJackFont", self:GetWide() * .5, self:GetTall() * .5, Color(0, 0, 0, 100), 1, 1)
			end
		end
	else
		draw.SimpleText( "Select Your Bet", "VeryBigBJFont", w * .5, self:GetTall() * .25, Color( 0, 0, 0, 100 ), 1, 1 )
		draw.SimpleText( "$50", "CardFont", self:GetWide() * .3, self:GetTall() * .5 + 75, Color( 0, 0, 0, 100 ), 1, 1 )
		draw.SimpleText( "$250", "CardFont", self:GetWide() * .5, self:GetTall() * .5 + 75, Color( 0, 0, 0, 100 ), 1, 1 )
		draw.SimpleText( "$500", "CardFont", self:GetWide() * .7, self:GetTall() * .5 + 75, Color( 0, 0, 0, 100 ), 1, 1 )
	end
end

function PANEL:AddCard_Player( Type, Value )
	local NewCard = vgui.Create( "perp_card", self )
	NewCard:SetupCard( Type, Value )
	NewCard:SetPos( self:GetWide(), self:GetTall() - self.CardSize_H - 10 )
	NewCard:SetTargetX( 10 + ( self.NumCards_Player * ( self.CardSize_W + 10 ) ) )
	self.NumCards_Player = self.NumCards_Player + 1
	NewCard.OwnedByPlayer = true
	
	table.insert( self.Cards, NewCard )
	
	self.PlayerCount = 0
	self.PlayerNumCards = 0
	
	for _, v in pairs( self.Cards ) do
		if v.OwnedByPlayer and v.Value ~= CARD_ACE then
			self.PlayerNumCards = self.PlayerNumCards + 1
			self.PlayerCount = self.PlayerCount + GAMEMODE.CardValues[ v.Value ]
		end
	end
	
	for _, v in pairs( self.Cards ) do
		if v.OwnedByPlayer and v.Value == CARD_ACE then
			self.PlayerNumCards = self.PlayerNumCards + 1
			
			if self.PlayerCount + 11 > 21 then
				self.PlayerCount = self.PlayerCount + 1
			else
				self.PlayerCount = self.PlayerCount + 11
			end
		end
	end
end

function PANEL:AddCard_Dealer( Type, Value, FaceDown )
	local NewCard = vgui.Create( "perp_card", self )
	NewCard:SetupCard( Type, Value, FaceDown )
	NewCard:SetPos( self:GetWide(), 10 )
	NewCard:SetTargetX( 10 + ( self.NumCards_Dealer * ( self.CardSize_W + 10 ) ) )
	self.NumCards_Dealer = self.NumCards_Dealer + 1
	
	table.insert( self.Cards, NewCard )
	
	self:RecalcDealerCounts()
end

function PANEL:RecalcDealerCounts()
	self.DealerCount = 0
	self.DealerNumCards = 0
	
	for _, v in pairs( self.Cards ) do
		if not v.OwnedByPlayer and v.Value ~= CARD_ACE and not v.FaceDown then
			self.DealerNumCards = self.DealerNumCards + 1
			self.DealerCount = self.DealerCount + GAMEMODE.CardValues[ v.Value ]
		end
	end
	
	for _, v in pairs( self.Cards ) do
		if not v.OwnedByPlayer and v.Value == CARD_ACE and not v.FaceDown then
			self.DealerNumCards = self.DealerNumCards + 1
			
			if self.DealerCount + 11 > 21 then
				self.DealerCount = self.DealerCount + 1
			else
				self.DealerCount = self.DealerCount + 11
			end
		end
	end
end

local function BlackJack_CheckPlayerVictory()
	if GAMEMODE.BlackJackWindow.PlayerCount == 21 then
		GAMEMODE.BlackJackWindow.MiddleText = "You have 21!"
		
		GAMEMODE.BlackJackWindow.StandButton:SetVisible(false)
		GAMEMODE.BlackJackWindow.HitButton:SetVisible(false)
		GAMEMODE.BlackJackWindow.DealButton:SetVisible(true)
	elseif GAMEMODE.BlackJackWindow.PlayerCount > 21 then
		GAMEMODE.BlackJackWindow.MiddleText = "You busted!"

		GAMEMODE.BlackJackWindow.StandButton:SetVisible(false)
		GAMEMODE.BlackJackWindow.HitButton:SetVisible(false)
		GAMEMODE.BlackJackWindow.DealButton:SetVisible(true)
	elseif GAMEMODE.BlackJackWindow.PlayerNumCards == 5 then
		GAMEMODE.BlackJackWindow.MiddleText = "You have Five Card Charlie!"
		
		GAMEMODE.BlackJackWindow.StandButton:SetVisible(false)
		GAMEMODE.BlackJackWindow.HitButton:SetVisible(false)
		GAMEMODE.BlackJackWindow.DealButton:SetVisible(true)
	end
end

local function BlackJack_CheckDealerVictory()
	if GAMEMODE.BlackJackWindow.DealerCount == 21 then
		if GAMEMODE.BlackJackWindow.PlayerCount == 21 then
			GAMEMODE.BlackJackWindow.MiddleText = "Push!"
		else
			GAMEMODE.BlackJackWindow.MiddleText = "Dealer got 21!"
		end
		
		GAMEMODE.BlackJackWindow.DealButton:SetVisible(true)
	elseif GAMEMODE.BlackJackWindow.DealerCount > 21 then
		if GAMEMODE.BlackJackWindow.PlayerCount > 21 then
			GAMEMODE.BlackJackWindow.MiddleText = "Push!"
		else
			GAMEMODE.BlackJackWindow.MiddleText = "Dealer busted!"
		end
		
		GAMEMODE.BlackJackWindow.DealButton:SetVisible(true)
	elseif GAMEMODE.BlackJackWindow.DealerNumCards == 5 then
		if GAMEMODE.BlackJackWindow.PlayerNumCards == 5 then
			if GAMEMODE.BlackJackWindow.PlayerCount > GAMEMODE.BlackJackWindow.DealerCount then
				GAMEMODE.BlackJackWindow.MiddleText = "You win!"
			elseif GAMEMODE.BlackJackWindow.PlayerCount == GAMEMODE.BlackJackWindow.DealerCount then	
				GAMEMODE.BlackJackWindow.MiddleText = "Push!"
			else
				GAMEMODE.BlackJackWindow.MiddleText = "You lose!"
			end
		else
			GAMEMODE.BlackJackWindow.MiddleText = "Dealer got Five Card Charlie!"
		end
		
		GAMEMODE.BlackJackWindow.DealButton:SetVisible(true)
	elseif GAMEMODE.BlackJackWindow.DealerCount >= 17 then
		if GAMEMODE.BlackJackWindow.PlayerCount > GAMEMODE.BlackJackWindow.DealerCount then
			GAMEMODE.BlackJackWindow.MiddleText = "Dealer stood. You win!"
		elseif GAMEMODE.BlackJackWindow.PlayerCount == GAMEMODE.BlackJackWindow.DealerCount then	
			GAMEMODE.BlackJackWindow.MiddleText = "Dealer stood. Push!"
		else
			GAMEMODE.BlackJackWindow.MiddleText = "Dealer stood. You lose!"
		end
		
		GAMEMODE.BlackJackWindow.DealButton:SetVisible(true)
	end
end


usermessage.Hook( "perp_bj_deal", function( UMsg )
	if not IsValid( GAMEMODE.BlackJackWindow ) then return end

	local CardOne_Type, CardOne_Value, CardTwo_Type, CardTwo_Value, CardThree_Type, CardThree_Value, CardFour_Type, CardFour_Value = UMsg:ReadShort(), UMsg:ReadShort(), UMsg:ReadShort(), UMsg:ReadShort(), UMsg:ReadShort(), UMsg:ReadShort(), UMsg:ReadShort(), UMsg:ReadShort()
	
	if GAMEMODE.BlackJackWindow.CardsInDeck <= 10 then GAMEMODE.BlackJackWindow.CardsInDeck = 54 end
	GAMEMODE.BlackJackWindow.CardsInDeck = GAMEMODE.BlackJackWindow.CardsInDeck - 4
	
	GAMEMODE.BlackJackWindow.NumCards_Player = 0
	GAMEMODE.BlackJackWindow.NumCards_Dealer = 0
	
	GAMEMODE.BlackJackWindow.MiddleText = nil
	
	GAMEMODE.BlackJackWindow.DealButton:SetVisible( false )
	GAMEMODE.BlackJackWindow.StandButton:SetVisible( true )
	GAMEMODE.BlackJackWindow.HitButton:SetVisible( true )
	
	GAMEMODE.BlackJackWindow.Cards = GAMEMODE.BlackJackWindow.Cards or {}

	for k, v in pairs( GAMEMODE.BlackJackWindow.Cards ) do
		v:Remove()
		GAMEMODE.BlackJackWindow.Cards[ k ] = nil
	end
	
	GAMEMODE.BlackJackWindow.Cards = {}
	
	GAMEMODE.BlackJackWindow:AddCard_Player( CardOne_Type, CardOne_Value )
	GAMEMODE.BlackJackWindow:AddCard_Player( CardTwo_Type, CardTwo_Value )
	GAMEMODE.BlackJackWindow:AddCard_Dealer( CardThree_Type, CardThree_Value )
	GAMEMODE.BlackJackWindow:AddCard_Dealer( CardFour_Type, CardFour_Value, true )
	
	BlackJack_CheckPlayerVictory()
end )

usermessage.Hook( "perp_bj_hit", function( UMsg )
	if not IsValid( GAMEMODE.BlackJackWindow ) then return end

	local CardOne_Type, CardOne_Value = UMsg:ReadShort(), UMsg:ReadShort()
	
	GAMEMODE.BlackJackWindow:AddCard_Player( CardOne_Type, CardOne_Value )
	
	BlackJack_CheckPlayerVictory()
	
	GAMEMODE.BlackJackWindow.CardsInDeck = GAMEMODE.BlackJackWindow.CardsInDeck - 1
end )

usermessage.Hook( "perp_bj_fd", function()
	if not IsValid( GAMEMODE.BlackJackWindow ) then return end
	
	local DealerCardNum = 0
	
	for _, v in pairs( GAMEMODE.BlackJackWindow.Cards ) do
		if not v.OwnedByPlayer then
			DealerCardNum = DealerCardNum + 1
			
			if DealerCardNum == 2 then
				v:Flip( false )
				
				break
			end
		end
	end
	
	GAMEMODE.BlackJackWindow:RecalcDealerCounts()
	
	BlackJack_CheckDealerVictory()
end )

usermessage.Hook( "perp_bj_hit_dealer", function( UMsg )
	if not IsValid( GAMEMODE.BlackJackWindow ) then return end

	GAMEMODE.BlackJackWindow:AddCard_Dealer( UMsg:ReadShort(), UMsg:ReadShort() )
	GAMEMODE.BlackJackWindow.CardsInDeck = GAMEMODE.BlackJackWindow.CardsInDeck - 1
	
	BlackJack_CheckDealerVictory()
end )

vgui.Register( "perp_blackjack", PANEL )