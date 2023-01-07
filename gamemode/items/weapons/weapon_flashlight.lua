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

ITEM.ID 					= 83
ITEM.Reference 				= "weapon_flashlight"

ITEM.Name 					= "Flashlight"
ITEM.Description 			= "See in the dark."

ITEM.Weight 				= 5
ITEM.Cost					= 1000

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/lagmite/lagmite.mdl" )
ITEM.WorldModel 			= Model( "models/lagmite/lagmite.mdl" )

ITEM.ModelCamPos		 	= Vector( 0, 14, 21 )
ITEM.ModelLookAt 			= Vector( 8, -4, -1 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )