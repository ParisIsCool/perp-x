--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- max short = 2^15 - 1 			= 32,767
-- max unsigned short = 2^16 - 1 	= 65,535
-- max int = 2^31 - 1 				= 2,147,483,647
-- max unsigned int = 2^32 - 1 		= 4,294,967,295

local VARTYPE_NONE 		= 0 	-- nil
local VARTYPE_ANGLE 	= 1 	-- Angle()
local VARTYPE_VECTOR 	= 2 	-- Vector()
local VARTYPE_BIT 		= 3 	-- true/false
local VARTYPE_INT 		= 4 	-- -2,147,483,647 to 2,147,483,647
local VARTYPE_FLOAT		= 5 	-- Int's can not have .5 etc.
local VARTYPE_STRING	= 6 	-- "what"
local VARTYPE_ENTITY 	= 7 	-- Entity()

util.AddNetworkString( "perp_pnwvar" )
util.AddNetworkString( "perp_gnwvar" )
util.AddNetworkString( "perp_gnwvar_flush" )
util.AddNetworkString( "perp_physcolor" )

local function GetNWType( Value )
	if type( Value ) == "Angle" then
		return VARTYPE_ANGLE, net.WriteAngle
	elseif type( Value ) == "Vector" then
		return VARTYPE_VECTOR, net.WriteVector
	elseif type( Value ) == "boolean" then
		return VARTYPE_BIT, net.WriteBit
	elseif type( Value ) == "number" then
		if math.floor( Value ) ~= Value then
			return VARTYPE_FLOAT, net.WriteFloat
		end

		return VARTYPE_INT, net.WriteInt
	elseif type( Value ) == "string" then
		return VARTYPE_STRING, net.WriteString
	elseif type( Value ) == "NPC" or type( Value ) == "Entity" or type( Value ) == "Player" or type( Value ) == "Vehicle" then
		return VARTYPE_ENTITY, net.WriteEntity
	end

	return VARTYPE_NONE
end

local function SendData( Type, Who, EntIndex, StringID, StringValue )
	local Enum, Func = GetNWType( StringValue )

	net.Start( Type )
		--if Type == "perp_gnwvar" then net.WriteString( tostring( EntIndex ) ) end -- EntIndex

		net.WriteTable({
			StringID,
			StringValue,
			EntIndex
		})

	if Type == "perp_gnwvar" and not Who then net.Broadcast() else net.Send( Who ) end
end

GM.GlobalData = GM.GlobalData or {} -- Global Entity Data

function SetGNWVar( StringID, StringValue )
	GAMEMODE.GlobalData[ "Global" ] = GAMEMODE.GlobalData[ "Global" ] or {}
	GAMEMODE.GlobalData[ "Global" ][ StringID ] = StringValue

	if StringValue == nil then
		if table.Count( GAMEMODE.GlobalData[ "Global" ] ) == 0 then
			GAMEMODE.GlobalData[ "Global" ] = nil
		end
	end

	SendData( "perp_gnwvar", nil, "Global", StringID, StringValue )
end

function GetGNWVar( StringID, Default )
	return GAMEMODE.GlobalData[ "Global" ] and GAMEMODE.GlobalData[ "Global" ][ StringID ] or Default
end

function ENTITY:SetGNWVar( StringID, StringValue )
	local EntIndex = tostring( self:EntIndex() )

	GAMEMODE.GlobalData[ EntIndex ] = GAMEMODE.GlobalData[ EntIndex ] or {}
	GAMEMODE.GlobalData[ EntIndex ][ StringID ] = StringValue

	if StringValue == nil then
		if table.Count( GAMEMODE.GlobalData[ EntIndex ] ) == 0 then
			GAMEMODE.GlobalData[ EntIndex ] = nil
		end
	end

	SendData( "perp_gnwvar", nil, EntIndex, StringID, StringValue )
end

function ENTITY:GetGNWVar( StringID, Default )
	local EntIndex = tostring( self:EntIndex() )

	return GAMEMODE.GlobalData[ EntIndex ] and GAMEMODE.GlobalData[ EntIndex ][ StringID ] or Default
end

function ENTITY:SendGNWVars()
	for EntIndex, Data in pairs( GAMEMODE.GlobalData ) do
		if EntIndex ~= tostring( self:EntIndex() ) then
			for StringID, StringValue in pairs( Data ) do
				SendData( "perp_gnwvar", self, EntIndex, StringID, StringValue )
			end
		end
	end
end

hook.Add( "EntityRemoved", "GNWVarFlush", function( Entity )
	if not Entity:EntIndex() then MsgC( Color( 255, 0, 0 ), "\n ERROR......ENTITY REMOVAL FAILURE!!!!!: " .. Entity:GetClass() "\n" ) return end
	local EntIndex = tostring( Entity:EntIndex() )

	if not GAMEMODE.GlobalData[ EntIndex ] then return end

	net.Start( "perp_gnwvar_flush" )
		net.WriteString( EntIndex )
	net.Broadcast()
	
	GAMEMODE.GlobalData[ EntIndex ] = nil
end )

function PLAYER:SetPNWVar( StringID, StringValue, DontSendToClient )
	self.PrivateData = self.PrivateData or {}

	self.PrivateData[ StringID ] = StringValue
	
	if not DontSendToClient then
		SendData( "perp_pnwvar", self, nil, StringID, StringValue )
	end
end

function PLAYER:GetPNWVar( StringID, Default )
	return self.PrivateData and self.PrivateData[ StringID ] or Default
end


/*************************************************
	Command "perp_nc"
	Job: Make a new character :)
*************************************************/
concommand.Add( "perp_nc", function( Player, Command, Args )
	if not Player.CanSetupPlayer then print("NC Error: CanSetupPlayer flag is false :(") return end

	if not Args[1] or not Args[2] or not Args[3] then return end

	Player.CanSetupPlayer = nil
	Player:Freeze(false)

	local Model = Args[1]
	local FirstName = tmysql.escape(string.upper( string.sub( Args[2], 1, 1 ) ) .. string.lower( string.sub( Args[2], 2 ) ))
	local LastName = tmysql.escape(string.upper( string.sub( Args[3], 1, 1 ) ) .. string.lower( string.sub( Args[3], 2 ) ))

	if not Model or not FirstName or not LastName then
		print("NC Error: Invalid Data sent.")
		return Player:ForceRename()
	end

	local modelInfo = GAMEMODE.ConvertModelInfo( Model ) or {}

	if modelInfo.gender != SEX_MALE and modelInfo.gender != SEX_FEMALE then net.Start("perp_newchar") net.Send(Player) print("NC Error: Gender not set properly.") return end
	if not JOB_DATABASE[TEAM_CITIZEN].Playermodels[modelInfo.gender][modelInfo.face] then net.Start("perp_newchar") net.Send(Player) print("NC Error: Face not valid in gender.") return end
	modelInfo.clothes = {
		[1] = 3,
		[2] = 5
	}
	modelInfo.skin = 0

	local theirNewModel = Player:GetModelPath( modelInfo.gender or "m", tonumber( modelInfo.face ) or 1 )
	
	Player:SetModel( theirNewModel )
	Player:SetPNWVar( "model", theirNewModel )
	Player.ModelInfo = modelInfo
	Player:SetPNWVar( "ModelInfo", modelInfo )
	Player.DefaultBodygroups = modelInfo.clothes or {}
	for k, v in pairs(Player.DefaultBodygroups) do
		Player:SetBodygroup(k, v)
	end

	tmysql.query( Format( Query( "UPDATEPLAYERMODEL" ), util.TableToJSON(modelInfo or {}), Player.PERPID ) )
	if not GAMEMODE.IsValidName( FirstName, LastName ) then 
		print("NC Error: Name not valid: " .. FirstName, LastName)
		return Player:ForceRename()
	end

	tmysql.query( Format( Query( "CHECKUSERNAMEAVAILABLITY" ), FirstName, LastName ), function( Results, Status, ErrorMsg )
		if Results[1] then
			Player:Notify( "This name is already taken, try again." )
			Player.p_NewCharacter = true
			print("NC Error: Name already taken.")
			return Player:ForceRename()
		else
			Player:SetGNWVar( "rp_fname", FirstName )
			Player:SetGNWVar( "rp_lname", LastName )
			
			tmysql.query( Format( Query( "UPDATEUSERNAME" ), FirstName, LastName, Player.PERPID ) )
			
			Player.CanSave = true
			print("NC: " .. FirstName .. " ".. LastName .." has been authenticated")
			GAMEMODE:PlayerAuthed( Player );
		end
	end, QUERY_FLAG_ASSOC )

end )

/*************************************************
	Command "perp_cn"
	Job: Change player name
*************************************************/

concommand.Add( "perp_cn", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end
	if not Player.CanRenameFree and not Player:NearNPC( 1 ) then return Player:CaughtCheating( "Trying to change name without being near the NPC." ) end

	local FirstName = tmysql.escape(string.upper( string.sub( Args[1], 1, 1 ) ) .. string.lower( string.sub( Args[1], 2 ) ))
	local LastName = tmysql.escape(string.upper( string.sub( Args[2], 1, 1 ) ) .. string.lower( string.sub( Args[2], 2 ) ))
	
	if not FirstName or not LastName then return end
	if FirstName == Player:GetFirstName() and LastName == Player:GetLastName() then return Player:CaughtCheating( "Trying to get a free name change with 'perp_cn'" ) end

	if not GAMEMODE.IsValidName( FirstName, LastName ) then 
		return Player:ForceRename()
	end

	if not Player.CanRenameFree then
		if Player:GetCash() < GAMEMODE.RenamePrice then
			return
		end
	end

	tmysql.query( Format( Query( "CHECKUSERNAMEAVAILABLITY" ), FirstName, LastName ), function( Results, Status, ErrorMsg )
		if Results[1] then
			Player:Notify( "This name is already taken, try again." )
			return Player:ForceRename()
		else
			if not Player.CanRenameFree then
				local Log = Format( "%s spent $%s on a name change", Player:Nick(), util.FormatNumber( GAMEMODE.RenamePrice ) )
				GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

				Player:TakeCash( GAMEMODE.RenamePrice, true )

				Player:Notify( Format( "Your name was successfully changed to %s for $%s", FirstName .. " " .. LastName, util.FormatNumber( GAMEMODE.RenamePrice ) ) )
				Player.CurrentlyRenaming = nil
			end
		
			Player.CanRenameFree = nil

			local old_name = Player:GetRPName()

			local Log = Format( "%s<%s> changed their name from %s to %s", Player:Nick(), Player:SteamID(), old_name, FirstName .. " " .. LastName )
			GAMEMODE:Log( "namelog", Log )

			Player:SetGNWVar( "rp_fname", FirstName )
			Player:SetGNWVar( "rp_lname", LastName )

			tmysql.query( Format( Query( "UPDATEUSERNAME" ), FirstName, LastName, Player.PERPID ) )
			tmysql.query( Format( Query( "UPDATEUSERNAMEINFO" ), Player:GetRPName(), Player.PERPID ) )

			if Player.p_NewCharacter then
				GAMEMODE:PlayerAuthed( Player );
				Player.p_NewCharacter = false
			end

		end
	end, QUERY_FLAG_ASSOC )	
end )

/*************************************************
	Command "perp_cf"
	Job: Change Facial
*************************************************/

concommand.Add( "perp_cf", function( Player, Command, Args )
	if not Player:NearNPC( 8 ) then return Player:CaughtCheating( "Trying to change clothes without being near the NPC." ) end

	if not Args[1] then return end
	if Player:Team() ~= TEAM_CITIZEN then return end
	if Player:GetCash() < GAMEMODE.FacialPrice then return end
	
	local Face = tonumber(Args[1])
	local Skin = tonumber(Args[2])

	if not Face then return end
	if not Skin then return end

	if Skin > Player:SkinCount() then return end
	if not JOB_DATABASE[TEAM_CITIZEN].Playermodels[Player.ModelInfo.gender][Face] then return end

	local Log = Format( "%s spent $%s on a name facial", Player:Nick(), util.FormatNumber( GAMEMODE.FacialPrice ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( GAMEMODE.FacialPrice, true )

	local theirNewModel = Player:GetModelPath( Player.ModelInfo.gender or "m", Face )

	Player:SetModel( theirNewModel )
	Player:SetPNWVar( "model", theirNewModel )
	Player.ModelInfo = Player.ModelInfo or {}
	Player.ModelInfo.face = Face
	Player.ModelInfo.skin = Skin
	Player:SetSkin(Skin)
	Player:SetPNWVar( "ModelInfo", Player.ModelInfo )
	Player.DefaultBodygroups = Player.ModelInfo.clothes
	for k, v in pairs(Player.DefaultBodygroups) do
		Player:SetBodygroup(k, v)
	end

	tmysql.query( Format( Query( "UPDATEPLAYERMODEL" ), util.TableToJSON(Player.ModelInfo), Player.PERPID ) )

	Player:Notify( Format( "You have spent $%s on a new facial", util.FormatNumber( GAMEMODE.FacialPrice ) ) )
end )

/*************************************************
	"perp_cc"
	Job: Change Clothes
*************************************************/
util.AddNetworkString("perp_cc")
net.Receive( "perp_cc", function( len, Player )
	if not Player:NearNPC( 9 ) then return Player:CaughtCheating( "Trying to change clothes without being near the NPC." ) end

	if Player:Team() ~= TEAM_CITIZEN then return end
	if Player:GetCash() < GAMEMODE.ClothesPrice then return end

	local clothes = net.ReadTable()
	if not clothes then return end

	-- this basically just checks if the player chose valid bodygroups.
	local confirmedclothes = {}
	for id, value in pairs(clothes) do
		for k, bg in pairs(JOB_DATABASE[TEAM_CITIZEN].Bodygroups[Player:GetSex()]) do
			if bg.ID == id then 
				for _, sub in pairs(bg.Submodels) do
					if sub[1] == value then
						confirmedclothes[id] = tmysql.escape(value)
						continue
					end
				end
				continue
			end
		end
	end
	
	local Log = Format( "%s spent $%s on new clothes", Player:Nick(), util.FormatNumber( GAMEMODE.ClothesPrice ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( GAMEMODE.ClothesPrice, true )

	Player.ModelInfo = Player.ModelInfo or {}
	Player.ModelInfo.clothes = confirmedclothes
	Player:SetPNWVar( "ModelInfo", Player.ModelInfo )
	Player.DefaultBodygroups = Player.ModelInfo.clothes
	for k, v in pairs(Player.DefaultBodygroups) do
		Player:SetBodygroup(k, v)
	end

	tmysql.query( Format( Query( "UPDATEPLAYERMODEL" ), util.TableToJSON(Player.ModelInfo or {}), Player.PERPID ) )

	Player:Notify( Format( "You have spent $%s on new clothes.", util.FormatNumber( GAMEMODE.ClothesPrice ) ) )
end )

/*************************************************
	Command "perp_cs"
	Job: Change Sex
*************************************************/

concommand.Add( "perp_cs", function( Player, Command, Args )
	if not Player:NearNPC( 10 ) then return Player:CaughtCheating( "Trying to change sex without being near the NPC." ) end

	if Player:Team() ~= TEAM_CITIZEN then return end
	if Player:GetCash() < GAMEMODE.SexChangePrice then return end

	local newSex = SEX_MALE
	if Player:GetSex() == SEX_MALE then newSex = SEX_FEMALE end

	local Log = Format( "%s spent $%s on a sex change", Player:Nick(), util.FormatNumber( GAMEMODE.SexChangePrice ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )


	Player:TakeCash( GAMEMODE.SexChangePrice, true )
	
	local theirNewModel = Player:GetModelPath( newSex, 1 )
	
	Player:SetModel( theirNewModel )
	Player:SetPNWVar( "model", theirNewModel )
	Player.ModelInfo.clothes = {}
	Player.ModelInfo.face = 1
	Player.ModelInfo.gender = newSex
	Player:SetPNWVar( "ModelInfo", Player.ModelInfo )
	Player.DefaultBodygroups = {}
	
	tmysql.query( Format( Query( "UPDATEPLAYERMODEL" ), tmysql.escape(util.TableToJSON(Player.ModelInfo or {})), Player.PERPID ) )

	Player:Notify( Format( "You have spent $%s on a sex change", util.FormatNumber( GAMEMODE.SexChangePrice ) ) )
end )

/*************************************************
	Command "pt"
	Job: The spinning shit above your head while you type
*************************************************/

concommand.Add( "pt", function( Player, Command, Args )
	if Args[1] and tostring( Args[1] ) == "1" then
		Player:SetGNWVar( "typing", 1 )
		Player.StartedTyping = CurTime()
	else
		Player:SetGNWVar( "typing", nil )
		Player.StartedTyping = nil
	end
end )

/*************************************************
	Command "perp_ab"
	Job: Add Buddy to Buddy List
*************************************************/

concommand.Add( "perp_ab", function( Player, Command, Args )
	if not Args[1] then return end
	if tostring( tonumber( Args[1] ) ) ~= tostring( Args[1] ) then return end
	
	Player.Buddies = Player.Buddies or {}
	table.insert( Player.Buddies, Args[1] )
end )

/*************************************************
	Command "perp_rb"
	Job: Remove Buddy from Buddy List
*************************************************/

concommand.Add( "perp_rb", function( Player, Command, Args )
	if not Args[1] or not Player.Buddies then return end
	if tostring( tonumber( Args[1] ) ) ~= tostring( Args[1] ) then return end
	
	for k, v in pairs( Player.Buddies ) do
		if v == Args[1] then
			Player.Buddies[ k ] = nil
		end
	end
end )