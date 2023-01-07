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

MIXTURE.ID = 15

MIXTURE.Results = "weapon_lock_pick"
MIXTURE.Ingredients = { "item_chunk_metal", "item_metal_rod", "item_wrench" }
MIXTURE.Requires = {
	{ GENE_STRENGTH, 3 },
	{ GENE_DEXTERITY, 1 },
}

MIXTURE.Free = true
MIXTURE.Category = "Thief Tools"

MIXTURE.RequiresHeatSource = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )