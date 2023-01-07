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

ITEM.ID 					= 82
ITEM.Reference 				= "furniture_concrete_barrier"

ITEM.Name 					= "Concrete Barrier"
ITEM.Description 			= "Useful for blocking off roads.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 50
ITEM.Cost 					= 300

ITEM.MaxStack 				= 50

ITEM.InventoryModel 		= Model( "models/props_c17/concrete_barrier001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/concrete_barrier001a.mdl" )

ITEM.ModelCamPos 			= Vector( -78, -68, 20 )
ITEM.ModelLookAt 			= Vector( 15, -5, 20 )
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