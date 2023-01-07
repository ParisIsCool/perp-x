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

MIXTURE.ID = 100

MIXTURE.Results = "furniture_kitchen_table"
MIXTURE.Ingredients = { "item_metal_rod", "item_metal_rod", "item_nail", "item_nail", "item_nail", "item_nail", "item_metal_polish", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal" }
MIXTURE.Requires = {
	{ SKILL_CRAFTING, 2 },
	{ GENE_DEXTERITY, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresSawHorse = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )