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

PROPERTY.ID = 19

PROPERTY.Name = "J&M Glass Co"
PROPERTY.Category = "Business"
PROPERTY.Description = "J&M Glass Co"
PROPERTY.Image = "j_m"

PROPERTY.Cost = 2000

PROPERTY.HUDBlip = Vector( -1410, 12500, 642 )

PROPERTY.Doors = {
    {Vector(-1766, 12665, 584), 'models/props_c17/door01_left.mdl'},
    {Vector(-1763.9899902344, 12464, 622), '*65'},
}

GAMEMODE:RegisterProperty(PROPERTY)
