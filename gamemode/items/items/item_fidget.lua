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

ITEM.ID 					= 998
ITEM.Reference 				= "item_fidget"

ITEM.Name 					= "Broken Fidget Spinner"
ITEM.Description			= "This one is broken.. but at least it is a spinner.. right?"

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_workshop/fidget_spinner.mdl" )
ITEM.WorldModel 			= Model( "models/props_workshop/fidget_spinner.mdl" )

ITEM.ModelCamPos 			= Vector( 4, -4, 14 )
ITEM.ModelLookAt 			= Vector( -2, 2, -6 )
ITEM.ModelFOV 				= 30

GAMEMODE:RegisterItem( ITEM )
