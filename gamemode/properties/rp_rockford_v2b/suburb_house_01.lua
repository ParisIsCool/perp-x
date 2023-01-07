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

PROPERTY.ID = 81;

PROPERTY.Name = "Suburbs House #1";
PROPERTY.Category = "House";
PROPERTY.Description = "A moderately sized house in the suburbs.";
PROPERTY.Image = "subs1";

PROPERTY.Cost = 3500;

PROPERTY.HUDBlip = Vector( 8380, 7254, 1636 )

PROPERTY.Doors = {
	{Vector(8170, 7233.919921875, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8430, 7290, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8490, 7185.919921875, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8429.919921875, 7174, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8199.009765625, 7653, 1596.0100097656), '*31'},
	{Vector(8199.009765625, 7653, 1596.0100097656), '*18'},
}

GAMEMODE:RegisterProperty(PROPERTY);
