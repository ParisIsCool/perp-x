--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local ITEM 					= {}

ITEM.ID 					= 4
ITEM.Reference 				= "item_waterbottle"

ITEM.Name 					= "Water Bottle"
ITEM.Description			= "A 24 oz. bottle of water."

ITEM.Weight 				= 5
ITEM.Cost					= 150

ITEM.MaxStack 				= 20

ITEM.InventoryModel 		= Model( "models/props/cs_office/Water_bottle.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_office/Water_bottle.mdl" )

ITEM.ModelCamPos 			= Vector( 12, 2, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )