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

PROPERTY.ID = 36

PROPERTY.Name = "Food Market"
PROPERTY.Category = "Business"
PROPERTY.Description = "Food Market Upper end"
PROPERTY.Image = "rockfordfoods"

PROPERTY.Cost = 2000

PROPERTY.HUDBlip = Vector( 1114, 6060, 1184 )

PROPERTY.Doors = {
    {Vector(1752, 6024, 626), '*2'},
    {Vector(1752, 6088, 626), '*3'},
}

GAMEMODE:RegisterProperty(PROPERTY)
