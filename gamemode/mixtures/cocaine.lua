--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local MIXTURE = {}

MIXTURE.ID = 2

MIXTURE.Results = "drug_cocaine"
MIXTURE.Ingredients = { "drug_coca_seeds", "item_pot" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ GENE_DEXTERITY, 1 },
}

MIXTURE.Free = true
MIXTURE.Category = "Illegal Substances"

function MIXTURE.CanMix( Player )	
	if Player:IsGovernmentOfficial() then
		return Player:Notify( "You cannot do this as a government official." )
	end
	
	local count = 0
	for _, v in pairs( ents.FindByClass( "ent_cocaine" ) ) do
		if v.Spawner and v.Spawner.SteamID == Player:SteamID() then
			count = count + 1
		end
	end
	
	local iCanHave = Player:IsGoldVIP() and MAX_COCAINE_GOLD or Player:IsVIP() and MAX_COCAINE_VIP or MAX_COCAINE

	if count >= iCanHave then return Player:Notify( "You have hit the maximum number of cocaine plants allowed." ) end

	return true
end

function MIXTURE.OnMix( Player, Trace )
	if GAMEMODE.Restarting then return Player:Notify( "This function cannot be completed, the server is pending a restart." ) end

	local Cocaine = ents.Create( "ent_cocaine" )
		Cocaine:SetPos( Trace.HitPos + Vector( 0, 0, 10 ) )
	Cocaine:Spawn()

	Cocaine.Spawner = { Entity = Player, SteamID = Player:SteamID(), Name = Player:Nick(), RPName = Player:GetRPName() }
	
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )