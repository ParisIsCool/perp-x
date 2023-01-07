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

MIXTURE.ID = 30

MIXTURE.Results = "furniture_wood_desk_polished"
MIXTURE.Ingredients = { "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_metal_polish" }
MIXTURE.Requires = {
	{ SKILL_WOODWORKING, 6 },
	{ SKILL_CRAFTING, 7 },
	{ GENE_DEXTERITY, 4 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresSawHorse = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )