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

PROPERTY.ID = 74;

PROPERTY.Name = "Shop E";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small shop in the business district.";
PROPERTY.Image = "shope";

PROPERTY.Cost = 1000;

PROPERTY.HUDBlip = Vector( -8497, 1621, 8 )

PROPERTY.Doors = 	{
	{Vector(-8668.6201171875, 1704, 60), 'models/props/storedoor1.mdl'},
	{Vector(-8290, 1398, 60), 'models/props_doors/doormainmetalsmall01.mdl'},
};

GAMEMODE:RegisterProperty(PROPERTY);
