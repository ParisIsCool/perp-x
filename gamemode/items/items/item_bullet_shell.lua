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

ITEM.ID 					= 25
ITEM.Reference 				= "item_bullet_shell"

ITEM.Name 					= "Bullet Casings"
ITEM.Description			= "Looks kinda empty."

ITEM.Weight 				= 5
ITEM.Cost					= 250

ITEM.MaxStack 				= 20

ITEM.InventoryModel 		= Model( "models/Shells/shell_large.mdl" )
ITEM.WorldModel 			= Model( "models/Shells/shell_large.mdl" )

ITEM.ModelCamPos 			= Vector( 0, -20, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 20
ITEM.Angles 				= Angle(-90, 0, 0)

GAMEMODE:RegisterItem( ITEM )