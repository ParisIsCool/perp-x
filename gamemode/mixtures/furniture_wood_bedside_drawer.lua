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

MIXTURE.ID = 26

MIXTURE.Results = "furniture_wood_bedside_drawer"
MIXTURE.Ingredients = { "item_board", "item_board", "item_nail", "item_nail", "item_nail", "item_nail", "item_glue", "item_glue" }
MIXTURE.Requires = {
	{ SKILL_WOODWORKING, 1 },
	{ SKILL_CRAFTING, 2 },
	{ GENE_DEXTERITY, 1 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresSawHorse = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )