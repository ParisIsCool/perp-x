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

ITEM.ID 					= 20
ITEM.Reference 				= "item_cardboard"

ITEM.Name 					= "Cardboard Box"
ITEM.Description			= "An ancient box made of cardboard."

ITEM.Weight 				= 5
ITEM.Cost					= 150

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_junk/cardboard_box004a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/cardboard_box004a.mdl" )

ITEM.ModelCamPos 			= Vector( 4, 8, 18 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )