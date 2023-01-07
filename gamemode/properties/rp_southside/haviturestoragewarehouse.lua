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

PROPERTY.ID = 4

PROPERTY.Name = "Haviture Storage Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Large sized warehouse near water."
PROPERTY.Image = "haviturestoragewarehouse"

PROPERTY.Cost = 685

PROPERTY.HUDBlip = 	Vector(6725,-1702,64)

PROPERTY.Doors = {
	{Vector(6784,-1028,8),"*76"},
	{Vector(6470,-1028,-52),"*75"},
}

GAMEMODE:RegisterProperty(PROPERTY)
