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

ITEM.ID 					= 54
ITEM.Reference 				= "furniture_fridge"

ITEM.Name 					= "Refrigerator"
ITEM.Description			= "Stands in the corner and looks good.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 10
ITEM.Cost					= 300

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_c17/FurnitureFridge001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/FurnitureFridge001a.mdl" )

ITEM.ModelCamPos 			= Vector( 72, -36, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, -9 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )