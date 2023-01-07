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

PROPERTY.ID = 31

PROPERTY.Name = "La Grande Room %i"
PROPERTY.Category = "Hotel"
PROPERTY.Description = "Fancy hotel suites at the la grande hotel."
PROPERTY.Image = "motels"

PROPERTY.Cost = 500

local data = {
	[1] = { Vector(7307,1898,128),{{Vector(7612,1629.96875,180),"*678"},{Vector(7322,1795.96875,180),"*683"}}},
	[2] = { Vector(7550,2258,128),{{Vector(7722,1940,180),"*697"},{Vector(7403.96875,2197.96875,180),"*684"}}},
	[3] = { Vector(7322,1887,448),{{Vector(7612,1629.96875,500),"*698"},{Vector(7322,1795.96875,500),"*686"}}},
	[4] = { Vector(7610,2269,448),{{Vector(7722,1940,500),"*699"},{Vector(7403.96875,2197.96875,500),"*685"}}},
	[5] = { Vector(6776,830,768),{{Vector(7114.96875,730,820),"*700"},{Vector(7108,554,820.25),"*673"}}},
	[6] = { Vector(7375,2247,768),{{Vector(7562,1908,820),"*701"},{Vector(7571.96875,2022,820.25),"*676"}}},
}

for k, v in pairs(data) do
	local PROPERTY = table.Copy(PROPERTY)
	PROPERTY.Name = string.format(PROPERTY.Name,k)
	PROPERTY.ID = 80 + (k-1)
	PROPERTY.HUDBlip = v[1]
	PROPERTY.Doors = v[2]
	PROPERTY.Image = "lagrande"
	GAMEMODE:RegisterProperty(PROPERTY)
end