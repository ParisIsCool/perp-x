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

PROPERTY.ID = 155

PROPERTY.Name = "Central Pharmacy"
PROPERTY.Category = "Business"
PROPERTY.Description = "Pharmacy with lots of medicine! Harry?"
PROPERTY.Image = "centralpharmacy"

PROPERTY.Cost = 585

PROPERTY.HUDBlip = Vector(-6545,3295,4)

PROPERTY.Doors = {
	{Vector(-6504,2956,20),"*168"},
	{Vector(-6662,3483,28),"*304"},
	{Vector(-6564,3705.96875,20),"*169"},
}

GAMEMODE:RegisterProperty(PROPERTY)
