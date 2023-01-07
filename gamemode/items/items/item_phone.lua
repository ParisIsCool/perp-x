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

ITEM.ID 					= 2
ITEM.Reference 				= "item_phone"

ITEM.Name 					= "Cell Phone"
ITEM.Description			= "Allows you to communicate with others from a distance.\n\nPress Z to open your phone."

ITEM.Weight 				= 5
ITEM.Cost					= 500

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/nokia/3230.mdl" )
ITEM.WorldModel 			= Model( "models/nokia/3230.mdl" )

ITEM.ModelCamPos 			= Vector(5, -5, -2)
ITEM.ModelLookAt 			= Vector(0, 0, 0)
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )