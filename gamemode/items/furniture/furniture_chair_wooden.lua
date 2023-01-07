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

ITEM.ID 					= 45
ITEM.Reference 				= "furniture_chair_wooden"

ITEM.Name 					= "Wooden Chair"
ITEM.Description			= "Take a load off.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 35
ITEM.Cost					= 750

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/nova/chair_wood01.mdl" )
ITEM.WorldModel 			= Model( "models/nova/chair_wood01.mdl" )

ITEM.ModelCamPos 			= Vector( 45, 18, 22 )
ITEM.ModelLookAt 			= Vector( 0, 0, 17 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM, "prop_vehicle_prisoner_pod" )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )