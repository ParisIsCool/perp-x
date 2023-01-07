--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function PLAYER:TradeWith( otherPlayer )
	if not IsValid( otherPlayer ) then return end
	
	if IsValid( otherPlayer.CurrentlyTrading ) then
		return self:Notify( "That player is already trading. Please wait until he is finished." )
	end
	
	if IsValid( self.CurrentlyTrading ) then
		return self:Notify( "You are already trading." )
	end
	
	if otherPlayer.TradeOffer == self then
		-- He wants to trade too lets do it!
		umsg.Start( "perp_t_s", self ) 
			umsg.Entity( otherPlayer )
		umsg.End()
		
		umsg.Start( "perp_t_s", otherPlayer ) 
			umsg.Entity( self )
		umsg.End()
		
		self.CurrentlyTrading 			= otherPlayer
		otherPlayer.CurrentlyTrading 	= self
		
		self.Trade_Offer 				= {}
		otherPlayer.Trade_Offer 		= {}
		
		self.Trade_CashOffer 			= 0
		otherPlayer.Trade_CashOffer 	= 0
		
		otherPlayer.nextTradeStart 		= nil
		otherPlayer.TradeOffer 			= nil
		
		otherPlayer.Trade_Accepted 		= nil
		self.Trade_Accepted 			= nil
	else
		if self.nextTradeStart and CurTime() < self.nextTradeStart then
			return self:Notify( "You must wait another " .. math.ceil( self.nextTradeStart - CurTime() ) .. " seconds before you can trade again." )
		end
		
		self.TradeOffer = otherPlayer
		self.nextTradeStart = CurTime() + 30
		
		otherPlayer:Notify( self:GetRPName() .. " would like to trade. Look at him at press F4 to accept." )
		self:Notify( "Trade request sent." )
	end
end

concommand.Add( "perp_t_ot", function( Player, Command, Args )
	if not IsValid( Player.CurrentlyTrading ) then return end
	if not Args[1] then return end
	
	local slotID = tonumber( Args[1] )
	
	if not Player.PlayerItems[ slotID ] then return end

	local Item = ITEM_DATABASE[ Player.PlayerItems[ slotID ].ID ]
	if Item.RestrictTrading then return Player:CaughtCheating( "Tried to trade restricted item: " .. Item.Name ) end

	local kID, kQuantity
	for k, v in pairs( Player.Trade_Offer ) do
		if slotID == v then
			kID = k
		end
	end

	local Item = Player.PlayerItems[ slotID ]

	local kID
	for k, v in pairs( Player.Trade_Offer ) do
		if v == slotID then
			kID = k
		end
	end
		
	if kID then
		-- Tell the other person we've retracted this offer.
		Player.Trade_Offer[ kID ] = nil
		
		umsg.Start( "perp_t_r", Player.CurrentlyTrading )
			umsg.Short( Item.ID ) -- ITEM ID
			umsg.Short( Item.Quantity ) -- ITEM QUANTITY
		umsg.End()
	else
		-- Tell the other person we've sent this offer.
		for i = 1, table.Count( Player.Trade_Offer ) + 1 do
			if not Player.Trade_Offer[ i ] then
				Player.Trade_Offer[ i ] = slotID
			end
		end
		
		umsg.Start( "perp_t_a", Player.CurrentlyTrading )
			umsg.Short( Item.ID ) -- ITEM ID
			umsg.Short( Item.Quantity ) -- ITEM QUANTITY
		umsg.End()
	end
	
	Player.Trade_Accepted = nil
	Player.CurrentlyTrading.Trade_Accepted = nil
end )

concommand.Add( "perp_t_d", function( Player, Command, Args )
	if not IsValid( Player.CurrentlyTrading ) then return end
	if not Args[1] then return end
	
	local cash = tonumber( math.Clamp( tonumber( Args[1] ), 0, Player:GetCash() ) ) or 0
	Player.Trade_CashOffer = cash
	
	umsg.Start( "perp_t_d", Player.CurrentlyTrading )
		umsg.Long( cash )
	umsg.End()
	
	Player.Trade_Accepted = nil
	Player.CurrentlyTrading.Trade_Accepted = nil
end )

concommand.Add( "perp_t_c", function( Player )
	if not IsValid( Player.CurrentlyTrading ) then return end

	umsg.Start( "perp_t_c", Player.CurrentlyTrading ) umsg.End()
	
	Player.CurrentlyTrading.CurrentlyTrading = nil
	Player.CurrentlyTrading.Trade_Offer = nil
	Player.CurrentlyTrading.Trade_CashOffer = nil
	
	Player.CurrentlyTrading = nil
	Player.Trade_Offer = nil
	Player.Trade_CashOffer = nil
end )

concommand.Add( "perp_t_ag", function( Player )
	if not IsValid( Player.CurrentlyTrading ) then return end

	local CurrentlyTrading = Player.CurrentlyTrading
	local CTTradeOffer = CurrentlyTrading.Trade_Offer
	local CTTradeCashOffer = CurrentlyTrading.Trade_CashOffer

	local TradeOffer = Player.Trade_Offer
	local TradeCashOffer = Player.Trade_CashOffer

	umsg.Start( "perp_t_ag", CurrentlyTrading ) umsg.End()

	Player.Trade_Accepted = true
	
	if CurrentlyTrading.Trade_Accepted then
		Player.CurrentlyTrading.CurrentlyTrading = nil
		Player.CurrentlyTrading.Trade_Offer = nil
		Player.CurrentlyTrading.Trade_CashOffer = nil

		Player.CurrentlyTrading.Trade_Accepted = nil
		Player.Trade_Accepted = nil
		
		Player.CurrentlyTrading = nil
		Player.Trade_Offer = nil
		Player.Trade_CashOffer = nil

		local freeSpotsRequired_Them = table.Count( TradeOffer )
		local freeSpotsRequired_Us = table.Count( CTTradeOffer )
		
		-- Make sure we have enough room.
		if ( ( INVENTORY_HEIGHT * INVENTORY_WIDTH ) - table.Count( CurrentlyTrading.PlayerItems ) ) < ( freeSpotsRequired_Them - freeSpotsRequired_Us ) then
			Player:Notify( CurrentlyTrading:GetRPName() .. " does not have enough free inventory room." )
			CurrentlyTrading:Notify( "You do not have enough free inventory room." )
			
			umsg.Start( "perp_t_c", Player ) umsg.End()
			umsg.Start( "perp_t_c", CurrentlyTrading ) umsg.End()
			
			return
		end
		
		if ( ( INVENTORY_HEIGHT * INVENTORY_WIDTH ) - table.Count( Player.PlayerItems ) ) < ( freeSpotsRequired_Us - freeSpotsRequired_Them ) then
			CurrentlyTrading:Notify( Player:GetRPName() .. " does not have enough free inventory room." )
			Player:Notify( "You do not have enough free inventory room." )
			
			umsg.Start( "perp_t_c", Player ) umsg.End()
			umsg.Start( "perp_t_c", CurrentlyTrading ) umsg.End()
			
			return
		end

		if CTTradeCashOffer > 0 and ( CTTradeCashOffer > MAX_CASH or Player:GetCash() + CTTradeCashOffer > MAX_CASH ) then
			CurrentlyTrading:Notify( Player:GetRPName() .. " can't carry that much money" )
			Player:Notify( "You cant carry anymore money, you need to put your money into an ATM" )

			umsg.Start( "perp_t_c", Player ) umsg.End()
			umsg.Start( "perp_t_c", CurrentlyTrading ) umsg.End()

			return
		end

		if TradeCashOffer > 0 and ( TradeCashOffer > MAX_CASH or CurrentlyTrading:GetCash() + TradeCashOffer > MAX_CASH ) then
			CurrentlyTrading:Notify( "You can't carry anymore money, you need to put your money into an ATM" )
			Player:Notify( CurrentlyTrading:GetRPName() .. " can't carry that much money" )

			umsg.Start( "perp_t_c", Player ) umsg.End()
			umsg.Start( "perp_t_c", CurrentlyTrading ) umsg.End()

			return
		end
		
		-- Everything appears to be OK. Let's move on. The client's handle all this on their own. Yay prediction!

		-- Cash
		if tonumber( TradeCashOffer ) > 0 then
			local col = Color( 0, 255, 0 )
			if TradeCashOffer >= 50000 then col = Color( 255, 165, 0 ) end
			Log( Format( "%s has given %s $%s through trade", Player:Nick(), CurrentlyTrading:Nick(), util.FormatNumber( TradeCashOffer ) ), col )
			local Log = Format( "%s was given $%s through trade by %s<%s>", CurrentlyTrading:Nick(), util.FormatNumber( TradeCashOffer ), Player:GetRPName(), Player:SteamID() )
			GAMEMODE:Log( "cashlog", Log, CurrentlyTrading:SteamID() )

			local Log = Format( "%s has given $%s through trade by %s<%s>", Player:Nick(), util.FormatNumber( TradeCashOffer ), CurrentlyTrading:GetRPName(), CurrentlyTrading:SteamID() )
			GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

			Player:TakeCash( TradeCashOffer, true )
			CurrentlyTrading:GiveCash( TradeCashOffer, true )
		end

		if tonumber( CTTradeCashOffer ) > 0 then
			local col = Color( 0, 255, 0 )
			if CTTradeCashOffer >= 50000 then col = Color( 255, 165, 0 ) end
			Log( Format( "%s has given %s $%s through trade", CurrentlyTrading:Nick(), Player:Nick(), util.FormatNumber( CTTradeCashOffer ) ), col )

			local Log = Format( "%s was given $%s through trade by %s<%s>", Player:Nick(), util.FormatNumber( TradeCashOffer ), CurrentlyTrading:GetRPName(), CurrentlyTrading:SteamID() )
			GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

			local Log = Format( "%s has given $%s through trade by %s<%s>", CurrentlyTrading:Nick(), util.FormatNumber( TradeCashOffer ), Player:GetRPName(), Player:SteamID() )
			GAMEMODE:Log( "cashlog", Log, CurrentlyTrading:SteamID() )

			CurrentlyTrading:TakeCash( CTTradeCashOffer, true )
			Player:GiveCash( CTTradeCashOffer, true )
		end

		-- Taking items
		local GivePlayer1 = {}
		for _, v in pairs( TradeOffer ) do
			local Item = Player.PlayerItems[ v ]
			if not Item then continue end

			Player.PlayerItems[ v ] = nil -- Take the item(s)

			table.insert( GivePlayer1, { Item.ID, Item.Quantity } ) -- Store the item to give later
		end

		local GivePlayer2 = {}
		for _, v in pairs( CTTradeOffer ) do
			local Item = CurrentlyTrading.PlayerItems[ v ]
			if not Item then continue end

			CurrentlyTrading.PlayerItems[ v ] = nil -- Take the item(s)

			table.insert( GivePlayer2, { Item.ID, Item.Quantity } ) -- Store the item to give later
		end

		-- Giving items
		for _, v in pairs( GivePlayer1 ) do
			CurrentlyTrading:GiveItem( v[1], v[2] ) -- Give the item(s)
		end

		for _, v in pairs( GivePlayer2 ) do
			Player:GiveItem( v[1], v[2] ) -- Give the item(s)
		end

		GAMEMODE:LogToAdmins("Trades",{
			text = CurrentlyTrading:GetRPName() .. " ["..CurrentlyTrading:SteamID().."] traded with " .. Player:GetRPName() .. " ["..Player:SteamID().."]",
			position = Player:GetPos(),
			player1 = CurrentlyTrading:SteamID(),
			player2 = Player:SteamID(),
			itemsto1 = GivePlayer1,
			itemsto2 = GivePlayer2,
			cashto1 = TradeCashOffer,
			cashto2 = CTTradeCashOffer,
			location = Player:GetZoneName(),
		})

		Player:PERPSave()
		CurrentlyTrading:PERPSave()
	end
end )