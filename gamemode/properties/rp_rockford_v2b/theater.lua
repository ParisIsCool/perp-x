--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


PROPERTY = {}

PROPERTY.ID = 500

PROPERTY.Name = "Movie Theater"
PROPERTY.Category = "Business"
PROPERTY.Description = "Large building located in the upper city. (Cinema Screen requires GMOD 64-Bit to view)"
PROPERTY.Image = "tacobell"

PROPERTY.Cost = 3000

PROPERTY.HUDBlip = Vector( -1541, 1893, 2007 )

PROPERTY.Doors = {
	{Vector(-964, 2334, 596), 'models/props/storedoor1.mdl'},
	{Vector(-964, 2426, 596), 'models/props/storedoor1.mdl'},
	{Vector(-964, 2438, 596), 'models/props/storedoor1.mdl'},
	{Vector(-964, 2530, 596), 'models/props/storedoor1.mdl'},
	{Vector(-1724, 2116, 596.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-1724, 2020, 596.25), 'models/props_doors/doormain01_small.mdl'},
};

					
GAMEMODE:RegisterProperty(PROPERTY)