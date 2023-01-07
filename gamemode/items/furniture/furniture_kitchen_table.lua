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

ITEM.ID 					= 206
ITEM.Reference 				= "furniture_kitchen_table"

ITEM.Name 					= "KItchen Table"
ITEM.Description			= "Kitchen Table"

ITEM.Weight 				= 10
ITEM.Cost					= 1000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_wasteland/kitchen_counter001d.mdl" )
ITEM.WorldModel 			= Model( "models/props_wasteland/kitchen_counter001d.mdl" )

ITEM.ModelCamPos 			= Vector( 0, -94, 10 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )