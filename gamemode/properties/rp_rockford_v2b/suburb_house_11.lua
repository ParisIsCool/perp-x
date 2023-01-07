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

PROPERTY.ID = 91;

PROPERTY.Name = "Suburbs House #11";
PROPERTY.Category = "House";
PROPERTY.Description = "A moderately sized house in the suburbs.";
PROPERTY.Image = "subs11";

PROPERTY.Cost = 3000;

PROPERTY.HUDBlip = Vector( 10825, 7482, 2208 )

PROPERTY.Doors = {
    {Vector(10798, 7170, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(11383, 7431, 1596.0100097656), '*17'},
    {Vector(10874, 7438, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10937.900390625, 7450, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10998, 7790.080078125, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10974.099609375, 7514, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10810, 7794, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10654, 7806, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10750, 7806, 1620), 'models/props_doors/doormain01_small.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY);
