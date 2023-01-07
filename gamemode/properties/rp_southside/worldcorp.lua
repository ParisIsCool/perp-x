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

PROPERTY.Name = "World Corp Suite %s"
PROPERTY.Category = "Offices"
PROPERTY.Description = "World Corp. Offices. Very Fancy!"
PROPERTY.Image = "motels"

PROPERTY.Cost = 900

local data = {
	[1] = { "6A", Vector(-695,4856,988),{{Vector(-710,4950,972),"*590"},}},
	[3] = { "6B ", Vector(-1697,4947,989),{{Vector(-1722,4950,972),"*589"}}},
	[4] = { "8A", Vector(-695,4856,988),{{Vector(-1014,5074,1252),"*596"},{Vector(-656,4856,1252),"*598"}}},
	[5] = { "8B", Vector(-1697,4947,989),{{Vector(-1418,5074,1252),"*597"},{Vector(-1776,4856,1252),"*599"}}},
	[6] = { "10A", Vector(-695,4856,988),{{Vector(-909.96875,4950,1532),"*600"}}},
	[7] = { "10B", Vector(-1697,4947,989),{{Vector(-1522,4950,1532),"*601"}}},
	[8] = { "12", Vector(-1222,5145,1825),{{Vector(-1173.96875,5148,1812),"*620"},{Vector(-1532,4894,1820),"*621"}}, 1350},
}

for k, v in pairs(data) do
	local PROPERTY = table.Copy(PROPERTY)
	PROPERTY.Name = string.format(PROPERTY.Name,v[1])
	PROPERTY.ID = 70 + (k-1)
	PROPERTY.HUDBlip = v[2]
	PROPERTY.Doors = v[3]
	PROPERTY.Image = "worldcorp"
	if v[4] then PROPERTY.Cost = v[4] end
	GAMEMODE:RegisterProperty(PROPERTY)
end