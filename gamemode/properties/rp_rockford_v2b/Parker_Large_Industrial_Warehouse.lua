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

PROPERTY.ID = 40

PROPERTY.Name = "Parker Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Very large warehouse located in the industrial area!"
PROPERTY.Image = "parker"

PROPERTY.Cost = 2000

PROPERTY.HUDBlip = Vector( -8000, 3851, 477 )

PROPERTY.Doors = {
	{Vector(-8000, 4030, 128), '*20'},
	{Vector(-8388.6796875, 4163, 62), 'models/props_c17/door01_left.mdl'},
	{Vector(-8000, 4030, 128), '*14'},
}

GAMEMODE:RegisterProperty(PROPERTY)
