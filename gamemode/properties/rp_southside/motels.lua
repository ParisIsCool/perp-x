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

PROPERTY.ID = 20

PROPERTY.Name = "Motel #%i"
PROPERTY.Category = "Motels"
PROPERTY.Description = "Motel apartments just off the shore."
PROPERTY.Image = "motels"

PROPERTY.Cost = 335

local data = {
	[1] = {Vector(-4910,1225,-42),{{Vector(-4772,1222,-44), "*745"},{Vector(-5000,1510,-43), "*759"},{Vector(-4774,1602,-44), "*760"}}},
	[2] = {Vector(-4566,1225,-47),{{Vector(-4684,1222,-44), "*742"},{Vector(-4681,1602,-44), "*754"},{Vector(-4456,1510,-43), "*753"}}},
	[3] = {Vector(-4162,1225,-39),{{Vector(-4300,1222,-44), "*741"},{Vector(-4297,1602,-44), "*752"},{Vector(-4072,1510,-43), "*751"}}},
	[4] = {Vector(-3776,1225,-38),{{Vector(-3913,1602,-44), "*737"},{Vector(-3688,1510,-43), "*736"},{Vector(-3916,1222,-44), "*733"}}},
	[5] = {Vector(-3574,974,-38),{{Vector(-3578,836,-44), "*738"},{Vector(-3198,838,-44), "*252"},{Vector(-3290,1064,-43), "*746"}}},
	[6] = {Vector(-4910,1225,-42),{{Vector(-4774,1602,132), "*758"},{Vector(-5000,1510,132), "*757"},{Vector(-4772,1222,132), "*744"}}},
	[7] = {Vector(-4566,1225,-47),{{Vector(-4684,1222,132), "*743"},{Vector(-4681,1602,132), "*756"},{Vector(-4456,1510,132), "*755"}}},
	[8] = {Vector(-4162,1225,-39),{{Vector(-4300,1222,132), "*740"},{Vector(-4297,1602,132), "*750"},{Vector(-4072,1510,132), "*749"}}},
	[9] = {Vector(-3776,1225,-38),{{Vector(-3916,1222,132), "*732"},{Vector(-3913,1602,132), "*735"},{Vector(-3688,1510,132), "*734"}}},
	[10] = {Vector(-3574,974,-38),{{Vector(-3578,836,132), "*739"},{Vector(-3290,1064,132), "*747"},{Vector(-3198,838,132), "*748"}}},
}

for k, v in pairs(data) do
	local PROPERTY = table.Copy(PROPERTY)
	PROPERTY.Name = string.format(PROPERTY.Name,k)
	PROPERTY.ID = 20 + (k-1)
	PROPERTY.HUDBlip = v[1]
	PROPERTY.Doors = v[2]
	GAMEMODE:RegisterProperty(PROPERTY)
end