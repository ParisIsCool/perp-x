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

MIXTURE.ID = 29

MIXTURE.Results = "furniture_wood_coffee_table"
MIXTURE.Ingredients = { "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_polish", "item_polish" }
MIXTURE.Requires = {
	{ SKILL_WOODWORKING, 4 },
	{ SKILL_CRAFTING, 4 },
	{ GENE_DEXTERITY, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresSawHorse = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )