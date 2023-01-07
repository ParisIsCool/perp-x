--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.chatRecord = {}

GM.linesToShow = 20

local ColorIDs = {}
local ColorIDNames = {}
ColorIDs[1] = Color( 240, 230, 140, 255 ) 	ColorIDNames[1] = "Local"
ColorIDs[2] = Color( 255, 255, 255, 255 ) 	ColorIDNames[2] = "OOC"
ColorIDs[3] = Color( 200, 200, 200, 255 )	ColorIDNames[3] = "Local OOC"
ColorIDs[4] = Color( 135, 206, 235, 255 )	ColorIDNames[4] = "Whisper"
ColorIDs[5] = Color( 255, 140, 0, 255 ) 	ColorIDNames[5] = "Yell"
ColorIDs[6] = Color( 50, 205, 50, 255 ) 	ColorIDNames[6] = "PM"
ColorIDs[7] = Color( 255, 50, 50, 255 ) 	ColorIDNames[7] = "Me"
ColorIDs[8] = Color( 255, 0, 0, 255 ) 		ColorIDNames[8] = "911"
ColorIDs[9] = Color( 0, 0, 255, 255 ) 		ColorIDNames[9] = "Radio"
ColorIDs[10] = Color( 255, 0, 255, 255 ) 	ColorIDNames[10] = "Organization"
ColorIDs[11] = Color( 0, 255, 0, 255 )		ColorIDNames[11] = ""
ColorIDs[12] = Color( 255, 255, 255, 255 ) 	ColorIDNames[12] = "Advert"
ColorIDs[13] = Color( 0, 255, 0, 255 ) 		ColorIDNames[13] = "Admin"
ColorIDs[14] = Color( 255, 0, 0, 255 ) 		ColorIDNames[14] = "Report"
ColorIDs[15] = Color( 255, 50, 50, 255 ) 	ColorIDNames[15] = "Event"
ColorIDs[16] = Color( 255, 50, 50, 255 ) 	ColorIDNames[16] = "Roll"
ColorIDs[17] = Color( 255, 50, 50, 255 ) 	ColorIDNames[17] = "Vomit"
ColorIDs[18] = Color( 148, 0, 211, 255 ) 	ColorIDNames[18] = "Emergency Alert"
ColorIDs[19] = Color( 255, 0, 255, 255 ) ColorIDNames[19] = "Help"
ColorIDs[20] = Color( 168, 183, 33, 255 ) 	ColorIDNames[20] = "Taxi"
--ColorIDs[14] = Color( 255, 255, 255, 255 )	ColorIDNames[14] = "Global"

local newMessageSound = Sound( "common/talk.wav" )

function GM:StartChat( teamSay )
	GAMEMODE.chatBoxIsOOC = teamSay
	GAMEMODE.chatBoxText = ""
	GAMEMODE.ChatBoxOpen = true

	if GAMEMODE.Options_ShowChatBubble:GetBool() then
		GAMEMODE.ChatBubbleOpen = true
		RunConsoleCommand( "pt", "1" )
	end

	gui.SetMousePos(ScrW()/2, ScrH()/2)

	return true
end

function GM:FinishChat()
	GAMEMODE.chatBoxIsOOC = nil
	GAMEMODE.chatBoxText = nil
	GAMEMODE.ChatBoxOpen = nil

	if GAMEMODE.ChatBubbleOpen then
		GAMEMODE.ChatBubbleOpen = nil
		RunConsoleCommand( "pt", "0" )
	end
end

function GM:ChatTextChanged( newChat )
	GAMEMODE.chatBoxText = newChat
end

-- This part is handled through UMsgs so baddies can't hear from across the map. Silly exploiters.
function GM:ChatText( playerID, playerName, text, type )
	surface.PlaySound( newMessageSound )
	table.insert( GAMEMODE.chatRecord, { CurTime(), "", nil, string.Trim( text ), ColorIDs[11], nil } )
	Msg( text .. "\n" )
end

function GM:AddChat(Col,Message)
	if not Message then Message = Col Col = ColorIDs[11] end
	table.insert( GAMEMODE.chatRecord, { CurTime(), "", nil, Message, Col, nil } )
end

function GM:OnPlayerChat( Player, Text, TeamChat, PlayerIsDead ) end

function chat._AddText( Colour, ... )
	local String = "" 
	for k, v in pairs( { ... } ) do
		if type( v ) == "string" then
			String = String .. v
		end
	end
	table.insert( GAMEMODE.chatRecord, { CurTime(), "", nil, string.Trim( String ), Colour or Color( 255, 255, 255, 255 ), nil } )
end

usermessage.Hook( "perp_chat", function( UMsg )
	local pl = UMsg:ReadEntity()
	local RPName = UMsg:ReadString()
	local text = UMsg:ReadString()
	local id = UMsg:ReadShort()

	if ( id == 2 or id == 3 ) and not GAMEMODE.Options_ShowOOC:GetBool() then return end

	if !IsValid(pl) then return end

	surface.PlaySound( newMessageSound )

	if not LocalPlayer():IsAdmin() then Msg( "[" .. ColorIDNames[ id ] .. "] " .. RPName .. ": " .. string.Trim( text ) .. "\n" ) end

	table.insert( GAMEMODE.chatRecord, { CurTime(), RPName, team.GetColor( pl:Team() ), string.Trim( text ), ColorIDs[ id or 1 ], nil } )
	hook.Run("OnPlayerChat", pl, text, false, true)
end )

usermessage.Hook( "perp_ochat", function( UMsg )
	local pl = UMsg:ReadEntity()
	local RPName = UMsg:ReadString()
	local text = UMsg:ReadString()
	local id = UMsg:ReadShort()

	if ( id == 2 or id == 3 ) and not GAMEMODE.Options_ShowOOC:GetBool() then return end

	surface.PlaySound( newMessageSound )

	local glowType
	local devs = { "STEAM_0:0:", } 
	local IsCDev = { "STEAM_0:0:" }

	if pl:IsPlayer() then
		if not pl:GetGNWVar( "disguised" ) then
			if pl:IsAdmin() then
				glowType = pl:GetRankColor()
			end
		end
	end

	if IsValid( LocalPlayer() ) and not LocalPlayer():IsAdmin() then Msg( "[" .. ColorIDNames[ id ] .. "] " .. RPName .. ": " .. string.Trim( text ) .. "\n" ) end

	table.insert( GAMEMODE.chatRecord, { CurTime(), RPName, team.GetColor( TEAM_CITIZEN ), string.Trim( text ), ColorIDs[ id or 1 ], glowType } )
	hook.Run("OnPlayerChat", pl, text, false, true)
end )

usermessage.Hook( "perp_fchat", function( UMsg )
	local text = UMsg:ReadString()
	local id = UMsg:ReadShort()

	surface.PlaySound( newMessageSound )

	if ( id == 11 and LocalPlayer():IsAdmin() ) or not LocalPlayer():IsAdmin() then
		Msg( string.Trim( text ) .. "\n" )
	end

	table.insert( GAMEMODE.chatRecord, { CurTime(), "", nil, string.Trim( text ), ColorIDs[ id or 1 ], nil } )
end )

function PLAYER:ChatMessage( Chat )
	table.insert( GAMEMODE.chatRecord, { CurTime(), "", nil, string.Trim( Chat ), ColorIDs[ 11 ], nil } )
end

--[[
	clean out GM.chatRecord, there isn't any other way I can think of doing this
	unless I add functions that really are not needed...
	Chat was never cleaned, so this will still be at something of an advantage
	pros > cons
]]

timer.Create( "CleanChat", 60, 0, function()
	local Cleaning = #GAMEMODE.chatRecord - GAMEMODE.linesToShow

	if Cleaning > 0 then
		for i = 1, Cleaning do
			table.remove( GAMEMODE.chatRecord, 1 )
		end
	end
end )

net.Receive( "VENOM_Chat_Limit", function( len, ply )
	local messagesLeft = net.ReadString()
	local timeRemainingSeconds = net.ReadString()
	local timeRemaining = string.FormattedTime( timeRemainingSeconds, "%02i:%02i" )
	
	notification.AddLegacy( "You have " .. messagesLeft .. " OOC messages left for another " .. timeRemaining .. " minutes.", NOTIFY_GENERIC, 8 )
end )

GM.chatPrefixes 				= {}
GM.chatPrefixes[ "ooc" ]		= "OOC"
GM.chatPrefixes[ "/" ] 			= "OOC"
--GM.chatPrefixes[ "g" ]		= "Global"
GM.chatPrefixes[ "//" ] 		= "Local OOC"
GM.chatPrefixes[ "looc" ] 		= "Local OOC"
GM.chatPrefixes[ "me" ] 		= "Action"
GM.chatPrefixes[ "action" ] 	        = "Action"
GM.chatPrefixes[ "w" ] 			= "Whisper"
GM.chatPrefixes[ "y" ] 			= "Yell"
--GM.chatPrefixes[ "s" ] 			= "Yell"
GM.chatPrefixes[ "911" ] 		= "Emergency"
GM.chatPrefixes[ "000" ] 		= "Emergency"
GM.chatPrefixes[ "211" ] 		= "Emergency"
GM.chatPrefixes[ "taxi" ] 		= "Taxi"
GM.chatPrefixes[ "broadcast" ] 	        = "Broadcast"
GM.chatPrefixes[ "radio" ] 		= "Government Radio"
GM.chatPrefixes[ "org" ] 		= "Organization"
GM.chatPrefixes[ "pm" ] 		= "Private Message"
GM.chatPrefixes[ "tm" ] 		= "Text Message"
GM.chatPrefixes[ "admin" ] 		= "Admin Talk"
GM.chatPrefixes[ "advert" ] 	        = "Advertisement"
GM.chatPrefixes[ "report" ]		= "Report"
GM.chatPrefixes[ "event" ]		= "Event"
GM.chatPrefixes[ "it" ]			= "Event"
GM.chatPrefixes[ "roll" ]		= "Roll"
GM.chatPrefixes[ "vomit" ]		= "Vomit"
GM.chatPrefixes[ "puke" ]		= "Puke"
GM.chatPrefixes[ "eas" ]		= "Emergency Alert"
GM.chatPrefixes[ "help" ]		= "Help"
