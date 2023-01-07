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

ITEM.ID 					= 130
ITEM.Reference 				= "item_parkingticket0"

ITEM.Name 					= "Written Warning"
ITEM.Description			= "You must acknowledge (use it) this warning before you can drive your vehicles again."

ITEM.Weight 				= 1
ITEM.Cost					= 0

ITEM.MaxStack 				= 1000

ITEM.InventoryModel 		= Model( "models/props_lab/clipboard.mdl" )
ITEM.WorldModel 			= Model( "models/props_lab/clipboard.mdl" )

ITEM.ModelCamPos 			= Vector( 22, 6, 8 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

ITEM.RestrictedSelling	 	= true
ITEM.RestrictTrading 		= true

if SERVER then
	function ITEM.OnUse( Player )	
		local Price = 0
		
		if Player:GetCash() < Price then
			return Player:Notify( "You can't afford this!" )
		end
		
		local Log = Format( "%s spent $%s on a written warning at %s", Player:Nick(), util.FormatNumber( Price ), Player:GetZoneName() )
		GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

		Player:TakeCash( Price, true )
		GAMEMODE.GiveCityMoney( Price )

		return true
	end

	function ITEM.OnDrop( Player )
		return Player:Notify( "You can't drop your ticket!" )
	end
else
	function ITEM.OnUse( SlotID )
		local Price = 0

		Derma_Query( "An officer has written you a warning.", "Acknowledge",
			"No...", function() end,
			"Understood.  I won't do it again.", function() RunConsoleCommand( "perp_i_u", SlotID ) end )
	end
end

GAMEMODE:RegisterItem( ITEM )