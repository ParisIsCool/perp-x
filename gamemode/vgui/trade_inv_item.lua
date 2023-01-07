--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local PANEL = {}

function PANEL:Think() end

PANEL.otherGrabItem = PANEL.GrabItem

function PANEL:OnMousePressed( MouseCode )	
	self.trueParent.SelectedForTrade = not self.trueParent.SelectedForTrade
	
	if self.trueParent.SelectedForTrade and table.Count( GAMEMODE.OurOffer_Items ) >= 15 then
		self.trueParent.SelectedForTrade = nil
		return LocalPlayer():Notify( "You have reached the maximum offer size." )
	end
	
	if self.trueParent.itemTable.RestrictTrading then
		self.trueParent.SelectedForTrade = nil
		return LocalPlayer():Notify( "You can't trade this item." )
	end
	
	GAMEMODE.Trade_WeAccepted 		= nil
	GAMEMODE.Trade_TheyAccepted 	= nil
	
	RunConsoleCommand( "perp_t_ot", self.trueParent.itemID )
	
	if self.trueParent.SelectedForTrade then
		table.insert( GAMEMODE.OurOffer_Items, self.trueParent.itemID )
	else
		for k, v in pairs( GAMEMODE.OurOffer_Items ) do
			if v == self.trueParent.itemID then
				table.remove( GAMEMODE.OurOffer_Items, k )
			end
		end
	end
end

function PANEL:OnMouseReleased() end

vgui.Register( "perp2_trade_inv_item", PANEL, "perp2_inventory_block_item" )