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

MIXTURE.ID = 41

MIXTURE.Results = "item_stim_pack"
MIXTURE.Ingredients = { "weapon_bottle", "food_coffee", "sv_drug_shroom", "sv_drug_mightymuscle", "food_melon", "food_melon", "food_melon", "item_propane_tank", "drug_cocaine", "drug_pot", "drug_meth", "item_chunk_plastic" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ GENE_STRENGTH, 2 },
	{ SKILL_CRAFTINESS, 4 },
}

MIXTURE.Free = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )