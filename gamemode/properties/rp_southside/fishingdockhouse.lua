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

PROPERTY.ID = 5

PROPERTY.Name = "Fishing Dockhouse"
PROPERTY.Category = "Residental"
PROPERTY.Description = "Cozy cabin on the docks. Includes attic."
PROPERTY.Image = "fishingdockhouse"

PROPERTY.Cost = 545

PROPERTY.HUDBlip = Vector(6215,-4446,-310)

PROPERTY.Doors = {
	{Vector(6246,-4724,-260),"*95"},
	{Vector(6108,-4262,-252),"*96"},
	{Vector(6340,-4226,-260),"*97"},
	{Vector(6394,-4254,-130),"*98"},
}

GAMEMODE:RegisterProperty(PROPERTY)
