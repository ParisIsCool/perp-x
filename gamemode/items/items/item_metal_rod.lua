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

ITEM.ID 					= 22
ITEM.Reference 				= "item_metal_rod"

ITEM.Name 					= "Metal Rod"
ITEM.Description			= "A long, slender metal rod."

ITEM.Weight 				= 5
ITEM.Cost					= 150

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_c17/signpole001.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/signpole001.mdl" )

ITEM.ModelCamPos			= Vector( 72, 9, 32 )
ITEM.ModelLookAt 			= Vector( 0, 0, 40 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )