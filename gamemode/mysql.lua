--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

MySQL = {
	Hostname = "perp.asocket.net", 				-- Hostname, normally "localhost"
	Username = "u123_s0vqpd4PQc", 	 			-- MySQL Username
	Password = "956Vv+@CD4jgVq^J@dGjhF0C", 		-- MySQL Password
	Database = "s123_aSocket_PERP",				-- MySQL Database
	Port 	 = 3306,							-- MySQL Port
}

function InitializeMySQL(func)

	Msg( "Loading MySQL... " )

	if tmysql then Msg( "Done\n" ) end

	TOTAL_QUERIES_RAN = 0
	TOTAL_QUERIES_ERRORED = 0

	local tmysql_connection, error = tmysql.Connect( MySQL.Hostname, MySQL.Username, MySQL.Password, MySQL.Database, MySQL.Port )
	if tmysql_connection then
		MsgC(Color(0, 255, 0), 'Succesfully connected to MySQL Database!\n')
	else
		print(error)
		MsgC(Color(255, 0, 0), '***DID NOT connect to MySQL Database!****\n')
	end

	if not tmysql_connection then
		if func then
			func(false, error)
		end
		return
	end
	if func then
		func(true)
	end
	function tmysql.query( sqlquery, callback, flags, callbackarg )
		local Trace = debug.getinfo( 2 )
		local Time = CurTime()

		local function Wrapper( results )

			-- wrap from tmysql4 to tmysql3
			local new_results = {}
			for k, v in pairs(results or {}) do
				if v.error then
					Error("TMYSQL ERROR! " .. tostring(v.error) .. "\n" .. sqlquery)
				end
				if v.data then
					new_results[k] = v.data
				end
			end
		
			if not new_results[2] then
				new_results = new_results[1]
			end
		
			if callback then callback( new_results, results ) end
		
		end

		tmysql_connection:Query( sqlquery, Wrapper, flags )
		TOTAL_QUERIES_RAN = TOTAL_QUERIES_RAN + 1
	end

	tmysql.escape = function(string)
		return tmysql_connection:Escape(string)
	end

	GAMEMODE:LoadOrganizations()

end

concommand.Add("reconnectmysql", function(ply)
	if IsValid(ply) and not ply:IsSuperAdmin() then return end
	MsgC(Color(255, 0, 0), 'Attempting to connect to database!!\n')
	InitializeMySQL(function(didConnect, error)
		if didConnect then
			MsgC(Color(0, 255, 0), 'Reconnection successful!\n')
		else
			MsgC(Color(0, 255, 0), 'Reconnection FAILED!! Reason: ' .. tostring(error) ..  '\n')
		end
	end)
end)

//This is only a temporary solution and the best would be to change to mysqloo completely
//A few incompatibilities:
//Mysql Bit fields are returned as numbers instead of a single char
//Mysql Bigint fields are returned as numbers
//This might pose a problem if you have a bigint field for steamid64
//Always make sure to cast that field to a string in the SELECT clause of your query
//Example: SELECT CAST(steamid64 as 'CHAR') as steamid64 FROM ...

require("mysqloo")
if (mysqloo.VERSION != "9") then
	error("using outdated mysqloo version")
end
tmysql = tmysql or {}
tmysql.Connections = tmysql.Connections or {}
local database = {}
local baseMeta = FindMetaTable("MySQLOO Database") or {} -- this ensures backwards compatibility to <=9.6
local databaseMT = {__index = function(tbl, key)
	return database[key] or baseMeta[key]
end}
function database:Escape(...)
	if (self.Disconnected) then error("database already disconnected") end
	return self:escape(...)
end
function database:Connect()
	self:connect()
	self:wait() //this is dumb
	//Unfortunately mysqloo only passes the error message to a callback
	//because waiting for the db to connect is really dumb
	//so there is no way to retrieve the actual error message here
	if (self:status() != mysqloo.DATABASE_CONNECTED) then
		return false, "[TMYSQL Wrapper]: Failed to connect to database"
	end
	table.insert(tmysql.Connections, self)
	return true
end
function database:Query(str, callback, ...)
	if (self.Disconnected) then error("database already disconnected") end
	local additionalArgs = {...}
	local qu = self:query(str)
	if (!callback) then
		qu:start()
		return
	end
	qu.onSuccess = function(qu, result)
		local results = {
			{
				status = true,
				error = nil,
				affected = qu:affectedRows(),
				lastid = qu:lastInsert(),
				data = result
			}
		}
		while(qu:hasMoreResults()) do
			result = qu:getNextResults()
			table.insert(results, {
				status = true,
				error = nil,
				affected = qu:affectedRows(),
				lastid = qu:lastInsert(),
				data = result
			})
		end
		table.insert(additionalArgs, results)
		callback(unpack(additionalArgs))
	end
	qu.onAborted = function(qu)
		local data = {
			status = false,
			error = "Query aborted"
		}
		table.insert(additionalArgs, {data})
		callback(unpack(additionalArgs))
	end
	qu.onError = function(qu, err)
		local data = {
			status = false,
			error = err
		}
		table.insert(additionalArgs, {data})
		callback(unpack(additionalArgs))
	end
	qu:start()
end
	
function database:SetCharacterSet(name)
	return self:setCharacterSet(name)
end
function database:Disconnect()
	if (self.Disconnected) then error("database already disconnected") end
	self:abortAllQueries()
	table.RemoveByValue(tmysql.Connections, self)
	self.Disconnected = true
	self:disconnect()
end
function database:Option(option, value)
	if (self.Disconnected) then error("database already disconnected") end
	if (option == bit.lshift(1, 16)) then	
		self:setMultiStatements(tobool(value))
	else
		print("[TMYSQL Wrapper]: Unsupported tmysql option")
	end
end
function tmysql.GetTable()
	return tmysql.Connections
end
//Clientflags are ignored, multistatements are always enabled by default
function tmysql.initialize(host, user, password, database, port, unixSocketPath, clientFlags)
	local db = mysqloo.connect(host, user, password, database, port, unixSocketPath)
	setmetatable(db, databaseMT)
	local status, err = db:Connect()
	if (!status) then
		return nil, err
	end
	return db, err
end
function tmysql.Create(host, user, password, database, port, unixSocketPath, clientFlags)
	local db = mysqloo.connect(host, user, password, database, port, unixSocketPath)
	setmetatable(db, databaseMT)
	return db
end
tmysql.Connect = tmysql.initialize