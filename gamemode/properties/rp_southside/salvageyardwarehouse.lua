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

PROPERTY.ID = 3

PROPERTY.Name = "Salvage Yard Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Large sized warehouse (roof windows) with grass near water, security gate."
PROPERTY.Image = "salvageyardwarehouse"

PROPERTY.Cost = 635

PROPERTY.HUDBlip = Vector(3056,-1781,136)

PROPERTY.Doors = {
	{Vector(3668,-1792,-16),"*78"},
	{Vector(3668,-2106,-76),"*79"},
	{Vector(4384,-837,-30),"*94"},
	{Vector(3048,-1991.96875,382),"*186"},
	{Vector(3048,-1591.96875,382),"*187"},
}

GAMEMODE:RegisterProperty(PROPERTY)
