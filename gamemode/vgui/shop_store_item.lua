--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up

local PANEL = {}

function PANEL:Think ( ) end

function PANEL:OnMousePressed ( MouseCode )	
	if (MouseCode == MOUSE_LEFT) then
		GAMEMODE.BuyItem(self.itemTable.ID, 1)
	elseif (MouseCode == MOUSE_RIGHT) then
		GAMEMODE.BuyItem(self.itemTable.ID, 5)
	end
end

function PANEL:OnMouseReleased( MouseCode )

end

vgui.Register("perp2_shop_store_item", PANEL, "perp2_inventory_block_item")