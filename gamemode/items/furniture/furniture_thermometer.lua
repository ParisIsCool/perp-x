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

ITEM.ID 					= 60
ITEM.Reference 				= "furniture_thermometer"

ITEM.Name 					= "Thermometer"
ITEM.Description			= "Displays the temperature."

ITEM.Weight 				= 10
ITEM.Cost					= 750

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_combine/perpthermo.mdl" )
ITEM.WorldModel 			= Model( "models/props_combine/perpthermo.mdl" )

ITEM.ModelCamPos 			= Vector( 18, 0, -2 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM, "prop_thermo" )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )