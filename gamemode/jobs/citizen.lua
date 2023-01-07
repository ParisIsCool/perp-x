--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local JOB = {}

JOB.ID = 1
TEAM_CITIZEN = JOB.ID
JOB.Name = "Citizen"
JOB.Color = Color( 52, 216, 25)

JOB.CanEquipInventoryGun = true

JOB.MaxPlayers = true
JOB.Pay = 50
JOB.GovOfficial = false
JOB.CanUsePersonalVehicle = true
JOB.Guns = {
}

JOB.Spawns = {}

JOB.Spawns["rp_rockford_v2b"] = {
    Vector( -5237.3134765625, -5410.75390625, 64.03125 ),
    Vector( -5235.8583984375, -5535.2880859375, 64.03125 ),
    Vector( -5121.5205078125, -5534.1674804688, 64.03125 ),
    Vector( -5122.4619140625, -5435.1752929688, 64.03125 ),
    Vector( -4998.70703125, -5550.9897460938, 64.03125 ),
    Vector( -4984.892578125, -5421.8032226563, 64.03125 ),
    Vector( -4847.728515625, -5575.6591796875, 64.03125 ),
    Vector( -4849.0981445313, -5452.1499023438, 64.03125 ),
    Vector( -4721.30859375, -5602.0166015625, 64.03125 ),
    Vector( -4680.7700195313, -5446.9658203125, 64.03125 ),
    Vector( -4580.38671875, -5594.0712890625, 64.03125 ),
    Vector( -4533.3095703125, -5455.4916992188, 64.03125 ),
    Vector( -4416.6328125, -5578.8911132813, 64.03125 ),
    Vector( -4371.4028320313, -5422.9497070313, 64.03125 ),
    Vector( -4239.58203125, -5601.9985351563, 64.03125 ),
    Vector( -4119.6416015625, -5456.2197265625, 64.03125 ),
}

JOB.Spawns["rp_truenorth_v1a"] = {
    Vector(4829, 3015, 136),
    Vector(5063, 3016, 136),
    Vector(5237, 3017, 136),
    Vector(5438, 3018, 136),
    Vector(5437, 3148, 136),
    Vector(5436, 3318, 136),
    Vector(5436, 3468, 136),
    Vector(4672, 3450, 136),
    Vector(4671, 3322, 136),
    Vector(4670, 3157, 136),
    Vector(4929, 3389, 72),
    Vector(5052, 3479, 72),
    Vector(5148, 3387, 72),
}

JOB.Spawns["rp_southside"] = {
	{Vector(2300,5298,224), Angle(0,0,0)},
	{Vector(2393,5457,224), Angle(0,0,0)},
	{Vector(2575,5459,224), Angle(0,0,0)},
	{Vector(2766,5460,224), Angle(0,0,0)},
	{Vector(2929,5461,224), Angle(0,0,0)},
	{Vector(3019,5282,224), Angle(0,0,0)},
	{Vector(3005,5047,224), Angle(0,0,0)},
	{Vector(3007,4838,224), Angle(0,0,0)},
	{Vector(3008,4641,224), Angle(0,0,0)},
	{Vector(2789,4633,224), Angle(0,0,0)},
	{Vector(2570,4632,224), Angle(0,0,0)},
	{Vector(2388,4631,224), Angle(0,0,0)},
	{Vector(2279,4788,224), Angle(0,0,0)},
	{Vector(2801,4807,0), Angle(0,0,0)},
	{Vector(2844,5050,0), Angle(0,0,0)},
	{Vector(2842,5322,0), Angle(0,0,0)},
	{Vector(3066,5047,0), Angle(0,0,0)},
	{Vector(2715,4645,0), Angle(0,0,0)},
	{Vector(2612,5485,0), Angle(0,0,0)},
}

JOB.Playermodels = {}
JOB.Playermodels[SEX_MALE] = {}
JOB.Playermodels[SEX_MALE][1] = "models/player/zelpa/male_01_extended.mdl"
JOB.Playermodels[SEX_MALE][2] = "models/player/zelpa/male_02_extended.mdl"
JOB.Playermodels[SEX_MALE][3] = "models/player/zelpa/male_03_extended.mdl"
JOB.Playermodels[SEX_MALE][4] = "models/player/zelpa/male_04_extended.mdl"
JOB.Playermodels[SEX_MALE][5] = "models/player/zelpa/male_05_extended.mdl"
JOB.Playermodels[SEX_MALE][6] = "models/player/zelpa/male_06_extended.mdl"
JOB.Playermodels[SEX_MALE][7] = "models/player/zelpa/male_07_extended.mdl"
JOB.Playermodels[SEX_MALE][8] = "models/player/zelpa/male_08_extended.mdl"
JOB.Playermodels[SEX_MALE][9] = "models/player/zelpa/male_09_extended.mdl"
 
