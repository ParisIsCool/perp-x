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

SHOP.ID 				= 8
SHOP.NPCAssociation 	= 299
SHOP.Name				= "Road Shop"

SHOP.Items = {
	'furniture_concrete_barrier',
	"furniture_police_barrier",
	"furniture_cone",
	"furniture_roadblock2",
	"item_tire",
	"item_exhaust",
	"item_vclight",
	"item_engine"
}

GAMEMODE:RegisterShop( SHOP )
