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

PROPERTY.ID = 86;

PROPERTY.Name = "Suburbs House #6";
PROPERTY.Category = "House";
PROPERTY.Description = "A giant house in the suburbs.";
PROPERTY.Image = "subs6";

PROPERTY.Cost = 1500;

PROPERTY.HUDBlip = Vector( 8755, 1282, 2139 )

PROPERTY.Doors = 	{
	{Vector(9034, 1522, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8958, 1306.0799560547, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8724, 1400, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8710, 1474.0799560547, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8942.080078125, 1538, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(9598, 990.08001708984, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8878.080078125, 1218, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8382, 1490.0799560547, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8393.919921875, 1414, 1620), 'models/props_doors/doormain01_small.mdl'},
	{Vector(8296, 960, 1656), '*24'},
};

GAMEMODE:RegisterProperty(PROPERTY);
