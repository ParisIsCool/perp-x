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

ITEM.ID 					= 86
ITEM.Reference 				= "drug_beer_box_full"

ITEM.Name 					= "Box o' Beer (6 Beers)"
ITEM.Description			= "Allows your guests to grab beers at their leisure."

ITEM.Weight 				= 10
ITEM.Cost					= 200

ITEM.MaxStack 				= 15

ITEM.InventoryModel 		= Model( "models/props/cs_militia/caseofbeer01.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_militia/caseofbeer01.mdl" )
ITEM.ModelCamPos 			= Vector( 0, -16, 25 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local Prop = Player:SpawnProp( ITEM, "prop_case_beer" )
		if not Prop or not IsValid( Prop ) then return false end
		
		Prop:SetNumBeers( 6, Player )
				
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )