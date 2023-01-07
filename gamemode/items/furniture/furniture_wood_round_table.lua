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

ITEM.ID 					= 97
ITEM.Reference 				= "furniture_wood_round_table"

ITEM.Name 					= "Round Wooden Table"
ITEM.Description			= "Slightly more pleasing to the eye.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 300

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props_c17/furnituretable001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/furnituretable001a.mdl" )

ITEM.ModelCamPos 			= Vector( -52, 21, 28 )
ITEM.ModelLookAt 			= Vector( 1, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )