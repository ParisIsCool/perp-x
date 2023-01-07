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

ITEM.ID 					= 265
ITEM.Reference 				= "special_logo"

ITEM.Name 					= "Voltage-Gaming Logo"
ITEM.Description			= "[RARE]\n\n Logo of our community. \n Given out in events or special times."

ITEM.Weight 				= 10
ITEM.Cost					= 10000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/vg/logo.mdl" )
ITEM.WorldModel 			= Model( "models/vg/logo.mdl" )

ITEM.ModelCamPos 			= Vector( 93, 52, 68 )
ITEM.ModelLookAt 			= Vector( 0, 0, 13 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )