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

PROPERTY.ID = 270;

PROPERTY.Name = "Shop 270";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shop270";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( 1876, 3139, 1574 )

PROPERTY.Doors = 	{
	{Vector(2236, 3090, 596.2509765625), 'models/props/storedoor1.mdl'},
	{Vector(2236, 3182, 596.2509765625), 'models/props/storedoor1.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
