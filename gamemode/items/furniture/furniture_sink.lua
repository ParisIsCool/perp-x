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

ITEM.ID 					= 79
ITEM.Reference 				= "furniture_sink"

ITEM.Name 					= 'Sink'
ITEM.Description 			= "Supplies ample amounts of water.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 50
ITEM.Cost 					= 500

ITEM.MaxStack 				= 3

ITEM.InventoryModel 		= Model( "models/props_c17/furnituresink001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/furnituresink001a.mdl" )

ITEM.ModelCamPos 			= Vector(18, 0, 30)
ITEM.ModelLookAt 			= Vector(-14, 0, -1)
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end

		Prop.WaterSource = true
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )