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

ITEM.ID 					= 1000
ITEM.Reference 				= "furniture_half_metal_barrier"

ITEM.Name 					= "Half Metal Barrier"
ITEM.Description			= "Half Metal Barrier"

ITEM.Weight 				= 10
ITEM.Cost					= 1000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_lab/blastdoor001b.mdl" )
ITEM.WorldModel 			= Model( "models/props_lab/blastdoor001b.mdl" )

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