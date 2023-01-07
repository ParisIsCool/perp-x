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

PROPERTY.ID = 501

PROPERTY.Name = "Taco Bell"
PROPERTY.Category = "Business"
PROPERTY.Description = "Moderately Sized business in the upper city."
PROPERTY.Image = "tacobell"

PROPERTY.Cost = 3500

PROPERTY.HUDBlip = Vector( 505, 1922, 970 )

PROPERTY.Doors = {
	{Vector(622, 2308, 596), 'models/props/storedoor1.mdl'},
	{Vector(530, 2308, 596), 'models/props/storedoor1.mdl'},
	{Vector(698, 1485.90625, 596), 'models/props_doors/doormain01_small.mdl'},
	{Vector(697.96875, 2266, 596), 'models/props_doors/doormain01_small.mdl'},
};

					
GAMEMODE:RegisterProperty(PROPERTY)