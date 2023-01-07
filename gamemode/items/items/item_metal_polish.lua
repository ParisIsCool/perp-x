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

ITEM.ID 					= 23
ITEM.Reference 				= "item_metal_polish"

ITEM.Name 					= "Metal Polish"
ITEM.Description			= "Polishes metal to a nice shine."

ITEM.Weight 				= 5
ITEM.Cost					= 300

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_plasticbottle003a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_plasticbottle003a.mdl" )

ITEM.ModelCamPos 			= Vector( 24, 0, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )