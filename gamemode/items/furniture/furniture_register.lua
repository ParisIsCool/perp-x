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

ITEM.ID 					= 50
ITEM.Reference 				= "furniture_register"

ITEM.Name 					= "Cash Register"
ITEM.Description			= "Useful for store managers (needed to sell items).\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping.\n Press F2 on an item when register is nearby."

ITEM.Weight 				= 5
ITEM.Cost					= 100

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_c17/cashregister01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/cashregister01a.mdl" )

ITEM.ModelCamPos 			= Vector( 2, 38, 8 )
ITEM.ModelLookAt 			= Vector( 2, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )