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

MIXTURE.ID = 7

MIXTURE.Results = "ammo_shotgun"
MIXTURE.Ingredients = { "item_bullet_shell", "item_chunk_plastic", "item_chunk_plastic", "item_cardboard" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 3 },
	{ GENE_DEXTERITY, 1 },
	{ GENE_PERCEPTION, 1 },
	{ SKILL_CRAFTINESS, 2 },
}

MIXTURE.Category = "Weapon - Ammo"

MIXTURE.RequiresHeatSource = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )