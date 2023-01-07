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

PROPERTY.ID = 2

PROPERTY.Name = "Metal Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Large sized warehouse near water, shared security gate."
PROPERTY.Image = "metalwarehouse"

PROPERTY.Cost = 865

PROPERTY.HUDBlip = Vector(-1032,-1747,55)

PROPERTY.Doors = {
	{Vector(-1750,-1728,16),"*85"},
	{Vector(-1757,-2042,-44),"*84"},
}

GAMEMODE:RegisterProperty(PROPERTY)
