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

PROPERTY.ID = 177

PROPERTY.Name = "Leprechauns Winklepicker Bar"
PROPERTY.Category = "Business"
PROPERTY.Description = "Bar with stage and pool table. Secrets down below..."
PROPERTY.Image = "bar"

PROPERTY.Cost = 900

PROPERTY.HUDBlip = Vector(4920,8031,148)

PROPERTY.Doors = {
	{Vector(5306,8610,196),"*355"},
	{Vector(4597.84375,8276,196),"*356"},
	{Vector(4858.96875,7914,196),"*360"},
	{Vector(4492,7770,188),"*361"},
	{Vector(4742,7652,188),"*372"},
	{Vector(4550,7412,188),"*373"},
}

GAMEMODE:RegisterProperty(PROPERTY)
