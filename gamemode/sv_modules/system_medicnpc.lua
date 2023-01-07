--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local LegFix = 600
local Heal = 300

concommand.Add( "perp_fixlegs", function( ply, cmd, args )
	if not IsValid( ply ) then return end
	if not ply:NearNPC( 29 ) then return ply:CaughtCheating( "Tried 'perp_fixlegs' without being near an NPC.", EXPLOIT_POSSIBLETHREAT ) end

	if not ply:IsGovernmentOfficial() then
		if ply:GetCash() < LegFix then return end

		local Log = Format( "%s paid $%i for leg repairs", ply:Nick(), util.FormatNumber( LegFix ) )
		GAMEMODE:Log( "cashlog", Log, ply:SteamID() )

		ply:TakeCash( LegFix, true )
		
	end

	ply.Crippled = nil
end )

concommand.Add( "perp_heal", function( ply, cmd, args )
	if not IsValid( ply ) then return end
	if not ply:NearNPC( 29 ) then return ply:CaughtCheating( "Tried 'perp_heal' without being near an NPC.", EXPLOIT_POSSIBLETHREAT ) end
	
	if not ply:IsGovernmentOfficial() then
		if ply:GetCash() < Heal then return end

		local Log = Format( "%s paid $%i for a heal", ply:Nick(), util.FormatNumber( Heal ) )
		GAMEMODE:Log( "cashlog", Log, ply:SteamID() )

		ply:TakeCash( Heal, true )
	end

	ply:SetHealth( 100 )
end )