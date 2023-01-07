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

ITEM.ID 					= 48
ITEM.Reference 				= "furniture_chair_computer"

ITEM.Name 					= "Computer Chair"
ITEM.Description			= "Take a load off.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 35
ITEM.Cost					= 500

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/nova/chair_office01.mdl" )
ITEM.WorldModel 			= Model( "models/nova/chair_office01.mdl" )

ITEM.ModelCamPos 			= Vector( -25, 46, 29 )
ITEM.ModelLookAt 			= Vector( 0, 0, 20 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM, "prop_vehicle_prisoner_pod" )
		
		if not Prop or not IsValid( Prop ) then return false end

		return true
	end
end

GAMEMODE:RegisterItem( ITEM )