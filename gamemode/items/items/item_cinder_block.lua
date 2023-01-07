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

ITEM.ID 					= 21
ITEM.Reference 				= "item_cinder_block"

ITEM.Name 					= "Cinder Block"
ITEM.Description			= "A small cinder block, ideal for making large, stable structures."

ITEM.Weight 				= 10
ITEM.Cost					= 100

ITEM.MaxStack 				= 50

ITEM.InventoryModel 		= Model( "models/props_junk/cinderblock01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/cinderblock01a.mdl" )

ITEM.ModelCamPos 			= Vector( -28, 0, 2 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )