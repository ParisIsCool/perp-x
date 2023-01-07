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

PROPERTY.ID = 31

PROPERTY.Name = "Southwestern warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Southwestern warehouse"
PROPERTY.Image = "southwestern"

PROPERTY.Cost = 2000

PROPERTY.HUDBlip = Vector( 7283, -13292, 369 )

PROPERTY.Doors = {
    {Vector(7481, -12858, 390), 'models/props_c17/door01_left.mdl'},
    {Vector(7280, -12860, 428), '*70'},
}

GAMEMODE:RegisterProperty(PROPERTY)
