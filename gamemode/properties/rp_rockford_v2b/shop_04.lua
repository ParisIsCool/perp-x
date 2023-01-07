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

PROPERTY.ID = 73;

PROPERTY.Name = "Shop D";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shopd";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( -8347, 967, 8 )

PROPERTY.Doors = 	{
	{Vector(-8668, 1194, 60), 'models/props/storedoor1.mdl'},
	{Vector(-8668, 1102, 60), 'models/props/storedoor1.mdl'},
	{Vector(-8034, 694, 60), 'models/props_doors/doormainmetalsmall01.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
