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

ITEM.ID 					= 1002
ITEM.Reference 				= "furniture_work_bench"

ITEM.Name 					= "Large Work Bench"
ITEM.Description			= "Do things on it?"

ITEM.Weight 				= 10
ITEM.Cost					= 1000

ITEM.MaxStack 				= 3

ITEM.InventoryModel 		= Model( "models/props/cs_militia/table_shed.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_militia/table_shed.mdl" )

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