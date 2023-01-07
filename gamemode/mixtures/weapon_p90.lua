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

MIXTURE.ID = 70

MIXTURE.Results = "weapon_p90"

MIXTURE.Ingredients = {'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_chunk_metal', 'item_wrench', 'item_wrench', 'item_chunk_plastic', 'item_chunk_plastic', 'item_chunk_plastic'};

MIXTURE.Requires = 	{
						{GENE_INTELLIGENCE, 4},
						{GENE_PERCEPTION, 2},
						{GENE_DEXTERITY, 2},
						{SKILL_CRAFTINESS, 5},
};

MIXTURE.Category = "Weapons - Guns"

MIXTURE.RequiresHeatSource = false;
MIXTURE.RequiresWaterSource = false;
MIXTURE.RequiresSawHorse = false;

function MIXTURE.CanMix ( player, pos )
	return true;
end

GAMEMODE:RegisterMixture(MIXTURE);
