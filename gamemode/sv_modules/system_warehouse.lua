--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

util.AddNetworkString("perp2_warehouse_insertsingle")
function PLAYER:AddToWarehouse( ItemID, Amount )
	if not self.CanSave then return Msg( "Not adding to " .. self:Nick() .. "'s warehouse because he's not setup yet.\n" ) end
	if CurTime() - math.Round( self.joinTime or CurTime() ) < 10 then return Msg( "Attempted to update " .. self:Nick() .. "'s warehouse when he hasn't been connected long enough.\n" ) end

	local Count = self:GetItemCount( ItemID )
	if Count < 1 then return end

	local Amount = math.Clamp( Amount, 0, Count )

	self.PlayerWarehouse[ ItemID ] = ( self.PlayerWarehouse[ ItemID ] or 0 ) + Amount

	if ITEM_DATABASE[ ItemID ].Holster then
		ITEM_DATABASE[ ItemID ].Holster( self )
	end

	self:TakeItemByID( ItemID, Amount )

	net.Start( "perp2_warehouse_insertsingle" )
		net.WriteInt( ItemID, 16 )
		net.WriteInt( Amount, 16 )
		net.WriteBool( true )
	net.Send(self)
	
	self:SaveWarehouseSingle( ItemID )
	self:SaveInventoryOnly()
end

util.AddNetworkString("perp2_warehouse_delete")
function PLAYER:TakeFromWarehouse( ItemID, Amount )
	if not self.CanSave then return Msg( "Not taking from " .. self:Nick() .. "'s warehouse because he's not setup yet.\n" ) end
	if CurTime() - math.Round( self.joinTime or CurTime() ) < 10 then return Msg( "Attempted to update " .. self:Nick() .. "'s warehouse when he hasn't been connected long enough.\n" ) end
	

	if not self.PlayerWarehouse[ ItemID ] then return end
	if self.PlayerWarehouse[ ItemID ] < 1 then return end

	local Amount = math.Clamp( Amount, 0, self.PlayerWarehouse[ ItemID ] )
	local AmountLeft = self.PlayerWarehouse[ ItemID ] - Amount

	self.PlayerWarehouse[ ItemID ] = AmountLeft < 1 and nil or AmountLeft

	self:GiveItem( ItemID, Amount )

	net.Start( "perp2_warehouse_delete", self )
		net.WriteInt( ItemID, 16 )
		net.WriteInt( Amount, 16 )
		net.WriteBool( true )
	net.Send(self)
	
	self:SaveWarehouseSingle( ItemID )
	self:SaveInventoryOnly()
end

/*************************************************
	"perpx_wh_add"
	Job: Put stuff into the Warehouse
*************************************************/
util.AddNetworkString("perpx_wh_add")
net.Receive( "perpx_wh_add", function( len, Player )
	if not Player:NearNPC( 19 ) then return Player:CaughtCheating( "Trying to put stuff into warehouse away from the NPC.", EXPLOIT_POSSIBLETHREAT ) end

	local ItemID = tonumber( net.ReadInt(16) )
	local Amount = tonumber( net.ReadInt(16) )
	if not ItemID or not Amount then return end

	if ItemID == 103 or ItemID == 130 or ItemID == 131 or ItemID == 132 or ItemID == 133 or ItemID == 134 or ItemID == 135 or ItemID == 136 or ItemID == 137 or ItemID == 138 or ItemID == 139 or ItemID == 140 then return end -- car ticket
	
	if Player:GetItemCount( ItemID ) < 1 then return end
	
	Player:AddToWarehouse( ItemID, math.Clamp( Amount, 0, Player:GetItemCount( ItemID ) ) )
end )

/*************************************************
	"perpx_wh_take"
	Job: Take stuff out from the Warehouse
*************************************************/
util.AddNetworkString("perpx_wh_take")
net.Receive( "perpx_wh_take", function( len, Player )
	if not Player:NearNPC( 19 ) then return Player:CaughtCheating( "Trying to take stuff out from the warehouse away from the NPC.", EXPLOIT_POSSIBLETHREAT ) end

	local ItemID = tonumber( net.ReadInt(16) )
	local Amount = tonumber( net.ReadInt(16) )
	if not ItemID or not Amount then return end

	if not Player:CanHoldItem( ItemID, Amount ) then
		return Player:Notify( "You do not have enough free inventory room." )
	end
	
	Player:TakeFromWarehouse( ItemID, Amount )
end )

-- This should return all the spawned items, but with 1 query per item instead of per quantity an item, smarter to save more queries and yeh... saves the players shit HAHA xD
function PLAYER:PutSpawnedIntoWarehouse()
	local ToUpdate = {}

	for k, v in pairs( ents.GetAll() ) do
		if v.ReturnToWarehouse and v.ReturnToWarehouseOwner == self:SteamID() and v.ReturnToWarehouseID then
			if not ToUpdate[ v.ReturnToWarehouseID ] then
				ToUpdate[ v.ReturnToWarehouseID ] = ( self.PlayerWarehouse[ v.ReturnToWarehouseID ] or 0 ) + 1
			else
				ToUpdate[ v.ReturnToWarehouseID ] = ToUpdate[ v.ReturnToWarehouseID ] + 1
			end
			
			v:Remove()
		end
	end

	for k, v in pairs( ToUpdate ) do
		OfflineSaveWarehouseSingle( k, v, self.PERPID )
	end
end

function OfflineSaveWarehouseSingle( iItem, iAmount, SteamID )
	if not iItem then return end
	
	if iAmount < 1 then
		tmysql.query( Format( Query( "DELETEFROMWAREHOUSE" ), SteamID, iItem ) )
	else
		tmysql.query( Format( Query( "INSERTINTOWAREHOUSE" ), SteamID, iItem, iAmount, iAmount ) )
	end
end

function PLAYER:SaveWarehouseSingle( iItem )
	if not iItem then return end

	local iAmount = self.PlayerWarehouse[ iItem ]
	
	if iAmount < 1 then
		tmysql.query( Format( Query( "DELETEFROMWAREHOUSE" ), self.PERPID, iItem ) )
	else
		tmysql.query( Format( Query( "INSERTINTOWAREHOUSE" ), self.PERPID, iItem, iAmount, iAmount ) )
	end
end

util.AddNetworkString("perp2_warehouse_load")
function PLAYER:LoadWarehouse()
	self.PlayerWarehouse = {}

	tmysql.query( Format( Query( "LISTWAREHOUSE" ), self.PERPID ), function( Results, Status, ErrorMsg )
		for _, v in pairs( Results ) do
			local ItemID, Amount = tonumber( v[ "itemid" ] ), tonumber( v[ "amount" ] )

			-- Make sure it is a VALID item
			if not ITEM_DATABASE[ ItemID ] then continue end

			self.PlayerWarehouse[ ItemID ] = Amount

		end
		
		net.Start("perp2_warehouse_load")
		net.WriteTable(self.PlayerWarehouse)
		net.Send(self)

	end, QUERY_FLAG_ASSOC )
end