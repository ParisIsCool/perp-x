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

PROPERTY.ID = 27

PROPERTY.Name = "Slums Apartment 302"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "slums2"

PROPERTY.Cost = 750

PROPERTY.HUDBlip = Vector( -4075, -7314, 3 )

PROPERTY.Doors = 	{
	{Vector(-4272, -7329, 295), 'models/props_c17/door01_left.mdl'},
	{Vector(-4184, -7249, 295), 'models/props_c17/door01_left.mdl'},
	{Vector(-3880, -7329, 297.28100585938), 'models/props_c17/door01_left.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
