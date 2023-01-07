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

ITEM.ID 					= 102
ITEM.Reference 				= "item_nail"

ITEM.Name 					= "Wood Nail"
ITEM.Description			= "A large nail. Useful for wood working."

ITEM.Weight 				= 5
ITEM.Cost					= 30

ITEM.MaxStack 				= 100

ITEM.InventoryModel 		= Model( "models/props_c17/TrapPropeller_Lever.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/TrapPropeller_Lever.mdl" )

ITEM.ModelCamPos 			= Vector( 0, -1, 22 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )