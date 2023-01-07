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

ITEM.ID 					= 205
ITEM.Reference 				= "furniture_metal_barrier"

ITEM.Name 					= "Metal Barrier"
ITEM.Description			= "Metal Barrier"

ITEM.Weight 				= 10
ITEM.Cost					= 1000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_lab/blastdoor001c.mdl" )
ITEM.WorldModel 			= Model( "models/props_lab/blastdoor001c.mdl" )

ITEM.ModelCamPos 			= Vector( 150, 0, 50 )
ITEM.ModelLookAt 			= Vector( 0, 0, 50 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end

		Prop.UnBurnable = true
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )