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

PROPERTY.ID = 90;

PROPERTY.Name = "Suburbs House #10";
PROPERTY.Category = "House";
PROPERTY.Description = "A moderately sized house in the suburbs.";
PROPERTY.Image = "subs10";

PROPERTY.Cost = 3000;

PROPERTY.HUDBlip = Vector( 10940, 4889, 2095 )

PROPERTY.Doors = {
    {Vector(11074, 5374, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10688, 5472, 1632), '*40'},
    {Vector(11675, 5288.990234375, 1596.0100097656), '*20'},
    {Vector(11074, 4893.919921875, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10830, 4226, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10882, 4734, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(11246.099609375, 5002, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(11266, 4941.919921875, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(11266, 4813.919921875, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(11198, 4590.080078125, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(11198, 4478.080078125, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10941.900390625, 4670, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10814.099609375, 4610, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(10688, 5472, 1632), '*25'},
}

GAMEMODE:RegisterProperty(PROPERTY);
