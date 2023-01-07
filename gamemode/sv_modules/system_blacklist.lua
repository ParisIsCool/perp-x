--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- Made by G-Force Connections
-- Dynamic system which will allow you to add blacklist types without having to recreate too much code...

-- System has 2 types of blacklist, one main blacklist and one multi valued blacklist

-- Multi value: self.Blacklists[ "name" ][ "custom_value" ] = "expire time"

-- Main value: self.Blacklists[ "name" ] = "expire time"

util.AddNetworkString("BlacklistTable")
function PLAYER:UpdateBlacklists()
	for k, v in pairs(player.GetHumans()) do
		if not v:IsAdmin() then continue end
		net.Start("BlacklistTable")
			net.WriteString(self:UniqueID())
			net.WriteTable(self.Blacklists)
		net.Send(v)
	end
end

util.AddNetworkString("BlacklistAdminTable")
function PLAYER:AdminGiveBlacklists()
	local blacklists = {}
	for k, v in pairs(player.GetAll()) do
		blacklists[v:UniqueID()] = v.Blacklists
	end
	net.Start("BlacklistAdminTable")
		net.WriteTable(blacklists)
	net.Send(self)
end

util.AddNetworkString("Blacklist")
function PLAYER:LoadBlacklists()
	self.Blacklists = {}

	tmysql.query( Format( Query( "SELECTBLACKLIST" ), self:SteamID() ), function( Results, Status, ErrorMsg )
		if not Results or not Results[1] then return end

		for _, v in pairs( Results ) do
			if v.type and v.expire and (tonumber( v.expire ) > os.time() or tonumber( v.expire ) == 0 ) then
				if v.value ~= "" then
					self.Blacklists[ v.type ] = self.Blacklists[ v.type ] or {}

					self.Blacklists[ v.type ][ v.value ] = { Reason = v.reason, Expire = tonumber( v.expire ) }

					--self:UpdateBlacklists()

				else
					
					if GAMEMODE:IsSerious() && v.type == 'serious' then
						gatekeeper.Drop(self:UserID(), 'You are blacklisted from the serious server!')
					end
					
					self.Blacklists[ v.type ] = { Reason = v.reason, Expire = tonumber( v.expire ) }

					--self:UpdateBlacklists()
				end
			else
				if v.value ~= "" then
					tmysql.query( Format( Query( "DELETEBLACKLIST2" ), self:SteamID(), tmysql.escape( v.type ), tmysql.escape( v.value ) ) )
				else
					tmysql.query( Format( Query( "DELETEBLACKLIST" ), self:SteamID(), tmysql.escape( v.type ) ) )
				end
			end
		end

		self:UpdateBlacklists()

	end, QUERY_FLAG_ASSOC )

	timer.Simple(1, function()
		if IsValid(self) and self:IsAdmin() then
			self:AdminGiveBlacklists()
		end
	end)

	-- Load others blacklists and send to admin
	--[[if self:IsAdmin() then
		for _, v in pairs( player.GetAll() ) do
			if not v.Blacklists or self == v then continue end
			for k, g in pairs( v.Blacklists ) do
				if k == "job" then
					for k, g in pairs( g ) do
						net.Start( "Blacklist" )
							net.WriteString( v:UniqueID() )
							net.WriteString( "job" )
							net.WriteInt( g.Expire, 32 )
							net.WriteString( g.Reason )
							net.WriteString( TeamName[ k ] )
						net.Send(self)
					end
				else
					net.Start( "Blacklist" )
						net.WriteString( v:UniqueID() )
						net.WriteString( k )
						net.WriteInt( g.Expire, 32 )
						net.WriteString( g.Reason )
					net.Send(self)
				end
			end
		end
	end]]
end

concommand.Add("perp_rebuild_lists", function(ply)
	if not ply:IsAdmin() then return end -- could be exploited for lag.
	for _, v in pairs( player.GetAll() ) do
		v:LoadBlacklists()
		MsgN("Rebuilding Lists.....");
	end
end )

concommand.Add("perp_giveblacklists", function(ply)
	if not ply:IsAdmin() then return end -- could be exploited for lag.
	ply:AdminGiveBlacklists()
end )

concommand.Add("perp_print_blacklists", function(ply)
	if not ply:IsAdmin() then return end -- could be exploited for lag.
	for k, v in pairs(player.GetAll()) do
		PrintTable(v.Blacklists)
	end
end )

function PLAYER:GiveBlacklist( Type, Expire, Reason, AdminID, Value )
	self.Blacklists = self.Blacklists or {}

	if Value then
		if self.Blacklists[ Type ] and self.Blacklists[ Type ][ Value ] ~= nil and ( self.Blacklists[ Type ][ Value ].Expire == 0 or self.Blacklists[ Type ][ Value ].Expire > os.time() ) then -- Already blacklisted and is good, why continue?
			return
		end

		self.Blacklists[ Type ] = {}
		
		if Expire == 0 then
			self.Blacklists[ Type ][ Value ] = { Reason = Reason, Expire = Expire }

			tmysql.query( Format( Query( "INSERTBLACKLIST2" ), self:SteamID(), tmysql.escape( Type ), Expire, tmysql.escape( Reason ), tmysql.escape( Value ), AdminID ) )
		else
			self.Blacklists[ Type ][ Value ] = { Reason = Reason, Expire = Expire + os.time() }
			
			tmysql.query( Format( Query( "INSERTBLACKLIST2" ), self:SteamID(), tmysql.escape( Type ), Expire + os.time(), tmysql.escape( Reason ), tmysql.escape( Value ), AdminID ) )
		end
	else
		if self.Blacklists[ Type ] and ( self.Blacklists[ Type ].Expire == 0 or self.Blacklists[ Type ].Expire > os.time() ) then -- Blacklist is still valid
			return
		end
		
		if Expire == 0 then
			self.Blacklists[ Type ] = { Reason = Reason, Expire = Expire }

			tmysql.query( Format( Query( "INSERTBLACKLIST" ), self:SteamID(), tmysql.escape( Type ), Expire, tmysql.escape( Reason ), AdminID ) )
		else
			self.Blacklists[ Type ] = { Reason = Reason, Expire = Expire + os.time() }

			tmysql.query( Format( Query( "INSERTBLACKLIST" ), self:SteamID(), tmysql.escape( Type ), Expire + os.time(), tmysql.escape( Reason ), AdminID ) )
		end
	end

	if Type == "serious" && GAMEMODE:IsSerious() then
		gatekeeper.Drop(self:UserID(), "You have been blacklisted from the serious server")
		return
	end

	self:UpdateBlacklists()

end

util.AddNetworkString("UnBlacklist")
function PLAYER:RevokeBlacklist( Type, Value )
	self.Blacklists = self.Blacklists or {}
	if not self:HasBlacklist( Type, Value ) then return end

	if Value then
		self.Blacklists[ Type ][ Value ] = nil

		tmysql.query( Format( Query( "DELETEBLACKLIST2" ), self:SteamID(), tmysql.escape( Type ), tmysql.escape( Value ) ) ) -- Cleanup mysql
	else
		self.Blacklists[ Type ] = nil

		tmysql.query( Format( Query( "DELETEBLACKLIST" ), self:SteamID(), tmysql.escape( Type ) ) ) -- Cleanup mysql
	end

	self:UpdateBlacklists()
end

-- Returns table, Reason + Expire time
function PLAYER:HasBlacklist( Type, Value )
	self.Blacklists = self.Blacklists or {}
	local PossibleBlacklist = self.Blacklists[ Type ]

	if Value and PossibleBlacklist then
		if PossibleBlacklist[ Value ] then
			if PossibleBlacklist[ Value ].Expire and ( PossibleBlacklist[ Value ].Expire == 0 or PossibleBlacklist[ Value ].Expire > os.time() ) then
				return PossibleBlacklist[ Value ]
			elseif PossibleBlacklist[ Value ].Expire == 0 then
				--print("perm");
				return PossibleBlacklist[ Value ]
			else -- Expired
				self.Blacklists[ Type ][ Value ] = nil

				for _, v in pairs( player.GetAll() ) do
					if v ~= self and not v:IsAdmin() then continue end

					net.Start( "UnBlacklist" )
						--net.WriteEntity( self ) -- Why writing entity? The code uses unique ID?
						net.WriteString( self:UniqueID() )
						net.WriteString( Type )
						net.WriteString( TeamName[ Value ] )
					net.Send(v)
				end

				tmysql.query( Format( Query( "DELETEBLACKLIST2" ), self:SteamID(), Type, Value ) ) -- Cleanup mysql
			end
		end
	elseif PossibleBlacklist then
		if PossibleBlacklist.Expire and ( PossibleBlacklist.Expire == 0 or PossibleBlacklist.Expire > os.time() ) then
			return PossibleBlacklist
		else -- Expired
			self.Blacklists[ Type ] = nil

			for _, v in pairs( player.GetAll() ) do
				if v ~= self and not v:IsAdmin() then continue end

				net.Start( "UnBlacklist" )
					--net.WriteEntity( self ) -- Why writing entity? The code uses unique ID?
					net.WriteString( self:UniqueID() )
					net.WriteString( Type )
				net.Send(v)
			end

			tmysql.query( Format( Query( "DELETEBLACKLIST" ), self:SteamID(), Type ) )  -- Cleanup mysql
		end
	end
end