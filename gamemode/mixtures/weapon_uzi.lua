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

MIXTURE.ID = 8

-- This used to be the uzi but now its the mp9

MIXTURE.Results = "weapon_mp9"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_plastic", "item_metal_rod", "item_paint" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 4 },
	{ GENE_DEXTERITY, 4 },
	{ SKILL_CRAFTINESS, 3 },
}

MIXTURE.Category = "Weapons - Guns"

function MIXTURE.CanMix( Player )
	Player:UnlockMixture( 6 )

	return true
end

GAMEMODE:RegisterMixture( MIXTURE )