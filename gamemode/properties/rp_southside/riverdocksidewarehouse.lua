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

PROPERTY.ID = 6

PROPERTY.Name = "River Dockside Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Large sized warehouse on water. Includes docks and security gates."
PROPERTY.Image = "riverdocksidewarehouse"

PROPERTY.Cost = 1025

PROPERTY.HUDBlip = Vector(113,-6284,-132)

PROPERTY.Doors = {
	{Vector(224,-5636,-208),"*82"},
	{Vector(-90,-5635,-268),"*81"},
	{Vector(395.96875,-3473,-160),"*92"},
	{Vector(115.96875,-3473,-160),"*93"},
	{Vector(-757.96875,-6313.9375,-237.3125),"*230"},
	{Vector(-757.96875,-6121.9375,-237.3125),"*231"},
	{Vector(-476,-6400,-208),"*296"},
}

GAMEMODE:RegisterProperty(PROPERTY)
