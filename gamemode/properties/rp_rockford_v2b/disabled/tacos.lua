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

PROPERTY.ID = 30

PROPERTY.Name = "Taco Hell"
PROPERTY.Category = "Business"
PROPERTY.Description = "Moderately Sized business at the enterance of the city."
PROPERTY.Image = "tacohell"

PROPERTY.Cost = 3000

PROPERTY.Doors = {
{Vector(622, 2308, 596), 'models/props/storedoor1.mdl'},
{Vector(530, 2308, 596), 'models/props/storedoor1.mdl'},
{Vector(698, 1485.9200439453, 596), 'models/props_doors/doormain01_small.mdl'},
{Vector(884, 2022, 608), '*27'},
{Vector(697.99798583984, 2266, 596), 'models/props_doors/doormain01_small.mdl'},
{Vector(884, 1734, 608), '*28'},
}

GAMEMODE:RegisterProperty(PROPERTY)
