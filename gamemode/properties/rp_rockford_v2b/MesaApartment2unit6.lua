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

PROPERTY.ID = 53

PROPERTY.Name = "Mesa Apartment 2 Unit 6"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "mesa2"

PROPERTY.Cost = 950

PROPERTY.HUDBlip = Vector( 792, 8052, 888 )

PROPERTY.Doors = {
	{Vector(514, 8142, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(814.083984375, 8446, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(846, 8070, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(966, 8026, 940), 'models/props_doors/doormain01_small.mdl'},
	{Vector(846, 7942, 940), 'models/props_doors/doormain01_small.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
