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

PROPERTY.ID = 156

PROPERTY.Name = "Industrial Warehouse"
PROPERTY.Category = "Business"
PROPERTY.Description = "Medium sized warehouse near pharmacy."
PROPERTY.Image = "industrialwarehouse"

PROPERTY.Cost = 585

PROPERTY.HUDBlip =Vector(-4698,3449,-8)

PROPERTY.Doors = {
	{Vector(-5219,3430,20),"*100"},
	{Vector(-5200,3744,112),"*99"},
	{Vector(-5200,3168,111),"*101"},
	{Vector(-4108,3813.96875,20),"*171"},
}

GAMEMODE:RegisterProperty(PROPERTY)
