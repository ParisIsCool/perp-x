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

PROPERTY.ID = 17

PROPERTY.Name = "NP Large Industrial Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Very large warehouse located in the industrial area, with its own front gate!"
PROPERTY.Image = "northernp"

PROPERTY.Cost = 2000

PROPERTY.HUDBlip = Vector( -5400, 6963, 424 )

PROPERTY.Doors = {
	{Vector(-6445, 6211, 54), 'models/props_c17/door01_left.mdl'},
	{Vector(-6429, 6978.5, 54), 'models/props_c17/door01_left.mdl'},
	{Vector(-5699, 7166.5, 54), 'models/props_c17/door01_left.mdl'},
    {Vector(-5676, 7872, 124), '*71'},
}

GAMEMODE:RegisterProperty(PROPERTY)
