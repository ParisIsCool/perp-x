--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

hook.Add( "InitPostEntity", "PropertyInit", function()
	for _, v in pairs( GAMEMODE.AutoLockDoors or {} ) do
		for _, ent in pairs( ents.FindInSphere( v[1], ( v[3] or 50 ) ) ) do
			if ent:IsDoor() and ( not v[2] or ent:GetModel() == v[2] ) then
				ent:Fire( "close" )
				ent:Fire( "lock", "", 0 )
			end
		end
	end
	
	for _, v in pairs( policeDoors ) do
		for _, ent in pairs( ents.FindInSphere( v[1], ( v[3] or 50 ) ) ) do
			if ent:IsDoor() and ( not v[2] or ent:GetModel() == v[2] ) then
				ent:Fire( "lock", "", 0 )
			end
		end
	end

	for _, v in pairs( GAMEMODE.AutoUnlockDoors ) do
		for _, ent in pairs(ents.FindInSphere( v[1], ( v[3] or 50 ) ) ) do
			if ent:IsDoor() and ( not v[2] or ent:GetModel() == v[2] ) then
				ent:Fire( "unlock" )
				ent:Fire( "open" )
			end
		end
	end

	for _, v in pairs( GAMEMODE.AutoDeleteEntities ) do
		for _, ent in pairs( ents.FindInSphere( v[1], ( v[3] or 50 ) ) ) do
			if ent:GetModel() == v[2] then
				ent:Remove()
			end
		end
	end

	for _, v in pairs( GAMEMODE.AutoSpawnEntities ) do
		local Prop = ents.Create( v.Type )
		if not IsValid( Prop ) then return Error( "v.Type is invalid?: " .. v.Type .. "\n" ) end

		Prop:SetModel( v.Model )
		Prop:SetPos( v.Pos )
		Prop:SetAngles( v.Angle or Angle( 0, 0, 0 ) )

		Prop:Spawn()
		Prop:Activate()

		Prop.NoDelete = true
		Prop.UnBreakable = true
		Prop.UnBurnable = true

		if IsValid( Prop:GetPhysicsObject() ) then
			Prop:GetPhysicsObject():EnableMotion( false )
		end
	end
end )

/*************************************************
	"perp_p_b"
	Job: Buy/Sell properties
*************************************************/

function PLAYER:ManageProperty(property)
	--if not self:NearNPC( 3 ) then return self:CaughtCheating( "Trying to buy/sell a house without being near the NPC.", EXPLOIT_POSSIBLETHREAT ) end

	self.Properties = self.Properties or 0
	
	if not property then return end

	local PropertyDB = PROPERTY_DATABASE[ property ]
	if not PropertyDB then return end
	
	local curOwner = GetGNWVar( "p_" .. property )
	local hasOwner = IsValid( curOwner ) and curOwner:IsPlayer()
	
	if hasOwner then
		if curOwner ~= self then return end

		local Log = Format( "%s sold %s for $%s", self:Nick(), PropertyDB.Name, util.FormatNumber( math.Round( PropertyDB.Cost * .5 ) ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )

		self:GiveCash( math.Round( PropertyDB.Cost * .5 ), true )

		GAMEMODE.HouseAlarms[ property ] = nil

		self:Notify( "You have sold " .. PropertyDB.Name .. " for $" .. util.FormatNumber( math.Round( PropertyDB.Cost * .5 ) ) )

		self.Properties = self.Properties - 1
		
		SetGNWVar( "p_" .. property, nil )
		hook.Call( "PropertyOwnership", GAMEMODE, property, nil )

		timer.Destroy("PayPropertyBills_" .. property)

		self:RemoveBlip("perp_property_"..tostring(PropertyDB.ID))

		for _, v in pairs( PROPERTY_DATABASE[ property ].Doors ) do
			for _, d in pairs( ents.FindInSphere( v[1], 30 ) ) do
				if d:GetModel() == v[2] then
					d:Fire( "unlock", "", 0 )
					d:Fire( "Close", "", 0 )
				end
			end
		end
	else
		if self:GetCash() < PropertyDB.Cost then return end

		local iCanHave = self:IsGoldVIP() and MAX_PROPERTIES_GOLD or self:IsVIP() and MAX_PROPERTIES_VIP or MAX_PROPERTIES

		if self.Properties and self.Properties >= iCanHave and not self:IsAdmin() then
			return self:Notify( "You can not buy any more properties, you've reached your maximum of " .. iCanHave .. "." )
		end

		local Log = Format( "%s bought %s for $%s", self:Nick(), PropertyDB.Name, util.FormatNumber( PropertyDB.Cost ) )
		GAMEMODE:Log( "cashlog", Log, self:SteamID() )

		self:TakeCash( PropertyDB.Cost, true )

		self:Notify( "You have bought " .. PropertyDB.Name .. " for $" .. util.FormatNumber( PropertyDB.Cost ) )
            
        self:AddRP(200)
		self:ReputationNotify( "+200 RP for buying a property!" )

		self.Properties = self.Properties + 1
		
		SetGNWVar( "p_" .. property, self )
		hook.Call( "PropertyOwnership", GAMEMODE, property, self )

		AddMapBlipSpecificPlayer(PropertyDB.HUDBlip,"paris/blips/house", "perp_property_"..tostring(PropertyDB.ID), 32, Color(255,255,255,255), 100000, "*", true, Player)

		timer.Create("PayPropertyBills_" .. property, 60*60, 0, function()
			local curOwner = GetGNWVar( "p_" .. property )
			if IsValid(curOwner) then
				if curOwner:GetBank() > PropertyDB.Cost then
					-- get charged bitch
					curOwner:Notify("You have been charged $" .. string.Comma(PropertyDB.Cost)  .. " for rent and utility fees.")
					curOwner:TakeBank(PropertyDB.Cost)
				else
					curOwner:Notify("You have failed to pay rent on " .. PropertyDB.Name  .. ". You have been evicted.")
					GAMEMODE.HouseAlarms[ property ] = nil
			
					curOwner.Properties = curOwner.Properties - 1
					
					SetGNWVar( "p_" .. property, nil )
					hook.Call( "PropertyOwnership", GAMEMODE, property, nil )
			
					curOwner:RemoveBlip("perp_property_"..tostring(PropertyDB.ID))
			
					for _, v in pairs( PropertyDB.Doors ) do
						for _, d in pairs( ents.FindInSphere( v[1], 30 ) ) do
							if d:GetModel() == v[2] then
								d:Fire( "unlock", "", 0 )
								d:Fire( "Close", "", 0 )
							end
						end
					end
				end
			end
		end)
		self:AddRP(200)
		self:ReputationNotify( "+200 RP for buying a property" )
	end
end

util.AddNetworkString("perp_p_b")
net.Receive( "perp_p_b", function( len, Player )
	Player:ManageProperty(net.ReadInt(16))
end)