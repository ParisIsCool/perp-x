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

MIXTURE.ID = 10

MIXTURE.Results = "weapon_glock"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_paint", "item_metal_polish" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 2 },
	{ GENE_PERCEPTION, 1 },
	{ GENE_DEXTERITY, 2 },
	{ SKILL_CRAFTINESS, 1 },
}

MIXTURE.Free = true
MIXTURE.Category = "Weapons - Guns"

function MIXTURE.CanMix( Player )
	Player:UnlockMixture( 5 )

	return true
end

GAMEMODE:RegisterMixture( MIXTURE )