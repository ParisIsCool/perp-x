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

ITEM.ID 					= 103
ITEM.Reference 				= "item_parkingticket"

ITEM.Name 					= "Traffic Ticket"
ITEM.Description			= "You have to pay it (use it) before you can drive your vehicles again.\nCheck the laws to see how much it costs before paying."

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
		local Price = GetGNWVar( "ticket_price" )
		
		if Player:GetCash() < Price then
			return Player:Notify( "You can't afford this!" )
		end
		
		local Log = Format( "%s spent $%s on a parking ticket at %s", Player:Nick(), util.FormatNumber( Price ), Player:GetZoneName() )
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
		local Price = GetGNWVar( "ticket_price" )

		Derma_Query( "Ticket: $" .. util.FormatNumber( Price ) .. " are you sure you want to pay?", "Ticket Payment",
			"No...", function() end,
			"Yes", function() RunConsoleCommand( "perp_i_u", SlotID ) end )
	end
end

GAMEMODE:RegisterItem( ITEM )