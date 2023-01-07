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

MIXTURE.ID = 24

MIXTURE.Results = "furniture_metal_detector"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_wrench", "item_wrench" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 3 },
	{ GENE_PERCEPTION, 2 },
	{ SKILL_CRAFTING, 4 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresHeatSource = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )