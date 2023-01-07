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

ITEM.ID 					= 14
ITEM.Reference 				= "drug_pot_seeds"

ITEM.Name 					= "Cannabis Seeds"
ITEM.Description			= "Looks like they would grow in a pot..."

ITEM.Weight 				= 5
ITEM.Cost					= 250

ITEM.MaxStack 				= 250

ITEM.InventoryModel 		= Model( "models/katharsmodels/contraband/zak_wiet/zak_seed.mdl" )
ITEM.WorldModel 			= Model( "models/katharsmodels/contraband/zak_wiet/zak_seed.mdl" )

ITEM.ModelCamPos 			= Vector( 2, 0, 8 )
ITEM.ModelLookAt 			= Vector( 1, 0, -4 )
ITEM.ModelFOV 				= 70

ITEM.RestrictedSelling	 	= true

if SERVER then
	function ITEM.OnDrop( Player, Trace )
		if Player:Team() ~= TEAM_CITIZEN then
			return Player:Notify( "You can not drop illegal items as a government official." )
		end

		return true
	end
end

GAMEMODE:RegisterItem( ITEM )