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

PROPERTY.ID = 34

PROPERTY.Name = "Power Plant"
PROPERTY.Category = "Business"
PROPERTY.Description = "A small power plant in the industrial region."
PROPERTY.Image = "powerplant"

PROPERTY.Cost = 2150

PROPERTY.HUDBlip = Vector( -7937, 5976, 620 )

PROPERTY.Doors = {
	{Vector(-8938, 6656, 54), '*9'},
	{Vector(-6994, 6851.7001953125, 54), '*10'},
	{Vector(-7980.009765625, 5972.009765625, 136), '*5'},
	{Vector(-7892.009765625, 5972.009765625, 136), '*4'},
	{Vector(-7298, 5554, 116), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-7426, 5554, 116), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8570, 5554, 116), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8442, 5554, 116), 'models/props_doors/doormain01_small.mdl'},
	{Vector(-8882, 6427, 77.688499450684), 'models/props_wasteland/exterior_fence001a.mdl'},
	{Vector(-7054, 6501, 77.688499450684), 'models/props_wasteland/exterior_fence001a.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
