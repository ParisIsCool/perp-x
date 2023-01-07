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

ITEM.ID 					= 44
ITEM.Reference 				= "item_wrench"

ITEM.Name 					= "Wrench"
ITEM.Description			= "Tightens things."

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_c17/tools_wrench01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/tools_wrench01a.mdl" )

ITEM.ModelCamPos 			= Vector( 4, -4, 14 )
ITEM.ModelLookAt 			= Vector( -2, 2, -6 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )