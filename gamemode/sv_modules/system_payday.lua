--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local PLAYER = FindMetaTable("Player")
function PLAYER:HasSpecialPrefix()
	local prefix = "asocket"
    local username = self:Nick()
    username = string.lower(username)
    username = string.gsub(username, " ", "")
	local found = string.find(username,prefix)
	return found
end

util.AddNetworkString("perp_payday")
util.AddNetworkString("nextpaydaysoon")

timer.Create( "PayDaySystem", 120, 0, function()
	
	GAMEMODE.CityBudget_LastExpenses = 0

	local Players = player.GetAll()
	local freecash = (GAMEMODE.GetTaxRate_Income()*(FREE_CASH_PER_PLAYER))*10
	GAMEMODE.GiveCityMoney( #Players * freecash )

	for k, v in pairs( Players ) do
		if v:Team() == TEAM_MAYOR then net.Start("nextpaydaysoon") net.Send(v) end
	end

	-- Car upkeep
	local CarUpkeep = 0
	for _, each in pairs( ents.FindByClass( "prop_vehicle_jeep" ) ) do
		if each.vehicleTable and each.vehicleTable.RequiredClass and JOB_DATABASE[ each.vehicleTable.RequiredClass ].Upkeep then
			CarUpkeep = CarUpkeep + JOB_DATABASE[ each.vehicleTable.RequiredClass ].Upkeep
		end
	end

	local n = #player.GetAll()
	local SalesTaxRandomFlux = (math.random(n*100,n*200))*GAMEMODE.GetTaxRate_Sales()

	local CityBudget = ( GAMEMODE.CityBudget - CarUpkeep ) + SalesTaxRandomFlux
	local Expenses = CarUpkeep
	local Income = SalesTaxRandomFlux + (#Players * freecash)
	
	-- Pass out the citizen's money first!
	for _, v in pairs( Players ) do
		if v:GetNWBool("isAFK") then
			v:Notify( "You didn't get your payday because you're AFK." )
			continue
		end

		-- Amount and checks
		local TO_EARN = GAMEMODE.JobWages[v:Team()] or 0

		local TO_EARN_TEXT = "from your unemployment check."
		if v:Team() != TEAM_CITIZEN then
			TO_EARN_TEXT 	= "for being a " .. JOB_DATABASE[ v:Team() ].Name .. "."
		end

		-- Tax
		local Rate = GAMEMODE.GetTaxRate_Income()
		local IncomeTax = math.Round( TO_EARN * Rate )
		local AddString = ""
		GAMEMODE.GiveCityMoney( IncomeTax )
		if v:HasSpecialPrefix() then
			Rate = GAMEMODE.GetTaxRate_Income() - 0.05
			AddString = " -5% aSocket tag bonus "
			if Rate < 0 then
				Rate = 0
			end
		end
		local IncomeTax = math.Round( TO_EARN * Rate )
		GAMEMODE.GiveCityMoney( IncomeTax )

		-- Bonuses
		if v:IsVIP() then
			TO_EARN = TO_EARN * 2
		end--elseif v:IsMember() then
		--	TO_EARN = TO_EARN * 1.1
		--end

		TO_EARN = math.Round( TO_EARN - IncomeTax )
		TO_EARN_TEXT = TO_EARN_TEXT .. " (" .. GAMEMODE.GetTaxRate_Income_Text() .. " Income Tax)" .. AddString

		if CityBudget < TO_EARN then
			v:Notify( "The city did not have enough funds to pay you." )
			continue
		end

		CityBudget = CityBudget - TO_EARN
		Expenses = Expenses - TO_EARN
		Income = Income + IncomeTax

		net.Start( "perp_payday", v ) net.WriteInt( TO_EARN, 16 ) net.WriteString( TO_EARN_TEXT, 16 ) net.Send(v)

		local Log = Format( "%s got $%s from their payday", v:Nick(), util.FormatNumber( TO_EARN ) )
		GAMEMODE:Log( "cashlog_payday", Log, v:SteamID() )

		v:GiveBank( TO_EARN, true )

		//v:AddProgress( 26, TO_EARN )
	end

	--if GAMEMODE.CityBudget < ( JobUpkeep + CarUpkeep - JobUpkeepTax ) then
		GAMEMODE.CityBudget_LastExpenses = Expenses
		GAMEMODE.CityBudget_LastIncome = Income
		GAMEMODE.CityBudget = CityBudget
	--end

	GAMEMODE.SendMayorCityBudgetUpdate()

end )


gameevent.Listen( "player_changename" )
hook.Add( "player_changename", "vg_check", function( check )

    local prefix = "asocket"
    local ID = check.userid
    local username = check.newname
    username = string.lower(username)
    username = string.gsub(username, " ", "")
	username = string.sub(username, 1, #prefix)
	local ply
	for k, v in pairs(player.GetAll()) do
		if v:UserID() == ID then
			ply = v
			break
		end
	end
	
    if username == prefix then
        for k, v in pairs(player.GetAll()) do
            v:ChatPrint(ply:Nick() .. " is receiving a -5% income tax decrease on their paychecks for having the aSocket tag in their name!")
        end
    end

end )