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

ITEM.ID 					= 267
ITEM.Reference 				= "special_bust"

ITEM.Name 					= "Statue of God"
ITEM.Description			= "A small statue of The Man, The Myth, The Legend, GOD.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 15000

ITEM.MaxStack 				= 2

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