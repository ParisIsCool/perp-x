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

MIXTURE.ID = 38

MIXTURE.Results = "furniture_plastic_crate"
MIXTURE.Ingredients = { "item_chunk_plastic", "item_chunk_plastic", "item_chunk_plastic", "item_nail", "item_nail", "item_nail", "item_nail" }
MIXTURE.Requires = {
	{ SKILL_CRAFTING, 2 },
	{ GENE_DEXTERITY, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )