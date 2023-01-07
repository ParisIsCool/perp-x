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

PROPERTY.ID = 1

PROPERTY.Name = "Brick Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Medium sized warehouse near water, shared security gate."
PROPERTY.Image = "brickwarehouse"

PROPERTY.Cost = 585

PROPERTY.HUDBlip = 	Vector(-3312,-1693,16)

PROPERTY.Doors = {
	{Vector(-2960,-1312,64),"*123"},
	{Vector(-2940,-1573.96875,-44),"*87"},
	{Vector(-2960,-1888,64),"*124"},
}

GAMEMODE:RegisterProperty(PROPERTY)
