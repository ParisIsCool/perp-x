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

PROPERTY.ID = 151

PROPERTY.Name = "Second Church of God"
PROPERTY.Category = "Business"
PROPERTY.Description = "Church near the suburbs area. Comes with confession booth."
PROPERTY.Image = "church"

PROPERTY.Cost = 400

PROPERTY.HUDBlip = Vector(-2560,8015,179)

PROPERTY.Doors = {
	{Vector(-2622,8498,230),"*298"},
	{Vector(-2498,8498,230),"*299"},
	{Vector(-2408.96875,8279,218),"*301"},
	{Vector(-2252.53125,8278.375,218.25),"*300"},
}

GAMEMODE:RegisterProperty(PROPERTY)
