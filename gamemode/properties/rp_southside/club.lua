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

PROPERTY.ID = 175

PROPERTY.Name = "Club"
PROPERTY.Category = "Business"
PROPERTY.Description = "Very large club with dance floor and many VIP rooms."
PROPERTY.Image = "club"

PROPERTY.Cost = 5000

PROPERTY.HUDBlip = Vector(-7642,5832,69)

PROPERTY.Doors = {
	{Vector(-7150,4360,84),"*148"},
	{Vector(-7258,4360,84),"*147"},
	{Vector(-7206,4868,84.25),"*665"},
	{Vector(-7036,5914,276.25),"*669"},
	{Vector(-7190,6156,276),"*654"},
	{Vector(-7574,5404,276),"*668"},
	{Vector(-8323.96875,5914,276.25),"*670"},
	{Vector(-8170,6156,276),"*655"},
	{Vector(-7680,6601,280),"*666"},
	{Vector(-7508,7029.84375,52),"*660"},
	{Vector(-7883.96875,7029.84375,52),"*656"},
}

GAMEMODE:RegisterProperty(PROPERTY)
