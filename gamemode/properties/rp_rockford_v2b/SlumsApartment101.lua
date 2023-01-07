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

PROPERTY.ID = 26

PROPERTY.Name = "Slums Apartment 101"
PROPERTY.Category = "Apartment"
PROPERTY.Description = "A very nice apartemnt in the city, over looking the park"
PROPERTY.Image = "slums1"

PROPERTY.Cost = 750

PROPERTY.HUDBlip = Vector( -3022, -7326, 3 )

PROPERTY.Doors = 	{
	{Vector(-3225.3100585938, -7375, 57.28099822998), 'models/props_c17/door01_left.mdl'},
	{Vector(-2920, -7295, 55), 'models/props_c17/door01_left.mdl'},
	{Vector(-2832, -7375, 55), 'models/props_c17/door01_left.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
