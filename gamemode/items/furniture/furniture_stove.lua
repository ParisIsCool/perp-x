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

ITEM.ID 					= 12
ITEM.Reference 				= "furniture_stove"

ITEM.Name 					= "Stove"
ITEM.Description			= "Useful for cooking things.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 35
ITEM.Cost					= 1000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_wasteland/kitchen_stove001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_wasteland/kitchen_stove001a.mdl" )

ITEM.ModelCamPos 			= Vector( 80, 0, 32 )
ITEM.ModelLookAt 			= Vector( -4, 0, 21 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end

		Prop.HeatSource = true
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )