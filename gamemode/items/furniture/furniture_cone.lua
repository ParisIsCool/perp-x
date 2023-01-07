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

ITEM.ID 					= 49
ITEM.Reference 				= "furniture_cone"

ITEM.Name 					= "Traffic Cone"
ITEM.Description			= "Points out hazardous areas to drivers.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 35
ITEM.Cost					= 250

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/props_junk/trafficcone001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/trafficcone001a.mdl" )

ITEM.ModelCamPos 			= Vector( 8, 34, 8 )
ITEM.ModelLookAt 			= Vector( 0, 0, -2 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )