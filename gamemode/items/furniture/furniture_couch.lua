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

ITEM.ID 					= 80
ITEM.Reference 				= "furniture_couch"

ITEM.Name 					= "Large Sofa"
ITEM.Description 			= "Perfect for relaxation after a long day.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 25
ITEM.Cost 					= 750

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_c17/furniturecouch001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/furniturecouch001a.mdl" )

ITEM.ModelCamPos 			= Vector( 92, 0, 26 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )