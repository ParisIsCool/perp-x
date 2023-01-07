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

ITEM.ID 					= 105
ITEM.Reference 				= "furniture_shelf"

ITEM.Name 					= "Metal Shelf"
ITEM.Description			= "Useful to show your shop items on.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 25
ITEM.Cost					= 500

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_wasteland/kitchen_shelf001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_wasteland/kitchen_shelf001a.mdl" )

ITEM.ModelCamPos 			= Vector( 100, 100, 56 )
ITEM.ModelLookAt 			= Vector( -10, -5, 45 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )