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

PROPERTY.ID = 172

PROPERTY.Name = "Bank Street Garage"
PROPERTY.Category = "Garage"
PROPERTY.Description = "Garage with work area located in alley behind World Corp."
PROPERTY.Image = "garage"

PROPERTY.Cost = 400

PROPERTY.HUDBlip = 	Vector(-4109,6590,140)

PROPERTY.Doors = {
	{Vector(-3849,6022,100),"*352"},{Vector(-3888,6304,160),"*351"},{Vector(-4218,7160,180),"*353"},
}

GAMEMODE:RegisterProperty(PROPERTY)

local PROPERTY = {}

PROPERTY.ID = 171

PROPERTY.Name = "Pleasant Road Garage"
PROPERTY.Category = "Garage"
PROPERTY.Description = "Garage with work area located in alley near the club. Has upstairs."
PROPERTY.Image = "garage2"

PROPERTY.Cost = 500

PROPERTY.HUDBlip = Vector(-9135,3471,126)

PROPERTY.Doors = {
	{Vector(-9056,3000,104),"*347"},{Vector(-9338,2953,52),"*348"},{Vector(-8712,3702,244),"*349"},
}

GAMEMODE:RegisterProperty(PROPERTY)
