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

PROPERTY.ID = 7

PROPERTY.Name = "Self Storage Lockup #%i"
PROPERTY.Category = "Business"
PROPERTY.Description = "Small storage lockup."
PROPERTY.Image = "selfstoragelockups"

PROPERTY.Cost = 335

local data = {
	[1] = {Vector(-6461,-2806,-197),{{Vector(-6468,-3008,-224),"*107"}}},
	[2] = {Vector(-6084,-2801,-271),{{Vector(-6076,-3008,-224),"*108"}}},
	[3] = {Vector(-6578,-3783,-276),{{Vector(-6468,-3648,-224),"*104"}}},
	[4] = {Vector(-6084,-3831,-289),{{Vector(-6076,-3648,-224),"*74"}}},
	[5] = {Vector(-7357,-3830,-290),{{Vector(-7356,-3648,-224),"*106"}}},
	[6] = {Vector(-7747,-3842,-281),{{Vector(-7748,-3648,-224),"*105"}}},
	[7] = {Vector(-7363,-2809,-296),{{Vector(-7356,-3008,-224),"*109"}}},
	[8] = {Vector(-7745,-2798,-292),{{Vector(-7748,-3008,-224),"*110"}}},
}

for k, v in pairs(data) do
	local PROPERTY = table.Copy(PROPERTY)
	PROPERTY.Name = string.format(PROPERTY.Name,k)
	PROPERTY.ID = 7 + (k-1)
	PROPERTY.HUDBlip = v[1]
	PROPERTY.Doors = v[2]
	GAMEMODE:RegisterProperty(PROPERTY)
end