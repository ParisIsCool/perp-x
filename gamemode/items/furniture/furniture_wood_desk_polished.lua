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

ITEM.ID 					= 93
ITEM.Reference 				= "furniture_wood_desk_polished"

ITEM.Name 					= "Polished Table"
ITEM.Description			= "Useful for a computer or easy reading.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 500

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props_interiors/furniture_desk01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_interiors/furniture_desk01a.mdl" )

ITEM.ModelCamPos 			= Vector( 73, 50, 33 )
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