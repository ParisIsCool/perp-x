--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.PlayerWarehouse = {}

net.Receive( "perp2_warehouse_load", function()
	local Warehouse = net.ReadTable()

	GAMEMODE.PlayerWarehouse = {}
	
	for id, amount in pairs(Warehouse) do
		if amount <= 0 then return end
		
		if not GAMEMODE.PlayerWarehouse[ id ] then
			GAMEMODE.PlayerWarehouse[ id ] = { amount = 0, table = ITEM_DATABASE[ id ] }
		end
		
		GAMEMODE.PlayerWarehouse[ id ].amount = GAMEMODE.PlayerWarehouse[ id ].amount + amount
		
		if not IsValid(GAMEMODE.WarehousePanel) then
			hook.Add("Initialize", "PerpLoadTooFast", function()
				GAMEMODE.WarehousePanel:Build()
			end)
		else
			GAMEMODE.WarehousePanel:Build()
		end
	end
end )

net.Receive( "perp2_warehouse_insertsingle", function()
	local iItem = net.ReadInt(16)
	local iAmount = net.ReadInt(16)
	local bInv = net.ReadBool() or false

	if iAmount <= 0 then return end

	if not GAMEMODE.PlayerWarehouse[ iItem ] then
		GAMEMODE.PlayerWarehouse[ iItem ] = { amount = 0, table = ITEM_DATABASE[ iItem ] }
	end

	GAMEMODE.PlayerWarehouse[ iItem ].amount = GAMEMODE.PlayerWarehouse[ iItem ].amount + iAmount

	if bInv then surface.PlaySound( "doors/door_metal_large_close2.wav" ) end

	GAMEMODE.WarehousePanel:Build()
end )

net.Receive( "perp2_warehouse_delete", function()
	local iItem = net.ReadInt(16)
	local iAmount = net.ReadInt(16)
	local bInv = net.ReadBool() or false
	
	if iAmount <= 0 then return end
	
	if not GAMEMODE.PlayerWarehouse[ iItem ] then
		GAMEMODE.PlayerWarehouse[ iItem ] = { amount = 0, table = ITEM_DATABASE[ iItem ] }
	end
	
	GAMEMODE.PlayerWarehouse[ iItem ].amount = GAMEMODE.PlayerWarehouse[ iItem ].amount - iAmount
	
	if bInv then surface.PlaySound( "doors/door_metal_thin_close2.wav" ) end
	
	GAMEMODE.WarehousePanel:Build()
end )

usermessage.Hook( "perp2_warehouse_wipe", function()
	GAMEMODE.PlayerWarehouse = {}
	
	GAMEMODE.WarehousePanel:Build()
end )