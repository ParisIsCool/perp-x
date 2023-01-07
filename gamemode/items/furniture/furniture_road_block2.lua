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

ITEM.ID 					= 204
ITEM.Reference 				= "furniture_roadblock2"

ITEM.Name 					= "Road Block"
ITEM.Description			= "Road Block"

ITEM.Weight 				= 10
ITEM.Cost					= 1000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props/cs_assault/BarrelWarning.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_assault/BarrelWarning.mdl" )

ITEM.ModelCamPos 			= Vector( 0, -60, 15 )
ITEM.ModelLookAt 			= Vector( 0, 0, 15 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )