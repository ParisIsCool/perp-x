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

MIXTURE.ID = 27

MIXTURE.Results = "furniture_wood_chest_drawers"
MIXTURE.Ingredients = { "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_glue", "item_glue", "item_glue", "item_glue", "item_glue", "item_glue", "item_glue", "item_glue", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal" }
MIXTURE.Requires = {
	{ SKILL_WOODWORKING, 4 },
	{ SKILL_CRAFTING, 6 },
	{ GENE_DEXTERITY, 3 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresSawHorse = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )