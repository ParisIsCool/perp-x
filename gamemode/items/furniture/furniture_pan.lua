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

ITEM.ID 					= 81
ITEM.Reference 				= "furniture_pan"

ITEM.Name 					= "Frying Pan"
ITEM.Description			= "Useful for frying things.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 5
ITEM.Cost 					= 100

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_interiors/pot02a.mdl" )
ITEM.WorldModel 			= Model( "models/props_interiors/pot02a.mdl" )

ITEM.ModelCamPos 			= Vector( 2, -4, 18 )
ITEM.ModelLookAt 			= Vector( 0, -1, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )