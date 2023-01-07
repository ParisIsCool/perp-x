--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
//  Developed Listening To:  //
//      Cage The Beatles     //
///////////////////////////--]]

local function InitializeMySQL(func)

	Msg( "Loading MySQL... " )

	--require( "tmysql4" )
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

function GM:Initialize()

	InitializeMySQL()

	SetGNWVar( "ticket_price", TICKET_PRICE )
	SetGNWVar( "tax_income", TAX_INCOME )
	SetGNWVar( "tax_sales", TAX_SALES )
	SetGNWVar( "nationalguard_active", 0) //sets national guard to inactive when server starts!

	if file.Exists( "perp/slot_jackpot.txt", "DATA" ) then
		SetGNWVar( "jackpot", math.Round( tonumber( file.Read( "perp/slot_jackpot.txt", "DATA" ) ) ) )
	end

	RunConsoleCommand("sv_allowdownload", "0");
	RunConsoleCommand("sv_allowupload", "0");
	RunConsoleCommand("sv_usemessage_maxsize", "10000");
	RunConsoleCommand("lua_log_sv", "1");
	RunConsoleCommand("sv_loadingurl", "http://perp.asocket.net/load/");
	RunConsoleCommand("sv_visiblemaxplayers", "50");
	RunConsoleCommand("sv_kickerrornum", "0");
	RunConsoleCommand("sv_minupdaterate", "10");
	
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

--[[
	
	PLAYER LOADING AND AUTHENTICATING

]]

util.AddNetworkString("TimeSync")
util.AddNetworkString("UpdateMixtures")
util.AddNetworkString("SendWagesToClients")

function PLAYER:LoadAccount(AccountNum)

	self:LoadWarehouse()
	self:LoadBlacklists()
	self:LoadVehicles()
	self:LoadAchievements()
	self:LoadCollectables()
	self:RefreshPerpExtra()

	GAMEMODE.LoadPhysgun( self )
	
	net.Start( "TimeSync" )
	net.WriteInt( os.time(), 32)
	net.Send(self)
	
	net.Start("SendWagesToClients")
	net.WriteTable(GAMEMODE.JobWages or {})
	net.WriteTable(GAMEMODE.MaxJobs or {})
	net.WriteTable(GAMEMODE.MaxVehicles or {})
	net.WriteString(GAMEMODE.MayorLaws or "")
	net.Send(self)

	tmysql.query( Format( Query( "SELECTACCOUNT" ), self:SteamID(), AccountNum ), function( Results, Status, ErrorMsg )
	
		if not IsValid( self ) then return end
	
		self.joinTime = CurTime()
	
		if not Results or not Results[1] then self:CreateAccount( false ) return end
	
		Results = Results[1] -- We only need the one row.
	
		if Results[ "rp_name_first" ] == "John" and Results[ "rp_name_last" ] == "Doe" then
			self:CreateAccount( true )
			return
		end
	
		--[[ Weapon Ammo ]]
		local Ammo = string.Explode( "-", Results[ "ammo" ] )
		self:GiveAmmo( Ammo[1] and tonumber( Ammo[1] ) or 0, "pistol" )
		self:GiveAmmo( Ammo[2] and tonumber( Ammo[2] ) or 0, "smg1" )
		self:GiveAmmo( Ammo[3] and tonumber( Ammo[3] ) or 0, "buckshot" )
		self:GiveAmmo( Ammo[4] and tonumber( Ammo[4] ) or 0, "ar2" )
	
		--[[ Model ]]
		self.DefaultModel = Results[ "model" ]
		local ModelInfo = GAMEMODE.ConvertModelInfo( Results[ "model" ] )
		self.ModelInfo = ModelInfo
		self:SetPNWVar( "ModelInfo", ModelInfo )
	
		local PlayerModel = self:GetModelPath( ModelInfo.gender or "m", tonumber( ModelInfo.face ) or 1 )
		self:SetModel( PlayerModel )
		self:SetSkin(ModelInfo.skin)
		self:SetPNWVar( "model", PlayerModel )
		self.DefaultBodygroups = ModelInfo.clothes or {}
		for k, v in pairs(self.DefaultBodygroups) do
			self:SetBodygroup(k, v)
		end
	
		--[[ Private Networked Variables ]]
		self:SetPNWVar( "time_played", tonumber( Results[ "time_played" ] ) )
		if tonumber( Results[ "time_played" ] ) < 3600*8 then
			self:SetNWInt("unraidable_until", os.time() + ((3600*8)-tonumber( Results[ "time_played" ] )) )
		else
			self:SetNWInt("unraidable_until", 0)
		end
	
	
		self:SetPNWVar( "cash", tonumber( Results[ "cash" ] ) )
		self:SetPNWVar( "bank", tonumber( Results[ "bank" ] ) )
		self:SetPNWVar( "mixtures", Results[ "formulas" ] )
	
		--[[ Public Networked Variables ]]
		self:SetGNWVar( "rp_fname", Results[ "rp_name_first" ] )
		self:SetGNWVar( "rp_lname", Results[ "rp_name_last" ] )
		self:SetGNWVar( "ringtone", tonumber( Results[ "ringtone" ] ) )
		self:SetNWString( "BackgroundURL", Results["background"] )
		self:SetRP( tonumber( Results[ "reputation" ] ) )
		self:SetLerpedRP( tonumber( Results[ "reputation" ] ) )
		self:FindLevel()

		--[[ Organization ]]
		local OrgID = tonumber( Results[ "organization" ] )
		if OrgID ~= 0 and GAMEMODE.OrganizationData[ OrgID ] then
			self:SetGNWVar( "org", OrgID )
			GAMEMODE:RequestOrganizationData( self, OrgID )
		end
	
		for k, v in pairs( GAMEMODE.OrganizationData ) do
			if k == OrgID then continue end
			net.Start( "perp_srod" )
			net.WriteInt( k, 16 )
			net.WriteString( v[1] )
			net.Send(self)
		end
	
		--[[ Skills ]]
		local ExplodeSkills = string.Explode( "-", Results[ "skills" ] )
		for i = 1, #SKILLS_DATABASE do
			if ExplodeSkills[ i ] and i ~= #ExplodeSkills then
				self:SetPNWVar( "s_" .. i, tonumber( ExplodeSkills[ i ] ) )
	
				local PostLevel = self:GetSkillLevel( SKILLS_DATABASE[ i ][1] )
				self:AchievedLevel( SKILLS_DATABASE[ i ][1], PostLevel )
			end
		end
	
		--[[ Genetics ]]
		local Genes = util.JSONToTable(Results["genes"])
		if not Genes then Genes = {FreeGenes=5,Genes={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0}} end
		local TotalGenes = 0
		for k, v in pairs(Genes.Genes) do TotalGenes = TotalGenes + v end
		if Genes.FreeGenes+TotalGenes > GAMEMODE.MaxGenesVIP then
			Genes = {FreeGenes=GM.MaxGenes,Genes={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0}}
		end
		for k, v in pairs(Genes.Genes) do
			Genes.Genes[k] = tonumber(v)
		end
		Genes.FreeGenes = tonumber(Genes.FreeGenes)
		self:SetPNWVar("Genes",Genes)
	
		--[[ Misc ]]
		if not GAMEMODE.IsValidName( Results[ "rp_name_first" ], Results[ "rp_name_last" ] ) then
			self:ForceRename()
		end
	
		--[[ Loading Items ]]
		self:LoadItems( Results[ "items" ] )
		timer.Simple( 0, function() self:EquipMains() end ) -- next frame
		net.Start( "UpdateMixtures" ) net.Send(self) -- Loads too early clientside, update listing here.

		--[[ Business Data ]]
		self["Business_Data"] = util.JSONToTable(Results["business_data"] or "") or {}

	
		self:ChatPrint( "Your account has been loaded after " .. math.Round( SysTime() - self.Loadtime, 3 ) .. " sec(s)." )
		self.Loadtime = nil
	
		timer.Create( self:SteamID(), 600, 0, function() if IsValid(self) then self:PERPSave() end end )
		--timer.Create( self:SteamID().."FreeRP", 240, 0, function() if IsValid(self) then self:AddRP(50) self:ReputationNotify( "+50 RP for being a good sport!" ) end end )
		self.CanSave = true
	end, QUERY_FLAG_ASSOC )
