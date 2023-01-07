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

SHOP.ID 				= 4
SHOP.NPCAssociation 	= 23
SHOP.Name				= "John's General Electronics/Items"

SHOP.Items = {	
	--"item_flashlight",
	"weapon_flashlight",
	"item_chip",
	"furniture_lamp_spot",
	"furniture_sign",
	"item_house_alarm",
    "furniture_camera",
	"item_tv_small",
	--"drug_vape0", --broken
	--"drug_vape1",
}
				
GAMEMODE:RegisterShop( SHOP )