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

PROPERTY.ID = 18

PROPERTY.Name = "Kellco"
PROPERTY.Category = "Business"
PROPERTY.Description = "Very Small warehouse Kellco"
PROPERTY.Image = "kellco"

PROPERTY.Cost = 2000

PROPERTY.HUDBlip = Vector( -13735, 12314, 681 )

PROPERTY.Doors = {
    {Vector(-13378, 12119, 566), 'models/props_c17/door01_left.mdl'},
    {Vector(-13380, 12320, 604), '*67'},
}

GAMEMODE:RegisterProperty(PROPERTY)