end

util.AddNetworkString("perp_createcharacter")
net.Receive("perp_createcharacter", function(len,Player)
	local AllowedNum = 1
	if Player:IsVIP() then AllowedNum = 2 end
	if Player:IsGoldVIP() then AllowedNum = 3 end
	tmysql.query( Format( Query( "SELECTID" ), Player:SteamID() ), function( Results, Status, ErrorMsg )
		if #Results < AllowedNum then
			Player:CreateAccount(false)
		end
	end)
end)

function GM:PlayerAuthed( Player )

	if not IsValid( Player ) then return end

	if aSoc then 
		aSoc.Initialize( Player )
	end

end

util.AddNetworkString("perp_chooseuser")
function GM:PlayerFullLoad(Player)
	Player.Loadtime = SysTime()
	tmysql.query( Format( Query( "SELECTID" ), Player:SteamID() ), function( Results, Status, ErrorMsg )
		if Results and Results[1] then
			-- null state...
			Player:Freeze(true)
			Player.AwaitingCharSelect = true
			-- possibly make invisible?
			local sentdata = {}
			for k, v in pairs(Results) do
				sentdata[v.id] = {
					Name = v["rp_name_first"] .. " " .. v["rp_name_last"],
					Model = v["model"],
					Cash = v["cash"],
					Bank = v["bank"],
					Timeplayed = v["time_played"],
					Color = v["physgun_col"]
				}
			end
			net.Start("perp_chooseuser") net.WriteTable(sentdata) net.Send(Player)
		else
			Player:Freeze(false)
			Player:CreateAccount(false)
		end
	end)
end

concommand.Add("loadplayer", function(ply)
	if not ply:IsLeader() then return end
	ply.Loadtime = SysTime()
	ply:LoadAccount(ply.PERPID)
end)

concommand.Add("chooseplayer", function(ply)
	if not ply:IsLeader() then return end
	GAMEMODE:PlayerFullLoad(ply)
end)

concommand.Add("loadallplayers", function(ply)
	if not ply:IsLeader() then return end
	for k, v in pairs(player.GetAll()) do
		v:LoadAccount(v.PERPID)
	end
end)

-- Character Selection Received
net.Receive("perp_chooseuser", function(len,Player)

	Player:SendGNWVars() -- Send all GNWVars to the client
	
	if not Player.AwaitingCharSelect then return end
	Player.AwaitingCharSelect = false

	local id = net.ReadInt(32)

	Player.AwaitingCharSelect = false

	if id == Player.PERPID then 

	else
		GAMEMODE:PlayerSpawn( Player )
		Player:PERPSave()
		Player:Reset()
	end
	-- add delete button stuff here

	Player.Loadtime = SysTime()
	tmysql.query( Format( Query( "SELECTACCOUNT" ), Player:SteamID(), id ), function( Results, Status, ErrorMsg ) 

		if Results and Results[1] then
			-- Success
			Player.PERPID = id
			Player:LoadAccount(Player.PERPID)
			timer.Simple(3, function()
				Player:Freeze(false)
				local msg = {}
				if Player:GetTimePlayed() < 300 then
					msg = {
						{"Welcome to PERP X! Use [ W ] [ A ] [ S ] [ D ] to move and\n[  TAB  ] to open the scoreboard! The rules in the [  TAB  ]\n are enforced on this server!", 15},
						{"Use [ Y ] to chat locally and [ U ] to chat globally!\nYou may link your discord using /discord to receive perks!", 15},
						{"Press [ Q ] to open your inventory. This menu is where\nyou create mixtures, modify genetics, view skills, and see inventory!", 15},
						{"If you need any help, use [ U ] to ask in OOC for help!", 15}
					}
				else
					msg = {
						{"Welcome back! Remember to read the rules in [  TAB  ]\nType /discord in chat to link your discord!",10},
					}
				end
				local offset = 2
				for _, msg in ipairs(msg) do
					timer.Simple(msg[2] + offset, function()
						Player:SendToolTip(msg[1], msg[2])
					end)
					offset = offset + msg[2]
				end
			end)
		else
			-- Failure, Reauthentication.
			GAMEMODE:PlayerFullLoad( Player )
		end
	end )

end)

util.AddNetworkString("perp_newchar")
function PLAYER:CreateAccount( InDatabaseAlready )
	if not IsValid( self ) then return end
	net.Start("perp_newchar") net.Send(self)
	self.CanSetupPlayer = true

	Msg( "Setting up new user account for " .. self:Nick() .. "\n" )
	
	if not InDatabaseAlready then
		tmysql.query( Format( Query( "CREATEACCOUNT" ), self:SteamID(), os.time() ), function(_,data) self.PERPID = data[1].lastid end  )
	end
	
	local selfModel = self:GetModelPath( "m", 1 )
	self:SetModel( selfModel )
	self:SetPNWVar( "model", selfModel )
	
	self:SetPNWVar( "time_played", 0 )
	self:SetPNWVar( "cash", 10000 )
	self:SetPNWVar( "bank", 0 )
	self:SetGNWVar( "ringtone", 1 )
	self:SetGNWVar( "disguised", nil )
	
	self:SetPNWVar( "Genes", {FreeGenes=5,Genes={[1]=0,[2]=2,[3]=0,[4]=0,[5]=0}} )
	
	--Give them a flashlight and a cell phone because of welfare, poor shits.
	self:GiveItem( 83, 1 )
	self:GiveItem( 2, 1 )
	self:GiveItem( 3, 1 )
	self:GiveItem( 104, 1 )
	self:GiveItem( 72, 5 ) -- chinese takeout
	
	timer.Simple(1, function()
		tmysql.query( Format( Query( "SAVEACCOUNTITEMS" ), self:CompileItems(), self.PERPID ) )
	end)
end
concommand.Add("CreateAccount", function(Player)
	if not Player:IsLeader() then return end
	Player:CreateAccount(false)
end)

local function SavePlayers( Player )
	if !Player:IsLeader() then return end
	for k, v in pairs( player.GetAll() ) do
		v:PERPSave()
		v:Notify("Account saved by admin!")
	end
	Player:Notify( "All Players Saved!" )
end
concommand.Add( "perp_save_all", SavePlayers )

local first = {
	"James","John","Robert","Michael","William","David","Richard","Joseph","Thomas","Charles","Christopher",
	"Daniel", "Matthew", "Anthony", "Donald", "Mark", "Paul", "Steven", "Andrew", "Kenneth", "Joshua", "Kevin",
	"Brian", "George", "Edward", "Ronald", "Timothy", "Jason", "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric"
}
local last = {
	"Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez",
	"Lopez", "Gonzales", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez",
	"Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen"
}

// Handle the players profile

function GM:PlayerInitialSpawn( Player )
	Player:SetTeam( TEAM_CITIZEN )

	hook.Add( "SetupMove", Player, function( ply, md, _, cmd )
		if ply == Player and not cmd:IsForced() then
			hook.Remove( "SetupMove", ply )
			hook.Run( "PlayerFullLoad", ply )
		end
	end )

	Log( Format( "%s connected to the server", Player:Nick() ) )
	Msg( Format( "Loading %s's account...\n", Player:Nick() ) )

	Player.PlayerItems = {}

	timer.Simple( 5, function() GAMEMODE.LoadPhysgun( Player ) end )

	// set to multicore
	concommand.Add("pp_mat_overlay", function() end)
	concommand.Add("cl_threaded_bone_setup 1", function() end)
	concommand.Add("cl_threaded_client_leaf_system 1", function() end)
	concommand.Add("r_threaded_client_shadow_manager 1", function() end)
	concommand.Add("r_threaded_particles 1", function() end)
	concommand.Add("r_threaded_renderables 1", function() end)
	concommand.Add("r_queued_ropes 1", function() end)
	concommand.Add("studio_queue_mode 1", function() end)
	concommand.Add("gmod_mcore_test 1", function() end)
	concommand.Add("mat_queue_mode -1", function() end)
	// set bullet hole disables
	Player:SendLua("RunConsoleCommand('r_drawmodeldecals', 0)")
	Player:SendLua("RunConsoleCommand('r_maxmodeldecal', 50)")
	Player:SendLua("RunConsoleCommand('sgm_ignore_warnings', 1)")

	if Player:IsBot() then
		Player:SetGNWVar( "rp_fname", first[math.random(1,#first)] )
		Player:SetGNWVar( "rp_lname", last[math.random(1,#last)] )
	end

	if GAMEMODE.DeadPlayers[ Player:SteamID() ] then
		local vPos = GAMEMODE.DeadPlayers[ Player:SteamID() ][1]
		timer.Simple( 2, function( Player )
			if IsValid( Player ) then
				Player:SetPos( vPos )
				timer.Simple( 0.5, function()
					Player:Kill()
					Player:ChatPrint( "Rejoining won't respawn you." )
				end )
			end
		end, Player )
	end

	if GAMEMODE.JailedPlayers[ Player:SteamID() ] then
		timer.Simple( 10, function( Player )
			if IsValid( Player ) then
				Player:ArrestTP()
				Player:ChatPrint( "You can't rejoin to avoid jail time." )

				GAMEMODE.JailedPlayers[ Player:SteamID() ] = nil
			end
		end, Player )
	end
end

function GM:EntityTakeDamage( ent, dmginfo )
	local inflictor = dmginfo:GetInflictor()
	local attacker 	= dmginfo:GetAttacker()

	-- No damage to the npcs, don't hurt them :(
	if ent:GetClass() == "npc_vendor" then return dmginfo:SetDamage( 0 ) end
	if ent:GetClass() == "npc_nextbot" then return dmginfo:SetDamage( 0 ) end

	if ent.UnBreakable then return dmginfo:SetDamage( 0 ) end

	-- Government officials can not do damage to the mayor
	if ent:IsPlayer() and ent:Team() == TEAM_MAYOR then
		if inflictor:IsPlayer() and inflictor:Team() ~= TEAM_CITIZEN then
			return dmginfo:SetDamage( 0 )
		end
	end

	-- Mayor can not do damage to government official
	if attacker:IsPlayer() and attacker:Team() == TEAM_MAYOR then
		if ent:IsPlayer() and ent:Team() ~= TEAM_CITIZEN then
			return dmginfo:SetDamage( 0 )
		end
	end

	-- Car Alarm
	if ent:IsVehicle() then
		if not IsValid(ent:GetDriver()) and ( not ent.TempAlarmDisable or ent.TempAlarmDisable < CurTime() ) and not ent.AlarmWentOff then
			if ent.AlarmEntity then
				if ent.AlarmPos < CurTime() then
					ent.AlarmEntity:Stop()
					ent.AlarmEntity:Play()
					ent.AlarmWentOff = os.time()
					ent.AlarmPos = CurTime() + 23
					if not VCMod1 then return end
					ent:VC_setHazardLights(true)
					local on = true
					timer.Create("AlarmHazardFlash"..tostring(ent),0.25,23*4,function()
						if IsValid(ent) then
							ent:VC_SetHighBeams(on)
							ent:VC_SetRunningLights(on)
							ent:VC_SetFogLights(on)
							on = not on
						end
					end)
					timer.Simple(24, function() ent:VC_setHazardLights(false) end)
				end
			end
		end
	end

	if ent:GetClass() == "prop_ragdoll" and IsValid( ent.Owner ) and ent.Owner:IsPlayer() and attacker:IsPlayer() and os.time() - ( ent.Owner.DeathTime or 0 ) >= 5 then
		if attacker == ent then return end
		if ent.FinishedOff then return end
		ent.FinishedOff = true

		if ent.Owner:GetPos():Distance( ent:GetPos() ) > 500 then return end

		ent.Owner.DontFixCripple = nil

		timer.Simple( 1, function()
			if ent.Owner and IsValid( ent.Owner ) then
				ent.FinishedOff = nil
				ent.Owner:Spawn()
			elseif ent and IsValid( ent ) then
				ent:Remove()
			end
		end ) -- Respawn in a second so it looks more realistic :)

		ent.Owner:Notify( "You have been finished off by a bullet to the head." )
        ent.Owner:SetNWInt("Hunger", 100)
        ent.Owner:SetNWInt("Saturation", 0)
		if ent.Owner:IsWarrented() then
			UnwarrantPlayers( ent.Owner:GetRPName()  )
			ent.Owner:SetGNWVar( "warrented", nil )
			ent.Owner:Notify( "Your warrant has been removed due to you being finished off." )
		end

		Log( Format( "%s(%s) finished off %s(%s)", inflictor:Nick(), inflictor:GetRPName(), ent.Owner:Nick(), ent.Owner:GetRPName() ), Color( 0, 255, 0 ) )
	end

end

function GM:PlayerShouldTaunt( ply, actid ) return false end

function GM:InitPostEntity()
	local tbl = {}
	tbl.MaxVelocity = 3000
	tbl.MaxAngularVelocity = 3600
	tbl.MaxCollisionsPerObjectPerTimestep = 1
	tbl.MaxCollisionChecksPerTimestep = 1
	tbl.LookAheadTimeObjectsVsWorld = 0.1
	tbl.LookAheadTimeObjectsVsObject = 0.1
	tbl.MinFrictionMass = 0
	tbl.MaxFrictionMass = 0

	physenv.SetPerformanceSettings( tbl )
	physenv.SetGravity( Vector( 0, 0, -600 ) )
	physenv.SetAirDensity( 2 )

	local up_time = tonumber( math.Round( RealTime() / 60 / 60 ) )
	if up_time == 0 then
		file.Write( "perp/useridlimit.txt", 2000 )
	end

	for _, v in pairs( ents.FindByClass( "prop_physics*" ) ) do
		if not v.NoDelete && not table.HasValue( KeepProps, v:GetModel() ) then
			v:Remove()
		else
			v.NoDelete = nil
		end
	end

	KeepProps = nil
end

function GM:OnReloaded()
	PrintMessage( HUD_PRINTTALK, "The server is reloading, some lag may occur..." )
	GM.Reloading = true
end


function GM:Think()
end

function GM:PlayerNoClip( Player )
	return Player:IsAdmin()
end

local function IsEmpty( vector )
	local point = util.PointContents( vector )
	local a = point ~= CONTENTS_SOLID
	and point ~= CONTENTS_MOVEABLE
	and point ~= CONTENTS_LADDER
	and point ~= CONTENTS_PLAYERCLIP
	and point ~= CONTENTS_MONSTERCLIP
	local b = true

	for _, v in pairs( ents.FindInSphere( vector, 35 ) ) do
		if v:IsNPC() or v:IsPlayer() or v:IsVehicle() or v:GetClass() == "prop_physics" then
			b = false
		end
	end

	return a and b
end

function GM:PlayerSelectSpawn( ply, locations )
	local POS = self.BaseClass:PlayerSelectSpawn( ply )
	if POS and POS.GetPos then
		POS = POS:GetPos()
	else
		POS = ply:GetPos()
	end

	if not locations then locations = JOB_DATABASE[ply:Team()].Spawns[game.GetMap()] or {} end

	local spawnpoint = math.random( #locations )
	if istable(locations[ spawnpoint ]) then
		POS = locations[ spawnpoint ][1]
		ANGLE = locations[ spawnpoint ][2]
	else
		ANGLE = Angle(0,0,0)
		POS = locations[ spawnpoint ]
	end

	-- Old DarkRP shit, lol.
	if not IsEmpty( POS ) then
		local found = false
		for i = 40, 300, 15 do
			if IsEmpty( POS + Vector( i, 0, 0 ) ) then
				POS = POS + Vector( i, 0, 0 )
				-- Yeah I found a nice position to put the player in!
				found = true
				break
			end
		end
		if not found then
			for i = 40, 300, 15 do
				if IsEmpty( POS + Vector( 0, i, 0 ) ) then
					POS = POS + Vector( 0, i, 0 )
					found = true
					break
				end
			end
		end
		if not found then
			for i = 40, 300, 15 do
				if IsEmpty( POS + Vector( 0, -i, 0 ) ) then
					POS = POS + Vector( 0, -i, 0 )
					found = true
					break
				end
			end
		end
		if not found then
			for i = 40, 300, 15 do
				if IsEmpty(POS + Vector( -i, 0, 0 ) ) then
					POS = POS + Vector( -i, 0, 0 )
					-- Yeah I found a nice position to put the player in!
					found = true
					break
				end
			end
		end
		-- If you STILL can't find it, you'll just put him on top of the other player lol
		if not found then
			POS = POS + Vector( 0, 0, 70 )
		end
	end

	return self.BaseClass:PlayerSelectSpawn( ply ), POS, ANGLE
end

util.AddNetworkString("perp_reset_stam")
function GM:PlayerSpawn( Player )

	if Player.JobModel then
		Player:SetModel( Player.JobModel )
	elseif Player:GetPNWVar( "model" ) then
		Player:SetModel( Player:GetPNWVar( "model" ) )
	elseif Player:IsBot() then
		Player:SetModel( GetModelPath( "m", math.random(1, 9) ) )
	end

	if IsValid( Player.rag ) then
		local rag = Player.rag
		Player.rag = nil
		timer.Simple( 5, function()
			if IsValid( rag ) then
				rag:Remove()
			end
		end )

		Player:SetPNWVar( "Ragdoll", nil )
	end

	Player.DeathTime = nil

	GAMEMODE.DeadPlayers[ Player:SteamID() ]  = nil

	Player:FindRunSpeed()

	Player.freshLayout = true

	if not Player.DontFixCripple then // BASICALLY, GODSTICK REVIVE DOESN'T DEMOTE MAYOR!
		Player.Crippled = nil

		net.Start( "perp_reset_stam" ) 
		net.Send(Player)
		Player.Stamina = 100

		if Player:Team() == TEAM_MAYOR then
			for _, v in pairs( player.GetAll() ) do
				if v ~= Player then
					v:Notify( "The mayor has been assassinated." )
				end
				if v:Team() == TEAM_SECRET_SERVICE then
					v:LeaveJob()
					v:Notify( "You've been demoted because of the mayor dying :(" )
				end
			end

			Player:Notify( "You have been assassinated." )

			Player:LeaveJob()
		end
	else
		Player.DontFixCripple = nil
	end

	if not Player.CurrentlyArrested then
		timer.Simple(1, function()
			self:PlayerLoadout( Player )
		end)

		if JOB_DATABASE[Player:Team()].CanEquipInventoryGun then Player:EquipMains() end

		local _, pos, angle = self:PlayerSelectSpawn( Player, JOB_DATABASE[Player:Team()].Spawns[game.GetMap()] or {} )
		Player:SetPos( pos )
		Player:SetEyeAngles( angle )
	else
		local arrestPos = GAMEMODE.JailLocations[1]
		for k, v in pairs( GAMEMODE.JailLocations ) do
			local dontDo
			for _, ent in pairs( player.GetAll() ) do
				if ent:GetPos():Distance( v ) <= 200 then
					dontDo = true
				end
			end

			if not dontDo then
				arrestPos = v
				break
			end
		end

		Player:SetPos( arrestPos )
	end

	Player:SetGNWVar( "warrented", nil )

	Player:GodEnable()
	timer.Simple( 10, function()
		if IsValid( Player ) then
			Player:GodDisable()
		end
	end )

	Player:SetupHands()

end

function GM:PlayerSetHandsModel( pl, ent )
   local simplemodel = player_manager.TranslateToPlayerModelName(pl:GetModel())
   local info = player_manager.TranslatePlayerHands(simplemodel)
   if info then
      ent:SetModel(info.model)
      ent:SetSkin(info.skin)
      ent:SetBodyGroups(info.body)
   end
end

function GM:PlayerDeath( Player, Inflictor, Killer )
	local folderdate, timedate = GAMEMODE:GetLogDate()
	local format = "ERROR"

	if Killer:IsVehicle() and IsValid( Killer:GetDriver() ) then
		format = Format( "%s(%s) was killed by a car, driver: %s(%s)", Player:Nick(), Player:GetRPName(), Killer:GetDriver():Nick(), Killer:GetDriver():GetRPName() )
		Log( format, Color( 255, 0, 0 ) )
	else
		if Killer:IsWorld() then
			if Player.Overdosed then
				Player.Overdosed = nil
				format = Format( "%s overdosed on cocaine", Player:Nick() )
				Log( format, Color( 255, 215, 0 ) )
			elseif Player:WaterLevel() > 3 then
				format = Format( "%s drowned", Player:Nick() )
				Log( format, Color( 255, 215, 0 ) )
			else
				format = Format( "%s was killed by the world", Player:Nick() )
				Log( format, Color( 255, 215, 0 ) )
			end
		elseif Killer:IsPlayer() then
			if Inflictor and IsValid(Inflictor) and Inflictor == Killer and ( Inflictor:IsPlayer() or Inflictor:IsNPC() ) then
				Inflictor = Inflictor:GetActiveWeapon()
				if !Inflictor or Inflictor == NULL then Inflictor = Killer end
			end

			if IsValid(Inflictor) and Inflictor:GetClass() == "ent_fire" and IsValid( Inflictor.Starter ) then
				Killer = Inflictor.Starter

				format = Format( "%s(%s) died from %s(%s)'s fire", Player:Nick(), Player:GetRPName(), Killer:Nick(), Killer:GetRPName() )
				Log( format, Color( 255, 215, 0 ) )
			elseif Killer == Player and Player:InVehicle() then
				format = Format( "%s(%s) died in a car crash", Player:Nick(), Player:GetRPName() )
				Log( format, Color( 255, 215, 0 ) )
				local veh = Player:GetVehicle()
				--veh:DisableVehicle( false, true )
			else
				format = Format( "%s(%s) was killed by %s(%s) with a %s", Player:Nick(), Player:GetRPName(), Killer:Nick(), Killer:GetRPName(), Inflictor:GetClass() )
				Log( format, Color( 255, 215, 0 ) )
			end
		elseif Killer:GetClass():lower():find( "ent_prop" ) or Killer:GetClass():lower():find( "ent_item" ) then
			format = Format( "%s(%s) was prop killed", Player:Nick(), Player:GetRPName() )
			Log( format, Color( 255, 255, 255 ) )
		end
	end

	if Player:GetVar( "venom_bank_robbery" ) == true then
		Player:SetVar( "venom_bank_robbery", false )
	end

	GAMEMODE:Log( "deaths", format )

	if JOB_DATABASE[Player:Team()].CanEquipInventoryGun then
		for i = 1, 2 do
			if Player.PlayerItems[ i ] then
				local itemDrop = ents.Create( "ent_item" )
					itemDrop:SetModel( ITEM_DATABASE[ Player.PlayerItems[ i ].ID ].WorldModel )
					itemDrop:SetContents( ITEM_DATABASE[ Player.PlayerItems[ i ].ID ].ID, Player )
					itemDrop:SetPos( Player:GetPos() + Vector( 0, 0, 50 + 10 * i ) )
					itemDrop:Spawn()
				itemDrop.Owner = Player
				Player:RemoveEquipped(i)
				--Player.PlayerItems[ i ] = nil
			end
		end
	end

	Player.Ammo = { pistol = Player:GetAmmoCount( "pistol" ), smg1 = Player:GetAmmoCount( "smg1" ), buckshot = Player:GetAmmoCount( "buckshot" ), Player:GetAmmoCount( "ar2" ) }

	local AmmoTable = {
		["pistol"] = {id = 30, amount = 40},
		["smg1"] = {id = 31, amount = 65},
		["buckshot"] = {id = 32, amount = 10},
		[1] = {id=nil, amount = 999999}
	}
	if Player:Team() == TEAM_CITIZEN then
		for k, v in pairs(Player.Ammo) do
			for i=math.floor(v/AmmoTable[k].amount),1,-1 do
				local ItemTable = ITEM_DATABASE[ AmmoTable[k].id ]
				if not ItemTable then return end
				local ItemDrop = ents.Create( "ent_item" )
				ItemDrop:SetModel( ItemTable.WorldModel )
				ItemDrop:SetContents( ItemTable.ID, Player )
				ItemDrop:SetPos( Player:GetPos() + ((i-1)*Vector(0,0,25)) )
				ItemDrop:SetSpawnEffect( true )
				ItemDrop:Spawn()
			end
		end
	end

	Player.NumBeersDrank = nil

	for _, v in pairs( Player:GetWeapons() ) do
		local ammo = v:GetPrimaryAmmoType()
		if ammo and v:Clip1() > 0 then
			local curammo = Player.Ammo[ ammo ] or 0
			Player.Ammo[ ammo ] = curammo  + v:Clip1()
		end
	end

	Player.RequiredDefib = math.random( 1, 3 )
	Player.DeathPos = Player:GetPos()

	--death timer - set it back to old times, many complaining about 2 - 3 minutes being too long. I agree. ~Brad
	
	GAMEMODE.DeadPlayers[ Player:SteamID() ] = { Player.DeathPos }
	if IsValid( Inflictor ) and Inflictor:IsVehicle() then
		Player:SetNWFloat("RespawnTime", CurTime() + math.random( 10, 25 ))
		Player:Notify( "You have been rammed by a vehicle. Paramedics will probably not arrive in time to save you." )
	elseif IsValid( Inflictor ) and Inflictor:GetClass() == "ent_fire" then
		Player:SetNWFloat("RespawnTime", CurTime() + math.random( 10, 40 ))
		Player:Notify( "You have been knocked unconcious in a fire. Paramedics will probably not arrive in time to save you." )
	elseif Player:WaterLevel() >= 3 then
		Player:SetNWFloat("RespawnTime", CurTime() + math.random( 45, 90 ))
		Player:Notify( "You have been knocked unconcious underwater. Paramedics will probably not arrive in time to save you." )
	else
		Player:SetNWFloat("RespawnTime", CurTime() + math.random( 60, 90 ))
	end

	Player:SetNWFloat("RespawnTimeCurTime", CurTime())
	net.Start("SerCurTimeSync") net.Send(Player)
	net.Start("YouHaveDiedYikes") net.Send(Player)

	-- Life alert
	if Player:HasItem( "item_lifealert" ) then
		Player:BroadcastLifeAlert()

		if not IsValid(Player.rag) then return end
		for k, v in pairs(player.GetAll()) do
			if not v:Team() == TEAM_MEDIC then continue end
			Player.rag:AddMapBlipSpecificPlayer("paris/blips/darts.png", Player:SteamID().."ragdoll", 24, Color(126,20,20), 10000000, "*", false, v)
		end

	end
end
util.AddNetworkString("SerCurTimeSync")
util.AddNetworkString("YouHaveDiedYikes")
util.AddNetworkString("ServerICryDieSlower")
util.AddNetworkString("ServerICryDieFaster")

net.Receive("ServerICryDieSlower", function(len,ply)
	if ply:Alive() then return end
	ply:SetNWFloat("RespawnTime", ply:GetNWFloat("RespawnTime") + 0.05)
end)

net.Receive("ServerICryDieFaster", function(len,ply)
	if ply:Alive() then return end
	ply:SetNWFloat("RespawnTime", ply:GetNWFloat("RespawnTime") - 0.1)
end)

local FunnyComments = { "Lol.", "The paramedics can't do their job.", "You bleed too quickly, try calming down next time.", "Dont bleed so quickly next time :)", "Maybe next time, don't die?", "See you in the next life!", "Lifes a bitch.", "You probably blended into the ground." }

function GM:PlayerDeathThink( Player )
	if Player:GetNWFloat("RespawnTime") < CurTime() then
		Player:Spawn()
		Player:Notify( "You have passed away... " .. FunnyComments[ math.random( #FunnyComments ) ] )
        Player:SetNWInt("Hunger", 100)
        Player:SetNWInt("Saturation", 0)
		if Player:IsWarrented() then
			UnwarrantPlayers( Player:GetRPName()  )
			Player:SetGNWVar( "warrented", nil )
			Player:Notify( "Your warrant has been removed due to you passing away." )
		end

		for k, v in pairs(player.GetAll()) do
			if v != Player then
				local Trace = {};
				Trace.start = v:EyePos();
				Trace.endpos = Player:GetPos();
				Trace.filter = {v, Player};
				Trace.mask = MASK_OPAQUE_AND_NPCS;

				local Res = util.TraceLine(Trace);

				if !Res.Hit then
					--v:AddProgress(38, 1);
				end
			end
		end
	end
end

function GM:DoPlayerDeath( Player, Attacker, DMGInfo )

	if not IsValid( rag ) then -- Already exists don't spawn another one.
		local rag = ents.Create( "prop_ragdoll" )
		rag:SetPos( Player:GetPos() )
		rag:SetAngles( Player:GetAngles() )
		rag:SetModel( Player:GetModel() )
		for k, v in pairs(Player:GetBodyGroups()) do
			rag:SetBodygroup(v.id, Player:GetBodygroup(v.id))
		end
		rag:SetSkin(Player:GetSkin())

		rag:Spawn()
		rag:Activate()

		local phyobj = rag:GetPhysicsObject()
		if IsValid(phyobj) then
			phyobj:SetVelocity(Player:GetVelocity()*5)
		end
		--rag:SetCollisionGroup( COLLISION_GROUP_WEAPON )

		rag.Owner = Player

		Player.rag = rag
		Player:SetPNWVar( "Ragdoll", rag:EntIndex() )

	end

	Player.DeathTime = os.time()
end

function GM:PlayerLoadout( Player )
	if not IsValid( Player ) then return end

	if Player.freshLayout then
		Player:StripWeapons()
	else
		Player.freshLayout = nil
	end

	Player:Give( "roleplay_keys" )
	Player:Give( "roleplay_fists" )
	Player:Give( "weapon_physcannon" )

	if Player:IsAdmin() then
		Player:Give( "god_stick" )
	end

	if Player:IsVIP() or Player:IsAdmin() then
		Player:Give( "weapon_physgun" )
	end

	local jobinfo = JOB_DATABASE[Player:Team()]
	if not jobinfo then return end
	for k, v in pairs(jobinfo.Guns or {}) do
		Player:Give(v)
		if jobinfo.FillGunClips then
			local wep = Player:GetWeapon(v)
			if IsValid(wep) then
				wep:SetClip1(wep:GetMaxClip1())
			end
		end
	end
	for k, v in pairs(jobinfo.RefillAmmo or {}) do
		Player:SetAmmo( v, k )
	end

end

function GM:PlayerConnect( name )
	for k, v in pairs(player.GetHumans()) do
		v:ChatPrint(name .. " has started connecting.")
	end
end

function GM:PlayerDisconnected( Player )
	Log( Format( "%s(%s) has left the server", Player:Nick(), Player:GetRPName() ) )

	-- Remove their vehicle (and rotators)
	Player:RemoveCar()

	Player.CanSave = true

	if ( Player.spray and IsValid(Player.spray) ) then
		Player.spray:Remove()
		Player.spray = nil
	end

	for _, v in pairs( ents.FindByClass( "prop_ragdoll" ) ) do
		if v.Owner == Player then
			v:Remove()
		end
	end

	if Player.CurrentlyArrested then
		GAMEMODE.JailedPlayers[ Player:SteamID() ] = true
	end

	if Player:Team() ~= TEAM_CITIZEN then
		if Player:Team() == TEAM_MAYOR then
			for _, v in pairs( player.GetAll() ) do
				if v ~= Player then
					v:Notify( "The mayor has left." )
				end

				if v:Team() == TEAM_SWAT then
					GAMEMODE.JobQuit[ v:Team() ]( v )
					v:Notify( "You've been demoted because of the mayor leaving :(" )
				elseif v:Team() == TEAM_SECRET_SERVICE then
					GAMEMODE.JobQuit[ v:Team() ]( v )
					v:Notify( "You've been demoted because of the mayor leaving :(" )
				end
			end

			hook.Call( "MayorQuit", GAMEMODE, Player )
		end

		if GAMEMODE.JobQuit and GAMEMODE.JobQuit[ Player:Team() ] then GAMEMODE.JobQuit[ Player:Team() ]( Player ) end
	end

	Player:PutSpawnedIntoWarehouse()
	Player:PERPSave()

	timer.Destroy( Player:SteamID() )

	-- Remove their properties
	for k, v in pairs( PROPERTY_DATABASE ) do
		local propOwner = GetGNWVar( "p_" .. k )

		if propOwner and IsValid( propOwner ) and propOwner == Player then
			SetGNWVar( "p_" .. k, NULL )
			hook.Call( "PropertyOwnership", GAMEMODE, k, NULL )

			for _, v in pairs( v.Doors ) do
				for _, d in pairs( ents.FindInSphere( v[1], 30 ) ) do
					if d:GetModel() == v[2] then
						d:Fire( "unlock", "", 0 )
						d:Fire( "Close", "", 0 )
					end
				end
			end
		end
	end

	-- Delete all of their props
	for _, v in pairs( ents.GetAll() ) do
		if not IsValid( v ) then return end
		if not v:GetClass() == "ent_meth" and not v:GetClass() == "ent_cocaine" and not v:GetClass() == "ent_shroom" and v.Owner == Player then
			v:Remove()
		end
	end

	-- Clean their backup table, we don't want to backup their shit drugs, they left.
	for k, v in pairs( SPAWNED_ITEMS ) do
		if v.Owner == Player:SteamID() then
			table.remove( SPAWNED_ITEMS, k )
		end
	end

	file.Write( "perp/items.txt", util.TableToJSON( SPAWNED_ITEMS ) )

	-- Make sure they're not on the phone with anyone
	if Player.Calling then DropCall( Player ) end
end

hook.Add("EntityRemoved", "Blah", function(ent)
	if ent:IsPlayer() then
		hook.Call("PlayerDisconnect", GAMEMODE, ent)
	end
end)

local nextrun = 0
concommand.Add("perp_reload_vehicles_sv", function(ply)
	if not ply:IsAdmin() then return end
	if CurTime() >= nextrun then
		Msg( "Reloading Vehicles...\n" )
		local Files, Folders = file.Find( FOLDER_NAME .. "/gamemode/vehicles/*.lua", "LUA" )
		for _, v in pairs( Files ) do include( FOLDER_NAME .. "/gamemode/vehicles/" .. v ) end
		nextrun = CurTime() + 10
	end
end)


--SAVE PLAYERS ON SHUTDOWN - NEEDS TO BE ADDED AGAIN OR FIXED!
function GM:ShutDown()
	for k, v in pairs( PROPERTY_DATABASE ) do
		local Owner = GetGNWVar( "p_" .. k )

		if IsValid( Owner ) then
			local Log = Format( "%s should have been refunded $%s for their property %s", Owner:Nick(), util.FormatNumber( v.Cost * .5 ), v.Name )
			GAMEMODE:Log( "cashlog", Log, Owner:SteamID() )

			Owner:GiveCash( v.Cost * .5, true )
		end
	end

	for _, v in pairs( player.GetAll() ) do
		v:PERPSave()
	end
end

function GM:CanPlayerSuicide() return false end


util.AddNetworkString("perp_help")
function GM:ShowHelp( Player )
	net.Start("perp_help")
	net.Send(Player)
end

util.AddNetworkString("perp_org")
function GM:ShowSpare1( Player )
	net.Start("perp_org")
	net.Send(Player)
end

util.AddNetworkString("perp_buddies")
function GM:ShowSpare2( Player )
	local eyeTrace = Player:GetEyeTrace()

	if eyeTrace.Entity and eyeTrace.Entity:IsPlayer() and eyeTrace.Entity:GetPos():Distance( Player:GetPos() ) < 300 then
		return Player:TradeWith( eyeTrace.Entity )
	end

	net.Start( "perp_buddies" ) net.Send(Player)
end

function GM:GravGunPunt ( Player, Target )
	if (GAMEMODE:GravGunPickupAllowed(Player, Target) && Target:GetPhysicsObject():IsMoveable()) then
		Target:SetAngles(Angle(0,0,0))
		Target:Activate()
	end
	return false; 
end

local Allowed = {
	["ent_weed"] = 					true,
	["ent_cocaine"] = 				true,
	["ent_meth"] = 					true,
	["ent_servicetruck_hook"] = 	true,
	["prop_physics"] = 				true,
	["prop_physics_multiplayer"] = 	true,
	["ent_fuelcan"] = 				true,
	["vc_pickup_tire"] = 			true,
	["vc_pickup_light"] = 			true,
	["vc_pickup_engine"] = 			true,
	["vc_pickup_exhaust"] = 		true,
	["mediaplayer_tv"] = 			true,
	["ent_item"] = 					true,
	["whk_tv"] = 					true,
	["whk_radio"] = 				true,
	["ent_money"] = 				true,
}
function GM:GravGunPickupAllowed( Player, Target )
	if not IsValid( Target ) then return false end

	if Target.NoDelete then return false end

	return Target and ( Player:CanManipulateEnt( Target ) or Allowed[Target:GetClass()])
end

function GM:PhysgunPickup( Player, Target )
	if game.SinglePlayer() then return true end

	if Target:GetClass() == "npc_walker" then return true end
	if Target:IsPlayer() and Player:IsAdmin() then
		Target:SetMoveType( MOVETYPE_NONE )
		return true
	end

	if Target.NoDelete or Target.DemoVehicle then return false end
	if Target.weld then return end

	return Player:CanManipulateEnt( Target )
end

function GM:PhysgunDrop( Player, Target )
	if Target:IsPlayer() then
		Target:SetMoveType( MOVETYPE_WALK )
	end
end

local AllowedEntities = {
	["ent_prop_item"] = true,
	["prop_clock"] = true,
	["prop_thermo"] = true,
	["prop_lamp"] = true,
	["prop_lantern"] = true,
	["item_doorbuster"] = true,
	["prop_vehicle_prisoner_pod"] = true,
	["prop_lamp_spot"] = true,
	["prop_metal_detector"] = true,
	["ent_cam_monitor"] = true,
	["ent_cam"] = true,
	["mediaplayer_tv"] = true,
	["vc_pickup_tire"] = true,
	["vc_pickup_engine"] = true,
	["vc_pickup_light"] = true,
	["vc_pickup_exhaust"] = true,
	["whk_tv"] = true,
	["whk_radio"] = true,
	["ent_item"] = true,
	["prop_sign"] = true,
	["ent_laptop"] = true,
}

function GM:OnPhysgunFreeze( weapon, phys, ent, ply )
	if ent:GetClass() == "prop_sign" and ent.weld then return false end
	if not ent.ForSale and not AllowedEntities[ent:GetClass()] then return false end
	if not phys:IsMoveable() then return false end

	if ent.ForSale and ent.Owner ~= ply then return false end

	phys:EnableMotion( false )

	local effectdata = EffectData()
	effectdata:SetOrigin( ent:GetPos() )
	effectdata:SetEntity( ent )
	util.Effect( "phys_freeze", effectdata, true, true )

	return true
end

function GM:OnPhysgunPickup( ply, ent )
	local effectdata = EffectData()
	effectdata:SetOrigin( ent:GetPos() )
	effectdata:SetEntity( entity )
	util.Effect( "phys_unfreeze", effectdata, true, true )
end

function PLAYER:CanManipulateEnt( Target )
	if not IsValid( self ) or not self:IsPlayer() then return false end
	if not IsValid( Target ) then return false end

	if self:IsAdmin() and Target:IsVehicle() then return true end
	if Target:GetClass() == "prop_sign" and (not Target.weld) then return true end

	if AllowedEntities[Target:GetClass()] and self:IsAdmin() then return true end

	if Target.ForSale and Target.Owner ~= self then return false end

	if Target:GetClass() == "prop_vehicle_prisoner_pod" and Target.pickupPlayer and not IsValid( Target:GetDriver() ) then
		if Target.pickupPlayer == self and Target.pickupPlayer:HasBuddy( self ) then
			return true
		end
	end

	if AllowedEntities[Target:GetClass()] and IsValid( Target.Owner ) then
		if Target.Owner == self or Target.Owner:HasBuddy( self ) and (not Target.weld) then
			return true
		end
	end

	return false
end

function GM:ScalePlayerDamage( Player, HitGroup, DmgInfo )
	local DamageScale = 1

	if (Player:Alive()) then
		if (HitGroup == HITGROUP_HEAD) then
			DmgInfo:ScaleDamage(2)

			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/ow0" .. math.random(1, 2) .. ".wav")
			else
				MoanFile = Sound("vo/npc/female01/ow0" .. math.random(1, 2) .. ".wav")
			end
		elseif (HitGroup == HITGROUP_CHEST or HitGroup == HITGROUP_GENERIC) then
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/hitingut0" .. math.random(1, 2) .. ".wav")
			else
				MoanFile = Sound("vo/npc/female01/hitingut0" .. math.random(1, 2) .. ".wav")
			end
		elseif (HitGroup == HITGROUP_LEFTARM or HitGroup == HITGROUP_RIGHTARM) then
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/myarm0" .. math.random(1, 2) .. ".wav")
			else
				MoanFile = Sound("vo/npc/female01/myarm0" .. math.random(1, 2) .. ".wav")
			end
		elseif (HitGroup == HITGROUP_GEAR) then
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/startle0" .. math.random(1, 2) .. ".wav")
			else
				MoanFile = Sound("vo/npc/female01/startle0" .. math.random(1, 2) .. ".wav")
			end
		elseif (HitGroup == HITGROUP_RIGHTLEG or HitGroup == HITGROUP_LEFTLEG) and not Player.Crippled then
			if (GAMEMODE.CrippleOverride) then return end
			Player.Crippled = true
			Player:Notify("You've broken your legs!")
			Player:FindRunSpeed()

			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound('vo/npc/male01/myleg0' .. math.random(1, 2) .. '.wav')
			else
				MoanFile = Sound('vo/npc/female01/myleg0' .. math.random(1, 2) .. '.wav')
			end
		else
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav")
			else
				MoanFile = Sound("vo/npc/female01/pain0" .. math.random(1, 9) .. ".wav")
			end
		end

		sound.Play(MoanFile, Player:GetPos(), 100, 100)
	end

	Player:GiveExperience( SKILL_HARDINESS, DmgInfo:GetDamage() * .25 )

	DmgInfo:ScaleDamage( DamageScale )
	return DmgInfo
end

function GM:PlayerSpray( ply )
	return false
end

hook.Add( "PlayerUse", "customUse", function( Player, Entity )
	if Player:InVehicle() then return end
	if Player.LastLeaveVehicle and Player.LastLeaveVehicle > CurTime() then return end

	if Player:KeyDown( IN_WALK ) then
		if Entity:GetClass() == "prop_vehicle_prisoner_pod" and Entity.pickupPlayer and Player == Entity.pickupPlayer and not Entity.used then
			if not Player:CanHoldItem( Entity.pickupTable, 1 ) then
				return Player:Notify( "You don't have enough inventory room!" )
			end

			Player:GiveItem( Entity.pickupTable, 1 )
			Entity.used = true
			Entity:Remove()
		end

		if ( Entity:GetClass() == "prop_lamp" or Entity:GetClass() == "prop_lantern" or Entity:GetClass() == "prop_lamp_spot" or Entity:GetClass() == "prop_sign" or Entity:GetClass() == "ent_cam_monitor" ) and Entity.pickupPlayer and Player == Entity.pickupPlayer and not Entity.used then
			if not Player:CanHoldItem( Entity.pickupTable, 1 ) then
				return Player:Notify( "You don't have enough inventory room!" )
			end

			Player:GiveItem( Entity.pickupTable, 1 )
			Entity.used = true
			Entity:Remove()
		end

		if Entity:GetClass() == "prop_metal_detector" and Entity.pickupPlayer and Player == Entity.pickupPlayer and not Entity.used then
			if not Player:CanHoldItem( Entity.pickupTable, 1 ) then
				return Player:Notify( "You don't have enough inventory room!" )
			end

			Player:GiveItem( Entity.pickupTable, 1 )
			Entity.used = true
			Entity:Remove()
		end
	elseif Entity:GetClass() == "prop_vehicle_prisoner_pod" and Entity.pickupPlayer and not IsValid( Entity:GetDriver() ) then
		Player:EnterVehicle( Entity )
	elseif ( Entity:GetClass() == "prop_lamp" or Entity:GetClass() == "prop_lantern" or Entity:GetClass() == "prop_lamp_spot" ) and Entity.flashlight and ( not Entity.nextLightFlip or CurTime() > Entity.nextLightFlip ) then
		-- toggle the lights.
		if not Player:CanManipulateEnt( Entity ) then return end

		if Entity.broken then
			sound.Play( "ambient/energy/spark" .. math.random( 1, 6 ) .. ".wav", Entity:GetPos(), 50 )
		else
			if Entity.lightCurOn then
				Entity.lightCurOn = false
				Entity.flashlight:Fire( "TurnOff", "", 0 )

				if Entity:GetClass() == "prop_lamp_spot" then
					Entity:SetSkin( 1 )
					Entity:SetGNWVar( "TurnedOn", nil )
				end
			else
				Entity.lightCurOn = true
				Entity.flashlight:Fire( "TurnOn", "", 0 )

				if Entity:GetClass() == "prop_lamp_spot" then
					Entity:SetSkin( 0 )
					Entity:SetGNWVar( "TurnedOn", true )
				end
			end
		end

		Entity.nextLightFlip = CurTime() + 1
	end
end )

function GM:PlayerSwitchFlashlight( Player )
	if Player:HasItem( "weapon_flashlight" ) then
		return true
	else
		if Player:FlashlightIsOn() then
			return true
		end

		if Player:Alive() then Player:Notify( "You need to buy a flash light from the electronic store before you can use this!" ) end
		return false
	end
end

timer.Create( "FixFlashlights", 5, 0, function()
	for _, v in pairs( player.GetHumans() ) do
		if v:FlashlightIsOn() and not v:HasItem( "weapon_flashlight" ) then
			v:Flashlight( false )
		end
	end
end )

concommand.Add( "perp_givemoolaa", function( ply, cmd, args ) --Easter Egg / Troll for the server lol
	if !ply:IsSuperAdmin() then return end
	ply:Ban( 1, false )
	ply:Kick( "-vG- You wanted the ez money, but instead you got shredded cuck." )
end )

concommand.Add("settime", function(ply,cmd,args)
	if not ply:IsLeader() then return end
	ply:SetPNWVar( "time_played", tonumber( args[1] ) )
	ply:PERPSave()
end)