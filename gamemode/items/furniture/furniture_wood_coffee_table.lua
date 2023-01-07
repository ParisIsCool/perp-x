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

ITEM.ID 					= 92
ITEM.Reference 				= "furniture_wood_coffee_table"

ITEM.Name 					= "Rounded Coffee Table"
ITEM.Description			= "A table for putting coffee on. Isn't that obvious?\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 300

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props/cs_office/table_coffee.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_office/table_coffee.mdl" )

ITEM.ModelCamPos 			= Vector( 69, 34, 52 )
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