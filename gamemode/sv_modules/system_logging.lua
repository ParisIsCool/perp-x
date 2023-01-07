--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

/* Logs built in for PERP by G-Force Connections  */

util.AddNetworkString("AdminNotify")
function Log( Text, Colour )
	Colour = Colour or Color( 255, 255, 255 )

	for _, v in pairs( player.GetAll() ) do
		if v:IsAdmin() then
			net.Start( "AdminNotify" )
				net.WriteString(Text)
				net.WriteColor(Colour)
			net.Send(v)
		end
	end

	GAMEMODE:Log( "general", Text )

	Msg( Text .. "\n" )
end

/* This function will handle all logging from now on

	GAMEMODE:Log( Type, String, SteamID ) or GAMEMODE:Log( Type, String ) for global logging.
*/

util.AddNetworkString("SuperLoggerReceiveLog")
function GM:LogToAdmins(type,log)
	local admins = {}
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() then table.insert(admins,v) end
	end
	log.time = os.time()
	net.Start("SuperLoggerReceiveLog")
		net.WriteTable({
			type = type,
			log = log,
		})
	net.Send(admins)
end

local Directory = "gtaonline_logs/" -- Main Directory
local PDirectory = "players/" -- Player Directory

function GM:Log( Type, String, SteamID)
	local Name, ToSave

	if not SteamID then -- Global Log
		local folderdate, timedate = GAMEMODE:GetLogDate()

		local Dir = Directory .. folderdate

		Name 	= Format( "%s/%s.txt", Dir, Type )
		ToSave 	= Format( "[%s] %s\n", timedate, String )
		            
					
		else -- Player Log or string.gsub( ply:SteamID(), ":", "_" )
			--local Dir = Directory .. PDirectory .. SteamID:gsub( ":", "_" )
			--local Dir = Directory .. PDirectory .. SteamID:gsub( SteamID:SteamID(), ":", "_" )
			--"[^a-zA-Z_0-9]", "_"
			--local player = SteamID()	
			--local Dir = Directory .. PDirectory .. ( string.Replace( player, ":", "_" ) )
			local Dir = Directory .. PDirectory .. SteamID:gsub( "[^a-z_0-9]", "" )
			if not file.IsDir( Dir, "DATA" ) then file.CreateDir( Dir ) end -- remove soon.

			Name 	= Format( "%s/%s.txt", Dir, Type )
			ToSave 	= Format( "[%s] %s\n", GAMEMODE:GetLogDate( true ), String )
		end
	
	local File = file.Open( Name, "a", "DATA" )
	if not File then return Error( "Unable to open file " .. Name .. "\n" ) end

	File:Write( ToSave )
	File:Close()
end


-- numonly is misleading, however it returns only one variable as: 01/01/01 - 00:00:00

function GM:GetLogDate( numonly )
	-- numonly = "day/month/year - hour:minute:second" -- %d.%b.%Y
	-- normal = "year/month - month name/day - day name,hour:minute:second"
	-------------------------------------------------------------------------------------------------------------
	-- orig --local initdate 		= os.date( numonly and "%d/%m/%y - %I:%M:%S" or "%Y/%m - %b/%d - %A,%I:%M:%S" )
	-------------------------------------------------------------------------------------------------------------
	--local initdate 		= os.date( numonly and "%y/%m/%d" or "%y/%m/%d" )	
	-- works soso local initdate 		= os.date( numonly and "%Y/%m/%d" or "%Y/%m/%d" or "%Y/%m - %b/%d - %A,%I:%M:%S" )
	-- sososo works ok local initdate 		= os.date( numonly and "%Y-%m-%d" or "%Y-%m-%d" or "%Y-%m - %b-%d - %A,%I:%M:%S" )
	--//  want Year/ 01 / 01
	--broken--local initdate 		= os.date( numonly and "%Y-%m-%d" or "%Y/%m/%d" or "%m-%Y - %b-%d - %A,%I:%M:%S" )
	-- good local initdate 	= os.date( numonly and "%m-%d-%Y" or "%Y/%m/%d" or "%m-%Y - %b-%d - %A,%I:%M:%S" )
	
	
	//first is write to txt date - time. then after or 
	-- better local initdate 	= os.date( numonly and "%m-%d-%Y - %I:%M:%S" or "%Y/%m/%d" or "%m-%d-%Y - %I:%M:%S" )
	local initdate 	= os.date( numonly and "%m-%d-%Y - %I:%M:%S" or "%Y/%m/%d" or "%m-%d-%Y - %I:%M:%S" )
	
	if numonly then
		return initdate
	else
		local folderdate 	= string.Explode( ",", initdate )[1]
		local timedate 		= string.Explode( ",", initdate )[2]
		
		return folderdate, timedate
		
	end
end

-- Ensure folders are available, thanks garry for removing automatic folder creation...
if not file.IsDir( "gtaonline_logs/" .. GM:GetLogDate(), "DATA" ) then file.CreateDir( "gtaonline_logs/" .. GM:GetLogDate() ) end

timer.Create( "FolderChecker", 10, 0, function()
	if not file.IsDir( "gtaonline_logs/" .. GAMEMODE:GetLogDate(), "DATA" ) then file.CreateDir( "gtaonline_logs/" .. GAMEMODE:GetLogDate() ) end
end )

hook.Add( "PlayerAuthed", "MakeLogDirectory", function( Player )
	--local player = ply:SteamID()
	--local Dir = Directory .. PDirectory .. ( string.Replace( player, ":", "_" ) )
	local Dir = Directory .. PDirectory .. Player:SteamID():gsub( "[^a-z_0-9]", "" )
	if not file.IsDir( Dir, "DATA" ) then file.CreateDir( Dir ) end
end )