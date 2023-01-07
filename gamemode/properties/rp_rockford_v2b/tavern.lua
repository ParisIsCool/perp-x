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

PROPERTY.ID = 199

PROPERTY.Name = "Tavern"
PROPERTY.Category = "Business"
PROPERTY.Description = "Tavern"
PROPERTY.Image = "pst"

PROPERTY.Cost = 2000

PROPERTY.HUDBlip = Vector( -1055, 5834, 785 )

PROPERTY.Doors = {
	{Vector(-1212, 5474, 628), 'models/props/storedoor1.mdl'},
	{Vector(-1212, 5382, 628), 'models/props/storedoor1.mdl'},
}

GAMEMODE:RegisterProperty(PROPERTY)
