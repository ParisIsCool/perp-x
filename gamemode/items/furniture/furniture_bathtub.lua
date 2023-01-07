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

ITEM.ID 					= 6
ITEM.Reference 				= "furniture_bathtub"

ITEM.Name 					= "Bathtub"
ITEM.Description			= "A large bathtub. Looks like it could hold a lot of water.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 10
ITEM.Cost					= 1000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props_interiors/BathTub01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_interiors/BathTub01a.mdl" )

ITEM.ModelCamPos 			= Vector( 0, -94, 10 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		Prop.WaterSource = true
		Prop.UnBurnable = true
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )