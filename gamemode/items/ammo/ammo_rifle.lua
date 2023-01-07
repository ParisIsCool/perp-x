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

ITEM.ID 					= 31
ITEM.Reference 				= "ammo_rifle"

ITEM.Name 					= "Rifle Ammo"
ITEM.Description			= "Allows you to fire your small-arms.\n\nGrants 65 rifle bullets."

ITEM.Weight 				= 5
ITEM.Cost					= 1000

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/Items/BoxSRounds.mdl" )
ITEM.WorldModel 			= Model( "models/Items/BoxSRounds.mdl" )

ITEM.ModelCamPos 			= Vector( 21, -4, 6 )
ITEM.ModelLookAt 			= Vector( -2, 0, 6 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )	
		Player:GiveAmmo( 65, "smg1" )
		--Player:AddProgress(36, 1)
	
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )