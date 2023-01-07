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

MIXTURE.ID = 25

MIXTURE.Results = "furniture_thermometer"
MIXTURE.Ingredients = { "furniture_clock", "item_chunk_metal", "item_metal_rod" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 3 },
	{ SKILL_CRAFTINESS, 3 },
}

MIXTURE.Free = true
MIXTURE.Category = "Furniture"

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )