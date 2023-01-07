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

PROPERTY.ID = 95;

PROPERTY.Name = "Country House";
PROPERTY.Category = "House";
PROPERTY.Description = "A small house near the lake.";
PROPERTY.Image = "country";

PROPERTY.Cost = 1850;

PROPERTY.HUDBlip = Vector( -8241, -13955, 773 )

PROPERTY.Doors = {
	{Vector(-8098, -13830, 196), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7998, -13998.099609375, 196), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7998, -14022, 196), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7998, -13886.099609375, 196), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8394, -13826, 196), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8510, -13950, 196), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8262, -14090, 196), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7998, -14022, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7998, -13998.099609375, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7998, -13886.099609375, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8062, -14074, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8330, -14010, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8394, -13826, 60), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8699.990234375, -13852, 228), '*63'},
	{Vector(-9350.990234375, -13823, 60.009998321533), '*77'},
	{Vector(-7134.990234375, -13687, 60.009998321533), '*78'},
};

GAMEMODE:RegisterProperty(PROPERTY);
