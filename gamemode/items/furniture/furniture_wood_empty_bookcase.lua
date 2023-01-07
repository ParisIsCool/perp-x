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

ITEM.ID 					= 95
ITEM.Reference 				= "furniture_wood_empty_bookcase"

ITEM.Name 					= "Empty Bookcase"
ITEM.Description			= "Now you can stack your pointless, unread books with style.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 300

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props_c17/shelfunit01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/shelfunit01a.mdl" )

ITEM.ModelCamPos 			= Vector( 72, 100, 49 )
ITEM.ModelLookAt 			= Vector( 0, 0, 45 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )