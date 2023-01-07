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

ITEM.ID 					= 101
ITEM.Reference 				= "item_glue"

ITEM.Name 					= "Glue"
ITEM.Description			= "A hot glue gun. Useful for wood working."

ITEM.Weight 				= 5
ITEM.Cost					= 125

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/Items/battery.mdl" )
ITEM.WorldModel 			= Model( "models/Items/battery.mdl" )

ITEM.ModelCamPos 			= Vector( 1, -17, 6 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )