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

MIXTURE.ID = 17

MIXTURE.Results = "drug_pot"
MIXTURE.Ingredients = { "drug_pot_seeds", "item_pot" }
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
	for _, v in pairs( ents.FindByClass( "ent_weed" ) ) do
		if v.Spawner and v.Spawner.SteamID == Player:SteamID() then
			count = count + 1
		end
	end
	
	local iCanHave = Player:IsGoldVIP() and MAX_WEED_GOLD or Player:IsVIP() and MAX_WEED_VIP or MAX_WEED

	if count >= iCanHave then return Player:Notify( "You have hit the maximum number of weed plants allowed." ) end

	return true
end

function MIXTURE.OnMix( Player, Trace )
	if GAMEMODE.Restarting then return Player:Notify( "This function cannot be completed, the server is pending a restart." ) end

	local Weed = ents.Create( "ent_weed" )
		Weed:SetPos( Trace.HitPos + Vector( 0, 0, 10 ) )
	Weed:Spawn()

	Weed.Spawner = { Entity = Player, SteamID = Player:SteamID(), Name = Player:Nick(), RPName = Player:GetRPName() }
	
	--Player:AddProgress( 27, 1 )
	
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )