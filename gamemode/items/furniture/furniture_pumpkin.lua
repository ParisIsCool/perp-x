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

ITEM.ID 					= 231
ITEM.Reference 				= "furniture_pumpkin"

ITEM.Name 					= "Pumpkin"
ITEM.Description			= "Useful for decor.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 300

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/pumbkin/pumbkin.mdl" )
ITEM.WorldModel 			= Model( "models/pumbkin/pumbkin.mdl" )

ITEM.ModelCamPos 			= Vector( 100, 0, 70 )
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