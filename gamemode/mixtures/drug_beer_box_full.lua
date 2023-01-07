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

MIXTURE.ID = 20

MIXTURE.Results = "drug_beer_box_full"
MIXTURE.Ingredients = { "drug_beer_box_empty", "drug_beer", "drug_beer", "drug_beer", "drug_beer", "drug_beer", "drug_beer" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ GENE_DEXTERITY, 1 },
	{ SKILL_CRAFTINESS, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Liquor"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )