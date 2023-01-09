--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.Name = "PERP"
--GM.Name = "Grand Theft Auto Miami RP"
GM.Author = "TEAM GARRY"

function GM:GetGameDescription() return GAMEMODE.Name end

local folder = GM.Folder
FOLDER_NAME = folder:gsub( "gamemodes/", "" )

VALID_NAME_CHARACTERS	=	{ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" }

SHOW_WEAPON_EQUIP_NOTIFICATINS = true

local DEVELOPERS = {}
DEVELOPERS["STEAM_0:0:89634933"] = true

function PLAYER:IsDeveloper()
	if !IsValid(self) then return end
	return DEVELOPERS[self:SteamID()]
end

EQUIP_WEAPON_MAIN 	= 1
EQUIP_MAIN 			= 1
EQUIP_WEAPON_SIDE 	= 2
EQUIP_SIDE 			= 2

INVENTORY_WIDTH 	= 13
INVENTORY_HEIGHT 	= 6

NORMAL_HORNS 		= 1337

MAX_CASH 			= 1000000

WEED_GROW_TIME 		= 600
COCAINE_GROW_TIME 	= 600

GM.SprintDecay = .22
GM.FistDamage = 5

PENETRATION_RIFLE = 3000
PENETRATION_SMG = 2500
PENETRATION_PISTOL = 1200

GM.Ringtones = {
	{ "Bad Touch", "badtouch.mp3", "IsVIP" },
	{ "Beverly Hills Cop", "beverlyhillscopt.mp3", "IsVIP" },
	{ "Britland Theme", "brit.mp3", "IsVIP" },
	{ "Close Encounters", "cencounters.mp3", "IsVIP" },
	{ "Candy Mountain", "candymountain.mp3", "IsVIP" },
	{ "Old Phone Ring", "classic.mp3" },
	{ "Digital Ring", "digital.mp3" },
	{ "DJ Spash", "djsmash.mp3", "IsVIP" },
	{ "Drum N Bass", "dnb.mp3", "IsVIP" },
	{ "Doorbell", "doorbell.mp3" },
	{ "Dubstep", "dubstep.mp3", "IsVIP" },
	{ "Fat Guy in Little Car", "fatguyinlittlec.mp3", "IsVIP" },
	{ "Garden Party", "garden_party.mp3", "IsVIP" },
	{ "Gold Member", "gold.mp3", "IsVIP" },
	{ "Hello Its ur Cell", "helloitsyourcell.mp3" , "IsVIP" },
	{ "Voice Ring", "human.mp3" },
	{ "Infinity", "infinity.mp3", "IsVIP" },
	{ "Jam Jingle", "jam.mp3", "IsVIP" },
	{ "Let Go", "letgo.mp3", "IsVIP" },
	{ "Mario Theme", "mario.mp3", "IsVIP" },
	{ "Milkshake", "milkshake.mp3", "IsVIP" },
	{ "Moskau", "moskau.mp3", "IsVIP" },
	{ "My Bunghole", "mybunghole.mp3", "IsVIP" },
	{ "Mysterious", "mysterious.mp3", "IsVIP" },
	{ "Pendulum", "pendulum.mp3" },
	{ "Pjanno", "pjanno.mp3", "IsVIP" },
	{ "Pokemon Theme", "pokemonthemesong.mp3", "IsVIP" },
	{ "Raindrops", "raindrops.mp3", "IsVIP" },
	{ "Rocky Movie Theme", "rockymovietheme.mp3", "IsVIP" },
	{ "Right Here", "righthere.mp3", "IsVIP" },
	{ "Santa", "santa.mp3", "IsVIP" },
	{ "Shut Ur Mouth", "shutyourmouth.mp3", "IsVIP" },
	{ "Tetris", "tetris.mp3", "IsVIP" },
	{ "TopGun Theme", "topguntheme.mp3", "IsVIP" },
	{ "Turn Lights Off", "turnlightsoff.mp3" },
	{ "We are young", "weareyoung.mp3" },
	{ "Your Mommas Calling", "yourmommascalling.mp3", "IsVIP" },
}


CARD_ACE = 1
CARD_2 = 2
CARD_3 = 3
CARD_4 = 4
CARD_5 = 5
CARD_6 = 6
CARD_7 = 7
CARD_8 = 8
CARD_9 = 9
CARD_10 = 10
CARD_JACK = 11
CARD_QUEEN = 12
CARD_KING = 13

CARD_DIAMOND = 13
CARD_HEART = 14
CARD_CLUB = 15
CARD_SPADE = 16

GM.CardValues = {}
GM.CardValues[ CARD_ACE ] = 11
GM.CardValues[ CARD_2 ] = 2
GM.CardValues[ CARD_3 ] = 3
GM.CardValues[ CARD_4 ] = 4
GM.CardValues[ CARD_5 ] = 5
GM.CardValues[ CARD_6 ] = 6
GM.CardValues[ CARD_7 ] = 7
GM.CardValues[ CARD_8 ] = 8
GM.CardValues[ CARD_9 ] = 9
GM.CardValues[ CARD_10 ] = 10
GM.CardValues[ CARD_JACK ] = 10
GM.CardValues[ CARD_QUEEN ] = 10
GM.CardValues[ CARD_KING ] = 10

GM.ExperienceForSprint = 1				-- Experience given every 5 ticks of stamina is taken.
GM.ExperienceForSwimming = 10				-- Experience for every 1 seconds swimming.
GM.ExperienceForDriving = 1				-- Experience for every 5 seconds driving.

CAR_PAINT_RANGE = 750

GM.DrowningDamage = 10
GM.DrowningDelay = 1
GM.DrownTime = 8

ChatRadius_Whisper = 256
ChatRadius_Local = 640
ChatRadius_Yell = 1024

GM.RenamePrice = 10000
GM.FacialPrice = 5000
GM.ClothesPrice = 1000
GM.SexChangePrice = 20000
COST_FOR_HYDRAULICS = 20000
COST_FOR_UNDERGLOW = 15000
COST_FOR_ANTITHEFT = 25000
COST_FOR_TURBO = 20000
PHYSGUN_COLORPRICE = 4000

GM.GeneResetPrice = 5000
GM.NewGenePrice = 3000
GM.MaxGenes = 10
GM.MaxGenesVIP = 14

GM.MaxTax_Sales = 75
GM.MaxTax_Income = 50

GM.MaxTicketPrice = 5000

GM.MayorPay = 600
FREE_CASH_PER_PLAYER = 120 -- hehehe

if GAMEMODE then
	GM.CityBudget = GAMEMODE.CityBudget or 0
	GM.CityBudget_LastIncome = GAMEMODE.CityBudget_LastIncome or 0
	GM.CityBudget_LastExpenses = GAMEMODE.CityBudget_LastExpenses or 0
else
	GM.CityBudget = 0
	GM.CityBudget_LastIncome = 0
	GM.CityBudget_LastExpenses = 0
end

function GM:IsSerious()
	return game.GetMap():lower() == 'rp_evocity2_v3p'
end

function GM:IsSerious()
	return game.GetMap():lower() == 'rp_evocity_v4b1'
end

if SERVER then return end
