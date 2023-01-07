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

PROPERTY.ID = 250;

PROPERTY.Name = "Shop 250";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shop250";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( 1873, 2753, 1334 )

PROPERTY.Doors = 	{
	{Vector(2236, 2706, 596.2509765625), 'models/props/storedoor1.mdl'},
	{Vector(2236, 2798, 596.2509765625), 'models/props/storedoor1.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
