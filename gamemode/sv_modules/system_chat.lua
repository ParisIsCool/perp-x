--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local ChatPatterns = {}

local ColorIDNames = {}
ColorIDNames[ 1 ] 	= "Local"
ColorIDNames[ 2 ] 	= "OOC"
ColorIDNames[ 3 ] 	= "Local OOC"
ColorIDNames[ 4 ] 	= "Whisper"
ColorIDNames[ 5 ] 	= "Yell"
ColorIDNames[ 6 ] 	= "PM"
ColorIDNames[ 7 ] 	= "Me"
ColorIDNames[ 8 ] 	= "911"
ColorIDNames[ 9 ] 	= "Radio"
ColorIDNames[ 10 ] 	= "Organization"
ColorIDNames[ 12 ] 	= "Advert"
ColorIDNames[ 13 ] 	= "Admin"
ColorIDNames[ 14 ] 	= "Report"
ColorIDNames[ 15 ]	= "Event"
ColorIDNames[ 16 ]	= "Roll"
ColorIDNames[ 17 ]  = "Vomit"
ColorIDNames[ 18 ]  = "EAS"
ColorIDNames[ 19 ]	= "Help"
ColorIDNames[ 20 ]	= "Taxi"


local CensoredWords = {
	"n1gger",
	"n1gg3r",
	"nigg3r",
	"nigger",
	"niggerfaggot",
}

--util.AddNetworkString( "VENOM_Chat_Limit" )

function PLAYER:ChatMessage( Chat )
	umsg.Start( "perp_fchat", self )
		umsg.String( Chat )
		umsg.Short( 11 )
	umsg.End()
end

function ChatLog( SteamID, Type, Text, Silent )
	GAMEMODE:Log( "chatlog_" .. Type, Text )
	GAMEMODE:Log( "chatlog_" .. Type, Text, SteamID )

	Msg( "[" .. Type .. "] " .. Text .. "\n" )

	if Silent then return end

	for _, v in pairs( player.GetAll() ) do
		if v:IsAdmin() then
			v:PrintMessage( HUD_PRINTCONSOLE, "[" .. Type .. "] " .. Text )
		end
	end
end

util.AddNetworkString("perp_puke")
function PLAYER:Puke()

	local Group = RecipientFilter()
	Group:AddPVS( self:EyePos())
	Group:AddPlayer( self )

	net.Start( "perp_puke" )
		net.WriteEntity(self)
	net.Send(Group)

	--self:AddProgress(30, 1)
end

-- Incoming brain fuck in this function :)

-- This is a special function, to return, you must do return "" or else it will fail/error.
-- Instead of return ply:Notify( "You're an idiot" ) :)

local ipRegEx = "(% *%d+% *%.% *%d+% *%.% *%d+% *%.% *%d+% *)"

function GM:PlayerSay( Player, Text, TeamChat, LifeAlert )
	Text = string.gsub( Text, ipRegEx, "x.x.x.x" )

	Player.lastAction = CurTime()

	if TeamChat and not string.match( Text, "^[ \t]*/" ) then Text = "/ooc" .. Text end
	if not TeamChat and not string.match( Text, "^[ \t]*/" ) then Text = "/local" .. Text end

	for k, v in pairs( ChatPatterns ) do
		if string.match( string.lower( Text ), "^[ \t]*[/]" .. string.lower( k ) ) then
			if k ~= "report" and ( not Player:Alive() or GAMEMODE.DeadPlayers[ Player:SteamID() ] ) and not LifeAlert and k != "ooc" and k != "admin" and k != "/" and k != "looc" then
				Player:Notify( "You can't chat while you're unconcious." )
				return ""
			end

			if (k == "vomit" or k == "puke") then
				if Player.LastPuke and Player.LastPuke > CurTime() - 10 then
					if !Player:IsSuperAdmin() then
						Player:Notify( "I know you don't have that much in your stomach." )
						return ""
					end
				end

				if !Player:IsVIP() then
					Player:Notify("This command requires VIP.")
					return ""
				end

				Player.LastPuke = CurTime()

				Player:Puke()
			end

			if v.CanSend == nil or v.CanSend( Player, Text ) then -- If CanSend or the function is nil :)
				local cText = string.Trim( string.sub( string.Trim( Text ), string.len( k ) + 2 ) )
				if string.len( cText ) < 1 and k ~= "roll" then return "" end
				if cText == " " then return end -- whitespace BE GONE

				if not v.CanRead then -- function doesn't exist, send it globally :)
					umsg.Start( v.Name )
				else
					local Players = RecipientFilter()

					for _, Player2 in pairs( player.GetHumans() ) do
						if v.CanRead( Player, Player2, Text ) then
							Players:AddPlayer( Player2 )
						end
					end

					umsg.Start( v.Name, Players )
				end

				if v.Name ~= "perp_fchat" then
					if v.Name == "perp_chat" then -- Local Chat, RP Name
						umsg.Entity( Player ) -- needs colours -.-
						umsg.String( Player:GetRPName() )
					else -- Global Chat OOC Name
						umsg.Entity( Player ) -- for ooc name glow
						umsg.String( Player:Nick() )
					end
				end

				if v.CustomMessage then
					cText = v.CustomMessage( Player, string.Trim( cText ) )
				end

					umsg.String( cText )
					umsg.Short( v.ID )
				umsg.End()

				if not v.ChatLog then
					ChatLog( Player:SteamID(), ColorIDNames[ v.ID ], Player:Nick() .. " [" .. Player:GetRPName() .. " - " .. Player:SteamID() .. "][Location: " .. Player:GetZoneName() .. "]: " .. string.Trim( string.sub( string.Trim( Text ), string.len( k ) + 2 ) ) )
					GAMEMODE:LogToAdmins("Chat",{
						text = Player:Nick() .. " ["..Player:SteamID().."] ".. Text ,
						position = Player:GetPos(),
						location = Player:GetZoneName(),
						player = Player:SteamID(),
						rpname = Player:GetRPName()
					})
				end
			end

			break
		end
	end

	return ""
end

-- ID can be the same, because the id's are just colours in clientside
-- Name can either be "perp_chat", "perp_ochat" or "perp_fchat" which all represent different usermessages
-- So perp_chat is real chat perp_ochat is real OOC chat and perp_fchat is fake chat
-- There's 3 functions, CanRead(), CanSend() and CustomMessage()
-- CanRead() For all the players who can read, return true, if the function is nil then it'll send the message to everyone
-- CanSend() Return true to allow the player to send the message, again if nil then it'll be sent without restrictions
-- CustomMessage() this will re-format the message, return the new text

-- If you call a function with a usermessage in CustomMessage(), you're going to have a bad time...

-- Local Chat

local Local = {}
Local.Name = "perp_chat"
Local.ID = 1

function Local:CanRead( To )
	return self:GetPos():Distance( To:GetPos() ) <= ChatRadius_Local or ( IsValid( To.Spectating ) and To.Spectating:IsPlayer() and To.Spectating:GetPos():Distance( self:GetPos() ) <= ChatRadius_Local or ( self.Calling and To.Calling and self.Calling == To and self.PickedUp ) )
end


ChatPatterns[ "local" ] = Local

-- Out Of Character
local OOC = {}
OOC.Name = "perp_ochat"
OOC.ID = 2

--function OOC:CanRead() return true end
function OOC:CanSend( Text )
	if self:IsAdmin() then return true end

	local Blacklist = self:HasBlacklist( "ooc" )

	if Blacklist then
		return self:ChatPrint( "You're blacklisted from OOC for: " .. Blacklist.Reason .. ", time remaining: " .. ( Blacklist.Expire == 0 and "forever" or TimeToString( Blacklist.Expire - os.time() ) ) )
	end

	if GAMEMODE.AllowOOC == false then
		return self:ChatPrint( "OOC is disabled at this time to preserve roleplay." )
	end

	/*
	
	local TextRemoved
	TextRemoved = Text:gsub( "//", "" )
	TextRemoved = Text:gsub( "/ooc", "" )
	local TextData = string.Explode( " ", TextRemoved )
	local BlackListTime = 0
	for k, v in pairs( TextData ) do
		for k, j in pairs( CensoredWords ) do
			if v:lower() == j:lower() then
				if v:lower() == "admin" or "admins" or "admin." or "admin2me" or "admin..." or "staff" or "cuck" or "rdm" or "cdm" or "nlr" then --Sorry don't have time to make a table
					self:ChatPrint( "Do not call for admins in OOC, use /report {DETAILS} to get an Administrator." )
					return false
				else
					self:ChatPrint( "You're being blacklisted from OOC for attempting to say '" .. v .. "' which isn't allowed." )
					BlackListTime = BlackListTime + 180
					ChatLog( self:SteamID(), "Auto Block | OOC", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "]: " .. TextRemoved )
					ChatLog( self:SteamID(), "Auto Blacklist", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "] has been blacklisted from OOC for " .. BlackListTime .. " seconds, for attempting to use '" .. v .. "' in OOC." )
				end
			end
		end
	end
	if BlackListTime > 0 then
		self:ChatPrint( "You're blacklisted from OOC for: [System] Censored Words in OOC, time remaining: " .. TimeToString( BlackListTime ) )
		return self:GiveBlacklist( "ooc", BlackListTime, "[System] Censored Words in OOC" )
	end

	*/

	if self:IsAdmin() then return true end

	/*

	--VERY STUPID - REMOVED CHAT LIMITER!


	--[[---------------------------------------------
	Chat Limiter
	Created by RickyBGamez aka VENOM

	Description: Limit the amount of messages a player can send in chat.
	--]]---------------------------------------------

	if !timer.Exists( "VENOM_ChatLimiter-" .. self:SteamID() ) then //Sends the data to system_chat.lua in cl_modules. | Timer is destroyed in sv_hooks.lua at the bottom, and a notification to staff is sent alerting them.
		self:SetPData( "venom_chat_limit", 10 )
		timer.Create( "VENOM_ChatLimiter-" .. self:SteamID(), 3600, 1, function() end )
		self:SetPData( "venom_chat_limit", self:GetPData( "venom_chat_limit" ) - 1 )
		timer.Simple( 0.5, function() //Have to wait atleast 0.01 seconds, otherwise we print that the time remaining is 0 seconds.
			net.Start( "VENOM_Chat_Limit" )
				net.WriteString( self:GetPData( "venom_chat_limit" ) )
				net.WriteString( timer.TimeLeft( "VENOM_ChatLimiter-" .. self:SteamID() ) )
			net.Send( self )
		end )
		return true
	else
		if self:GetPData( "venom_chat_limit" ) > "0" then
			self:SetPData( "venom_chat_limit", self:GetPData( "venom_chat_limit" ) - 1 )
			net.Start( "VENOM_Chat_Limit" )
				net.WriteString( self:GetPData( "venom_chat_limit" ) )
				net.WriteString( timer.TimeLeft( "VENOM_ChatLimiter-" .. self:SteamID() ) )
			net.Send( self )
			return true
		else
			net.Start( "VENOM_Chat_Limit" )
				net.WriteString( self:GetPData( "venom_chat_limit" ) )
				net.WriteString( timer.TimeLeft( "VENOM_ChatLimiter-" .. self:SteamID() ) )
			net.Send( self )
			return false
		end
	end
	
	*/


	return true
end



ChatPatterns[ "ooc" ] = OOC
ChatPatterns[ "/" ] = OOC -- "//"

-- Local Out Of Character

local LocalOOC = {}
LocalOOC.Name = "perp_ochat"
LocalOOC.ID = 3

function LocalOOC:CanRead( To )
	return self:GetPos():Distance( To:GetPos() ) <= ChatRadius_Local or ( IsValid( To.Spectating ) and To.Spectating:IsPlayer() and To.Spectating:GetPos():Distance( self:GetPos() ) <= ChatRadius_Local or ( self.Calling and To.Calling and self.Calling == To and self.PickedUp ) )
end

ChatPatterns[ "looc" ] = LocalOOC
ChatPatterns[ "//" ] = LocalOOC -- "///"



-- Whisper

local Whisper = {}
Whisper.Name = "perp_chat"
Whisper.ID = 4

function Whisper:CanRead( To )
	return self:GetPos():Distance( To:GetPos() ) <= ChatRadius_Whisper or ( IsValid( To.Spectating ) and To.Spectating:IsPlayer() and To.Spectating:GetPos():Distance( self:GetPos() ) <= ChatRadius_Whisper )
end

ChatPatterns[ "w" ] = Whisper

-- Yell

local Yell = {}
Yell.Name = "perp_chat"
Yell.ID = 5

function Yell:CanRead( To )
	return self:GetPos():Distance( To:GetPos() ) <= ChatRadius_Yell or ( IsValid( To.Spectating ) and To.Spectating:IsPlayer() and To.Spectating:GetPos():Distance( self:GetPos() ) <= ChatRadius_Yell )
end

ChatPatterns[ "y" ] = Yell
--ChatPatterns[ "s" ] = Yell

-- Personal Message

local PM = {}
PM.Name = "perp_chat"
PM.ID = 6
PM.ChatLog = true -- Don't use chatlog, because we already do it in the CanSend function below

function PM:CanRead( To, Text )
	if not To:HasItem( "item_phone" ) then return end

	Text = Text:gsub( "/pm ", "/pm" ) -- get rid of whitespace after /pm



	local Explode = string.Explode( " ", Text:gsub( "/pm", "" ):Trim() )
	if not Explode[2] then return end

	local LookingFor = Explode[1]:lower()
	if not LookingFor or LookingFor == ""  or LookingFor == " " then return end

	if self ~= To and To:GetRPName():lower():find( LookingFor ) then
		--To:EmitSound( "perp2.5/text_message.wav", 50 )
		--local tone = (util.JSONToTable(file.Read("paris_phonesettings.txt", "DATA") or ""))
		local path = "paris/phone/Export.mp3"
		if tone and tone.TextTone and tone.TextTone.Path then path = tone.TextTone.Path end
		To:EmitSound(path, 50)
	end

	return self == To or To:GetRPName():lower():find( LookingFor )
end

function PM:CanSend( Text )
	if not self:HasItem( "item_phone" ) then
		return self:ChatMessage( "You must have a Cell Phone to use this command." )
	end

	Text = Text:gsub( "/pm ", "" ) -- Remove /pm with whitespace
	Text = Text:gsub( "/pm", "" ) -- Remove the rest of the /pm's as cunts decide to abuse /pm/pm/pm blah blah

	local FoundChar = 0
	local TheOne = NULL
	local LookingFor = string.Explode( " ", Text:Trim() )[1]:lower()
	if not LookingFor or LookingFor == ""  or LookingFor == " " then return end

	for _, v in pairs( player.GetAll() ) do
		if v ~= self and v:GetRPName():lower():find( LookingFor ) then
			FoundChar = FoundChar + 1

			if FoundChar > 1 then break end

			TheOne = v
		end
	end

	if FoundChar == 0 then
		return self:ChatMessage( "No player found with '" .. LookingFor .. "' in their name." )
	elseif FoundChar > 1 then
		return self:ChatMessage( "Multiple players found with '" .. LookingFor .. "' in their name." )
	end

	if IsValid( TheOne ) and not TheOne:HasItem( "item_phone" ) then return self:ChatMessage( "This person does not have a cell phone." ) end

	return true
end

function PM:CustomMessage( Text )
	if string.find( Text:lower(), "/pm[" ) then return "Bad boy, no." end
	if string.find( Text:lower(), "/pm(" ) then return "Bad boy, no." end

	Text = Text:gsub( "/pm ", "" ) -- Remove /pm with whitespace
	Text = Text:gsub( "/pm", "" ) -- Remove the rest of the /pm's as cunts decide to abuse /pm/pm/pm blah blah

	local Exploded = string.Explode( " ", Text:Trim() )
	local LookingFor = Exploded[1]:lower() -- The player we're looking for
	if not LookingFor or LookingFor == ""  or LookingFor == " " then return end

	table.remove( Exploded, 1 ) -- Remove the "Looking For string"

	local FoundChar = NULL

	for _, v in pairs( player.GetAll() ) do
		if v ~= self and v:GetRPName():lower():find( LookingFor ) then
			FoundChar = v

			break
		end
	end

	ChatLog( self:SteamID(), "PM", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "][Location: " .. self:GetZoneName() .. "] to " .. "[" .. FoundChar:GetRPName() .. " - " .. FoundChar:SteamID() .. "][Location: " .. FoundChar:GetZoneName() .. "]: " .. string.Implode( " ", Exploded ) )

	return "To " .. FoundChar:GetRPName() .. ": " .. string.Implode( " ", Exploded )
end

ChatPatterns[ "pm" ] = PM
ChatPatterns[ "tm" ] = PM

-- Doing Message

local Me = {}
Me.Name = "perp_fchat"
Me.ID = 7

function Me:CanRead( To )
	return self:GetPos():Distance( To:GetPos() ) <= ChatRadius_Local or ( IsValid( To.Spectating ) and To.Spectating:IsPlayer() and To.Spectating:GetPos():Distance( self:GetPos() ) <= ChatRadius_Local )
end

function Me:CustomMessage( Text )
	return self:GetFirstName() .. " " .. Text
end

ChatPatterns[ "me" ] = Me
ChatPatterns[ "action" ] = Me

-- Broadcast Message

local Broadcast = {}
Broadcast.Name = "perp_chat"
Broadcast.ID = 8

function Broadcast:CanSend()
	if self:Team() ~= TEAM_MAYOR and not self:IsSuperAdmin() then
		return self:ChatMessage( "You're not the mayor, hurr durr." )
	end

	return true
end

ChatPatterns[ "broadcast" ] = Broadcast

-- Emergency Message

local Emergency = {}
Emergency.Name = "perp_chat"
Emergency.ID = 8

function Emergency:CanRead( To )
	return To:IsGovernmentOfficial() and To:Team() ~= TEAM_MAYOR or self == To
end

function Emergency:CanSend()
	--[[if self:IsGovernmentOfficial() then
		return self:ChatMessage( "Please use /radio to communicate with your fellow Government Emyloyees." )
	end
]]--
	if not self:HasItem( "item_phone" ) then
		return self:ChatMessage( "You must have a Cell Phone to use this command." )
	end

	return true
end

function Emergency:CustomMessage( Text )
	return "[911]: " .. Text
end

ChatPatterns[ "911" ] = Emergency
ChatPatterns[ "000" ] = Emergency
ChatPatterns[ "211" ] = Emergency

-- Taxi Message

local Taxi = {}
Taxi.Name = "perp_chat"
Taxi.ID = 20

function Taxi:CanRead( To )
	return To:IsTransitOfficial() or self == To
	--return To:Team() ~= TEAM_TAXI or self == To
end

function Taxi:CanSend()
	--[[if self:IsGovernmentOfficial() then
		return self:ChatMessage( "Please use /radio to communicate with your fellow Government Emyloyees." )
	end
]]--
	if not self:HasItem( "item_phone" ) then
		return self:ChatMessage( "You must have a Cell Phone to use this command." )
	end

	return true
end

function Taxi:CustomMessage( Text )
	return "[Taxi]: " .. Text
end

ChatPatterns[ "taxi" ] = Taxi

-- Government Radio Message

local Radio = {}
Radio.Name = "perp_chat"
Radio.ID = 9

function Radio:CanRead( To )
	return To:IsGovernmentOfficial()
end

function Radio:CanSend()
	if not self:IsGovernmentOfficial() and self:Team() == TEAM_TAXI then
		return self:ChatMessage( "You're not apart of the Government, hurr durr." )
	end

	return true
end

ChatPatterns[ "radio" ] = Radio




-- Organization Message

local Organization = {}
Organization.Name = "perp_chat"
Organization.ID = 10
Organization.ChatLog = true -- Don't use chatlog, because we already do it in the CanSend function below

function Organization:CanRead( To )
	return self:GetGNWVar( "org", 0 ) == To:GetGNWVar( "org", 0 ) and To:HasItem( "item_phone" ) and not To:IsGovernmentOfficial()
end

function Organization:CanSend( Text )
	if not self:HasItem( "item_phone" ) then
		return self:ChatMessage( "You must have a Cell Phone to use this command." )
	elseif self:GetGNWVar( "org", 0 ) == 0 then
		return self:ChatMessage( "You must be in an Organization to use this command." )
	elseif self:IsGovernmentOfficial() then
		return self:ChatMessage( "You cannot use org chat while employed by the Government." )
	end

	Text = string.Trim( string.sub( string.Trim( Text ), 5 ) )

	ChatLog( self:SteamID(), "Organization", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. " - " .. GAMEMODE.OrganizationData[ self:GetGNWVar( "org", 0 ) ][1] .. "][Location: " .. self:GetZoneName() .. "]: " .. Text )

	return true
end

ChatPatterns[ "org" ] = Organization

-- Advert Message

local Advert = {}
Advert.Name = "perp_fchat"
Advert.ID = 12
Advert.ChatLog = true -- Don't use chatlog, because we already do it in the CanSend function below

function Advert:CanSend( Text )
	if self:IsSuperAdmin() then return true end

	local Blacklist = self:HasBlacklist( "advert" )

	if Blacklist then
		return self:ChatPrint( "You're blacklisted from Advert for: " .. Blacklist.Reason .. ", time remaining: " .. ( Blacklist.Expire == 0 and "forever" or TimeToString( Blacklist.Expire - os.time() ) ) )
	end

	if self.LastUsedAdvert and self.LastUsedAdvert + 30 > CurTime() then return self:ChatPrint( "Please wait another " .. TimeToString( math.Round( self.LastUsedAdvert - CurTime() ) ) .. "before posting another Advert." ) end
	self.LastUsedAdvert = CurTime()

	local TextRemoved
	TextRemoved = Text:gsub( "/advert ", "" )
	TextRemoved = Text:gsub( "/advert", "" )
	local TextData = string.Explode( " ", TextRemoved )
	local BlackListTime = 0
	for k, v in pairs( TextData ) do
		for k, j in pairs( CensoredWords ) do
			if v:lower() == j:lower() then
				self:ChatPrint( "You're being blacklisted from Advert for attempting to say '" .. v .. "' which isn't allowed." )
				BlackListTime = BlackListTime + 300
				ChatLog( self:SteamID(), "Auto Block | Advert", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "]: " .. TextRemoved )
				ChatLog( self:SteamID(), "Auto Blacklist", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "] has been blacklisted from Advert for " .. BlackListTime .. " seconds, for attempting to use '" .. v .. "' in Advert." )
			end
		end
	end
	if BlackListTime > 0 then
		self:ChatPrint( "You're blacklisted from Advert for: [System] Censored Words in Advert, time remaining: " .. TimeToString( BlackListTime ) )
		return self:GiveBlacklist( "advert", BlackListTime, "[System] Censored Words in Advert" )
	end

	if self.CurrentlyArrested then
		return self:ChatPrint( "You can't use this while in jail, hurr durr." )
	end

	if self:GetBank() >= 500 then
		self:TakeBank( 500, true )
		self:Notify( "$500 has been taken from your bank account to cover the advertisement cost." )
        self:AddRP(200)
		self:ReputationNotify( "+200 RP for creating an advert!" )
	else
		self:ChatPrint( "You don't have $500 in your bank account to cover the advertisement costs." )
		return false
	end

	ChatLog( self:SteamID(), "Advert", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "][Location: " .. self:GetZoneName() .. "]: " .. TextRemoved, true )

	-- Log it :)
	Log( Format( "[ADVERT] %s (%s): %s", self:Nick(), self:GetRPName(), TextRemoved ), Color( 255, 255, 0 ) )

	return true
end

function Advert:CustomMessage( Text )
	return "[ADVERT] " .. Text
end

ChatPatterns[ "advert" ] = Advert

-- Admin Chat

local Admin = {}
Admin.Name = "perp_ochat"
Admin.ID = 13

function Admin:CanRead( To )
	return To:IsAdmin()
end

function Admin:CanSend()
	if not self:IsAdmin() then return self:ChatPrint( "You can't use administrator chat, hurr durr." ) end

	return true
end

ChatPatterns[ "admin" ] = Admin

-- Report

local Report = {}
Report.Name = "perp_ochat"
Report.ID = 14
Report.ChatLog = true -- we log it ourselves

function Report:CanRead( To )
	return To:IsAdmin()
end

function Report:CanSend( Text )
	local AssignTicketNumber = math.random( 1000, 9999 );
	--if self:IsAdmin() then return self:ChatPrint( "Use /admin instead." ) end

	--self:ChatPrint( "Your report has been sent. Please wait for a response." )

	Text = Text:gsub( "/report ", "" ) -- Remove /report with whitespace
	Text = Text:gsub( "/report", "" ) -- Remove the rest of the /report's as cunts decide to abuse /report/report/report blah blah

	--Log( Format( "[REPORT] [#" .. AssignTicketNumber .. "] %s (%s): %s", self:Nick(), self:GetRPName(), Text ), Color( 255, 0, 0 ) )

	return true
end

function Report:CustomMessage( Text )
	local AssignTicketNumber = math.random( 1000, 9999 );

	self:ChatPrint( "Your report has been sent. Please wait for a response.  You have been assigned ticket #" .. AssignTicketNumber .. "" )
	--self:ChatPrint( "If your report isn't urgent, instead try using /help to receive help from the community!" )

	Text = Text:gsub( "/report ", "" ) -- Remove /report with whitespace
	Text = Text:gsub( "/report", "" ) -- Remove the rest of the /report's as cunts decide to abuse /report/report/report blah blah

	ChatLog( self:SteamID(), "Report", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "][Location: " .. self:GetZoneName() .. "]: " .. Text, true )

	--Log( "[REPORT] [#" .. AssignTicketNumber .. "] " .. self:Nick() .. " (" .. self:GetRPName() .. "): " .. Text )


	for _, v in pairs( player.GetAll() ) do
		if v:IsAdmin() then
			v:PrintMessage( HUD_PRINTCONSOLE, "[REPORT] [#" .. AssignTicketNumber .. "] " .. self:Nick() .. " (" .. self:GetRPName() .. "): " .. Text )
		end
	end

	return "[#" .. AssignTicketNumber .. "] [Name: " .. self:GetRPName() .. "][Location: " .. self:GetZoneName() .. "]: " .. Text

end

ChatPatterns[ "report" ] = Report


--Events
local Event = {}
Event.Name = "perp_fchat"
Event.ID = 15

function Event:CanRead( To )
	return self:GetPos():Distance( To:GetPos() ) <= ChatRadius_Local or ( IsValid( To.Spectating ) and To.Spectating:IsPlayer() and To.Spectating:GetPos():Distance( self:GetPos() ) <= ChatRadius_Local or ( self.Calling and To.Calling and self.Calling == To and self.PickedUp ) )
end

function Event:CustomMessage( Text )
	return "**||Event|| " ..  Text
end

ChatPatterns[ "event" ] = Event
ChatPatterns[ "it" ] = Event

--rolls
local Roll = {}
Roll.Name = "perp_fchat"
Roll.ID = 16
Roll.ChatLog = true -- dont log this...

function Roll:CanRead( To )
	return self:GetPos():Distance( To:GetPos() ) <= ChatRadius_Local or ( IsValid( To.Spectating ) and To.Spectating:IsPlayer() and To.Spectating:GetPos():Distance( self:GetPos() ) <= ChatRadius_Local or ( self.Calling and To.Calling and self.Calling == To and self.PickedUp ) )
end

function Roll:CustomMessage( Text )
    --return "||Roll|| " .. Player:GetFirstName() .. " rolls: " .. math.random(1,100); end
	--return "** " .. self:GetFirstName() .. " rolls: " .. math.random( 1, 100 )
    local var = math.random(1,100)
    if var == 69 then
        self:AddRP(69)
		self:ReputationNotify( "+69 RP for rolling funny number!" )
    end
	return "**||Roll|| " .. self:GetFirstName() .. " rolls: " .. var
end

ChatPatterns[ "roll" ] = Roll

-- Vomit

local Puke = {}
Puke.Name = "perp_fchat"
Puke.ID = 17

function Puke:CanRead( To )
	return
end

function Puke:CustomMessage( Text )
	return
end

ChatPatterns[ "vomit" ] = Puke
ChatPatterns[ "puke" ] = Puke

-- Emergency ALERT MESSAGE

local EmergencyA = {}
EmergencyA.Name = "perp_chat"
EmergencyA.ID = 18

function EmergencyA:CanRead( To )
	return To:IsValid()
end


function EmergencyA:CanSend()
	if self:Team() ~= TEAM_MAYOR and not self:IsSuperAdmin() then
		return self:ChatMessage( "You're not the mayor, hurr durr." )
	end

	return true
end

function EmergencyA:CustomMessage( Text )
	return "[EMERGENCY ALERT]: " .. Text
end

ChatPatterns[ "eas" ] = EmergencyA

-- Help
local Help = {}
Help.Name = "perp_ochat"
Help.ID = 19

function Help:CanRead( To )
	return To:IsValid()
end

function Help:CanSend( Text )
	if self:IsSuperAdmin() then return true end

	local Blacklist = self:HasBlacklist( "help" )

	if Blacklist then
		return self:ChatPrint( "You're blacklisted from help for: " .. Blacklist.Reason .. ", time remaining: " .. ( Blacklist.Expire == 0 and "forever" or TimeToString( Blacklist.Expire - os.time() ) ) )
	end

	local TextRemoved
	TextRemoved = Text:gsub( "/help ", "" )
	TextRemoved = Text:gsub( "/help", "" )
	local TextData = string.Explode( " ", TextRemoved )
	local BlackListTime = 0
	for k, v in pairs( TextData ) do
		for k, j in pairs( CensoredWords ) do
			if v:lower() == j:lower() then
				if v:lower() == "admin" then
					self:ChatPrint( "Do not call for admins in /help, instead please use /report {DETAILS} to get an Administrator." )
					return false
				else
					BlackListTime = BlackListTime + 20
					self:ChatPrint( "Please do not use '" .. v .. "' in Help, this is a place to ask for help." )
					ChatLog( self:SteamID(), "Auto Block | Help", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "]: " .. TextRemoved )
					ChatLog( self:SteamID(), "Auto Blacklist", self:Nick() .. " [" .. self:GetRPName() .. " - " .. self:SteamID() .. "] has been blacklisted from Help for " .. BlackListTime .. " seconds, for attempting to use '" .. v .. "' in Help." )
				end
			end
		end
	end

	if BlackListTime > 0 then
		self:ChatPrint( "You're blacklisted from Help for: [System] Censored Words in Help, time remaining: " .. TimeToString( BlackListTime ) )
		return self:GiveBlacklist( "help", BlackListTime, "[System] Censored Words in Help" )
	end

	return true
end

function Help:CustomMessage( Text )
	return "[HELP] " .. Text
end

ChatPatterns[ "help" ] = Help
