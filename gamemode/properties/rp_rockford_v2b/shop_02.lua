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

PROPERTY.ID = 71;

PROPERTY.Name = "Shop B";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shopb";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( -8257, -3059, 8 )

PROPERTY.Doors = 	{
	{Vector(-8668, -3826, 60), 'models/props/storedoor1.mdl'},
	{Vector(-8668, -3918, 60), 'models/props/storedoor1.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
