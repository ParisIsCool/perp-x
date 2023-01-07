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

ITEM.ID 					= 85
ITEM.Reference 				= "drug_beer_box_empty"

ITEM.Name 					= "Box o' Beer (Empty)"
ITEM.Description			= "Allows your guests to grab beers at their leisure."

ITEM.Weight 				= 10
ITEM.Cost					= 100

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props/cs_militia/caseofbeer01.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_militia/caseofbeer01.mdl" )
ITEM.ModelCamPos 			= Vector( 0, -16, 25 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
ITEM.ModelFOV 				= 70

if SERVER then

	function ITEM.OnUse( Player )
		local prop = Player:SpawnProp( ITEM, "prop_case_beer" )
		if not prop or not IsValid( prop ) then return false end
		
		prop:SetNumBeers( 0, Player )
				
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )