--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

ITEM_DATABASE = ITEM_DATABASE or {}

function GM:RegisterItem( ItemTable )
	if not ITEM_DATABASE[ ItemTable.ID ] then
		--Msg( "\t-> Loaded " .. ItemTable.Name .. "\n" )
	end
	if ITEM_DATABASE[ ItemTable.ID ] and ITEM_DATABASE[ ItemTable.ID ].Name != ItemTable.Name then
		ErrorNoHalt( "Conflicting ItemTable ID's: " .. ItemTable.ID .. "\n" )
	end
	ITEM_DATABASE[ ItemTable.ID ] = ItemTable
end

local ThatDoesntGoThere = Sound( "buttons/button10.wav" )
local PerfectMatch = Sound( "UI/buttonclickrelease.wav" )
function PLAYER:SwapItemPosition( first, second )	
	if self:InVehicle() then return end
	if not self:Alive() then return self:Notify( "You cannot manipulate items while dead." ) end
	if CLIENT and isArrested then return LocalPlayer():Notify( "You cannot manipulate items while you're arrested." ) end
	if SERVER and self.CurrentlyArrested then return self:Notify( "You cannot manipulate items while you're arrested." ) end
	
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems
	else
		playerItems = self.PlayerItems
	end
	
	local firstB = playerItems[ first ]
	local secondB = playerItems[ second ]
	
	local haveFirst = util.tobool( firstB )
	local haveSecond = util.tobool( secondB )
	
	if not firstB then
		return self:Notify( "Error swapping item! Is the inventory out of sync?" )
	end

	if second <= 2 then
		if not ITEM_DATABASE[ firstB.ID ].EquipZone and ITEM_DATABASE[ firstB.ID ].EquipZone == second then
			if CLIENT then
				surface.PlaySound( ThatDoesntGoThere )
				GAMEMODE.InventoryBlocks_Linear[ first ]:GrabItem()
				GAMEMODE.InventoryBlocks_Linear[ second ]:GrabItem()
			end
			
			return
		end
		
		if haveSecond and firstB.Quantity > 1 then
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[ first ]:GrabItem()
				GAMEMODE.InventoryBlocks_Linear[ second ]:GrabItem()
				
				if secondB.ID ~= firstB.ID then
					surface.PlaySound( ThatDoesntGoThere )
				else
					surface.PlaySound( PerfectMatch )
				end
			end
			
			return
		end
		
		if not haveSecond and firstB.Quantity > 1 then
			if SERVER then
				self:setItemSlot( second, firstB.ID, firstB.Quantity - 1 )
			else
				setItemSlot( second, firstB.ID, firstB.Quantity - 1 )
			end

			self:InvSeeUpdate(first)
			self:InvSeeUpdate(second)
			
			firstB.Quantity = 1
		end
	elseif haveSecond and firstB.ID == secondB.ID then
		prospectiveNum = firstB.Quantity + secondB.Quantity
		newStack = math.Clamp( prospectiveNum, 1, ITEM_DATABASE[ firstB.ID ].MaxStack )
		oldStack = prospectiveNum - newStack
		
		if oldStack == 0 then
			playerItems[ second ] = nil
			playerItems[ first ].Quantity = newStack
		else
			playerItems[ second ].Quantity = oldStack
			playerItems[ first ].Quantity = newStack
		end

		self:InvSeeUpdate(first)
		self:InvSeeUpdate(second)

	elseif haveSecond and first <= 2 then
		if secondB.Quantity > 1 then
			if CLIENT then
				surface.PlaySound( ThatDoesntGoThere )
				GAMEMODE.InventoryBlocks_Linear[ first ]:GrabItem()
				GAMEMODE.InventoryBlocks_Linear[ second ]:GrabItem()
			end
			
			return
		end
	end

	firstB = playerItems[ first ]
	secondB = playerItems[ second ]

	self:InvSeeUpdate(first)
	self:InvSeeUpdate(second)
	
	if SERVER and JOB_DATABASE[self:Team()].CanEquipInventoryGun then
		if second <= 2 and ITEM_DATABASE[ firstB.ID ].Equip then
			ITEM_DATABASE[ firstB.ID ].Equip( self )
			
			if haveSecond and secondB and ITEM_DATABASE[ secondB.ID ].Holster then
				-- Secondary
				ITEM_DATABASE[ secondB.ID ].Holster( self )
			end
		elseif first <= 2 and ITEM_DATABASE[ firstB.ID ].Holster then
			-- Primary
			ITEM_DATABASE[ firstB.ID ].Holster( self )
			
			if haveSecond and secondB and ITEM_DATABASE[ secondB.ID ].Equip then
				ITEM_DATABASE[ secondB.ID ].Equip( self )
			end
		end
	end

	if first == 1 or first == 2 or second == 1 or second == 2 then
		if firstB and secondB and ITEM_DATABASE[ firstB.ID ] and ITEM_DATABASE[ secondB.ID ] and ITEM_DATABASE[ firstB.ID ].EquipZone ~= ITEM_DATABASE[ secondB.ID ].EquipZone then
			surface.PlaySound( ThatDoesntGoThere )
			GAMEMODE.InventoryBlocks_Linear[ first ]:GrabItem()
			GAMEMODE.InventoryBlocks_Linear[ second ]:GrabItem()

			return
		end
	end
	
	playerItems[ first ] = secondB
	playerItems[ second ] = firstB

	self:InvSeeUpdate(first)
	self:InvSeeUpdate(second)
	
	if CLIENT then
		surface.PlaySound( PerfectMatch )
		
		GAMEMODE.InventoryBlocks_Linear[ first ]:GrabItem()
		GAMEMODE.InventoryBlocks_Linear[ second ]:GrabItem()
		
		RunConsoleCommand( "perp_i_sp", first, second )
	end
end

function PLAYER:HasItem( itemName, iAmount )
	if itemName == "item_phone" and self:Team() == TEAM_DISPATCHER then return true end

	local ID
	for k, v in pairs( ITEM_DATABASE ) do
		if v.Reference == itemName then
			ID = v.ID
		end
	end

	if not ID then
		return Msg( "Couldn't find item with Reference " .. itemName .. "\n" )
	end

	return self:GetItemCount( ID ) > ( iAmount or 0 )
end

function PLAYER:GetItemCount( itemID )	
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems
	else
		playerItems = self.PlayerItems
	end
	if not playerItems then return 0 end
	
	local Quantity = 0
	for _, v in pairs( playerItems ) do
		if v.ID == itemID then
			Quantity = Quantity + v.Quantity
		end
	end
	
	return Quantity
end

function PLAYER:CanHoldItem( itemID, Quantity )
	local itemTable = ITEM_DATABASE[ itemID ]

	if not itemTable then return end
	
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems
	else
		playerItems = self.PlayerItems
	end
	
	local numToAdd = Quantity
	for i = 3, INVENTORY_HEIGHT * INVENTORY_WIDTH + 2 do
		if playerItems[ i ] then
			if playerItems[ i ].ID == itemTable.ID and playerItems[ i ].Quantity < itemTable.MaxStack then
				numToAdd = numToAdd - itemTable.MaxStack - playerItems[ i ].Quantity
			end
		else
			numToAdd = numToAdd - itemTable.MaxStack
		end
		
		if numToAdd <= 0 then break end
	end
	
	return numToAdd <= 0
end

if SERVER then
	util.AddNetworkString("perp2_item_add1")
end

function PLAYER:GiveItem( itemID, Quantity )
	local itemTable = ITEM_DATABASE[ itemID ]
	if not itemTable then return end
	
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems
	else
		playerItems = self.PlayerItems
	end
	
	local numToAdd = Quantity
	for k, v in pairs( playerItems ) do
		if v.ID == itemID and v.Quantity < itemTable.MaxStack and k > 2 then
			local ProspAdd = math.Clamp( itemTable.MaxStack - v.Quantity, 0, numToAdd )
			v.Quantity = v.Quantity + ProspAdd
			
			numToAdd = numToAdd - ProspAdd
			
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[ k ]:GrabItem()
				
				if GAMEMODE.ShopPanel then
					GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[ k ]:GrabItem()
				end
			end
		end
		
		if numToAdd <= 0 then break end
	end
	
	local slotLastAddedTo

	if numToAdd > 0 then
		for i = 3, INVENTORY_HEIGHT * INVENTORY_WIDTH + 2 do
			if not playerItems[ i ] then
				local ProspAdd = math.Clamp( itemTable.MaxStack, 0, numToAdd )
				
				if CLIENT then
					setItemSlot( i, itemID, ProspAdd )
					GAMEMODE.InventoryBlocks_Linear[ i ]:GrabItem()
					
					if GAMEMODE.ShopPanel then
						GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[ i ]:GrabItem()
					end
				else
					self:setItemSlot( i, itemID, ProspAdd )
					self:InvSeeUpdate(i)
					slotLastAddedTo = i
				end
				
				numToAdd = numToAdd - ProspAdd
			end
			
			if numToAdd <= 0 then break end
		end
	end
	
	if SERVER then
		net.Start( "perp2_item_add1" )
			net.WriteInt( itemID,16 )
			net.WriteInt( Quantity,16 )
		net.Send(self)
		return slotLastAddedTo
	end
	
	if CLIENT then
		GAMEMODE.WarehousePanel:Build()
	end
end

function PLAYER:TakeItemByID( itemID, Quantity )
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems
	else
		playerItems = self.PlayerItems
	end
	
	for k, v in pairs( playerItems ) do
		if v.ID == itemID then
			self:TakeItem( k, Quantity )
			break
		end
	end
end

if SERVER then
	util.AddNetworkString("perp_item_rem1")
end

function PLAYER:TakeItem( slotID, Quantity )
	local playerItems
	if CLIENT then
		playerItems = GAMEMODE.PlayerItems
	else
		playerItems = self.PlayerItems
	end
	
	local Item = playerItems[ slotID ]
	if not Item then return end
	
	local itemTable = ITEM_DATABASE[ Item.ID ]
	
	local numToTake = Quantity

	if SERVER then
		net.Start( "perp_item_rem1" )
			net.WriteInt( slotID,16 )
			net.WriteInt( Quantity,16 )
		net.Send(self)
		self:InvSeeUpdate(slotID)
	end

	local BoutToTake = math.Clamp( Item.Quantity, 0, numToTake )
	playerItems[ slotID ].Quantity = Item.Quantity - BoutToTake
	
	if Item.Quantity <= 0 then
		playerItems[ slotID ] = nil
	end

	self:InvSeeUpdate(slotID)
	
	if CLIENT then
		GAMEMODE.InventoryBlocks_Linear[ slotID ]:GrabItem()
				
		if GAMEMODE.ShopPanel then
			GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[ slotID ]:GrabItem()
		end
	end
			
	numToTake = numToTake - BoutToTake
	
	if numToTake <= 0 then return end
	
	for k, v in pairs( playerItems ) do
		if v.ID == itemTable.ID then
			local BoutToTake = math.Clamp( v.Quantity, 0, numToTake )
			
			v.Quantity = v.Quantity - BoutToTake
			
			if v.Quantity <= 0 then
				playerItems[ k ] = nil
			end

			self:InvSeeUpdate(slotID)
			
			if CLIENT then
				GAMEMODE.InventoryBlocks_Linear[ k ]:GrabItem()
				
				if GAMEMODE.ShopPanel then
					GAMEMODE.ShopPanel.ShopPlayerInventory.InventoryBlocks[ k ]:GrabItem()
				end
			end
			
			numToTake = numToTake - BoutToTake
		end
		
		if numToTake <= 0 then return end
	end
	
	if CLIENT then
		GAMEMODE.WarehousePanel:Build()
	end
end

if SERVER then
	util.AddNetworkString("perp_item_edit")
	function PLAYER:EditItemSlot(slotID, itemID, Quantity)
		net.Start( "perp_item_edit" )
		net.WriteInt( slotID,16 )
		net.WriteInt( itemID,16 )
		net.WriteInt( Quantity,16 )
		net.Send(self)
		self.PlayerItems[slotID] = {
			ID = itemID,
			Quantity = Quantity,
		}
	end
end








---- [[

 -- Inventory See System

---- ]]


if CLIENT then

	function PLAYER:InvSeeUpdate()
		
	end

	local ThatDoesntGoThere = Sound( "buttons/button10.wav" )
	local PerfectMatch = Sound( "UI/buttonclickrelease.wav" )
	function PLAYER:InvSeeSwapItemPosition( first, second, fromSlotType, toSlotType, steamID, otherItems )	-- to only be used clientside lol
		if not self:IsAdmin() then return end
		if not IsValid(player.GetBySteamID(steamID)) then return end

		playerItems = GAMEMODE.PlayerItems

		local firstB = playerItems[ first ]
		local secondB = playerItems[ second ]
		local sendTo = self
		local sendFrom = self

		if toSlotType == "other" then
			secondB = otherItems[ second ]
			sendTo = player.GetBySteamID(steamID)
		end
		if fromSlotType == "other" then
			firstB = otherItems[ first ]
			sendFrom = player.GetBySteamID(steamID)
		end

		net.Start("perp_request_invsee_change")
		net.WriteEntity(sendFrom)
		net.WriteTable(secondB or {})
		net.WriteInt(first,16)
		net.WriteEntity(sendTo)
		net.WriteTable(firstB or {})
		net.WriteInt(second,16)
		net.SendToServer()
		
		local haveFirst = util.tobool( firstB )
		local haveSecond = util.tobool( secondB )
		
		if not firstB then
			return self:Notify( "Error swapping item! Is the inventory out of sync?" )
		end

	end

	net.Receive( "perp_singleitem_init", function()

		local Item = net.ReadTable()
		local slot = net.ReadInt(16)
		if Item.ID and Item.Quantity then
			setItemSlot( slot, Item.ID, Item.Quantity )
		else
			GAMEMODE.PlayerItems[slot] = nil
			GAMEMODE.InventoryBlocks_Linear[ slot ]:GrabItem()
		end

	end )

else -- Serverside Bullshit

	util.AddNetworkString("perp_invsee_init")
	net.Receive("perp_invsee_init", function(len,ply)
		if !ply:IsAdmin() then return end
		local otherply = player.GetBySteamID(net.ReadString())
		if !IsValid(otherply) then return end
		ply.InvSeer = otherply:SteamID()
		net.Start("perp_invsee_init")
			net.WriteTable(otherply.PlayerItems)
			net.WriteString(otherply:SteamID())
		net.Send(ply)
	end)

	util.AddNetworkString("perp_invsee_update")
	function PLAYER:InvSeeUpdate(slot)
		for k, v in pairs(player.GetHumans()) do
			if v.InvSeer == self:SteamID() then
				net.Start("perp_invsee_update")
				net.WriteInt(slot,16)
				net.WriteTable(self.PlayerItems[ slot ] or {})
				net.WriteString("other")
				net.Send(v)
			end
		end
		if self.InvSeer and IsValid(player.GetBySteamID( self.InvSeer )) then
			net.Start("perp_invsee_update")
			net.WriteInt(slot,16)
			net.WriteTable(self.PlayerItems[ slot ] or {})
			net.WriteString("local")
			net.Send(self)
		end
	end

	util.AddNetworkString("perp_singleitem_init")
	function PLAYER:LoadSingleSlot( slot )
		net.Start( "perp_singleitem_init" )
			net.WriteTable(self.PlayerItems[ slot ] or {})
			net.WriteInt(slot,16)
		net.Send(self)
		self:InvSeeUpdate(slot)
	end


	util.AddNetworkString("perp_request_invsee_change")
	net.Receive("perp_request_invsee_change", function(len,ply)
		if not ply:IsAdmin() then return end

		local sendFrom = net.ReadEntity()
		local firstB = net.ReadTable()
		local firstSlot = net.ReadInt(16)
		local sendTo = net.ReadEntity()
		local secondB = net.ReadTable()
		local secondSlot = net.ReadInt(16)

		if not IsValid(sendFrom) or not sendFrom:IsPlayer() or not IsValid(sendTo) or not sendTo:IsPlayer() then return end
		if firstB.ID and firstB.Quantity then
			sendFrom:setItemSlot( firstSlot, firstB.ID, firstB.Quantity )
		else
			sendFrom.PlayerItems[ firstSlot ] = nil
		end
		sendFrom:LoadSingleSlot( firstSlot )

		if secondB.ID and secondB.Quantity then
			sendTo:setItemSlot( secondSlot, secondB.ID, secondB.Quantity )
		else
			sendTo.PlayerItems[ secondSlot ] = nil
		end
		sendTo:LoadSingleSlot( secondSlot )

	end)
end