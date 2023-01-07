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

ITEM.ID 					= 53
ITEM.Reference 				= "furniture_bed"

ITEM.Name 					= "Small Bed"
ITEM.Description			= "Needed for a good night sleep.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 10
ITEM.Cost					= 500

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/env/furniture/bed_connemara/bed_connemara_3rd.mdl" )
ITEM.WorldModel 			= Model( "models/env/furniture/bed_connemara/bed_connemara_3rd.mdl" )

ITEM.ModelCamPos 			= Vector( 93, 52, 68 )
ITEM.ModelLookAt 			= Vector( 0, 0, 13 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )