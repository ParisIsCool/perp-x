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

MIXTURE.ID = 11

MIXTURE.Results = "weapon_fiveseven"
MIXTURE.Ingredients = { "item_chunk_metal", "item_chunk_metal", "item_paint", "item_paint", "item_chunk_plastic" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 3 },
	{ GENE_DEXTERITY, 3 },
	{ SKILL_CRAFTINESS, 3 },
}

MIXTURE.Category = "Weapons - Guns"

function MIXTURE.CanMix(  Player )
	Player:UnlockMixture( 5 )

	return true
end

GAMEMODE:RegisterMixture( MIXTURE )