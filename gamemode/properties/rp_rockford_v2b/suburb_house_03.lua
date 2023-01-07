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

PROPERTY.ID = 83;

PROPERTY.Name = "Suburbs House #3";
PROPERTY.Category = "House";
PROPERTY.Description = "A moderately sized house in the suburbs.";
PROPERTY.Image = "subs3";

PROPERTY.Cost = 3000;

PROPERTY.HUDBlip = Vector( 8450, 5600, 1773 )

PROPERTY.Doors = {
    {Vector(8194, 5649.919921875, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8032, 5248, 1632), '*38'},
    {Vector(8378.080078125, 5506, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8318, 5614.080078125, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8386, 5614, 1620), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8826, 5540, 1623), '*29'},
    {Vector(8506.080078125, 5986, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8526, 5986, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8810, 5894, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8610, 5874, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8610, 5674, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8814.080078125, 5690, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8586, 5518, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8610, 5234, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8374.080078125, 5506, 1756), 'models/props_doors/doormain01_small.mdl'},
    {Vector(8826, 5540, 1623), '*16'},
    {Vector(8032, 5248, 1632), '*23'},
    {Vector(8191.009765625, 6299, 1596.0100097656), '*19'},
}

GAMEMODE:RegisterProperty(PROPERTY);
