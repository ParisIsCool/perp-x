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

ITEM.ID 					= 200
ITEM.Reference 				= "item_raw_fish"

ITEM.Name 					= "Raw Fish"
ITEM.Description			= "With a little heat I'm sure this would taste good."

ITEM.Weight 				= 5
ITEM.Cost					= 10

ITEM.MaxStack 				= 15

ITEM.InventoryModel 		= Model( "models/foodnhouseholditems/fishbass.mdl" )
ITEM.WorldModel 			= Model( "models/foodnhouseholditems/fishbass.mdl" )

ITEM.ModelCamPos 			= Vector( -5, 0, -20 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )