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

ITEM.ID 					= 10
ITEM.Reference 				= "drug_meth"

ITEM.Name 					= "Meth"
ITEM.Description			= "Completely dried and cooked methamphetamine."

ITEM.Weight 				= 5
ITEM.Cost					= 2000

ITEM.MaxStack 				= 100

ITEM.InventoryModel 		= Model( "models/props/water_bottle/perp2_bottle.mdl" )
ITEM.WorldModel 			= Model( "models/props/water_bottle/perp2_bottle.mdl" )

ITEM.ModelCamPos 			= Vector( 36, -6, 5 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
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