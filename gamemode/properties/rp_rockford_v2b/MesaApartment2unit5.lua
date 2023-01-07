--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


PROPERTY = {}

PROPERTY.ID = 55

PROPERTY.Name = "Mesa Apartment 2 Unit 5"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "mesa2"

PROPERTY.Cost = 950

PROPERTY.HUDBlip = Vector( -1, 8034, 616 )

PROPERTY.Doors = {
	{Vector(254, 8190, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-50, 8446, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-78, 7938, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-198, 7982, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-78, 8066, 940), 'models/props_doors/doormain01_small.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
