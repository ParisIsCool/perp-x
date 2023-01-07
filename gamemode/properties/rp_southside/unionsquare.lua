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

PROPERTY.Name = "Union Square Apartment %s"
PROPERTY.Category = "Apartments"
PROPERTY.Description = "Apartments near the union square park."
PROPERTY.Image = "motels"

PROPERTY.Cost = 400

local data = {
	[1] = { "A", Vector(1856,3200,226),{{Vector(1878,3148,220),"*531"},{Vector(1964,3354,220),"*533"},{Vector(2299,3337.5,217.5),"*532"}}},
	[2] = { "B", Vector(1899,2641,223),{{Vector(1930,2644,220),"*534"},{Vector(2051.96875,2486,220),"*535"},{Vector(1668.96875,2521.5,217.5),"*536"}}},
	[3] = { "C", Vector(1056,2641,221),{{Vector(1046,2644,220),"*528"},{Vector(1339,2521.5,217.5),"*530"},{Vector(956,2486,220),"*529"}}},
	[4] = { "D", Vector(1135,3205,228),{{Vector(1098,3148,220),"*526"},{Vector(708.96875,3334.5,217.5),"*439"},{Vector(979.96875,3386,220),"*527"}}},
	[5] = { "E", Vector(1856,3226,500),{{Vector(1878,3148,484),"*464"},{Vector(2299,3337.5,481.5),"*465"},{Vector(1964,3354,484),"*466"}}},
	[6] = { "F", Vector(1926,2641,497),{{Vector(1930,2644,484),"*27"}, {Vector(2051.96875,2486,484),"*28"}, {Vector(1668.96875,2521.5,481.5),"*29"}}},
	[7] = { "G", Vector(1024,2635,502),{{Vector(1046,2644,484),"*22"},{Vector(1339,2521.5,481.5),"*24"},{Vector(956,2486,484),"*23"}}},
	[8] = { "H", Vector(1135,3192,512),{{Vector(1098,3148,484),"*25"},{Vector(979.96875,3386,484),"*26"},{Vector(708.96875,3334.5,481.5),"*440"}}},
	[9] = { "I", Vector(1856,3218,755),{{Vector(1878,3148,748),"*461"},{Vector(1964,3354,748),"*463"},{Vector(2299,3337.5,745.5),"*462"}}},
	[10] = { "J", Vector(1984,2625,764),{{Vector(2051.96875,2486,748),"*31"},{Vector(1930,2644,748),"*30"},{Vector(1668.96875,2521.5,745.5),"*32"}}},
	[11] = { "K", Vector(1024,2571,769),{{Vector(1046,2644,748),"*33"},{Vector(1339,2521.5,745.5),"*35"},{Vector(956,2486,748),"*34"}}},
	[12] = { "L", Vector(944,3271,782),{{Vector(1098,3148,748),"*36"},{Vector(979.96875,3386,748),"*37"},{Vector(708.96875,3334.5,745.5),"*441"}}},
}

for k, v in pairs(data) do
	local PROPERTY = table.Copy(PROPERTY)
	PROPERTY.Name = string.format(PROPERTY.Name,v[1])
	PROPERTY.ID = 58 + (k-1)
	PROPERTY.HUDBlip = v[2]
	PROPERTY.Doors = v[3]
	PROPERTY.Image = "uqapartment"
	GAMEMODE:RegisterProperty(PROPERTY)
end