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

MIXTURE.ID = 9

MIXTURE.Results = "weapon_shotgun"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_chunk_metal", "item_metal_rod" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 4 },
	{ GENE_PERCEPTION, 2 },
	{ GENE_DEXTERITY, 2 },
	{ SKILL_CRAFTINESS, 3 },
}

MIXTURE.Category = "Weapons - Guns"

function MIXTURE.CanMix( Player )
	Player:UnlockMixture( 7 )

	return true
end

GAMEMODE:RegisterMixture( MIXTURE )