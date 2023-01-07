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

PROPERTY.ID = 290;

PROPERTY.Name = "Shop 290";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shop290";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( 1872, 3516, 1491 )

PROPERTY.Doors = 	{
	{Vector(2236, 3474, 596.2509765625), 'models/props/storedoor1.mdl'},
	{Vector(2236, 3566, 596.2509765625), 'models/props/storedoor1.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
