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

ITEM.ID 					= 29
ITEM.Reference 				= "item_paint"

ITEM.Name 					= "Paint Bucket"
ITEM.Description			= "Filled to the brim with paint."

ITEM.Weight 				= 5
ITEM.Cost					= 150

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_junk/plasticbucket001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/plasticbucket001a.mdl" )

ITEM.ModelCamPos 			= Vector( 8, 26, 8 )
ITEM.ModelLookAt 			= Vector( 0, 0, 4 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )