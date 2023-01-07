--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

METH_COOK_TIME = 60 * 10
METH_BURN_TIME = 60 * 12

local MIXTURE = {}

MIXTURE.ID = 1

MIXTURE.Results = "drug_meth_wet"
MIXTURE.Ingredients = { "item_waterbottle", "item_waterbottle", "item_waterbottle", "item_kittylitter", "item_salt", "item_iodine" }
MIXTURE.Requires = {
	{ GENE_INTELLIGENCE, 2 },
	{ SKILL_CRAFTINESS, 3 },
}

MIXTURE.Free = true
MIXTURE.Category = "Illegal Substances"
MIXTURE.RequiresWaterSource = true

function MIXTURE.CanMix( Player )
	if Player:IsGovernmentOfficial() then
		return Player:Notify( "You cannot do this as a government official." )
	end

	return true
end

GAMEMODE:RegisterMixture( MIXTURE )