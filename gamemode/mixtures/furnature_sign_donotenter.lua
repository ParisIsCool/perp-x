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

MIXTURE.ID = 1050

MIXTURE.Results = "furniture_sign_donotenter"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_paint" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ SKILL_CRAFTING, 1 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )