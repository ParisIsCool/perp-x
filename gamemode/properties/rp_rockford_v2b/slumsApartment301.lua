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

PROPERTY.ID = 20

PROPERTY.Name = "Slums Apartment 301"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "slums2"

PROPERTY.Cost = 750

PROPERTY.HUDBlip = Vector( -3022, -7326, 3 )

PROPERTY.Doors = 	{
	{Vector(-3225.3100585938, -7375, 297.28100585938), 'models/props_c17/door01_left.mdl'},
	{Vector(-2920, -7295, 295), 'models/props_c17/door01_left.mdl'},
	{Vector(-2832, -7375, 295), 'models/props_c17/door01_left.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
