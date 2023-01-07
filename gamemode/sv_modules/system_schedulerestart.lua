--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

util.AddNetworkString("restartin")

hook.Add( "PlayerInitialSpawn", "RestartTimer", function( Player )
	if GAMEMODE.Restarting then
		net.Start( "restartin" )
		net.WriteBool( true )
		net.WriteInt( ( GAMEMODE.Restarting - os.time() ) + 10, 32 )
		net.Send(Player)
	end
end )

concommand.Add( "restart_server", function( Player, Command, Args )
	if Player and IsValid( Player ) and not Player:IsSuperAdmin() then return end

	local RestartTime = tonumber( Args[1] ) or 15

	if RestartTime > 15 then return Player:PrintMessage( HUD_PRINTCONSOLE, "You can't restart more than 15 minutes." ) end

	if RestartLottery then
		if RestartTime >= 10 then
			LotteryEndQuick(5*60)
		else
			RestartLottery()
		end
	end

	local RestartIn = os.time() + RestartTime * 60

	GAMEMODE.Restarting = RestartIn

	net.Start( "restartin" )
	net.WriteBool(true)
	net.WriteInt( ( RestartIn - os.time() ) + 10, 32 )
	net.Broadcast()
	
	timer.Create( "HecktikTimer", 5, 0, function()
		net.Start( "restartin" )
		net.WriteBool(true)
		net.WriteInt( ( RestartIn - os.time() ) + 10, 32 )
		net.Broadcast()
	end )

	timer.Create( "RestartCheck", 1, 0, function()
		if RestartIn <= os.time() then
			for _, v in pairs( player.GetAll() ) do
			
				v:PutSpawnedIntoWarehouse()

				v:PERPSave()
			end

			timer.Simple( 10, function() RunConsoleCommand( "changelevel", game.GetMap() ) end )
			
			timer.Destroy( "RestartCheck" )
		end
	end )

	PrintMessage( HUD_PRINTTALK, "Restart Count Down Initalized." )
end )

concommand.Add( "stop_restart", function( Player )
	if Player and IsValid( Player ) and not Player:IsSuperAdmin() then return end

	GAMEMODE.Restarting = false

	net.Start( "restartin" )
	net.WriteBool( false )
	net.Broadcast()

	timer.Destroy( "HecktikTimer" )
	timer.Destroy( "RestartCheck" )

	PrintMessage( HUD_PRINTTALK, "Restart Cancelled." )
end )