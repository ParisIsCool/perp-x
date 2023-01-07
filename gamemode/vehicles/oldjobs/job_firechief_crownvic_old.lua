--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


local VEHICLE 			= {}


VEHICLE.ID 				= 'FC';


VEHICLE.Name 			= "Crown Victoria Firechief";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Victoria";

VEHICLE.Script 			= "crownvicpolice"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_FIRECHIEF

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil
VEHICLE.DefaultIceFriction = 0

VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector(4, 0, 2)
VEHICLE.ViewAdjustments_ThirdPerson = nil


VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")

VEHICLE.PaintText = ""

VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {
						{model = 'models/sentry/07crownvic_uc.mdl', skin = '5', name = 'red', color = Color(0, 0, 0, 255)},
					};

VEHICLE.PassengerSeats 	=	nil
VEHICLE.ExitPoints 		=	{
								Vector(-103.0634, -23.6848, -11.1878),
								Vector(68.9006, -23.6848, -11.1878),
								Vector(68.9006, -14.02453, -11.1878),
								Vector(-103.0634, -14.02453, -11.1878),
							};



VEHICLE.Props = {
	{
		Model = "models/lonewolfie/intlightbarsmall.mdl",
		Scale = .90,
		Pos = Vector(-0.4, -51.4, 60.4),
		Ang = Angle( 0, -90, 0),
		Skin = 4
	},
	{
		Model = "models/lonewolfie/whelenavenger_double.mdl",
		Scale = 1,
		Pos = Vector(0, 44.4, 49.8),
		Ang = Angle( 0, 90, 0),
	},
}

VEHICLE.TrafficDirect = {
	directions = {
		{
			{
			},
			{
		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),
			},
			{

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

			},
			{

		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),
			}
		},
		{
			{
			},
			{
		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

			},
			{
		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

			},
			{
		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

			},
			{
		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

			},
			{
		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

			},
			{
		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),

			}
		},
		{
			{
			},
			{
		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),

			},
			{

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),

			},
			{

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),

			},
			{

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),

			},
			{

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),

			},
			{
		Vector(-17, -51.8, 63.1),
		Vector(-15.3, -51.8, 63.1),
		Vector(-13.7, -51.8, 63.1),

		Vector(-11, -51.8, 63.1),
		Vector(-9.3, -51.8, 63.1),
		Vector(-7.6, -51.8, 63.1),

		Vector(-5.1, -51.8, 63.1),
		Vector(-3.3, -51.8, 63.1),
		Vector(-1.6, -51.8, 63.1),

		Vector(1.6, -51.8, 63.1),
		Vector(3.3, -51.8, 63.1),
		Vector(5.1, -51.8, 63.1),

		Vector(7.6, -51.8, 63.1),
		Vector(9.3, -51.8, 63.1),
		Vector(11, -51.8, 63.1),

		Vector(13.7, -51.8, 63.1),
		Vector(15.3, -51.8, 63.1),
		Vector(17, -51.8, 63.1),

			}
		}
	}
}

VEHICLE.SirenColors = 	{
	BlueCV = {
		//Deck Lights
		{ Pos = Vector(-7.8, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-9.3, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-11.1, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-12.5, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-14.2, -68.9, 50.4), Ang = Angle(0,90,-1) },
		//Corner
		{ Pos = Vector(-35.1, 112.3, 32.4), Ang = Angle(0,-45,-1) },
		//Grill
		{ Pos = Vector(9.7, 118.9, 32.4), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(7.4, 118.9, 32.4), Ang = Angle(0,-90,-1) },

		//Rear Window
		{ Pos = Vector(1.6, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(3.3, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(5.1, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(7.6, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(9.3, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(11, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(13.7, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(15.3, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(17, -51.8, 61.7), Ang = Angle(0,90,-1) },

		//Front Window
		{ Pos = Vector(-1.2, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-2.6, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-3.9, 43.5, 48.9), Ang = Angle(0,-90,-1) },
	},

	RedCV = {
		//Deck Lights
		{ Pos = Vector(7.8, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(9.3, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(11.1, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(12.5, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(14.2, -68.9, 50.4), Ang = Angle(0,90,-1) },
		//Corner
		{ Pos = Vector(35.1, 112.3, 32.4), Ang = Angle(0,-135,-1) },
		//Grill
		{ Pos = Vector(-9.7, 118.9, 32.4), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-7.4, 118.9, 32.4), Ang = Angle(0,-90,-1) },

		//Rear Window
		{ Pos = Vector(-1.6, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-3.3, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-5.1, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-7.6, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-9.3, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-11, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-13.7, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-15.3, -51.8, 61.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-17, -51.8, 61.7), Ang = Angle(0,90,-1) },

		//Front Window
		{ Pos = Vector(1.2, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(2.6, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(3.9, 43.5, 48.9), Ang = Angle(0,-90,-1) },
	},
};

VEHICLE.SirenNoise = Sound("perp2.5/siren_long.mp3")
VEHICLE.SirenNoise_DurMod = 4.628410 //0.795
VEHICLE.SirenNoise_Alt = Sound("perp2.5/siren_wail.mp3")
VEHICLE.SirenNoise_Alt_DurMod = 2.949440 //1



GAMEMODE:RegisterVehicle(VEHICLE)
