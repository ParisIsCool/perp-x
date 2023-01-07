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

PROPERTY.ID = 157

PROPERTY.Name = "Tugboat"
PROPERTY.Category = "Boats"
PROPERTY.Description = "Boat in the middle of the channel."
PROPERTY.Image = "tugboat"

PROPERTY.Cost = 400

PROPERTY.HUDBlip = Vector(12588,-12962,-127)

PROPERTY.Doors = {
	{Vector(12420,-12410,-232),"*112"},
	{Vector(12738,-13432,-220),"*178"},
	{Vector(12738,-13288,-220),"*179"},
	{Vector(12738,-13464,-220),"*174"},
	{Vector(12738,-13608,-220),"*175"},
	{Vector(12542,-13464,-220),"*180"},
	{Vector(12542,-13608,-220),"*181"},
	{Vector(12542,-13432,-220),"*176"},
	{Vector(12542,-13288,-220),"*177"},
	{Vector(12604,-12594,-232),"*113"},
	{Vector(12770,-12484,-376),"*114"},
	{Vector(12442,-12673,-260),"*115"},
}

GAMEMODE:RegisterProperty(PROPERTY)
