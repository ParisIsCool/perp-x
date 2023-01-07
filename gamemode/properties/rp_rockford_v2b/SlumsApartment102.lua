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

PROPERTY.ID = 29

PROPERTY.Name = "Slums Apartment 102"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "slums1"

PROPERTY.Cost = 750

PROPERTY.HUDBlip = Vector( -4075, -7314, 3 )

PROPERTY.Doors = 	{
	{Vector(-3880, -7329, 57.28099822998), 'models/props_c17/door01_left.mdl'},
	{Vector(-4184, -7249, 55), 'models/props_c17/door01_left.mdl'},
	{Vector(-4272, -7329, 55), 'models/props_c17/door01_left.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
