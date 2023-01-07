--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- fuck this file in particular

local SHOP = {};

SHOP.ID 				= 35;

SHOP.NPCAssociation 	= 35;
SHOP.Name				= "Mining Equiptment";

SHOP.Items = {	
					
					'zrms_basket',
					'zrms_conveyorbelt_n',
					'zrms_conveyorbelt_s',
					'zrms_conveyorbelt_c_left',
					'zrms_conveyorbelt_c_right',
					'zrms_crusher',
					'zrms_inserter',
					'zrms_refiner_bronze',
					'zrms_refiner_iron',
					'zrms_refiner_silver',
					'zrms_refiner_gold',
					'zrms_refiner_coal',
					'zrms_sorter_bronze',
					'zrms_sorter_iron',
					'zrms_sorter_silver',
					'zrms_sorter_gold',
					'zrms_sorter_coal',
					'zrms_mineentrance_base',
					'zrms_melter',					
					--'zrms_storagecrate',
					'zrms_gravelcrate',
					'zrms_splitter',
					
					
					
					
				};
				
GAMEMODE:RegisterShop( SHOP )