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

PROPERTY.ID = 154

PROPERTY.Name = "Remote Dockside Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Medium sized remote warehouse near water. Security gate with docks."
PROPERTY.Image = "brickwarehouse"

PROPERTY.Cost = 600

PROPERTY.HUDBlip = Vector(-12246,-9972,-205)

PROPERTY.Doors = {
	{Vector(-13804,-9980,-104),"*191"},
	{Vector(-12956,-9984,-144),"*7"},
	{Vector(-12957,-9670,-204),"*6"},
	{Vector(-12328,-10184,250),"*5"},
	{Vector(-12328,-9784,250),"*4"},
	{Vector(-11336,-10914,-247.3125),"*228"},
	{Vector(-11336,-11106,-247.3125),"*229"},
}

GAMEMODE:RegisterProperty(PROPERTY)
