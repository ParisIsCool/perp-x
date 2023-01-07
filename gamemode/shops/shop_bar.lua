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

SHOP.ID 				= 5
SHOP.NPCAssociation 	= 155
SHOP.Name				= "Bar"

SHOP.Items	=	{
					"drug_beer",
					"drug_cig",
					"item_coke",
					"drug_bong", 
				}
				
GAMEMODE:RegisterShop( SHOP )