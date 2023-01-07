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

MIXTURE.ID = 5001

MIXTURE.Results = "furniture_half_metal_barrier"
MIXTURE.Ingredients = { "item_nail", "item_chunk_metal", "item_chunk_metal" }
MIXTURE.Requires = {
	{ SKILL_CRAFTING, 3 },
	{ GENE_DEXTERITY, 1 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )