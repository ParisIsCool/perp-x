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

ITEM.ID 					= 203
ITEM.Reference 				= "furniture_steel_beam"

ITEM.Name 					= "Steel Beam"
ITEM.Description			= "Steel Beam"

ITEM.Weight 				= 10
ITEM.Cost					= 1000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/mechanics/solid_steel/step_beam_32.mdl" )
ITEM.WorldModel 			= Model( "models/mechanics/solid_steel/step_beam_32.mdl" )

ITEM.ModelCamPos 			= Vector( 0, -94, 10 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
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