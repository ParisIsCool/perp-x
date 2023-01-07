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

MIXTURE.ID = 5

MIXTURE.Results = "ammo_pistol"
MIXTURE.Ingredients = { "item_bullet_shell", "item_chunk_metal", "item_cardboard" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 1 },
	{ GENE_DEXTERITY, 2 },
	{ SKILL_CRAFTINESS, 2 },
}

MIXTURE.Category = "Weapon - Ammo"

MIXTURE.RequiresHeatSource = true

function MIXTURE.CanMix()
	return true
end

GAMEMODE:RegisterMixture( MIXTURE )