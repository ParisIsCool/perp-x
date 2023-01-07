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

ITEM.ID 					= 1
ITEM.Reference 				= "furniture_radio"

ITEM.Name 					= "Radio"
ITEM.Description			= "Picks up FM broadcasts.\n\nAim at radio once spawned and press Z to change it's frequency.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 5
ITEM.Cost					= 1500

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props/cs_office/radio.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_office/radio.mdl" )

ITEM.ModelCamPos 			= Vector( 20, 0, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 8 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "whk_radio")

		if (!prop or !IsValid(prop)) then return false end

		return true
	end
end

GAMEMODE:RegisterItem( ITEM )
