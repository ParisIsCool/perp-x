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

PROPERTY.ID = 88;

PROPERTY.Name = "Suburbs House #8";
PROPERTY.Category = "House";
PROPERTY.Description = "A small house in the suburbs.";
PROPERTY.Image = "subs8";

PROPERTY.Cost = 2000;

PROPERTY.HUDBlip = Vector( 10663, 2250, 1886 )

PROPERTY.Doors = 	{
	{Vector(10518.099609375, 2050, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(10598.099609375, 1730, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(10990, 2050, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(10805.900390625, 2558, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(10662, 2130, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(10778.099609375, 2242, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(10430, 2426, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(10770, 2054, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11199, 2456.9899902344, 1596.0100097656), '*21'},
};

GAMEMODE:RegisterProperty(PROPERTY);
