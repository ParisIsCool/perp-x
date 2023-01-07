--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

usermessage.Hook( "perp_t_s", function( UMsg )
	if IsValid( GAMEMODE.TradingWith ) then
		Msg( "Already trading but got UMsg informing start of trade.\n" )
		GAMEMODE.CancelTrade()
	end
	
	local tW = UMsg:ReadEntity()
	
	if not IsValid( tW ) then return end
	
	GAMEMODE.TradingWith = tW
	
	GAMEMODE.TradeScreen = vgui.Create( "perp2_trade" )
	
	GAMEMODE.TheirOffer_Cash = 0
	GAMEMODE.TheirOffer_Items = {}
	GAMEMODE.OurOffer_Items = {}
	GAMEMODE.OurOffer_Cash = 0
	
	GAMEMODE.Trade_WeAccepted = nil
	GAMEMODE.Trade_TheyAccepted = nil
end )

usermessage.Hook( "perp_t_d", function( UMsg )
	if not GAMEMODE.TradingWith or not GAMEMODE.TradeScreen:IsValid() then
		return Msg( "Offer cash offer but not trading.\n" )
	end

	GAMEMODE.TheirOffer_Cash = UMsg:ReadLong()
	
	GAMEMODE.TradeScreen.cashBox.theirCashOffer:SetText( GAMEMODE.TheirOffer_Cash )
	
	GAMEMODE.Trade_WeAccepted = nil
	GAMEMODE.Trade_TheyAccepted = nil
end )

usermessage.Hook( "perp_t_a", function( UMsg )
	if not GAMEMODE.TradingWith or not GAMEMODE.TradeScreen:IsValid() then
		return Msg( "Offer incoming but not trading.\n" )
	end

	local itemID = UMsg:ReadShort()
	local itemQuantity = UMsg:ReadShort()
	
	local newTable = {}
	newTable.ID = itemID
	newTable.Quantity = itemQuantity

	for i = 1, 15 do
		if not GAMEMODE.TheirOffer_Items[ i ] then
			GAMEMODE.TheirOffer_Items[ i ] = newTable
			GAMEMODE.TradeScreen.theirOffer.InventoryBlocks[ i ]:GrabItem()

			break
		end
	end

	GAMEMODE.Trade_WeAccepted = nil
	GAMEMODE.Trade_TheyAccepted = nil
end )

usermessage.Hook( "perp_t_r", function( UMsg )
	if not GAMEMODE.TradingWith or not GAMEMODE.TradeScreen:IsValid() then
		return Msg( "Offer removal but not trading.\n" )
	end
	
	local itemID = UMsg:ReadShort()
	local itemQuantity = UMsg:ReadShort()
	
	GAMEMODE.Trade_WeAccepted = nil
	GAMEMODE.Trade_TheyAccepted = nil

	for k, v in pairs( GAMEMODE.TheirOffer_Items ) do
		if v.ID == itemID and v.Quantity == itemQuantity then
			GAMEMODE.TheirOffer_Items[ k ] = nil

			if GAMEMODE.TradeScreen.theirOffer.InventoryBlocks[ k ] then
				GAMEMODE.TradeScreen.theirOffer.InventoryBlocks[ k ]:GrabItem()
			end
			
			return
		end
	end
end )

usermessage.Hook( "perp_t_c", function()
	if not GAMEMODE.TradingWith or not GAMEMODE.TradeScreen:IsValid() then
		return Msg( "Got cancel trade command but not trading.\n" )
	end

	GAMEMODE.CancelTrade()
end )

usermessage.Hook( "perp_t_ag", function()
	if not GAMEMODE.TradingWith or not GAMEMODE.TradeScreen:IsValid() then
		return Msg( "Got they accepted command but not trading.\n" )
	end
	
	GAMEMODE.Trade_TheyAccepted = true
	
	if GAMEMODE.Trade_WeAccepted then
		GAMEMODE.FinishTrade()
	end
end )

function GM.CancelTrade()
	GAMEMODE.TradingWith = nil
	GAMEMODE.TheirOffer_Cash = nil
	GAMEMODE.TheirOffer_Items = nil
	GAMEMODE.OurOffer_Items = nil
	GAMEMODE.OurOffer_Cash = nil
	
	LocalPlayer():Notify( "Trade canceled." )
	
	RunConsoleCommand( "perp_t_c" )
	
	if GAMEMODE.TradeScreen then GAMEMODE.TradeScreen:Remove() GAMEMODE.TradeScreen = nil end
end

function GM.FinishTrade()
	for _, v in pairs( GAMEMODE.OurOffer_Items ) do
		GAMEMODE.PlayerItems[ v ] = nil
		GAMEMODE.InventoryBlocks_Linear[ v ]:GrabItem()
	end

	GAMEMODE.TradingWith = nil
	GAMEMODE.TheirOffer_Cash = nil
	GAMEMODE.TheirOffer_Items = nil
	GAMEMODE.OurOffer_Items = nil
	GAMEMODE.OurOffer_Cash = nil

	if GAMEMODE.TradeScreen then GAMEMODE.TradeScreen:Remove() GAMEMODE.TradeScreen = nil end

	LocalPlayer():Notify( "Trade completed successfully." )
end