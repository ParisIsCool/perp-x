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

MIXTURE.ID = 5009

MIXTURE.Results = "item_repair_kit"
MIXTURE.Ingredients = { "item_wrench", "item_wrench", "item_wrench", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_plastic", "item_chunk_plastic", "item_chunk_plastic" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ SKILL_CRAFTING, 3 },
	{ GENE_DEXTERITY, 1 },
}

MIXTURE.Free = true
MIXTURE.Category = "Others"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )