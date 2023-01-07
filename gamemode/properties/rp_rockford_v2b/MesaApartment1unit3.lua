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

PROPERTY.ID = 61

PROPERTY.Name = "Mesa Apartment 1 Unit 3"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "mesa1"

PROPERTY.Cost = 750

PROPERTY.HUDBlip = Vector( -1008, 9396, 623 )

PROPERTY.Doors = {
	{Vector(-1278, 9218, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-946, 9470, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-826, 9426, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-946, 9342, 804), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-974, 8962, 804), 'models/props_doors/doormain01_small.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
