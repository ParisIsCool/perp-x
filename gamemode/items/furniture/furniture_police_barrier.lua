
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

ITEM.ID 					= 84
ITEM.Reference 				= "furniture_police_barrier"

ITEM.Name 					= "Police Barricade"
ITEM.Description			= "Useful for blocking\ncity roads.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 15
ITEM.Cost 					= 500

ITEM.Rotate 				= 90

ITEM.MaxStack 				= 50

ITEM.InventoryModel 		= Model( "models/props_wasteland/barricade002a.mdl" )
ITEM.WorldModel 			= Model( "models/props_wasteland/barricade002a.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 80, -2 )
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