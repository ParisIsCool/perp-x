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

ITEM.ID 					= 255
ITEM.Reference 				= "ammo_rifle_event"

ITEM.Name 					= "Free Rifle Ammo"
ITEM.Description			= "Grants 500 rifle bullets per box. FOR EVENT USE ONLY!"

ITEM.Weight 				= 5
ITEM.Cost					= 0

ITEM.MaxStack 				= 50

ITEM.InventoryModel 		= Model( "models/Items/BoxSRounds.mdl" )
ITEM.WorldModel 			= Model( "models/Items/BoxSRounds.mdl" )

ITEM.ModelCamPos 			= Vector( 21, -4, 6 )
ITEM.ModelLookAt 			= Vector( -2, 0, 6 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )	
		Player:GiveAmmo( 500, "smg1" )
		--Player:AddProgress(36, 1)
	
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )