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

MIXTURE.ID = 6

MIXTURE.Results = "ammo_rifle"
MIXTURE.Ingredients = { "item_bullet_shell", "item_chunk_metal", "item_chunk_metal", "item_chunk_plastic" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 2 },
	{ GENE_DEXTERITY, 3 },
	{ GENE_PERCEPTION, 2 },
	{ SKILL_CRAFTINESS, 2 },
}

MIXTURE.Category = "Weapon - Ammo"

MIXTURE.RequiresHeatSource = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )