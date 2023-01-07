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

ITEM.ID 					= 5
ITEM.Reference 				= "item_kittylitter"

ITEM.Name 					= "Kitty Litter"
ITEM.Description			= "A large bottle of kitty litter. Keeps the smell away."

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_plasticbottle001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_plasticbottle001a.mdl" )

ITEM.ModelCamPos 			= Vector( 5, -25, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

GAMEMODE:RegisterItem( ITEM )