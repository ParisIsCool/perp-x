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

ITEM.ID 					= 259
ITEM.Reference 				= "furniture_i_beam"

ITEM.Name 					= "I Beam"
ITEM.Description			= "Provides support to props."

ITEM.Weight 				= 10
ITEM.Cost					= 1100

ITEM.MaxStack 				= 4

ITEM.InventoryModel 		= Model( "models/props_junk/iBeam01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/iBeam01a.mdl" )

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