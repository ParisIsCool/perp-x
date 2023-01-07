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

ITEM.ID 					= 108
ITEM.Reference 				= "furniture_metal_fence"

ITEM.Name 					= "Metal Fence"
ITEM.Description			= "Designed for both privacy and protection.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 10
ITEM.Cost					= 400

ITEM.MaxStack 				= 50

ITEM.InventoryModel 		= Model( "models/props_c17/fence01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/fence01a.mdl" )

ITEM.ModelCamPos 			= Vector( 132, 0, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end

		Prop.UnBurnable = true
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )