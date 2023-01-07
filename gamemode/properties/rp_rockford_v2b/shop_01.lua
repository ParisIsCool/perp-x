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

PROPERTY.ID = 70;

PROPERTY.Name = "Shop A";
PROPERTY.Category = "Business";
PROPERTY.Description = "A large shop in the business district.";
PROPERTY.Image = "shopa";

PROPERTY.Cost = 1150;

PROPERTY.HUDBlip = Vector( -8367, -3870, 8 )

PROPERTY.Doors = 	{
	{Vector(-8668, -3154, 60), 'models/props/storedoor1.mdl'},
	{Vector(-8668, -3246, 60), 'models/props/storedoor1.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
