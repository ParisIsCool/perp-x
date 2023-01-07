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

ITEM.ID 					= 32
ITEM.Reference 				= "ammo_shotgun"

ITEM.Name 					= "Buckshot"
ITEM.Description			= "Allows you to fire your shotguns.\n\nGrants 10 buckshot cartridges."

ITEM.Weight 				= 5
ITEM.Cost					= 1000

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/items/boxbuckshot.mdl" )
ITEM.WorldModel 			= Model( "models/items/boxbuckshot.mdl" )

ITEM.ModelCamPos			= Vector( 13, 12, 13 )
ITEM.ModelLookAt 			= Vector( 1, 2, 5 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )	
		Player:GiveAmmo( 10, "buckshot" )
		--Player:AddProgress(36, 1)
	
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )