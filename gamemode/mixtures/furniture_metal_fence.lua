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

MIXTURE.ID = 40

MIXTURE.Results = "furniture_metal_fence"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_metal_rod", "item_metal_rod", "item_metal_rod", "item_metal_rod", "item_metal_rod" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ GENE_STRENGTH, 2 },
	{ SKILL_CRAFTINESS, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )