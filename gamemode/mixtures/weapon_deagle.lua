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

MIXTURE.ID = 12

MIXTURE.Results = "weapon_deagle"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_plastic", "item_chunk_plastic" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 2 },
	{ GENE_DEXTERITY, 5 },
	{ GENE_PERCEPTION, 1 },
	{ SKILL_CRAFTINESS, 6 },
}

MIXTURE.Category = "Weapons - Guns"

function MIXTURE.CanMix( Player )
	Player:UnlockMixture( 5 )

	return true
end

GAMEMODE:RegisterMixture( MIXTURE )