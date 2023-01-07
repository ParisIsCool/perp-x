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

MIXTURE.ID = 103

MIXTURE.Results = "furniture_steel_ladder"
MIXTURE.Ingredients = { "item_metal_rod", "item_metal_polish", "item_chunk_metal", "furniture_metal_fence" }
MIXTURE.Requires = {
	{ SKILL_CRAFTING, 4 },
	{ GENE_DEXTERITY, 2 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

MIXTURE.RequiresHeatSource = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )