--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local SHOP = {}

SHOP.ID 				= 3
SHOP.NPCAssociation 	= 18
SHOP.Name				= "Ching's Convenience Store"

SHOP.Items	=	{
					"drug_beer",
					"item_phone",
					"furniture_radio",
					"item_paper_towels",
					"furniture_cone",
					"item_lifealert",
					"item_salt",
					"item_kittylitter",
					"weapon_bat",
					"weapon_binoculars",
					"drug_cig",
					"item_coke",
					"drug_bong", 
					//"weapon_camera",
					"item_lawbook",
					"food_chinese_takeout",
					"food_coffee",
					"food_coke",
					"food_melon",
                    "food_chips",
                    "food_sandwich",
					"food_orangejuice",
					"item_waterbottle",
					"item_fuelcan",
					"drug_vape0", --broken
					"drug_vape1",
					--{'item_balloon', {'01.29', '02.16', '04.15', '05.18', '05.31', '06.30', '07.16', '08.09', '08.11', '08.24', '12.02', '12.28'}},
				}
				
GAMEMODE:RegisterShop( SHOP )