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

PROPERTY.ID = 153

PROPERTY.Name = "Diner"
PROPERTY.Category = "Business"
PROPERTY.Description = "Diner near suburban with built in freezer!"
PROPERTY.Image = "diner"

PROPERTY.Cost = 650

PROPERTY.HUDBlip = Vector(913,11002,199)

PROPERTY.Doors = {
	{Vector(1038,10662,206),"*185"},
	{Vector(882,10662,206),"*184"},
	{Vector(649.84375,11180,220),"*338"},
	{Vector(1180.53125,11135,231.25),"*339"},
	{Vector(1108.5625,11135,231.25),"*340"},
	{Vector(1029.84375,11180,220),"*337"},
	{Vector(1152,11338,221),"*341"},
}

GAMEMODE:RegisterProperty(PROPERTY)
