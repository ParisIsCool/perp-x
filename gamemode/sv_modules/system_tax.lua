--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function GM.GiveCityMoney( amount )
	GAMEMODE.CityBudget = GAMEMODE.CityBudget + amount
	GAMEMODE.CityBudget_LastIncome = GAMEMODE.CityBudget_LastIncome or 0 + amount
end	

util.AddNetworkString("perp2_mayor_info")
function GM.SendMayorCityBudgetUpdate()
	for _, v in pairs( player.GetAll() ) do
		if v:Team() == TEAM_MAYOR then
			net.Start( "perp2_mayor_info" )
				net.WriteInt( GAMEMODE.CityBudget, 32 )
				net.WriteInt( GAMEMODE.CityBudget_LastIncome, 16 )
				net.WriteInt( GAMEMODE.CityBudget_LastExpenses, 16 )
			net.Send(v)
		end
	end
end