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

ITEM.ID 					= 7
ITEM.Reference 				= "item_salt"

ITEM.Name 					= "Salt"
ITEM.Description			= "A sack of salt. Useful for refilling salt shakers."

ITEM.Weight 				= 5
ITEM.Cost					= 300

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_misc/flour_sack-1.mdl" )
ITEM.WorldModel 			= Model( "models/props_misc/flour_sack-1.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 30, 6 )
ITEM.ModelLookAt 			= Vector( 0, 0, 9 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )