--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


PROPERTY = {};

PROPERTY.ID = 72;

PROPERTY.Name = "Shop C";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shopc";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( -8270, 48, 8 )

PROPERTY.Doors = 	{
	{Vector(-8668, 94, 60), 'models/props/storedoor1.mdl'},
	{Vector(-8668, 2, 60), 'models/props/storedoor1.mdl'},
	{Vector(-7966, 442, 60), 'models/props_doors/doormainmetalsmall01.mdl'},
	{Vector(-7778, 314, 60), 'models/props_doors/doormainmetalsmall01.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