JOB.Playermodels[SEX_FEMALE] = {}
JOB.Playermodels[SEX_FEMALE][1] = "models/player/zelpa/female_01_extended.mdl"
JOB.Playermodels[SEX_FEMALE][2] = "models/player/zelpa/female_02_extended.mdl"
JOB.Playermodels[SEX_FEMALE][3] = "models/player/zelpa/female_03_extended.mdl"
JOB.Playermodels[SEX_FEMALE][4] = "models/player/zelpa/female_04_extended.mdl"
JOB.Playermodels[SEX_FEMALE][5] = "models/player/zelpa/female_07_extended.mdl"
JOB.Playermodels[SEX_FEMALE][6] = "models/player/zelpa/female_06_extended.mdl"


JOB.Bodygroups = {
	[SEX_MALE] = {
		["Shirt"] = {
			ID = 1,
			Submodels = {
				{0, "Button Up 1"},
				{1, "Button Up 2"},
				{4, "Button Up 3"},
				{10, "Button Up 4"},
				{11, "Button Up 5"},
				{12, "Button Up 6"},
				{13, "Button Up 7"},
				{14, "Button Up 8"},
				{2, "Blue Sweater"},
				{3, "White Sweater"},
				{5, "Vest"},
				{6, "Vest 2"},
				{7, "Medical Vest"},
				{8, "Medical Vest 2"},
				{9, "Medical Sweater"},
				{15, "Blue Jacket"},
				{16, "Teal Jacket"},
				{17, "Red Jacket"},
				{18, "Grey Jacket"},
				{19, "Brown Jacket"},
				{20, "Tan jacket"},
			}
		},
		["Pants"] = {
			ID = 2,
			Submodels = {
				{0, "Blue Jeans"},
				{1, "Dark Jeans"},
				{2, "Worn Jeans"},
				{3, "Holster Jeans"},
				{4, "Holster Jeans 2"},
				{5, "Dirty Jeans"},
				{6, "Cowboy Jeans"},
			}
		},
		["Hands"] = {
			ID = 3,
			Submodels = {
				{0, "No Gloves"},
				{1, "Fingerless Gloves"},
				{2, "Gloves"},
			}
		},
		["Beanie"] = {
			ID = 4,
			Submodels = {
				{0, "No Beanie"},
				{1, "Blue Beanie"},
				{2, "Green Benie"},
			}
		},
		["Glasses"] = {
			ID = 5,
			Submodels = {
				{0, "No Glasses"},
				{1, "Glasses"},
			}
		},
	},
	[SEX_FEMALE] = {
		["Shirt"] = {
			ID = 1,
			Submodels = {
				{0, "Button Up 1"},
				{1, "Button Up 2"},
				{4, "Button Up 3"},
				{10, "Button Up 4"},
				{11, "Button Up 5"},
				{12, "Button Up 6"},
				{13, "Button Up 7"},
				{14, "Button Up 8"},
				{2, "Blue Sweater"},
				{3, "White Sweater"},
				{5, "Vest"},
				{6, "Vest 2"},
				{7, "Medical Vest"},
				{8, "Medical Vest 2"},
				{9, "Medical Sweater"},
				{15, "Blue Jacket"},
				{16, "Teal Jacket"},
				{17, "Red Jacket"},
			}
		},
		["Pants"] = {
			ID = 2,
			Submodels = {
				{0, "Blue Jeans"},
				{1, "Dark Jeans"},
				{2, "Worn Jeans"},
				{3, "Holster Jeans"},
				{4, "Holster Jeans 2"},
				{5, "Dirty Jeans"},
				{6, "Cowboy Jeans"},
			}
		},
		["Hands"] = {
			ID = 3,
			Submodels = {
				{0, "No Gloves"},
				{1, "Fingerless Gloves"},
				{2, "Gloves"},
			}
		},
		["Glasses"] = {
			ID = 4,
			Submodels = {
				{0, "No Glasses"},
				{1, "Glasses"},
			}
		},
	}
}

GM:RegisterJob( JOB )