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

PROPERTY.ID = 220;

PROPERTY.Name = "Shop 220";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shop220";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( 1894, 1979, 1270 )

PROPERTY.Doors = 	{
	{Vector(2236, 1938, 596.2509765625), 'models/props/storedoor1.mdl'},
	{Vector(2236, 2030, 596.2509765625), 'models/props/storedoor1.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
