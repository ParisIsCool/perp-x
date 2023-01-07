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

ITEM.ID 					= 24
ITEM.Reference 				= "item_board"

ITEM.Name 					= "Wooden Board"
ITEM.Description			= "A flat piece of wood."

ITEM.Weight 				= 5
ITEM.Cost					= 100

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_debris/wood_board06a.mdl" )
ITEM.WorldModel 			= Model( "models/props_debris/wood_board06a.mdl" )

ITEM.ModelCamPos 			= Vector( 66, -4, 9 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )