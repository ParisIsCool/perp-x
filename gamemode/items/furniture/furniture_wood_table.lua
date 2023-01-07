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

ITEM.ID 					= 100
ITEM.Reference 				= "furniture_wood_table"

ITEM.Name 					= "Wooden Table"
ITEM.Description			= "A plain wooden table.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 300

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props_c17/furnituretable002a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/furnituretable002a.mdl" )

ITEM.ModelCamPos 			= Vector( -68, 41, 38 )
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