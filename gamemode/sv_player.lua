--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

--if not file.IsDir( "perp_logs/cashlog", "DATA" ) then file.CreateDir( "perp_logs/cashlog" ) end
if not file.IsDir( "perp_logs/caught_exploiting", "DATA" ) then file.CreateDir( "perp_logs/caught_exploiting" ) end

if not file.IsDir( "perp_logs/caught_exploiting/1", "DATA" ) then file.CreateDir( "perp_logs/caught_exploiting/1" ) end
if not file.IsDir( "perp_logs/caught_exploiting/2", "DATA" ) then file.CreateDir( "perp_logs/caught_exploiting/2" ) end
if not file.IsDir( "perp_logs/caught_exploiting/3", "DATA" ) then file.CreateDir( "perp_logs/caught_exploiting/3" ) end

EXPLOIT_UNIMPORTANT = 1
EXPLOIT_POSSIBLETHREAT = 2
EXPLOIT_THREAT = 3

function PLAYER:CaughtCheating( log, exploit_level )
	local date = os.date( "*t" )
	local format = string.format( "[%i/%i/%i - %02i:%02i:%02i] %s", date.day, date.month, date.year, date.hour, date.min, date.sec, log ) .. "\n"

	file.Append( "perp_logs/caught_exploiting/" .. ( exploit_level or EXPLOIT_UNIMPORTANT ) .. "/" .. string.gsub( self:SteamID() , ":", "_" ) .. ".txt", format )
	
	if exploit_level and exploit_level == EXPLOIT_THREAT then
		PrintMessage( HUD_PRINTTALK, self:Nick() .. " is being banned for an attempted exploit." )
		self:ChatPrint( "You're currently being banned for an attempted exploit" )
		self:ChatPrint( "If you believe this is a mistake, please contact an Admin" )

		--frank.AddBan( self:Nick(), self:SteamID(), 0, "Possible Exploit Threat", "Cheat Bot", "STEAM_0:0:1337" )
	end
end



// ALL BANK FUNCTIONS

function PLAYER:SetCash( value, no_log )
	-- Saftey reasons:
	if value < 0 then return self:CaughtCheating( "Tried to set players cash to a negative value." ) end

	self:SetPNWVar( "cash", value )

	if not no_log then
		local Log = Format( "%s had their cash set to $%s", self:Nick(), util.FormatNumber( value ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )
	end
end

function PLAYER:GiveCash( value, no_log )
	-- Saftey reasons:
	if value < 0 then return self:CaughtCheating( "Tried to give a negative value to the player." ) end

	self:SetPNWVar( "cash", self:GetCash() + value )

	if not no_log then
		local Log = Format( "%s was given $%s", self:Nick(), util.FormatNumber( value ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )
	end
end

function PLAYER:GiveCashBankRobbery( value, no_log )
	-- Saftey reasons:
	if value < 0 then return self:CaughtCheating( "Tried to give a negative value to the player." ) end

	self:SetPNWVar( "cash", self:GetCash() + value )

	if not no_log then
		local Log = Format( "%s was given $%s from a Bank Robbery.", self:Nick(), util.FormatNumber( value ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )
	end
end

function PLAYER:TakeCash( value, no_log )
	-- Saftey reasons:
	if value < 0 then return self:CaughtCheating( "Tried to take a negative value from the player." ) end

	self:SetPNWVar( "cash", self:GetCash() - value )

	if not no_log then
		local Log = Format( "%s has removed $%s", self:Nick(), util.FormatNumber( value ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )
	end
end

function PLAYER:SetBank( value, no_log )
	-- Saftey reasons:
	if value < 0 then return self:CaughtCheating( "Tried to set players bank to a negative value." ) end

	self:SetPNWVar( "bank", value )
	self:SetAchievementStatus("50kbank",self:GetBank() + value)
	self:SetAchievementStatus("100kbank",self:GetBank() + value)
	self:SetAchievementStatus("1mbank",self:GetBank() + value)

	if not no_log then
		local Log = Format( "%s had their bank set to $%s", self:Nick(), util.FormatNumber( value ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )
	end
end

function PLAYER:GiveBank( value, no_log )
	-- Saftey reasons:
	if value < 0 then return self:CaughtCheating( "Tried to give a negative value to the players bank." ) end

	self:SetPNWVar( "bank", self:GetBank() + value )
	self:SetAchievementStatus("50kbank",self:GetBank() + value)
	self:SetAchievementStatus("100kbank",self:GetBank() + value)
	self:SetAchievementStatus("1mbank",self:GetBank() + value)

	if not no_log then
		local Log = Format( "%s has deposited $%s", self:Nick(), util.FormatNumber( value ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )
	end
end

function PLAYER:TakeBank( value, no_log )
	-- Saftey reasons:
	if value < 0 then return self:CaughtCheating( "Tried to take a negative value from the players bank." ) end

	self:SetPNWVar( "bank", self:GetBank() - value )
	self:SetAchievementStatus("50kbank",self:GetBank() + value)
	self:SetAchievementStatus("100kbank",self:GetBank() + value)
	self:SetAchievementStatus("1mbank",self:GetBank() + value)

	if not no_log then
		local Log = Format( "%s has withdrawn $%s", self:Nick(), util.FormatNumber( value ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )
	end
end

util.AddNetworkString( "BankDeposit" )
net.Receive("BankDeposit", function(byte, Player)
	local amount = net.ReadInt(32)

	if (amount <= 0) then return; end
	if (Player:GetCash() < amount) then return; end
	
	local Log = Format( "%s deposit $%s", Player:Nick(), util.FormatNumber( amount ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )
	
	Player:TakeCash(amount, true);
	Player:GiveBank(amount, true);
	
	Player:PERPSave()
end)

util.AddNetworkString( "BankWithdraw" )
net.Receive("BankWithdraw", function(byte, Player)
	local amount = net.ReadInt(32)
	
	if (amount <= 0) then return; end
	if (Player:GetBank() < amount) then return; end
	if ((Player:GetCash() + amount) > MAX_CASH) then return; end //-13
	
	local Log = Format( "%s withdrew $%s", Player:Nick(), util.FormatNumber( amount ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )
	
	Player:GiveCash(amount, true);
	Player:TakeBank(amount, true);
	Player:PERPSave()
end)

function PLAYER:GiveExperience( SkillID, XP )
	local realID = GAMEMODE.GetRealSkillID( SkillID )
	
	local preLevel = self:GetSkillLevel( SkillID )
	if preLevel == GAMEMODE.MaxSkillLevel_Level then return end
	
	self:SetPNWVar( "s_" .. realID, math.Clamp( self:GetPNWVar( "s_" .. realID, 0 ) + XP, 0, GAMEMODE.MaxSkillLevel ) )
	local postLevel = self:GetSkillLevel( SkillID )
	
	if preLevel > postLevel then
		self:Notify( "You are now level " .. postLevel .. " " .. SKILLS_DATABASE[ realID ][2] )

		self:AchievedLevel( SKILLS_DATABASE[ realID ][1], postLevel )
	end
end

function PLAYER:FindRunSpeed()
	if not self.Stamina then return end
	
	self.LastSetSprint = self.LastSetSprint or ""
	
	local newSetSprint = { 200, 300 }
	if self.CurrentlyArrested then
		newSetSprint = { 80, 80 }
	elseif self.Crippled then
		newSetSprint = { 100, 100 }
	else
		if self.Stamina > 0 and self:GetNWFloat("Hunger") > 0 then
			newSetSprint = { 200, 300 }
		else
			if self:GetNWFloat("Hunger") <= 0 and CurTime() > (self.LastHungerNotif or 0) then
				self:Notify("You don't have enough energy to run. Find something to eat!")
				self.LastHungerNotif = CurTime() + 20
			end
			newSetSprint = { 200, 200 }
		end
	end
	
	local prospectiveNewSprint = newSetSprint[1] .. newSetSprint[2]
	
	if prospectiveNewSprint == self.LastSetSprint then return end
	
	self.LastSetSprint = prospectiveNewSprint
	GAMEMODE:SetPlayerSpeed( self, newSetSprint[1], newSetSprint[2] )
end

util.AddNetworkString("perp_rename")
function PLAYER:ForceRename()
	self.CanRenameFree = true
		
	net.Start( "perp_rename") net.Send(self)
end

function PLAYER:HasBuddy( otherPlayer )
	if self == otherPlayer then return true end

	if not self.Buddies then return end
	
	for _, v in pairs( self.Buddies ) do
		if v == otherPlayer:UniqueID() then
			return true
		end
	end
end

function PLAYER:ReachedPropLimit()
	local iCount = 0
	for _, v in pairs( ents.GetAll() ) do
		if v.pickupPlayer == self then
			iCount = iCount + 1
		end
	end
	if self:IsOwner() then
		return false
	end
	if self:IsDivisionalLeader() then
		return false
	end
	if self:IsSuperAdmin() and iCount > MAX_PROPS_SUPERADMIN then
		self:Notify( "You have reached the prop limit." )
		return true
	elseif self:IsSuperAdmin() then
		return false
	end
	if self:IsAdmin() and iCount > MAX_PROPS_ADMIN then
		self:Notify( "You have reached the prop limit. [ADMIN]" )
		return true
	elseif self:IsAdmin() then
		return false
	end
	if self:IsGoldVIP() and iCount > MAX_PROPS_GOLD then
		self:Notify( "You have reached the prop limit. [GOLD]" )
		return true
	elseif self:IsGoldVIP() then
		return false
	end
	if self:IsVIP() and iCount > MAX_PROPS_VIP then
		self:Notify( "You have reached the prop limit. [VIP]" )
		return true
	elseif self:IsVIP() then
		return false
	end
	if self:IsMember() and iCount > MAX_PROPS then
		self:Notify( "You have reached the prop limit. [GUEST]" )
		return true
	elseif self:IsMember() then
		return false
	end
end

SPAWNED_ITEMS = {}
function PLAYER:SpawnProp( ItemTable, overrideType )
	if self.lastSpawnProp and self.lastSpawnProp > CurTime() then 
		return self:Notify("Please slow down your prop spawning.")
	end
	
	if self:ReachedPropLimit() then return end
	
	self.lastSpawnProp = CurTime() + .25

	local ty = overrideType or "ent_prop_item"

	local trace = {}
		trace.start = self:GetShootPos()
		trace.endpos = self:GetShootPos() + self:GetAimVector() * 50
		trace.filter = self
	local tRes = util.TraceLine( trace )

	if InCasino( tRes.HitPos ) then return self:Notify( "You may not spawn items in the Casino!" ) end

	local itemDrop = ents.Create( ty )
	if not overrideType or overrideType == "prop_vehicle_prisoner_pod" then
		itemDrop:SetModel( ItemTable.WorldModel )
	end

	local ang = self:EyeAngles()
	ang.yaw = ang.yaw + 180 -- Rotate it 180 degrees in my favour
	ang.roll = 0
	ang.pitch = 0

	if ItemTable.Rotate then ang.yaw = ang.yaw - ItemTable.Rotate end
	
	itemDrop:SetPos( tRes.HitPos )
	itemDrop:SetAngles( ang )
	
	itemDrop:Spawn()
	itemDrop:Activate()
	itemDrop:SetSpawnEffect( true )

	local vFlushPoint = tRes.HitPos - ( tRes.HitNormal * 512 )  -- Find a point that is definitely out of the object in the direction of the floor
	vFlushPoint = itemDrop:NearestPoint( vFlushPoint )		  	-- Find the nearest point inside the object to that point
	vFlushPoint = itemDrop:GetPos() - vFlushPoint			   	-- Get the difference
	vFlushPoint = tRes.HitPos + vFlushPoint						-- Add it to our target pos

	itemDrop:SetPos( vFlushPoint )

	if overrideType == "prop_vehicle_prisoner_pod" then
		itemDrop:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		
		local SeatDatabase = list.Get( "Vehicles" )[ "Seat_Jeep" ]
		if SeatDatabase.Members then table.Merge( itemDrop, SeatDatabase.Members ) end
		if SeatDatabase.KeyValues then
			for _, v in pairs( SeatDatabase.KeyValues ) do
				itemDrop:SetKeyValue( _, v )
			end
		end
	end
	
	if itemDrop.SetContents then
		itemDrop:SetContents( ItemTable.ID, self )
	end

	itemDrop.RefundTable = table.insert( SPAWNED_ITEMS, { Items = { ItemTable.ID }, Owner = self:SteamID() } ) -- In case of a server crash it'll refund props
	file.Write( "perp/items.txt", util.TableToJSON( SPAWNED_ITEMS ) )
	
	itemDrop.pickupTable = ItemTable.ID
	itemDrop.pickupPlayer = self
	itemDrop.Owner = self
	itemDrop.ReturnToWarehouse = true
	itemDrop.ReturnToWarehouseOwner = self:SteamID()
	itemDrop.ReturnToWarehouseID = tonumber( ItemTable.ID )
	
	return itemDrop
end

hook.Add( "EntityRemoved", "RemoveRefundTable", function( Entity )
	if Entity.RefundTable then
		table.remove( SPAWNED_ITEMS, Entity.RefundTable )
		file.Write( "perp/items.txt", util.TableToJSON( SPAWNED_ITEMS ) )
	end
end )

function PLAYER:StripMains()
	if self.PlayerItems[1] then
		ITEM_DATABASE[ self.PlayerItems[1].ID ].Holster( self )
	end
		
	if self.PlayerItems[2] then
		ITEM_DATABASE[ self.PlayerItems[2].ID ].Holster( self )
	end
end

function PLAYER:EquipMains()
	if self.PlayerItems[1] then
		local Function = ITEM_DATABASE[ self.PlayerItems[1].ID ]
		
		if Function.Equip then Function.Equip( self ) end
	end
	
	if self.PlayerItems[2] then
		local Function = ITEM_DATABASE[ self.PlayerItems[2].ID ]
		
		if Function.Equip then Function.Equip( self ) end
	end
end

util.AddNetworkString("perp_rem_eqp")
function PLAYER:RemoveEquipped( ID )
	local id
	if ID == EQUIP_MAIN then id = 1 end
	if ID == EQUIP_SIDE then id = 2 end
	
	if not id then return end
	
	if self.PlayerItems and self.PlayerItems[ id ] and ITEM_DATABASE[ id ] then
		ITEM_DATABASE[ self.PlayerItems[ id ].ID ].Holster( self )

		self.PlayerItems[ id ] = nil
		
		net.Start( "perp_rem_eqp" )
			net.WriteInt( id, 16 )
		net.Send(self)
	end
end

local Kill = PLAYER.Kill
function PLAYER:Kill()
	if not self:Alive() then return end

	Kill( self )
end

util.AddNetworkString( "playerIsArrested" )
function PLAYER:Arrest()
	if IsValid( self ) and not self.CurrentlyArrested then
		self.CurrentlyArrested = true
		self:FindRunSpeed()
		if IsValid( self:GetVehicle() ) then self:ExitVehicle() end
		self:StripWeapons()
		net.Start( "perp_strip_main" ) net.Send(self)
		self:RemoveEquipped( EQUIP_MAIN )
		self:RemoveEquipped( EQUIP_SIDE )
		self:SetGNWVar( "warrented", nil )
		net.Start( "playerIsArrested" )
			net.WriteBool( true )
		net.Send( self )
		self:ToggleArrestHands()
	end
end

util.AddNetworkString("perp_arrested")
function PLAYER:UnArrest()
	if IsValid( self ) and self.CurrentlyArrested then
		self.CurrentlyArrested = nil
		self:FindRunSpeed()
		net.Start( "perp_arrested" ) net.WriteInt(0,16) net.Send(self)
		self:ToggleArrestHands()
		net.Start( "playerIsArrested" )
			net.WriteBool( false )
		net.Send( self )
		GAMEMODE:PlayerLoadout( self )
	end
end

util.AddNetworkString("perp_strip_main")
function PLAYER:ArrestTP()
	if self.CurrentlyArrested then return end
	if self:Team() ~= TEAM_CITIZEN then return end
	
	--local goTime = JAIL_TIME
	--if self:IsWarrented() then
		--goTime = JAIL_TIME_WARRENTED
		self:SetGNWVar( "warrented", nil )
	--end
	--[[
	local arrestPos = GAMEMODE.JailLocations[1]
	for _, v in pairs( GAMEMODE.JailLocations ) do
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
]]--
	if IsValid( self:GetVehicle() ) then self:ExitVehicle() end

	self:StripWeapons()
	
	--net.Start( "perp_arrested" )
		--net.WriteInt( goTime, 16 )
	--net.Send(self)
	
	net.Start( "perp_strip_main" ) net.Send(self)
	
	self:RemoveEquipped( EQUIP_MAIN )
	self:RemoveEquipped( EQUIP_SIDE )
	
	self.CurrentlyArrested = true
	
	--self:SetPos( arrestPos )
	
	--[[timer.Simple( goTime, function()
		if not IsValid( self ) then return end

		self:UnArrest()
	end )]]--
end

util.AddNetworkString("perp_loading")
function PLAYER:PERPSave()
	if not self.CanSave then return Msg( "Not saving " .. self:Nick() .. " because he's not setup yet.\n" ) end
	if not self.PERPID then return Msg( "Not saving " .. self:Nick() .. " because he doesnt have a perpid.\n" ) end
	//if CurTime() - math.Round( self.joinTime or CurTime() ) < 10 then return Msg( "Attempted to save " .. self:Nick() .. " when he hasn't been connected long enough.\n" ) end
	
	Msg( "Saving " .. self:Nick() .. "...\n" )

	net.Start("perp_loading")
	net.Send(self)
	
	local timeSinceJoin = CurTime() - math.Round( self.joinTime or CurTime() )
	
	local skills = ""
	for i = 1, #SKILLS_DATABASE do	
		skills = skills .. self:GetPNWVar( "s_" .. i, 0 ) .. "-"
	end
	
	local genes = util.TableToJSON(self:GetPNWVar( "Genes" ))

	local pistol_ammo 	= self:GetAmmoCount( "pistol" )
	local smg1_ammo 	= self:GetAmmoCount( "smg1" )
	local buckshot_ammo = self:GetAmmoCount( "buckshot" )
        local ar2_ammo = self:GetAmmoCount( "ar2" )

	for _, v in pairs( self:GetWeapons() ) do
		if v.Primary then
			if v.Primary.Ammo == "pistol" then
				pistol_ammo = pistol_ammo + v:Clip1()
			elseif v.Primary.Ammo == "smg1" then
				smg1_ammo = smg1_ammo + v:Clip1()
			elseif v.Primary.Ammo == "buckshot" then
				buckshot_ammo = buckshot_ammo + v:Clip1()
                       elseif v.Primary.Ammo == "ar2" then
				ar2_ammo = ar2_ammo + v:Clip1()

			end
		end
	end

	for k, v in pairs(self["PERP_ChangedAchivements"] or {}) do
		tmysql.query( Format( "UPDATE `achievements` SET `progress`='%i' WHERE `id`='%i' AND `id`='%s';", v, self.PERPID, k ) )
	end

	tmysql.query( Format( Query( "SAVEACCOUNT" ),
		self:GetPNWVar( "cash", 0 ), 								-- Money
		self:GetPNWVar( "time_played", 0 ) + timeSinceJoin, 		-- Time Played
		os.time(), 													-- Last Played
		self:CompileItems(), 										-- Items
		skills, 													-- Skills
		genes, 														-- Genes
		self:GetPNWVar( "mixtures", "" ), 							-- Mixtures
		self:GetPNWVar( "bank", 0 ), 								-- Bank Money
		self:GetGNWVar( "ringtone", 1 ), 							-- Phone Ringtone
		pistol_ammo .. "-" .. smg1_ammo .. "-" .. buckshot_ammo .. "-" .. ar2_ammo,   -- Ammo
		os.time(),
		self:GetNWInt( "reputation" ),
		self.PERPID ) ) 											-- SteamID
end

concommand.Add("saveplayer", function(ply)
	if not ply:IsLeader() then return end
	ply:PERPSave()
end)

function PLAYER:SaveInventoryOnly()
	tmysql.query( Format( Query( "SAVEACCOUNTITEMS" ), self:CompileItems(), self.PERPID ) )
end

-- Realistic fall damage is from TTT
-- ALl credits here go to BadKing for
-- Scripting this, it works well and
-- as required.

function GM:GetFallDamage( ply, speed )
   return 1
end

local fallsounds = {
   Sound( "player/damage1.wav" ),
   Sound( "player/damage2.wav" ),
   Sound( "player/damage3.wav" )
}

local removed_ents = {
	["ent_prop_item"] =  true,
	["prop_vehicle_jeep"] = true,
}

function PLAYER:Reset()
	for k, v in pairs(PROPERTY_DATABASE) do
		if GetGNWVar( "p_" .. k ) == self then
			self:ManageProperty(k)
		end
	end
	for class, _ in pairs(removed_ents) do
		for k, v in pairs(ents.FindByClass(class)) do
			if v.Owner == self then
				v:Remove()
			end
		end
	end
end


function GM:OnPlayerHitGround( ply, in_water, on_floater, speed )
   if in_water or speed < 450 or not IsValid( ply ) then return end

   -- Everything over a threshold hurts you, rising exponentially with speed
   local damage = math.pow( 0.05 * ( speed - 420 ), 1.75 )

   -- I don't know exactly when on_floater is true, but it's probably when
   -- landing on something that is in water.
   if on_floater then damage = damage / 2 end

   -- if we fell on a dude, that hurts (him)
   local ground = ply:GetGroundEntity()
   if IsValid( ground ) and ground:IsPlayer() then
	  if math.floor( damage ) > 0 then
		 local dmg = DamageInfo()
		 dmg:SetDamageType( DMG_CRUSH )

		 dmg:SetAttacker( ply )
		 dmg:SetInflictor( ply )
		 dmg:SetDamageForce( Vector( 0, 0, -1 ) )
		 dmg:SetDamage( damage )

		 ground:TakeDamageInfo( dmg )
	  end

	  -- our own falling damage is cushioned
	  damage = damage / 3
   end

   if math.floor( damage ) > 0 then
	  local dmg = DamageInfo()
	  dmg:SetDamageType( DMG_FALL )
	  dmg:SetAttacker( game.GetWorld() )
	  dmg:SetInflictor( game.GetWorld() )
	  dmg:SetDamageForce( Vector( 0, 0, 1 ) )
	  dmg:SetDamage( damage )

	  ply:TakeDamageInfo( dmg )

	  -- play CS:S fall sound if we got somewhat significant damage
	  if damage > 5 then
		 sound.Play( table.Random( fallsounds ), ply:GetShootPos(), 55 + math.Clamp( damage, 0, 50 ), 100 )
	  end
   end
end

util.AddNetworkString("PerpExtrasClientOnly")

local function setvars(Player)
	for k, v in pairs(Player.PerpExtra or {}) do
		if string.StartWith(k, "sv") then
			if tonumber(v) then
				Player[k] = tonumber(v)
			else
				Player[k] = v
			end
		elseif string.StartWith(k, "cl") then
			net.Start("PerpExtrasClientOnly")
				net.WriteTable({k,v})
			net.Send(Player)
		else
			if tonumber(v) then
				Player:SetNWInt(k, tonumber(v))
			elseif istable(v) then
				Player[k] = v
				timer.Simple(15, function()
					net.Start("PerpExtrasClientOnly")
					net.WriteTable({k,v})
					net.Send(Player)
				end)
			else
				Player:SetNWString(k, v)
			end
		end
	end
end

function PLAYER:RefreshPerpExtra(func)
	tmysql.query( "SELECT * FROM `perp_extra` WHERE `id`='" .. tostring(self.PERPID) .. "';", function( Results, Status, ErrorMsg )
		if not IsValid(self) then return end
		if not Results or not Results[1] or not Results[1]["id"] then
			tmysql.query( Format("INSERT INTO `perp_extra` (`id`, `extra1`) VALUES('%i', '%s');", self.PERPID, "[]" ), function( Results, Status, ErrorMsg )
				self.PerpExtra = {}
				if func and isfunction(func) then
					func(self.PerpExtra)
				end
			end)
		elseif istable(util.JSONToTable(Results[1]["extra1"])) then
			self.PerpExtra = util.JSONToTable(Results[1]["extra1"])
			setvars(self)
			if func and isfunction(func) then
				func(self.PerpExtra)
			end
		end
	end)
end

function SetPerpExtra(Player,key,value)
	if not IsValid(Player) then return end

	-- do this first for security
	Player.PerpExtra[key] = value
	setvars(Player)

	Player:RefreshPerpExtra(function(perpextra)
		if perpextra[key] == value then return true end
		-- and again
		Player.PerpExtra[key] = value
		setvars(Player)
		tmysql.query( Format("UPDATE `perp_extra` SET `extra1`='%s' WHERE `id`='%i';", util.TableToJSON(Player.PerpExtra), Player.PERPID), function( Results, Status, ErrorMsg )
			
		end)
	end)
end

local function CorpseDragging(ply,key)
	if(( key == IN_USE ) and IsValid(ply) and not ply:InVehicle()) then
		local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		if(!IsValid(ent)) then return end
		local Distance = ply:GetPos():Distance(ent:GetPos())
		if(Distance > 70) then return end
		if constraint.HasConstraints( ent ) then
			if(Distance > 70) then return end
			//if (ent:GetClass() == "prop_ragdoll" and ent:GetNWBool('EDS.UseableClient', false)) then
			if (ent:GetClass() == "prop_ragdoll" and ply:GetActiveWeapon():GetClass() == "roleplay_fists") then
				constraint.RemoveConstraints( ply:GetEyeTrace().Entity, "Ballsocket" )
			return end
		return end
		//if (ent:GetClass() == "prop_ragdoll" and ent:GetNWBool( 'EDS.UseableClient', false)) then 
		if (ent:GetClass() == "prop_ragdoll" and ply:GetActiveWeapon():GetClass() == "roleplay_fists") then 
			local EntityDrag = ents.Create ("drag_entity")
			EntityDrag:SetPos(ply:GetEyeTrace().HitPos)
			EntityDrag:DrawShadow(false)
			EntityDrag:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			EntityDrag:Spawn()
			constraint.Weld(EntityDrag,ent,0,tr.PhysicsBone,5000,true,false)
			if(IsValid(EntityDrag) and IsValid(ply)) then
				timer.Simple( 0.01, function()
					if(!IsValid(EntityDrag)) then return end
					ply:PickupObject(EntityDrag)
				end)
			end
		end
	end
end
hook.Add( "KeyPress", "CorpseDrag", CorpseDragging)

function GM:AnnounceAFKStatus(ply)
	local status = "now"
	if not ply:GetNWBool("isAFK") then
		status = "no longer"
	end
	Msg( ply:Nick() .. " [ " .. ply:GetRPName() .. " ] is " .. status .. " AFK.\n" )
	GAMEMODE:LogToAdmins("AFK",{
		text = ply:Nick() .. " (" .. ply:GetRPName() .. ") ["..ply:SteamID().."] is " .. status .. " AFK",
		player = ply:SteamID(),
		lastactiontime = ply.lastAction,
		location = ply:GetZoneName(),
	})
	local lua = "if GAMEMODE.Options_ShowAFK:GetInt() == 1 then GAMEMODE:AddChat(Color(255,255,255,150),' ** " .. ply:Nick() .. " is " .. status .. " AFK') end"
	for k, v in pairs(player.GetAll()) do
		v:SendLua(lua)
	end
end

hook.Add("PlayerSay", "PERP_AFKChat", function( ply, text, team )
    if (string.StartWith(string.lower(text), "/afk")) then
        ply:SetNWBool("isAFK",not ply:GetNWBool("isAFK"))
		GAMEMODE:AnnounceAFKStatus(ply)
    end
end)

util.AddNetworkString("perp_sendcollectables");
function PLAYER:SendCollectables()
	net.Start("perp_sendcollectables");
	net.WriteTable(self["PERP_Collectables"]);
	net.Send(self);
end

function PLAYER:LoadCollectables()
	self["PERP_Collectables"] = {};
	tmysql.query("SELECT * from `perp_collectables` WHERE `perpid`='"..self.PERPID.."';", function(Results)
		if Results and Results[1] then
			for _, data in pairs(Results) do
				self["PERP_Collectables"][data.collectable] = util.JSONToTable(data.data);
			end
		end
		self:SendCollectables();
	end)
end

function PLAYER:HasCollectable(collectable,id)
	if not self["PERP_Collectables"] then return false end
	if not self["PERP_Collectables"][collectable] then return false end
	return self["PERP_Collectables"][collectable][id] or false
end

function PLAYER:SetCollectable(collectable,id,state)
	self["PERP_Collectables"][collectable] = self["PERP_Collectables"][collectable] or {};
	self["PERP_Collectables"][collectable][id] = state;
	tmysql.query("SELECT * from `perp_collectables` WHERE `perpid`='"..self.PERPID.."' AND `collectable`='"..collectable.."';", function(Results)
		local data = util.TableToJSON(self["PERP_Collectables"][collectable]);
		if Results and Results[1] then
			tmysql.query(string.format("UPDATE `perp_collectables` SET `data`='%s' WHERE `perpid`='%i' and `collectable`='%s';", data, self.PERPID, collectable));
		else
			tmysql.query(string.format("INSERT INTO `perp_collectables` (`perpid`, `collectable`, `data`) VALUES ('%i', '%s', '%s');", self.PERPID, collectable, data));
		end
	end)
	self:SendCollectables();
end