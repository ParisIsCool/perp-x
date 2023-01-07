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

ITEM.ID 					= 58
ITEM.Reference 				= "furniture_bust"

ITEM.Name 					= "Marble Bust"
ITEM.Description			= "A small statue of The Man.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 250

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_combine/breenbust.mdl" )
ITEM.WorldModel 			= Model( "models/props_combine/breenbust.mdl" )

ITEM.ModelCamPos 			= Vector( 32, 0, 0 )
ITEM.ModelLookAt 			= Vector( 0, -2, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )