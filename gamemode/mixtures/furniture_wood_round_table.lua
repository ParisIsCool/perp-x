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

MIXTURE.ID = 34

MIXTURE.Results = "furniture_wood_round_table"
MIXTURE.Ingredients = { "item_board", "item_board", "item_board", "item_glue", "item_glue", "item_glue", "item_glue" }
MIXTURE.Requires = {
	{ SKILL_WOODWORKING, 2 },
	{ SKILL_CRAFTING, 5 },
	{ GENE_DEXTERITY, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresSawHorse = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )