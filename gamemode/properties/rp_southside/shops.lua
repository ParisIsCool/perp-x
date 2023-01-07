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

PROPERTY.Name = "%s Shop"
PROPERTY.Category = "Shops"
PROPERTY.Description = "Motel apartments just off the shore."
PROPERTY.Image = "motels"

PROPERTY.Cost = 335

local data = {
	[1] = {"Orange", "orangeshop",Vector(5050,4864,-47),{{Vector(4740,4840,4),"*42"},{Vector(5324,4726,4),"*256"},{Vector(5603,5001,4),"*254"}}},
	[2] = {"Green","greenshop",Vector(5311,5456,-18),{{Vector(4740,5416,4),"*116"},{Vector(5324,5578,4),"*257"},{Vector(5603,5353,4),"*255"}}},
	[3] = {"Red","redshop",Vector(3865,6554,16),{{Vector(3896,6276,68),"*118"},{Vector(3786,6860,68),"*258"},{Vector(3478,7163,72),"*127"}}},
	[4] = {"Blue","blueshop",Vector(1602,6916,16),{{Vector(1284,7462,72),"*126"},{Vector(1738,7244,68),"*259"},{Vector(1623,6660,68),"*119"}}},
	[5] = {"Teal","tealshop",Vector(588,7118,16),{{Vector(600,6852,68),"*120"},{Vector(438,7436,68),"*260"},{Vector(284,7658,76),"*125"}}},
	[6] = {"Cyan","cyanshop",Vector(4679,2812,-35),{{Vector(4646,3260,4),"*117"},{Vector(4534,2675,4),"*128"},{Vector(4620,2166,-4),"*129"}}},
}

for k, v in pairs(data) do
	local PROPERTY = table.Copy(PROPERTY)
	PROPERTY.Name = string.format(PROPERTY.Name,v[1])
	PROPERTY.ID = 31 + (k-1)
	PROPERTY.HUDBlip = v[3]
	PROPERTY.Doors = v[4]
	PROPERTY.Image = v[2]
	GAMEMODE:RegisterProperty(PROPERTY)
end