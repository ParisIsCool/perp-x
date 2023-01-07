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

MIXTURE.ID = 13

MIXTURE.Results = "weapon_molotov"
MIXTURE.Ingredients = { "weapon_bottle", "item_propane_tank", "item_paper_towels", "item_paper_towels" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ GENE_DEXTERITY, 2 },
	{ SKILL_CRAFTINESS, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Explosives & Misc"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )