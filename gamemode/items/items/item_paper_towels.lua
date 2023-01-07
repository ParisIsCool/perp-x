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

ITEM.ID 					= 39
ITEM.Reference 				= "item_paper_towels"

ITEM.Name 					= "Paper Towels"
ITEM.Description			= "Useful for cleaning up blood stains."

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props/cs_office/paper_towels.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_office/paper_towels.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 0, 28 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )