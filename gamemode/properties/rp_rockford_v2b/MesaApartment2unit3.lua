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

PROPERTY.ID = 57

PROPERTY.Name = "Mesa Apartment 2 Unit 3"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "mesa2"

PROPERTY.Cost = 950

PROPERTY.HUDBlip = Vector( -1, 8034, 616 )

PROPERTY.Doors = {
	{Vector(254, 8190, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-78, 7938, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-198, 7982, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-78, 8066, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-50, 8446, 804), 'models/props_doors/doormain01_small.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
