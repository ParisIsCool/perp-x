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

ITEM.ID 					= 1001
ITEM.Reference 				= "furniture_sign_donotenter"

ITEM.Name 					= "Do Not Enter Sign"
ITEM.Description			= "Tells people to not enter..."

ITEM.Weight 				= 2
ITEM.Cost					= 500

ITEM.MaxStack 				= 3

ITEM.InventoryModel 		= Model( "models/props_downtown/sign_donotenter.mdl" )
ITEM.WorldModel 			= Model( "models/props_downtown/sign_donotenter.mdl" )

ITEM.ModelCamPos 			= Vector( 0, -94, 10 )
ITEM.ModelLookAt 			= Vector( 0, -90, 0 )
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