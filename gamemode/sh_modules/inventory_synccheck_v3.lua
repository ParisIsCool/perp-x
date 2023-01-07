--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

	
// redone by killz
-- ^ ew

if(CLIENT) then
	--GM.LastInventoryClientChange = CurTime()
	
	GM.LastInvClientChange = CurTime()

	local function Perp2InvFix()
		local meta = {}
		meta.__newindex = function(tbl, key, value)
			GAMEMODE.LastInvClientChange = CurTime() + 3 + (LocalPlayer():Ping() * 0.001)
			
			rawset(tbl,key,value)
		end
		
		setmetatable(GAMEMODE.PlayerItems, meta)
	end
	hook.Add("InitPostEntity", "Perp2InvFix", Perp2InvFix)
	
	local function InvSync_RecInventCorr()
		if(GAMEMODE.LastInvClientChange > CurTime()) then return end

		local iSlot = net.ReadInt(16)
		local iID = net.ReadInt(16)
		local iQuantity = net.ReadInt(32)
		
		if(iQuantity < 1) then
			iQuantity = nil
		end
		if(iID < 1) then
			iID = nil
		end
		
		local iOutOfSync = false
		
		if(not iID or not iQuantity) then
			if(GAMEMODE.PlayerItems[iSlot]) then
				iOutOfSync = 1
			end
			GAMEMODE.PlayerItems[iSlot] = nil
			
			GAMEMODE.InventoryBlocks_Linear[iSlot]:GrabItem()
		else
			if(GAMEMODE.PlayerItems[iSlot]) then
				if(GAMEMODE.PlayerItems[iSlot].ID != iID) then
					GAMEMODE.PlayerItems[iSlot].ID = iID
					
					iOutOfSync = 2
					
					GAMEMODE.PlayerItems[iSlot].Table = ITEM_DATABASE[iID]
					
					GAMEMODE.InventoryBlocks_Linear[iSlot]:GrabItem()
				end
				if(GAMEMODE.PlayerItems[iSlot].Quantity != iQuantity) then
					GAMEMODE.PlayerItems[iSlot].Quantity = iQuantity
					
					iOutOfSync = 3
					
					GAMEMODE.PlayerItems[iSlot].Table = ITEM_DATABASE[iID]
					
					GAMEMODE.InventoryBlocks_Linear[iSlot]:GrabItem()
				end
			else
				iOutOfSync = 4
				
				GAMEMODE.PlayerItems[iSlot] = {}
				GAMEMODE.PlayerItems[iSlot].ID = iID
				GAMEMODE.PlayerItems[iSlot].Quantity = iQuantity
				GAMEMODE.PlayerItems[iSlot].Table = ITEM_DATABASE[iID]
				
				GAMEMODE.InventoryBlocks_Linear[iSlot]:GrabItem()
			end
		end
		
		if(iOutOfSync) then
			LocalPlayer():Notify("[Inventory Sync][ERROR] Updating slot " .. iSlot .. "! (EC " .. iOutOfSync .. ")")
			RunConsoleCommand("perp2_sync_warn", iSlot, iOutOfSync)
		end
	end
	net.Receive("perp2_invsync_corr", InvSync_RecInventCorr)

end



if(SERVER) then
	util.AddNetworkString("perp2_invsync_corr")
	function InvenSynr_ValidSlot(objPl)
		local tblPlayerItems = objPl.PlayerItems
		
		if(not tblPlayerItems) then return end
		
		for iSlot=3, INVENTORY_WIDTH * INVENTORY_HEIGHT + 2 do
			if(not tblPlayerItems[iSlot] or not tblPlayerItems[iSlot].ID or not tblPlayerItems[iSlot].Quantity) then
				
				net.Start("perp2_invsync_corr")
				net.WriteInt(iSlot,16)
				net.WriteInt(0,16)
				net.WriteInt(0,32)
				net.Send(objPl)
			else
				net.Start("perp2_invsync_corr")
				net.WriteInt(iSlot,16)
				net.WriteInt(tblPlayerItems[iSlot].ID,16)
				net.WriteInt(tblPlayerItems[iSlot].Quantity,32)
				net.Send(objPl)
			end
		end
	end

	local function InvSyncer_Timer()
		--[[for k, v in pairs(player.GetAll()) do
			if(v.PlayerItems) then
				InvenSynr_ValidSlot(v)
			end
		end]]
	end
	timer.Create("InvSyncer_Timer", 3, 0, function() InvSyncer_Timer() end)

	function InvSyncer_PlyOutOfSync(objPl,_, tblArgs)
		local str = "_lite"
		//if(GAMEMODE.IsSerious()) then
			//str = "_serious"
		//end
		
		//filex.Append("perpx" .. str .. "/sync.txt", "Player " .. objPl:Nick() .. "(" .. objPl:SteamID() .. ") inventory out of sync. Slot " .. tblArgs[1] .. ". Location " .. tostring(objPl:GetPos()) .. "! Error code " .. tblArgs[2] .. "\n")
	end
	concommand.Add("perp2_sync_warn", InvSyncer_PlyOutOfSync)
end