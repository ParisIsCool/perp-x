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

ITEM.ID 					= 13
ITEM.Reference 				= "drug_pot"

ITEM.Name 					= "Marijuana"
ITEM.Description			= "Fresh and green."

ITEM.Weight 				= 5
ITEM.Cost					= 140 -- 150% profit over $250 per seed, i got this percentage of estimate 3 weed per pot.

ITEM.MaxStack 				= 200

ITEM.InventoryModel 		= Model( "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl" )
ITEM.WorldModel 			= Model( "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl" )

ITEM.ModelCamPos 			= Vector( 2, 0, 8 )
ITEM.ModelLookAt 			= Vector( 1, 0, -4 )
ITEM.ModelFOV 				= 70

ITEM.RestrictedSelling	 	= true

GAMEMODE:RegisterItem( ITEM )