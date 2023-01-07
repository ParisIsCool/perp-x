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

MIXTURE.ID = 4

MIXTURE.Results = "weapon_ak47"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_board", "item_board", "item_paint" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 4 },
	{ GENE_PERCEPTION, 2 },
	{ GENE_DEXTERITY, 2 },
	{ SKILL_CRAFTINESS, 6 },
}

MIXTURE.Category = "Weapons - Guns"

function MIXTURE.CanMix( Player )
	Player:UnlockMixture( 6 )

	return true
end

GAMEMODE:RegisterMixture( MIXTURE )