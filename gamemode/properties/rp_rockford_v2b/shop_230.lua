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

PROPERTY.ID = 230;

PROPERTY.Name = "Shop 230";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shop230";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( 1836, 2361, 1336 )

PROPERTY.Doors = 	{
	{Vector(2236, 2322, 596.2509765625), 'models/props/storedoor1.mdl'},
	{Vector(2236, 2414, 596.2509765625), 'models/props/storedoor1.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
