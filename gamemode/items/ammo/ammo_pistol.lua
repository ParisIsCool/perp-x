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

ITEM.ID 					= 30
ITEM.Reference 				= "ammo_pistol"

ITEM.Name 					= "Pistol Ammo"
ITEM.Description			= "Allows you to fire your small-arms.\n\nGrants 40 pistol bullets."

ITEM.Weight 				= 5
ITEM.Cost					= 1000

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/items/357ammo.mdl" )
ITEM.WorldModel 			= Model( "models/items/357ammo.mdl" )

ITEM.ModelCamPos 			= Vector( 12, -4, 9 )
ITEM.ModelLookAt 			= Vector( 0, 0, 4 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		Player:GiveAmmo( 40, "pistol" )
		--Player:AddProgress(36, 1)
	
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )