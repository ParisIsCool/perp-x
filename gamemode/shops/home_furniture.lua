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

SHOP.ID 				= 1
SHOP.NPCAssociation 	= 7
SHOP.Name				= "Jenny's Home Furnishings"

SHOP.Items = {
	"furniture_chair_wooden",
	"furniture_chair_plastic",
	"furniture_chair_computer",
	'furniture_concrete_barrier',
	'furniture_couch',
	"furniture_clock",
	"furniture_bathtub",
	"furniture_stove",
	"furniture_register",
	"item_pot",
	"furniture_desk",
	"furniture_bed",
	'furniture_pan',
	'furniture_sink',
	"furniture_fridge",
	"furniture_picture",
	"furniture_bust",
	"furniture_i_beam",
	"item_police_barrier",
	{'item_balloon', {
		'01.01', //TDSkating
		'02.18', //bob
		'02.22', //Neenja
		'02.26', //Dante
		'03.23', //Biopsy
		'03.29', //Cubez
		'08.25', //Joweosme
		'08.26', //Stryke
		'10.07', //Babygal
		'10.08', //Scott
		'10.12', //Maze
		'10.25', //Killslick
		'12.06', //Crotiz
		}
	}, // '01.29', '02.16', '04.15', '05.18', '05.31', '06.30', '07.16', '08.09', '08.11', '08.24', '12.02', '12.28'; SilverFang, Jimmy, Phaze, Ekim, Keegs/Leumas, Pk191, Dawn, Inferno, Chris, Venom, Jake, CreamyX.
}




GAMEMODE:RegisterShop( SHOP )
