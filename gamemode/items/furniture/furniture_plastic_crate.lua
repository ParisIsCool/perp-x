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

ITEM.ID 					= 106
ITEM.Reference 				= "furniture_plastic_crate"

ITEM.Name 					= "Plastic Crate"
ITEM.Description			= "Easy to keep shop items on.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 5
ITEM.Cost					= 100

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_junk/PlasticCrate01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/PlasticCrate01a.mdl" )

ITEM.ModelCamPos 			= Vector( 32, -33, 21 )
ITEM.ModelLookAt 			= Vector( -8, 10, 0 )
ITEM.ModelFOV 				= 90

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )