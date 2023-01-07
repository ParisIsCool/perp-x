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

ITEM.ID 					= 19
ITEM.Reference 				= "item_chunk_plastic"

ITEM.Name 					= "Chunk of Plastic"
ITEM.Description			= "A small chunk of plastic."

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 100

ITEM.InventoryModel 		= Model( "models/props_c17/canisterchunk01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/canisterchunk01a.mdl" )

ITEM.ModelCamPos 			= Vector( 14, 0, 18 )
ITEM.ModelLookAt 			= Vector( 0, 0, 20 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )