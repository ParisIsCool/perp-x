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

ITEM.ID 					= 17
ITEM.Reference 				= "furniture_clock"

ITEM.Name 					= "Clock"
ITEM.Description			= "Displays the time in an easy to read fasion."

ITEM.Weight 				= 10
ITEM.Cost					= 500

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_c17/clock01.mdl" )
ITEM.WorldModel 			= Model( "models/props_c17/clock01.mdl" )

ITEM.ModelCamPos 			= Vector( 2, 0, 17 )
ITEM.ModelLookAt 			= Vector( -14, 0, -88 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM, "prop_clock" )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

//GAMEMODE:RegisterItem( ITEM )