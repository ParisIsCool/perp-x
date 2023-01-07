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

ITEM.ID 				= 15
ITEM.Reference 				= "item_pot"

ITEM.Name 				= "Gardening Pot"
ITEM.Description			= "Useful for planting things."

ITEM.Weight 				= 10
ITEM.Cost				= 300

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/props_c17/pottery06a.mdl" )
ITEM.WorldModel 		= Model( "models/props_c17/pottery06a.mdl" )

ITEM.ModelCamPos 			= Vector( 42, 6, 18 )
ITEM.ModelLookAt 			= Vector( 0, 0, 14 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )