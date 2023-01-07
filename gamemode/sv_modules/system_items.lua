--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function PLAYER:setItemSlot( SlotID, ItemID, ItemQuantity )
	if not self.PlayerItems then self.PlayerItems = {} end
	if !(self || IsValid(self) || self:IsPlayer() || self.PlayerItems) then return end

	self.PlayerItems[ SlotID ] 			= {}
	self.PlayerItems[ SlotID ].ID 		= ItemID
	self.PlayerItems[ SlotID ].Quantity = ItemQuantity
	self:InvSeeUpdate(SlotID)
end

function GM:InventoryUseItem() end
-- Loading
util.AddNetworkString("perp_item_init")
function PLAYER:LoadItems( input )

	self.PlayerItems = {}

	local itemInfo = string.Explode( ";", string.Trim( input ) )

	local Items = {}

	local Time = CurTime()

	for _, v in pairs( itemInfo ) do
		local splitAgain = string.Explode( ",", v )

		if #splitAgain == 3 then
			if not ITEM_DATABASE[ tonumber( splitAgain[2] ) ] then continue end -- Invalid item

			local SlotID = tonumber( splitAgain[1] )
			self:setItemSlot( SlotID, tonumber( splitAgain[2] ), tonumber( splitAgain[3] ) )

			if SlotID <= 2 and ITEM_DATABASE[ self.PlayerItems[ SlotID ].ID ].Equip then
				ITEM_DATABASE[ self.PlayerItems[ SlotID ].ID ].Equip( self )
			end
			
			if tonumber( splitAgain[3] ) <= 0 then continue end -- Exploit for minus items, idk?


				table.insert(Items, {
					SlotID = SlotID,
					ItemID = tonumber( splitAgain[2] ),
					ItemQuantity = tonumber( splitAgain[3] )
				})

		end
	end

	net.Start( "perp_item_init" )
		net.WriteTable(Items)
	net.Send(self)
end

-- Save
function PLAYER:CompileItems()
	local saveString = ""
	
	for k, v in pairs( self.PlayerItems or {} ) do
		saveString = saveString .. k .. "," .. v.ID .. "," .. v.Quantity .. ";"
	end
	
	return saveString
end

/*************************************************
	Command "perp_i_sp"
	Job: Swap players slot item
*************************************************/

concommand.Add( "perp_i_sp", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end

	if not Player:Alive() then return end
	if Player:InVehicle() then return end
	if Player.CurrentlyArrested then return end

	local SlotID1 = tonumber( Args[1] )
	local SlotID2 = tonumber( Args[2] )

	if not Player.PlayerItems[ SlotID1 ] then return end
	
	local FirstItem = ITEM_DATABASE[ Player.PlayerItems[ SlotID1 ].ID ]

	if SlotID1 == 1 or SlotID1 == 2 or SlotID2 == 1 or SlotID2 == 2 then
		if Player.PlayerItems[ SlotID1 ] and Player.PlayerItems[ SlotID2 ] then
			if FirstItem and FirstItem.EquipZone ~= ITEM_DATABASE[ Player.PlayerItems[ SlotID2 ].ID ].EquipZone then
				return Player:CaughtCheating( "Tried to equip a weapon in the wrong slot." )
			end
		end
	end
	
	Player:SwapItemPosition( SlotID1, SlotID2 )
end )

/*************************************************
	Command "perp_i_u"
	Job: Use item slot
*************************************************/

concommand.Add( "perp_i_u", function( Player, Command, Args )
	if not Args[1] then return end
	if not Player:Alive() then return end
	if Player:InVehicle() then return end
	if Player.CurrentlyArrested then return end

	local SlotID = tonumber( Args[1] )
	
	local FirstItem = Player.PlayerItems[ SlotID ]
	if not FirstItem then return end

	local FirstItemTable = ITEM_DATABASE[ FirstItem.ID ]
	if not FirstItemTable then return end

	if not FirstItemTable.Equip and FirstItemTable.OnUse and FirstItemTable.OnUse( Player ) then

		gamemode.Call("InventoryUseItem",Player, FirstItem.ID)

		FirstItem.Quantity = FirstItem.Quantity - 1

		net.Start( "perp_item_rem1" )
			net.WriteInt( SlotID,16 )
			net.WriteInt( 1,16 )
		net.Send(Player)
		
		if FirstItem.Quantity <= 0 then
			Player.PlayerItems[ SlotID ] = nil
		end
		Player:InvSeeUpdate(SlotID)

	end
end )

/*************************************************
	Command "perp_i_d"
	Job: Drop item slot
*************************************************/

concommand.Add( "perp_i_d", function( Player, Command, Args )
	if not Args[1] then return end
	if Player:InVehicle() then return end
	if Player:ReachedPropLimit() then return end
	if not Player:Alive() then return end
	if Player.CurrentlyArrested then return end
	if Player:IsDoingSomethingTooFast() then return end
	
	local SlotID = tonumber( Args[1] )
	
	if Player.PlayerItems[ SlotID ] then
		local ItemTable = ITEM_DATABASE[ Player.PlayerItems[ SlotID ].ID ]
		if not ItemTable then return end

		if GAMEMODE.LastPlayerDroppedItem and GAMEMODE.LastPlayerDroppedItem > CurTime() - .25 then return Player:Notify( "You're dropping items too quickly, slow down." ) end
		GAMEMODE.LastPlayerDroppedItem = CurTime()

		local Trace = {}
			Trace.start = Player:GetShootPos()
			Trace.endpos = Player:GetShootPos() + Player:GetAimVector() * 50
			Trace.filter = Player
		local TRes = util.TraceLine( Trace )

		if InCasino( TRes.HitPos ) then return Player:Notify( "You may not drop items in the Casino!" ) end
		
		local useCommand = true
		if ItemTable.OnDrop then useCommand = ItemTable.OnDrop( Player, TRes ) end
		
		if useCommand then
			local ItemDrop = ents.Create( "ent_item" )
			ItemDrop:SetModel( ItemTable.WorldModel )
			ItemDrop:SetContents( ItemTable.ID, Player )
			ItemDrop:SetPos( TRes.HitPos )
			ItemDrop:SetSpawnEffect( true )
			ItemDrop:Spawn()

			if ItemTable.OnSpawn then ItemTable.OnSpawn( Player, ItemDrop ) end

			ItemDrop.Owner = Player
			ItemDrop.ReturnToWarehouse = true
			ItemDrop.ReturnToWarehouseOwner = Player:SteamID()
			ItemDrop.ReturnToWarehouseID = ItemTable.ID

			Player.PlayerItems[ SlotID ].Quantity = Player.PlayerItems[ SlotID ].Quantity - 1

			net.Start( "perp_item_rem1" )
				net.WriteInt( SlotID,16 )
				net.WriteInt( 1,16 )
				net.WriteBool(true)
			net.Send(Player)
			
			if Player.PlayerItems[ SlotID ].Quantity == 0 then
				if SlotID <= 2 and ItemTable.Holster then
					ItemTable.Holster( Player )
				end
			
				Player.PlayerItems[ SlotID ] = nil
			end
			Player:InvSeeUpdate(SlotID)
		end
	end
end )

/*************************************************
	Command "perp_i_b"
	Job: Buy item
*************************************************/

concommand.Add( "perp_i_b", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end
	if not Player:Alive() then return end
	
	local ItemID = tonumber( Args[1] or 0 )
	local Amount = tonumber( Args[2] or 0 )

	local ItemTable = ITEM_DATABASE[ ItemID ]
	if not ItemTable then return end
	
	if Amount <= 0 then return end
	
	local StoresThatHave = {}
	for k, v in pairs( SHOP_DATABASE ) do
		for _, i in pairs( v.Items ) do
			if i == ItemID then
				table.insert( StoresThatHave, v.NPCAssociation )
			elseif type( i ) == "table" and i[1] == ItemTable.Reference then
				table.insert( StoresThatHave, v.NPCAssociation )
				break
			end
		end
	end

	local canBuy = false
	for _, v in pairs( ents.FindInSphere( Player:GetPos(), 200 ) ) do
		if v:GetClass() == "npc_nextbot" or v:GetClass() == "npc_vendor" and table.HasValue( StoresThatHave, v.NPCID ) then
			canBuy = true
			break
		end
		--if v:GetClass() == "npc_vendor" and table.HasValue( StoresThatHave, v.NPCID ) then
			--canBuy = true
			--break
		--end
	end
	
	if not canBuy then return Player:CaughtCheating( "Trying to buy " .. ItemTable.Name .. " without being near the NPC" ) end
	
	local Total = Amount * ItemTable.Cost
	Total = math.Round( Total + ( Total * GAMEMODE.GetTaxRate_Sales() ) )

	GAMEMODE.CityBudget = GAMEMODE.CityBudget + ( Total * GAMEMODE.GetTaxRate_Sales() )
	
	if Player:GetCash() < Total then return end
	if not Player:CanHoldItem( ItemTable.ID, Amount ) then return end

	local Log = Format( "%s bought %sx%i for $%s", Player:Nick(), ItemTable.Name, Amount, util.FormatNumber( Total ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( Total, true )

	Player:GiveItem( ItemTable.ID, Amount )
end )

/*************************************************
	Command "perp_i_s"
	Job: Sell item
*************************************************/

concommand.Add( "perp_i_s", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end
	if not Player:Alive() then return end
	
	local SlotID = tonumber( Args[1] )
	local Amount = tonumber( Args[2] )

	local Item = Player.PlayerItems[ SlotID ]
	if not Item then return end
	
	local ItemTable = ITEM_DATABASE[ Item.ID ]
	if not ItemTable then return end

	if Amount <= 0 then return Player:CaughtCheating( "Trying to sell item " .. ItemTable.name .. " with a negative or 0 value." ) end
	if ItemTable.RestrictedSelling then return end
	
	if Player:GetItemCount( ItemTable.ID ) < Amount then return end

	local Total = math.Round( Amount * ItemTable.Cost * .5 )
	
	local Log = Format( "%s sold %sx%i for $%s", Player:Nick(), ItemTable.Name, Amount, util.FormatNumber( Total ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:GiveCash( Total, true )	
	
	Player:TakeItem( SlotID, Amount )
end )

function GM.FindHeatSource( Position, Size, skipFire )
	for _, v in pairs( ents.FindInSphere( Position, Size ) ) do
		if v.HeatSource then
			if not skipFire and math.random( 1, 100 ) == 1 then
				local Fire = ents.Create( "ent_fire" )
				Fire:SetPos( v:GetPos() )
				Fire:Spawn()
				
				v:Remove()
			end
		
			return true
		end
	end
end

function GM.FindSawHorse( Position, Size )
	for _, v in pairs( ents.FindInSphere( Position, Size ) ) do
		if v.SawHorse then return true end
	end
end

function GM.FindWaterSource( Position, Size )
	for _, v in pairs( ents.FindInSphere( Position, Size ) ) do
		if v.WaterSource then return true end
	end
end

/* Mixing */

MixRange = 150

local combineSound = Sound( "buttons/button19.wav" )

concommand.Add( "perp_mix", function( Player, Command, Args )
	if Player:InVehicle() then return Player:Notify( "No mixing while in your vehicle, you're gonna have a car crash!" ) end
	if not Player:Alive() then return Player:Notify( "You're dead, you can't mix!" ) end

	local iID = tonumber( Args[1] )
	
	local tblMixture = MIXTURE_DATABASE[ iID ]
	
	if not tblMixture then
		return Player:Notify( "Invalid mixture!" )
	end
	
	local tblRequired = {}
	for k, v in pairs( tblMixture.Ingredients ) do
		tblRequired[v] = tblRequired[v] or 0
		tblRequired[v] = tblRequired[v] + 1
	end
	
	for i, a in pairs( tblRequired ) do
		if Player:GetItemCount( i ) < a then
			return Player:Notify( "You don't have the resources to create this mixture." )
		end
	end
	
	for _, req in pairs( tblMixture.Requires ) do
		if Player:GetSkillLevel( req[1] ) < req[2] then
			return Player:Notify( "You don't have the required skills to do this." )
		end
	end
	
	if tblMixture.RequiresWaterSource and not GAMEMODE.FindWaterSource( Player:GetPos(), MixRange ) then
		return Player:Notify( "This mixture requires a water source." )
	end
	
	if tblMixture.RequiresHeatSource and not GAMEMODE.FindHeatSource( Player:GetPos(), MixRange ) then
		return Player:Notify( "This mixture requires a heat source." )
	end

	if tblMixture.RequiresSawHorse and not GAMEMODE.FindSawHorse( Player:GetPos(), MixRange ) then
		return Player:Notify( "This mixture requires a saw horse." )
	elseif tblMixture.RequiresSawHorse then
		Player:GiveExperience( SKILL_WOODWORKING, GAMEMODE.ExperienceForWoordWorking )
	end
	
	local iResults = tblMixture.Results
	if not iResults then
		return Player:Notify( "Result is nil, contact a Developer!" )
	elseif type( iResults ) == "string" then
		return Player:Notify( "Result is string, contact a Developer!" )
	end

	local trd	= {}
		trd.start = Player:EyePos()
		trd.endpos = trd.start + Player:GetAimVector() * 200
		trd.filter = Player
		
	local tr = util.TraceLine( trd )
		
	local item = ITEM_DATABASE[ iResults ]
	if not item then
		return Player:Notify( "Result is nil, contact a Developer!" )
	end

	if Player.LastMixed and Player.LastMixed > CurTime() - .25 then
		return Player:Notify( "Slow down!" )
	end
	Player.LastMixed = CurTime()

	if tblMixture.CanMix and not tblMixture.CanMix( Player, Player:GetPos() ) then return end
	if not tblMixture.Free and not Player:HasMixture( tblMixture.ID ) then return end

	if tblMixture.OnMix then
		if not tblMixture.OnMix( Player, tr ) then return end
	else
		if Player:ReachedPropLimit() then return end

		local newItem = ents.Create( "ent_item" )
			newItem:SetPos( tr.HitPos + Vector( 0, 0, 10 ) )
			newItem:SetModel( item.WorldModel )
			newItem:SetContents( item.ID, Player )
			newItem:SetSpawnEffect( true )
		newItem:Spawn()
		newItem.Owner = Player
	end
	
	for k, v in pairs( tblRequired ) do
		Player:TakeItemByID( k, v )
	end
	
	Player:GiveExperience( SKILL_CRAFTING, GAMEMODE.ExperienceForCraft )
	
	--Player:AddProgress(35, 1)
end )

/* Selling items */

local function CashRegisterNearBy( Pos )
	for _, v in pairs( ents.FindInSphere( Pos, 300 ) ) do
		if v:GetClass() == "ent_prop_item" and v.pickupTable == 50 then
			return v
		end
	end
end

concommand.Add( "perp_buy_putitemforsale", function( Player, Command, Args )
	local Entity 			= Entity( Args[1] )
	local Price 			= tonumber( Args[2] )
	local Description 		= tostring( Args[3] )
	local Title 			= tostring( Args[4] )
	
	if not IsValid( Entity ) or not Price or not Description then return end

	if not IsValid( Entity.Owner ) or not Entity.Owner:IsPlayer() or not Entity.Owner == Player then
		return Player:Notify( "This isn't your item." )
	end

	if Entity:GetPos():Distance( Entity:GetPos() ) > 500 then return end
	if Price >= 10000000 then Player:Notify( "WTF that's an insane price!!!" ) return end

	if Entity:IsVehicle() then return end -- Not selling vehicles just yet :(

	if Player.ItemsForSale > MAX_ITEMS_FORSALE then
		return Player:Notify( "You've the max items you can have for sale" )
	end

	if not CashRegisterNearBy( Entity:GetPos() ) then
		return Player:Notify( "There needs to be a cash register near by for you to sell this." )
	end
	
	Entity:SetForSale( Price, Description, Title )
end )

function PLAYER:OpenItemSellingDialog( Entity )
	umsg.Start( "perp_opensetitemforsaledialog", self )
		umsg.Entity( Entity )
		umsg.Short( Entity.ItemID )
	umsg.End()
end

function ENTITY:SetForSale( Price, Description, Title )
	if not IsValid( self.Owner ) or not self.Owner:IsPlayer() then return end
	if not self:CanBeSold() then return end
	if self:IsVehicle() then return end -- Not selling vehicles yet.
	
	self.ForSale 		= true
	self.ForSalePrice 	= Price
	self.Description	= Description
	self.Title 			= Title

	self:SetGNWVar( "ForSale", true )
	self:SetGNWVar( "Price", Price )
	self:SetGNWVar( "Title", Title )
end

function ENTITY:StopSelling()
	self.ForSale 		= nil
	self.ForSalePrice 	= nil
	self.Description 	= nil

	self:SetGNWVar( "ForSale", false )
	self:SetGNWVar( "Price", nil )
end

-------------------

function PLAYER:OpenItemBuyingDialog( Entity, Name )
	umsg.Start( "perp_openbuyitempanel", self )
		umsg.Entity( Entity )
		umsg.String( Name )
		umsg.Long( Entity.ForSalePrice )
		umsg.String( Entity.Description )
		umsg.Entity( Entity.Owner )
	umsg.End()
end

concommand.Add( "perp_buy_forsaleitem", function( Player, Command, Args )
	local Entity = Entity( Args[1] )

	if not IsValid( Entity ) then return end
	if not IsValid( Entity.Owner ) or not Entity.Owner:IsPlayer() then
		return Player:Notify( "Couldn't buy item - owner not found." )
	end
	
	if Entity:GetPos():Distance( Entity:GetPos() ) > 500 then return end

	local Price = tonumber( Entity.ForSalePrice )
	if not Price then return end

	Price = math.abs( Price )
	if Price < 1 then return end
	
	if Player:GetCash() < Price then return end
	
	if Entity:GetClass() == "ent_item" then -- not selling vehicles yet
		local Item = ITEM_DATABASE[ Entity.ItemID ]

		if not Player:CanHoldItem( Entity.ItemID, 1 ) then return Player:Notify( "Not enough room in your inventory." ) end
		
		local Log = Format( "%s bought %s for $%s from %s<%s>", Player:Nick(), Item.Name, util.FormatNumber( Price ), Entity.Owner:GetRPName(), Entity.Owner:SteamID() )
		GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

		Player:TakeCash( Price, true )
		
		local Log = Format( "%s sold %s for $%s from %s<%s>", Entity.Owner:Nick(), Item.Name, util.FormatNumber( Price ), Player:GetRPName(), Player:SteamID() )
		GAMEMODE:Log( "cashlog", Log, Entity.Owner:SteamID() )

		Entity.Owner:GiveCash( Price, true )
		
		Entity.Owner:Notify( Player:GetRPName() .. " bought your " .. Item.Name .. ", you received $" .. util.FormatNumber( Price ) )
		
		Player:GiveItem( Entity.ItemID, 1 )
		Player:Notify( "You bought a " .. Item.Name .. " for $" .. util.FormatNumber( Price ) )
		
		Entity:Remove()
	end
end )

hook.Add( "KeyPress", "PlayerUseForitemSelling", function( Player, Key )
	if iKey ~= IN_USE then return end
	
	local Entity = Player:GetEyeTrace().Entity
	if not IsValid( Entity ) then return end
	
	if Entity:GetPos():Distance( Player:GetPos() ) > 500 then return end

	if Entity.ForSale then	
		Player:OpenItemBuyingDialog( Entity, ITEM_DATABASE[ Entity.ItemID ].Name )
	end
end )

function GM:ShowTeam( Player )
	Player.ItemsForSale = Player.ItemsForSale or 0

	local Entity = Player:GetEyeTrace().Entity
	if Entity:GetPos():Distance( Player:GetPos() ) < 500 then
		if Entity:CanBeSold() then
			if Player.ItemsForSale > MAX_ITEMS_FORSALE then
				return Player:Notify( "You've the max items you can have for sale" )
			end

			if not CashRegisterNearBy( Entity:GetPos() ) then
				return Player:Notify( "There needs to be a cash register near by for you to sell this." )
			end

			if not Entity.ForSale and Entity.Owner == Player then
				Player:OpenItemSellingDialog( Entity )
			elseif Entity.Owner == Player then
				Entity:StopSelling()
			end
		end
	end
end