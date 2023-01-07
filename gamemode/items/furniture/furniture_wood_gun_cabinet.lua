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

ITEM.ID 					= 96
ITEM.Reference 				= "furniture_wood_gun_cabinet"

ITEM.Name 					= "Antique Gun Cabinet"
ITEM.Description			= "Unfortunatly, the guns don't work.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 1000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props/cs_militia/gun_cabinet.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_militia/gun_cabinet.mdl" )

ITEM.ModelCamPos 			= Vector( 89, 1, 42 )			
ITEM.ModelLookAt 			= Vector( 0, 0, 41 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )