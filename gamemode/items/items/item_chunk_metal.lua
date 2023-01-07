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

ITEM.ID 					= 18
ITEM.Reference 				= "item_chunk_metal"

ITEM.Name 					= "Piece of Metal"
ITEM.Description			= "A small piece of metal."

ITEM.Weight 				= 5
ITEM.Cost					= 250

ITEM.MaxStack 				= 100

ITEM.InventoryModel 		= Model( "models/gibs/metal_gib4.mdl" )
ITEM.WorldModel 			= Model( "models/gibs/metal_gib4.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 0, 8 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )