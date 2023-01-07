--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- Coca Seeds = 68
-- Weed Seeds = 14
-- Shrooms = 78
-- Meth = 10

-- List the druggies from the number that they're in the npc folder, or else they'll get mixed up.

local Druggies = {}
Druggies[1] = { Name = "Tow Yard", Sells = { "weedseed", "shrooms", "cocaineseed" }, Buys = { "weed", "shrooms", "cocaine", "meth" } }
Druggies[2] = { Name = "Tavern", Sells = { "cocaineseed", "shrooms" }, Buys = { "weed","cocaine","meth" } }

local Drugs = {}
Drugs[68] = "cocaineseed"
Drugs[14] = "weedseed"
Drugs[78] = "shrooms"
Drugs[10] = "meth"
Drugs[13] = "weed"
Drugs[69] = "cocaine"

local TextToNumber, NumberToText = {}, {}
for k, v in pairs( Drugs ) do TextToNumber[ v ] = k NumberToText[ k ] = v end

local function rdvs( ID )
	local Config = Druggies[ ID ]
	if not Config then return end

	local Entity = Config.Entity
	if not IsValid( Config.Entity ) then return end

	local ShouldSell 	= math.random( 0, #Config.Sells )
	local ShouldBuy 	= math.random( 0, #Config.Buys )

	Entity.Sells 		= ShouldSell ~= 0 and Config.Sells[ ShouldSell ] or 0
	Entity.Buys 		= ShouldBuy ~= 0 and Config.Buys[ ShouldBuy ] or 0
	Entity.NextThreat 	= CurTime()
	
	--timer.Start( "perp_druggy" .. ID, math.random( 360, 600 ), 1, function() rdvs( ID ) end )
	
	timer.Create( "perp_druggy_" .. ID, math.random( 380, 720 ), 200, function() rdvs( ID ) end )

	local FORMAT = Format( "1 Drug ID: %s selling: %s buying: %s\n", ID, NumberToText[ ShouldSell ~= 0 and Config.Sells[ ShouldSell ] or 0 ] or "nothing", NumberToText[ ShouldBuy ~= 0 and Config.Buys[ ShouldBuy ] or 0 ] or "nothing" )
	Msg( FORMAT )

	local time = GAMEMODE:GetLogDate( true )
	file.Append( "druggy_change.txt", Format( "[%s] %s", time, FORMAT ) )
end

concommand.Add("changedruggy", function(ply,cmd,args)
	if not ply:IsSuperAdmin() then return end
	rdvs( tonumber(args[1]) )
end)



local Count = 0
hook.Add( "NPCSpawned", "DruggyVars", function( NPCID, Entity )
	if NPCID == 16 then
		Count = Count + 1

		local Config = Druggies[ Count ]
		if not Config then return Error( "too many druggies with no config?\n" ) end

		Config.Entity = Entity

		-- Convert text into numbers, so the system knows which drug to sell/buy
		-- I left it as text so it's easier to set up.
		for k, v in pairs( Config.Sells ) do Config.Sells[ k ] = TextToNumber[ v ] end
		for k, v in pairs( Config.Buys ) do Config.Buys[ k ] = TextToNumber[ v ] end

		local ShouldSell 	= math.random( 0, #Config.Sells )
		local ShouldBuy 	= math.random( 0, #Config.Buys )

		Entity.DrugID 		= Count
		Entity.Sells 		= ShouldSell ~= 0 and Config.Sells[ ShouldSell ] or 0
		Entity.Buys 		= ShouldBuy ~= 0 and Config.Buys[ ShouldBuy ] or 0
		Entity.NextThreat 	= CurTime() + 300

		local tct = Count -- Fucking garry.
		
		timer.Create( "perp_druggy_" .. Count, math.random( 360, 660 ), 200, function() rdvs( tct ) end )

		local FORMAT = Format( "2 Drug ID: %s selling: %s buying: %s\n", Count, NumberToText[ ShouldSell ~= 0 and Config.Sells[ ShouldSell ] or 0 ] or "nothing", NumberToText[ ShouldBuy ~= 0 and Config.Buys[ ShouldBuy ] or 0 ] or "nothing" )
		Msg( FORMAT )

		local time = GAMEMODE:GetLogDate( true )
		file.Append( "druggy_change.txt", Format( "[%s] %s", time, FORMAT ) )
	end
end )

concommand.Add( "perp_druggy", function( Player, Command, args )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to get druggy info while away from druggy", EXPLOIT_POSSIBLETHREAT ) end
	
	umsg.Start( "perp_druggy", Player )
		umsg.Short( Druggy.Buys )
		umsg.Short( Druggy.Sells )
		umsg.Short( Druggy.NextThreat )
	umsg.End()
end )
--[[ BROKEN!
concommand.Add( "perp_bd_thr", function( Player, Command, Args )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to threaten while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	--Player:Notify( "This is disabled atm." )

	if Druggy.NextThreat < CurTime() then
		timer.Create( "perp_druggy", math.random( 300, 600 ), 0, Rdvs )
		
		local iDrug = tonumber( Args[1] )
		
		local iNum = 1
		if iDrug == 14 then
			iNum = 1
		elseif iDrug == 78 then
			iNum = 2
		elseif iDrug == 68 then
			iNum = 3
		end
		
		Druggy.Sell = iNum

		Druggy.NextThreat = CurTime() + math.random( 300, 600 )
	end
end )
]]
concommand.Add( "perp_bd_w", function( Player, Command, Args )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to buy weed while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	if not Args[1] then return end
	if Druggy.Sells ~= 14 then return Player:CaughtCheating( "Trying to buy weed while druggy isn't selling", EXPLOIT_POSSIBLETHREAT ) end

	local Amount = tonumber( Args[1] )
	local Cost = Amount * ITEM_DATABASE[ 14 ].Cost
	
	if Amount <= 0 then return Player:CaughtCheating( "Trying to buy negative/no amount of weed: " .. Amount, EXPLOIT_POSSIBLETHREAT ) end
	if Player:GetCash() < Cost then return end

	if not Player:CanHoldItem( 14, Amount ) then return end

	local Log = Format( "%s bought %i weed for $%s", Player:Nick(), Amount, util.FormatNumber( Cost ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( Cost, true )

	Player:GiveItem( 14, Amount )
end )

concommand.Add( "perp_bd_shroom", function( Player, Command, Args )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to buy shrooms while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	if not Args[1] then return end
	if Druggy.Sells ~= 78 then return Player:CaughtCheating( "Trying to buy shrooms while druggy isn't selling", EXPLOIT_POSSIBLETHREAT ) end

	local Amount = tonumber( Args[1] )
	local Cost = Amount * ITEM_DATABASE[78].Cost
	
	if Amount <= 0 then return Player:CaughtCheating( "Trying to buy negative/no amount of shroom: " .. Amount, EXPLOIT_POSSIBLETHREAT ) end
	if Player:GetCash() < Cost then return end
	
	if not Player:CanHoldItem( 78, Amount ) then return end

	local Log = Format( "%s bought %i shrooms for $%s", Player:Nick(), Amount, util.FormatNumber( Cost ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( Cost, true )
	
	Player:GiveItem( 78, Amount )
end )

concommand.Add( "perp_bd_cocaine", function( Player, Command, Args )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to buy cocaine while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	if not Args[1] then return end
	if Druggy.Sells ~= 68 then return Player:CaughtCheating( "Trying to buy cocaine while druggy isn't selling", EXPLOIT_POSSIBLETHREAT ) end

	local Amount = tonumber( Args[1] )
	local Cost = Amount * ITEM_DATABASE[68].Cost
	
	if Amount <= 0 then return Player:CaughtCheating( "Trying to buy negative/no amount of cocaine: " .. Amount, EXPLOIT_POSSIBLETHREAT ) end
	if Player:GetCash() < Cost then return end
	
	if not Player:CanHoldItem( 68, Amount ) then return end

	local Log = Format( "%s bought %i cocaine for $%s", Player:Nick(), Amount, util.FormatNumber( Cost ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( Cost, true )

	Player:GiveItem( 68, Amount )
end )

concommand.Add( "perp_sd_w", function( Player )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to sell weed while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	if Druggy.Buys ~= 13 then return Player:CaughtCheating( "Trying to sell weed while druggy isn't buying", EXPLOIT_POSSIBLETHREAT ) end

	local Amount = Player:GetItemCount( 13 )
	
	if Amount == 0 then return end
	
	Player:TakeItemByID( 13, Amount ) -- Take the players drugs

	local Log = Format( "%s was given $%s for selling %s weed", Player:Nick(), util.FormatNumber( Amount * ITEM_DATABASE[13].Cost ), util.FormatNumber( Amount ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:GiveCash( Amount * ITEM_DATABASE[13].Cost, true )
end )

concommand.Add( "perp_sd_m", function( Player )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to sell meth while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	if Druggy.Buys ~= 10 then return Player:CaughtCheating( "Trying to sell meth while druggy isn't buying", EXPLOIT_POSSIBLETHREAT ) end

	local Amount = Player:GetItemCount( 10 )
	
	if Amount == 0 then return end

	Player:TakeItemByID( 10, Amount ) -- Take the players drugs

	local Log = Format( "%s was given $%s for selling %s meth", Player:Nick(), util.FormatNumber( Amount * ITEM_DATABASE[10].Cost ), util.FormatNumber( Amount ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:GiveCash( Amount * ITEM_DATABASE[10].Cost, true ) -- Give them their dosh
end )

concommand.Add( "perp_sd_shroom", function( Player )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to sell shrooms while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	if Druggy.Buys ~= 78 then return Player:CaughtCheating( "Trying to sell shrooms while druggy isn't buying", EXPLOIT_POSSIBLETHREAT ) end

	local Amount = Player:GetItemCount( 78 )
	if Amount <= 0 then return end
	
	Player:TakeItemByID( 78, Amount ) -- Take the players drugs

	local Log = Format( "%s was given $%s for selling %s shrooms", Player:Nick(), util.FormatNumber( Amount * ITEM_DATABASE[78].Cost ), util.FormatNumber( Amount ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:GiveCash( Amount * ITEM_DATABASE[78].Cost, true )
end )

concommand.Add( "perp_sd_cocaine", function( Player )
	local Druggy = Player:NearNPC( 16 )
	if not Druggy then return Player:CaughtCheating( "Trying to sell cocaine while away from druggy", EXPLOIT_POSSIBLETHREAT ) end

	if Druggy.Buys ~= 69 then return Player:CaughtCheating( "Trying to sell cocaine while druggy isn't buying", EXPLOIT_POSSIBLETHREAT ) end

	local Amount = Player:GetItemCount( 69 )
	if Amount <= 0 then return end
	
	Player:TakeItemByID( 69, Amount ) -- Take the players drugs
	
	local Log = Format( "%s was given $%s for selling %s cocaine", Player:Nick(), util.FormatNumber( Amount * ITEM_DATABASE[69].Cost ), util.FormatNumber( Amount ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:GiveCash( Amount * ITEM_DATABASE[69].Cost, true )
end )