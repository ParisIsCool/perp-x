--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local SHOP = {}

SHOP.ID 				= 69
SHOP.NPCAssociation 	= 269
SHOP.Name				= "Vending Machine"

SHOP.Items = {
	"food_coke",
	"food_melon",
	"food_orangejuice",
	"food_chips",
}
				
GAMEMODE:RegisterShop( SHOP )