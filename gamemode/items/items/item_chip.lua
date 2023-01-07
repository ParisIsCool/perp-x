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

ITEM.ID 					= 70
ITEM.Reference 				= "item_chip"

ITEM.Name 					= "Electronics"
ITEM.Description 			= "An electronic component, useful for making automated systems."

ITEM.Weight 				= 20
ITEM.Cost 					= 300

ITEM.MaxStack 				= 40

ITEM.InventoryModel 		= Model( "models/cheeze/wires/mini_chip.mdl" )
ITEM.WorldModel 			= Model( "models/cheeze/wires/mini_chip.mdl" )

ITEM.ModelCamPos 			= Vector(0, 0, 8)
ITEM.ModelLookAt 			= Vector(0, 0, 0)
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )