--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local DefaultDeck = {
				'd_a',
				'd_2',
				'd_3',
				'd_4',
				'd_5',
				'd_6',
				'd_7',
				'd_8',
				'd_9',
				'd_10',
				'd_j',
				'd_q',
				'd_k',
				
				'h_a',
				'h_2',
				'h_3',
				'h_4',
				'h_5',
				'h_6',
				'h_7',
				'h_8',
				'h_9',
				'h_10',
				'h_j',
				'h_q',
				'h_k',
				
				'c_a',
				'c_2',
				'c_3',
				'c_4',
				'c_5',
				'c_6',
				'c_7',
				'c_8',
				'c_9',
				'c_10',
				'c_j',
				'c_q',
				'c_k',

				's_a',
				's_2',
				's_3',
				's_4',
				's_5',
				's_6',
				's_7',
				's_8',
				's_9',
				's_10',
				's_j',
				's_q',
				's_k',
			}
			
local ConvertTables = {}
ConvertTables[ "a" ] = CARD_ACE
ConvertTables[ "2" ] = CARD_2
ConvertTables[ "3" ] = CARD_3
ConvertTables[ "4" ] = CARD_4
ConvertTables[ "5" ] = CARD_5
ConvertTables[ "6" ] = CARD_6
ConvertTables[ "7" ] = CARD_7
ConvertTables[ "8" ] = CARD_8
ConvertTables[ "9" ] = CARD_9
ConvertTables[ "10" ] = CARD_10
ConvertTables[ "j" ] = CARD_JACK
ConvertTables[ "q" ] = CARD_QUEEN
ConvertTables[ "k" ] = CARD_KING
ConvertTables[ "d" ] = CARD_DIAMOND
ConvertTables[ "h" ] = CARD_HEART
ConvertTables[ "c" ] = CARD_CLUB
ConvertTables[ "s" ] = CARD_SPADE
					
local function BlackJack_GetRandomCard( Player, ForPlayer )
	Player.BlackJack_Deck = Player.BlackJack_Deck or table.Copy( DefaultDeck )
	if #Player.BlackJack_Deck <= 10 or NewBet ~= 0 then
		Player.BlackJack_Deck = table.Copy( DefaultDeck )
	end

	local ReturnCard = table.Random( Player.BlackJack_Deck )
	
	for k, v in pairs( Player.BlackJack_Deck ) do
		if v == ReturnCard then
			Player.BlackJack_Deck[ k ] = nil
		end
	end
	
	local ExplodedString = string.Explode( "_", ReturnCard )
	
	local Value = ConvertTables[ ExplodedString[2] ]
	
	if ForPlayer then
		table.insert( Player.BlackJack_Cards_Player, Value )
	else
		table.insert( Player.BlackJack_Cards_Dealer, Value )
	end
	
	return ConvertTables[ ExplodedString[1] ], Value
end

local function BlackJack_GetCount( Player, ForPlayer )
	local TableToUse = Player.BlackJack_Cards_Dealer
	
	if ForPlayer then
		TableToUse = Player.BlackJack_Cards_Player
	end
	
	local CurrentCount = 0
	local NumCards = table.Count( TableToUse )
	
	for _, v in pairs( TableToUse ) do
		if v ~= CARD_ACE then
			CurrentCount = CurrentCount + GAMEMODE.CardValues[ v ]
		end
	end
	
	for _, v in pairs( TableToUse ) do
		if v == CARD_ACE then
			if CurrentCount + 11 > 21 then
				CurrentCount = CurrentCount + 1
			else
				CurrentCount = CurrentCount + 11
			end
		end
	end
	
	return CurrentCount, NumCards
end

local function BlackJack_CheckDealerVictory( Player )
	local DealerCount, DealerNumCards = BlackJack_GetCount( Player, false )
	local PlayerCount, PlayerNumCards = BlackJack_GetCount( Player, true )
	
	if DealerCount == 21 then
		if PlayerCount == 21 then
			local Log = Format( "%s won $%s in BlackJack", Player:Nick(), util.FormatNumber( Player.BlackJack_Bet ) )
			GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

			Player:GiveCash( Player.BlackJack_Bet, true )
		end
		
		Player.BlackJack_Playing = nil
		timer.Remove( "BJ_Dealer_" .. Player:SteamID() )
	elseif DealerCount > 21 then
		if PlayerCount <= 21 then
			local Log = Format( "%s won $%s in BlackJack", Player:Nick(), util.FormatNumber( Player.BlackJack_Bet * 2 ) )
			GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

			Player:GiveCash( Player.BlackJack_Bet * 2, true )
		end
		
		Player.BlackJack_Playing = nil
		timer.Remove( "BJ_Dealer_" .. Player:SteamID() )
	elseif DealerNumCards == 5 then
		if PlayerNumCards == 5 then
			if PlayerCount > DealerCount then
				local Log = Format( "%s won $%s in BlackJack", Player:Nick(), util.FormatNumber( Player.BlackJack_Bet * 2 ) )
				GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

				Player:GiveCash( Player.BlackJack_Bet * 2, true )
			elseif DealerCount == PlayerCount then
				local Log = Format( "%s won $%s in BlackJack", Player:Nick(), util.FormatNumber( Player.BlackJack_Bet ) )
				GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

				Player:GiveCash( Player.BlackJack_Bet, true )
			end
		end
		
		Player.BlackJack_Playing = nil
		timer.Remove( "BJ_Dealer_" .. Player:SteamID() )
	elseif DealerCount >= 17 then
		if PlayerCount > DealerCount then
			local Log = Format( "%s won $%s in BlackJack", Player:Nick(), util.FormatNumber( Player.BlackJack_Bet * 2 ) )
			GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

			Player:GiveCash( Player.BlackJack_Bet * 2, true )
		elseif PlayerCount == DealerCount then
			local Log = Format( "%s won $%s in BlackJack", Player:Nick(), util.FormatNumber( Player.BlackJack_Bet ) )
			GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

			Player:GiveCash( Player.BlackJack_Bet, true )
		end
		
		Player.BlackJack_Playing = nil
		timer.Remove( "BJ_Dealer_" .. Player:SteamID() )
	end
end

local function BlackJack_GiveDealerCard( Player )
	if not Player or not IsValid( Player ) or not Player:IsPlayer() then return end
	if not Player.BlackJack_Playing then return end
	
	umsg.Start( "perp_bj_hit_dealer", Player )
		local Type, Value = BlackJack_GetRandomCard( Player, false )
		umsg.Short( Type )
		umsg.Short( Value )
	umsg.End()
	
	BlackJack_CheckDealerVictory( Player )
end

local function BlackJack_FlipDealer( Player )
	umsg.Start( "perp_bj_fd", Player ) umsg.End()

	BlackJack_CheckDealerVictory( Player )
	
	if Player.BlackJack_Playing then
		timer.Create( "BJ_Dealer_" .. Player:SteamID(), .5, 3, function() BlackJack_GiveDealerCard( Player ) end )
	end
end

---------------------------------------------------------
------------ WELCOME TO THE EXPLOITABLE LAND ------------
------------ MAKE SURE YOU CONFIRM EVERY COMMAND --------
------------ OR ELSE YOU WILL GET EXPLOITED. ------------
---------------------------------------------------------

concommand.Add( "perp_bj_q", function( Player )
	-- Confirm the player is near the NPC.
	if not Player:NearNPC( 24 ) then return Player:CaughtCheating( "Trying to use 'perp_bj_q' without being near a BlackJack Dealer." ,EXPLOIT_POSSIBLETHREAT ) end

	Player.BlackJack_Playing = nil
	Player.BlackJack_Deck = nil
	Player.BlackJack_Bet = nil
end )

-- Most exploitable function, be careful.
concommand.Add( "perp_bj_d", function( Player, Command, Args )
	-- Confirm the player is near the NPC.
	if not Player:NearNPC( 24 ) then return Player:CaughtCheating( "Trying to use 'perp_bj_d' without being near a BlackJack Dealer." , EXPLOIT_POSSIBLETHREAT ) end

	-- Confirm player is not playing because they can modify this value to get as much cash they want
	if Player.BlackJack_Playing then return Player:CaughtCheating( "Trying to modify 'perp_bj_d' while playing.", EXPLOIT_POSSIBLETHREAT ) end

	-- Check the value they put in, this is highly exploitable if not checked.
	local NewBet = tonumber( Args[1] ) or 0

	-- Not using the proper amounts, obivously they're using the command through console.
	if NewBet ~= 0 and NewBet ~= 50 and NewBet ~= 250 and NewBet ~= 500 then return Player:CaughtCheating( "Put custom value: $" .. util.FormatNumber( NewBet ) .. " in 'perp_bj_d'.", EXPLOIT_POSSIBLETHREAT ) end

	if NewBet > 0 or not Player.BlackJack_Bet then
		Player.BlackJack_Bet = NewBet
	end

	-- They're trying to use the command without the right amount of cash.
	if Player.BlackJack_Bet > Player:GetCash() then return Player:CaughtCheating( "Trying to bet: $" .. util.FormatNumber( NewBet ) .. " with insufficient funds: $" .. util.FormatNumber( Player:GetCash() ) .. " in 'perp_bj_d'.", EXPLOIT_POSSIBLETHREAT ) end

	-- Remove their cash before setting shit
	local Log = Format( "%s started a BlackJack deal with $%s", Player:Nick(), util.FormatNumber( Player.BlackJack_Bet ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( Player.BlackJack_Bet, true )

	Player.BlackJack_Playing = true
	Player.BlackJack_Deck = Player.BlackJack_Deck or table.Copy( DefaultDeck )
	
	if #Player.BlackJack_Deck <= 10 or NewBet ~= 0 then
		Player.BlackJack_Deck = table.Copy( DefaultDeck )
	end
	
	Player.BlackJack_Cards_Player = {}
	Player.BlackJack_Cards_Dealer = {}
		
	umsg.Start( "perp_bj_deal", Player )
		local Type, Value = BlackJack_GetRandomCard( Player, true )
		umsg.Short( Type )
		umsg.Short( Value )
		
		local Type, Value = BlackJack_GetRandomCard( Player, true )
		umsg.Short( Type )
		umsg.Short( Value )
		
		local Type, Value = BlackJack_GetRandomCard( Player, false )
		umsg.Short( Type )
		umsg.Short( Value )
		
		local Type, Value = BlackJack_GetRandomCard( Player, false )
		umsg.Short( Type )
		umsg.Short( Value )
	umsg.End()
	
	if BlackJack_GetCount( Player, true ) == 21 then
		BlackJack_FlipDealer( Player ) 
	end
end )

concommand.Add( "perp_bj_h", function( Player, Command, Args )
	-- Confirm the player is near the NPC.
	if not Player:NearNPC( 24 ) then return Player:CaughtCheating( "Trying to use 'perp_bj_h' without being near a BlackJack Dealer.", EXPLOIT_POSSIBLETHREAT ) end

	-- Make sure they're playing.
	if not Player.BlackJack_Playing then return Player:CaughtCheating( "Trying to 'perp_bj_h' without playing.", EXPLOIT_POSSIBLETHREAT ) end
	
	umsg.Start( "perp_bj_hit", Player )
		local Type, Value = BlackJack_GetRandomCard( Player, true )
		umsg.Short( Type )
		umsg.Short( Value )
	umsg.End()
	
	local Count, NumCards = BlackJack_GetCount( Player, true )
	
	if Count == 21 then
		BlackJack_FlipDealer( Player )
	elseif Count > 21 then
		Player.BlackJack_Playing = nil
	elseif NumCards == 5 then
		Player.BlackJack_Playing = nil
	end
end )

concommand.Add( "perp_bj_s", function( Player )
	-- Confirm the player is near the NPC.
	if not Player:NearNPC( 24 ) then return Player:CaughtCheating( "Trying to use 'perp_bj_s' without being near a BlackJack Dealer." ) end

	-- Make sure they're playing.
	if not Player.BlackJack_Playing then return Player:CaughtCheating( "Trying to 'perp_bj_s' without playing BlackJack." ) end

	BlackJack_FlipDealer( Player )
end )