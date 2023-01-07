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

MIXTURE.ID = 32

MIXTURE.Results = "furniture_wood_empty_bookcase"
MIXTURE.Ingredients = { "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_board", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail", "item_nail" }
MIXTURE.Requires = {
	{ SKILL_WOODWORKING, 6 },
	{ SKILL_CRAFTING, 8 },
	{ GENE_DEXTERITY, 3 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresSawHorse = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )