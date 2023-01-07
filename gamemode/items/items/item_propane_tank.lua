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

ITEM.ID 					= 40
ITEM.Reference 				= "item_propane_tank"

ITEM.Name 					= "Propane Tank"
ITEM.Description			= "Useful for fueling fires."

ITEM.Weight 				= 5
ITEM.Cost					= 1500

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_junk/PropaneCanister001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/PropaneCanister001a.mdl" )

ITEM.ModelCamPos 			= Vector( -5, 25, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )