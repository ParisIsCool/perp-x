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

ITEM.ID 					= 88
ITEM.Reference 				= "furniture_saw_horse"

ITEM.Name 					= "Saw Horse"
ITEM.Description			= "Useful for working with wood.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 100
ITEM.Cost					= 750

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props/cs_militia/sawhorse.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_militia/sawhorse.mdl" )

ITEM.ModelCamPos 			= Vector( 42, -54, 20 )
ITEM.ModelLookAt 			= Vector( -6, 0, 15 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		Prop.SawHorse = true

		return true
	end
end

GAMEMODE:RegisterItem( ITEM )