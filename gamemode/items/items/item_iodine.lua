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

ITEM.ID 					= 8
ITEM.Reference 				= "item_iodine"

ITEM.Name 					= "Iodine"
ITEM.Description			= "A bottle of iodine."

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_plasticbottle002a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_plasticbottle002a.mdl" )

ITEM.ModelCamPos 			= Vector( 22, 2, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )