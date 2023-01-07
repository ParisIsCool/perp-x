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

PROPERTY.ID = 64

PROPERTY.Name = "Mesa Apartment 1 Unit 2"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "mesa1"

PROPERTY.Cost = 750

PROPERTY.HUDBlip = Vector( -1840, 9377, 638 )

PROPERTY.Doors = {
	{Vector(-1538, 9266, 668), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-1990, 9382, 668), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-1870, 9466, 668), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-1870, 9338, 668), 'models/props_doors/doormain01_small.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
