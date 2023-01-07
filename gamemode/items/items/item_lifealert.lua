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

ITEM.ID 					= 3
ITEM.Reference 				= "item_lifealert"

ITEM.Name 					= "Life Alert"
ITEM.Description			= "Automatically contacts paramedics in case of an accident."

ITEM.Weight 				= 5
ITEM.Cost					= 500

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props_c17/consolebox05a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/consolebox05a.mdl" )

ITEM.ModelCamPos 			= Vector( 33, 20, 9 )
ITEM.ModelLookAt 			= Vector( 0, -5, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )