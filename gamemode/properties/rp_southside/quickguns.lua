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

PROPERTY.ID = 152

PROPERTY.Name = "Quick Guns"
PROPERTY.Category = "Business"
PROPERTY.Description = "Gun business with shooting range in the back."
PROPERTY.Image = "quickguns"

PROPERTY.Cost = 650

PROPERTY.HUDBlip = Vector(-1034,10429,146)

PROPERTY.Doors = {
	{Vector(-1523.96875,10408,188),"*313"},
	{Vector(-1454,10612,171),"*319"},
	{Vector(-1266,10616,171),"*320"},
	{Vector(-915,10210,188),"*315"},
	{Vector(-658,10144,176),"*316"},
	{Vector(-830,9928,176),"*317"},
	{Vector(-704,9874,176),"*318"},
	{Vector(-916,10074,188),"*314"},
}

GAMEMODE:RegisterProperty(PROPERTY)
