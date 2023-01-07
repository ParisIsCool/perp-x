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

ITEM.ID 					= 99
ITEM.Reference 				= "furniture_wood_simple_table"

ITEM.Name 					= "Simplistic Table"
ITEM.Description			= "Looks a bit rotten in some parts...\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 500

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props/cs_militia/wood_table.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_militia/wood_table.mdl" )

ITEM.ModelCamPos 			= Vector( 33, 76, 52 )
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