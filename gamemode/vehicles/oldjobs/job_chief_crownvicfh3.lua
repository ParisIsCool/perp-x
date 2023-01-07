local VEHICLE 			= {}

VEHICLE.ID 				= 'chcv'

VEHICLE.Name 			= "Police Car"
VEHICLE.Make 			= "Ford"
VEHICLE.Model 			= "2011 Crown Vic"

VEHICLE.Script 			= "for_crownvic_fh3"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_CHIEF
VEHICLE.MarkedCrown 	= true
VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil
VEHICLE.DefaultIceFriction = 0

VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector(4, 0, 2)
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")

VEHICLE.PaintText = ""

VEHICLE.RadarPosition = {
	{ Pos = Vector(-20.5, 35, 51), Ang = Angle(0, 0, 0), Right = true },
	{ Pos = Vector(-22.5, 35, 51), Ang = Angle(0, 0, 0), Center = true },
	{ Pos = Vector(-24.6, 35, 51), Ang = Angle(0, 0, 0), Left = true },
}

/*
VEHICLE.PolTakeDowns = {
	{ Vector(-3.2, 1.2, 71.8) },
	{ Vector(3.2, 1.2, 71.8) }
}
VEHICLE.PolAlleyLeft = {
	{ Vector(-27.1, -4.9, 71.8) }
}
VEHICLE.PolAlleyRight = {
	{ Vector(27.1, -4.9, 71.8) }
}
*/

VEHICLE.PolTakeDowns = {
	{ Vector(-15.4, -0.8, 71) },
	{ Vector(15.4, -0.8, 71) }
}
VEHICLE.PolAlleyLeft = {
	{ Vector(-28, -7.4, 71) }
}
VEHICLE.PolAlleyRight = {
	{ Vector(28, -7.4, 71) }
}

VEHICLE.PaintJobs = {
	{model = 'models/tdmcars/emergency/for_crownvic_fh3.mdl', skin = '6', name = '', color = Color(0, 0, 0, 255)},
};

VEHICLE.PassengerSeats 	=	nil

VEHICLE.ExitPoints 		=	{
	Vector(68,5,13),
	Vector(68,-34,15),
	Vector(68,-14,15),
	Vector(-68,-34,15),
};

VEHICLE.BodyGroups = {
{Group = 0, Value = 1},  //[NOTHING]
{Group = 1, Value = 1},  //[NOTHING]
{Group = 2, Value = 0},  //[NOTHING]
{Group = 3, Value = 0},  //[NOTHING]
{Group = 4, Value = 0},  //[NOTHING]
{Group = 5, Value = 0},  //[NOTHING]
{Group = 6, Value = 0},  //[NOTHING]
{Group = 7, Value = 0},  //[NOTHING]
{Group = 8, Value = 0},  //[NOTHING]
{Group = 9, Value = 1},  //[BG EDIT START] SPOT LIGHTS 	(0/1)
{Group = 10, Value = 0}, //	DASH LIGHT (DETECTIVE) 		(0/1)
{Group = 11, Value = 0}, //	FRONT WINDOW LIGHTS 		(0/1)
{Group = 12, Value = 3}, //	PUSH BAR 					(0:Simple 1:Wrap 2:CHP 3:None)
{Group = 13, Value = 1}, //	GRILLE 						(0/1)
{Group = 14, Value = 1}, //	MIRROR LIGHTS 				(0/1)
{Group = 15, Value = 2}, //	LIGHT BAR					(0:None 1:Halogen 2:CHP 3:Solex 4:LAPD)
{Group = 16, Value = 1}, //	INTERIOR EQUIPMENT			(0/1)
{Group = 17, Value = 2}, //	TOP SIREN SLOT (Control)	(0-3 Who cares...)
{Group = 18, Value = 0}, //	BOTTOM SIREN SLOT (Control)	(0/1 Who cares...)
{Group = 19, Value = 0}, //	CAGE						(0:Wall 1:Bars 2:None)
{Group = 20, Value = 1}, //	REAR DOOR WINDOW LIGHTS		(0/1)
{Group = 21, Value = 0}, //	REAR WINDOW LIGHTS			(0:None 1:Full top bar 2:2x whelen)
{Group = 22, Value = 1}, //	REAR WINDOW LOWER			(0/1)
{Group = 23, Value = 1}, //	HEADLIGHT ICONS				(0/1)
{Group = 24, Value = 0}, //	FRONT DOOR PANELS			(0/1)
{Group = 25, Value = 0}, //	REAR DOOR PANELS			(0/1)
{Group = 26, Value = 0}, //	TRUNK PANELS				(0/1)
{Group = 27, Value = 0}, //	TRUMP BADGE					(0/1)
{Group = 28, Value = 1}, //	DOOR HANDLES				(0:White 1:Black)
{Group = 29, Value = 0}, //	REAR WINDOWS (TINT)			(0/1)
{Group = 30, Value = 1}, //	ANTENNAS					(0:Short x2 1:Tall x1 2:Tall x2 3:None)
{Group = 31, Value = 0}, //	[BG EDIT START] WHEELS		(0:Rims 1:Hubcaps)
};

VEHICLE.Props = {
}
VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = SoundDuration( Sound("perp2.5/SIREN_1.wav") )
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = SoundDuration( Sound("perp2.5/SIREN_2.wav") )
/*
VEHICLE.TrafficDirect =		{
	directions = {
		{
			{
			},
			{
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
			},
			{
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),

				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
			},
			{
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),

				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),

				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
			},
			{
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),

				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),

				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),

				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
			},
		},
		{
			{
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
			},
			{
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
			},
		},
		{
			{
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
			},
			{
				Vector(-24.1, -9.9, 71.8),
				Vector(-23.05, -10.7, 71.8),
				Vector(-22, -10.7, 71.8),
				Vector(-17.9, -11.6, 71.8),
				Vector(-16.55, -11.6, 71.8),
				Vector(-15.5, -11.6, 71.8),
				Vector(-10.8, -11.6, 71.8),
				Vector(-9.75, -11.6, 71.8),
				Vector(-8.7, -11.6, 71.8),
				Vector(-2.15, -12.4, 71.8),
				Vector(-3.2, -12.4, 71.8),
				Vector(-4.25, -12.4, 71.8),
				Vector(2.15, -12.4, 71.8),
				Vector(3.2, -12.4, 71.8),
				Vector(4.25, -12.4, 71.8),
				Vector(10.8, -11.6, 71.8),
				Vector(9.75, -11.6, 71.8),
				Vector(8.7, -11.6, 71.8),
				Vector(17.9, -11.6, 71.8),
				Vector(16.55, -11.6, 71.8),
				Vector(15.5, -11.6, 71.8),
				Vector(24.1, -9.9, 71.8),
				Vector(23.05, -10.7, 71.8),
				Vector(22, -10.7, 71.8),
			}
		}
	}
}
*/
VEHICLE.TrafficDirect =		{
	directions = {
		{
			{
			},
			{
				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),
			},
			{
				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),

				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),

				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
		},
		{
			{
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),

				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),

				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),

				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),

				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),

				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),

				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
		},
		{
			{
			},
			{
				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
			{
				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),

				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
			{
				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),

				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
			{
				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),

				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
			{
				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),

				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
			{
				Vector(17.4, -13.9, 71.3),
				Vector(16.1, -13.9, 71.3),
				Vector(14.6, -13.9, 71.3),
				Vector(13.3, -13.9, 71.3),

				Vector(11.3, -13.9, 71.3),
				Vector(9.8, -13.9, 71.3),
				Vector(8.5, -13.9, 71.3),
				Vector(7.3, -13.9, 71.3),

				Vector(5.2, -13.9, 71.3),
				Vector(3.8, -13.9, 71.3),
				Vector(2.7, -13.9, 71.3),
				Vector(1.3, -13.9, 71.3),

				Vector(-1.3, -13.9, 71.3),
				Vector(-2.7, -13.9, 71.3),
				Vector(-3.8, -13.9, 71.3),
				Vector(-5.2, -13.9, 71.3),

				Vector(-7.3, -13.9, 71.3),
				Vector(-8.5, -13.9, 71.3),
				Vector(-9.8, -13.9, 71.3),
				Vector(-11.3, -13.9, 71.3),

				Vector(-13.3, -13.9, 71.3),
				Vector(-14.6, -13.9, 71.3),
				Vector(-16.1, -13.9, 71.3),
				Vector(-17.4, -13.9, 71.3),
			},
		}
	}
}

/*
//Rear Drivers
Vector(-1.3, -13.9, 71.3)
Vector(-2.7, -13.9, 71.3)
Vector(-3.8, -13.9, 71.3)
Vector(-5.2, -13.9, 71.3)

Vector(-7.3, -13.9, 71.3)
Vector(-8.5, -13.9, 71.3)
Vector(-9.8, -13.9, 71.3)
Vector(-11.3, -13.9, 71.3)

Vector(-13.3, -13.9, 71.3)
Vector(-14.6, -13.9, 71.3)
Vector(-16.1, -13.9, 71.3)
Vector(-17.4, -13.9, 71.3)
//Rear Drivers Corner
Vector(-21, -13.6, 71.3)
Vector(-22.3, -12.9, 71.3)
Vector(-23.7, -12, 71.3)
Vector(-24.7, -11.4, 71.3)
Vector(-25.8, -10.6, 71.3)
Vector(-26.7, -9.9, 71.3)
//Front Drivers Corner
Vector(-21, -1.2, 71)
Vector(-22.3, -2, 71)
Vector(-23.5, -2.7, 71)
Vector(-24.8, -3.7, 71)
Vector(-26, -4.3, 71)
Vector(-26.8, -4.8, 71)
//Front Drivers
Vector(-11.3, -0.8, 71)
Vector(-10.2, -0.8, 71)
Vector(-8.6, -0.8, 71)
Vector(-7.3, -0.8, 71)

Vector(-5.3, -0.8, 71)
Vector(-4.1, -0.8, 71)
Vector(-2.6, -0.8, 71)
Vector(-1.3, -0.8, 71)

//Rear Passenger
Vector(1.3, -13.9, 71.3)
Vector(2.7, -13.9, 71.3)
Vector(3.8, -13.9, 71.3)
Vector(5.2, -13.9, 71.3)

Vector(7.3, -13.9, 71.3)
Vector(8.5, -13.9, 71.3)
Vector(9.8, -13.9, 71.3)
Vector(11.3, -13.9, 71.3)

Vector(13.3, -13.9, 71.3)
Vector(14.6, -13.9, 71.3)
Vector(16.1, -13.9, 71.3)
Vector(17.4, -13.9, 71.3)
//Rear Passenger Corner
Vector(21, -13.6, 71.3)
Vector(22.3, -12.9, 71.3)
Vector(23.7, -12, 71.3)
Vector(24.7, -11.4, 71.3)
Vector(25.8, -10.6, 71.3)
Vector(26.7, -9.9, 71.3)
//Front Passenger Corner
Vector(21, -1.2, 71)
Vector(22.3, -2, 71)
Vector(23.5, -2.7, 71)
Vector(24.8, -3.7, 71)
Vector(26, -4.3, 71)
Vector(26.8, -4.8, 71)
//Front Passenger
Vector(11.3, -0.8, 71)
Vector(10.2, -0.8, 71)
Vector(8.6, -0.8, 71)
Vector(7.3, -0.8, 71)

Vector(5.3, -0.8, 71)
Vector(4.1, -0.8, 71)
Vector(2.6, -0.8, 71)
Vector(1.3, -0.8, 71)
*/

VEHICLE.SirenColorsStages = 	{
	BlueCV = {
	/*
		//Lightbar Rear
		{ Pos = Vector(24.1, -9.9, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.05, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(22, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(17.9, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(16.55, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(15.5, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(10.8, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(9.75, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(8.7, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(2.15, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(3.2, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(4.25, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Lightbar Front
		--Vector(27.1, -4.9, 71.8),
		{ Pos = Vector(24.3, -0.8, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(22.95, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(21.6, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(17.9, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(16.55, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(15.2, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(11.1, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(10.15, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(8.8, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		--Vector(3.2, 1.2, 71.8),
	*/
		//Rear Passenger
		{ Pos = Vector(1.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(2.7, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(3.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(5.2, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(7.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(8.5, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(9.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(13.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(14.6, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(16.1, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(17.4, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Rear Passenger Corner
		{ Pos = Vector(21, -13.6, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(22.3, -12.9, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.7, -12, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(24.7, -11.4, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(25.8, -10.6, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(26.7, -9.9, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Front Passenger Corner
		{ Pos = Vector(21, -1.2, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(22.3, -2, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(23.5, -2.7, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(24.8, -3.7, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(26, -4.3, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(26.8, -4.8, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		//Front Passenger
		{ Pos = Vector(11.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(10.2, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(8.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(7.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },

		{ Pos = Vector(5.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(4.1, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(2.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(1.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },


		//Deck Lights
		{ Pos = Vector(-7.8, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-9.3, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11.1, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-12.5, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-14.2, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Corner
		{ Pos = Vector(-35.1, 112.3, 32.4), Ang = Angle(0,-45,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-35.1, 111.8, 34.2), Ang = Angle(0,-45,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-35.1, 113.3, 30.4), Ang = Angle(0,-45,-1), LSTG2 = true, LSTG3 = true },

		//Driver Rear Window
		{ Pos = Vector(-38.3, -43.6, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -41.9, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -40.4, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		//Passenger Rear Window
		{ Pos = Vector(38.3, -43.6, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -41.9, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -40.4, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },


		//Grill
		{ Pos = Vector(9.7, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(7.4, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Reverse
		{ Pos = Vector(11, -112, 37), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11, -112, 37), Ang = Angle(0,90,-1),LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11, -112, 39), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11, -112, 39), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11, -112, 35), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11, -112, 35), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		//Front Window
		{ Pos = Vector(-1.2, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-2.6, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-3.9, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG3 = true },
	},

	RedCV = {
	/*
		//Lightbar Rear
		{ Pos = Vector(-24.1, -9.9, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.05, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-22, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-17.9, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-16.55, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-15.5, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-10.8, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-9.75, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-8.7, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-2.15, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-3.2, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-4.25, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Lightbar Front
		--Vector(-27.1, -4.9, 71.8),
		{ Pos = Vector(-24.3, -0.8, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-22.95, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-21.6, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-17.9, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-16.55, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-15.2, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-11.1, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-10.15, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-8.8, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		--Vector(-3.2, 1.2, 71.8),
	*/
		//Rear Drivers
		{ Pos = Vector(-1.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-2.7, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-3.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-5.2, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(-7.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-8.5, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-9.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(-13.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-14.6, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-16.1, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-17.4, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Rear Drivers Corner
		{ Pos = Vector(-21, -13.6, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-22.3, -12.9, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.7, -12, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-24.7, -11.4, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-25.8, -10.6, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-26.7, -9.9, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Front Drivers Corner
		{ Pos = Vector(-21, -1.2, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-22.3, -2, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-23.5, -2.7, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-24.8, -3.7, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-26, -4.3, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-26.8, -4.8, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		//Front Drivers
		{ Pos = Vector(-11.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-10.2, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-8.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-7.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },

		{ Pos = Vector(-5.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-4.1, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-2.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-1.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },


		//Deck Lights
		{ Pos = Vector(7.8, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(9.3, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11.1, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(12.5, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(14.2, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Corner
		{ Pos = Vector(35.1, 112.3, 32.4), Ang = Angle(0,-135,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(35.1, 111.8, 34.2), Ang = Angle(0,-135,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(35.1, 113.3, 30.4), Ang = Angle(0,-135,-1), LSTG2 = true, LSTG3 = true },

		//Driver Rear Window
		{ Pos = Vector(-38.3, -43.6, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -41.9, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -40.4, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		//Passenger Rear Window
		{ Pos = Vector(38.3, -43.6, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -41.9, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -40.4, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },

		//Grill
		{ Pos = Vector(-9.7, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-7.4, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Brake
		{ Pos = Vector(33, -108, 39), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-33, -108, 39), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(33, -108, 37), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-33, -108, 37), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		//Front Window
		{ Pos = Vector(1.2, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(2.6, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(3.9, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG3 = true },
	},

	BlueCV1 = {
	/*
		//Lightbar Rear
		{ Pos = Vector(24.1, -9.9, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.05, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(22, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(10.8, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(9.75, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(8.7, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Lightbar Front
		--Vector(27.1, -4.9, 71.8),
		{ Pos = Vector(24.3, -0.8, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(22.95, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(21.6, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },

		{ Pos = Vector(11.1, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(10.15, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(8.8, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
	*/
		//Rear Passenger
		{ Pos = Vector(1.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(2.7, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(3.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(5.2, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(13.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(14.6, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(16.1, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(17.4, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		//Rear Passenger Corner
		{ Pos = Vector(21, -13.6, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(22.3, -12.9, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.7, -12, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(24.7, -11.4, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(25.8, -10.6, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(26.7, -9.9, 71.3), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Front Passenger Corner
		{ Pos = Vector(21, -1.2, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(22.3, -2, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(23.5, -2.7, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(24.8, -3.7, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(26, -4.3, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(26.8, -4.8, 71), Ang = Angle(0,-135,-1), LSTG1 = true, LSTG3 = true },
		//Front Passenger
		{ Pos = Vector(11.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(10.2, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(8.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(7.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },

		//Deck Lights
		{ Pos = Vector(-7.8, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-9.3, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11.1, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-12.5, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-14.2, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Corner
		{ Pos = Vector(-35.1, 112.3, 32.4), Ang = Angle(0,-45,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-35.1, 111.8, 34.2), Ang = Angle(0,-45,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-35.1, 113.3, 30.4), Ang = Angle(0,-45,-1), LSTG2 = true, LSTG3 = true },

		//Driver Rear Window
		{ Pos = Vector(-38.3, -43.6, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -41.9, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -40.4, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		//Passenger Rear Window
		{ Pos = Vector(38.3, -43.6, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -41.9, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -40.4, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },

		//Grill
		{ Pos = Vector(9.7, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(7.4, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },

		//Front Window
		{ Pos = Vector(-1.2, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-2.6, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-3.9, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		//Reverse
		--[[{ Pos = Vector(11, -112, 37), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11, -112, 37),LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11, -112, 39), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11, -112, 39), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11, -112, 35), LSTG2 = true, LSTG3 = true }, ]]--
	},

	RedCV1 = {
	/*
		//Lightbar Rear
		{ Pos = Vector(-24.1, -9.9, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.05, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-22, -10.7, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-10.8, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-9.75, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-8.7, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Lightbar Front
		--Vector(-27.1, -4.9, 71.8),
		{ Pos = Vector(-24.3, -0.8, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-22.95, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-21.6, 0.2, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-11.1, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-10.15, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-8.8, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG3 = true },
	*/
		//Rear Drivers
		{ Pos = Vector(-1.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-2.7, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-3.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-5.2, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(-13.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-14.6, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-16.1, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-17.4, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		//Rear Drivers Corner
		{ Pos = Vector(-21, -13.6, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-22.3, -12.9, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.7, -12, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-24.7, -11.4, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-25.8, -10.6, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-26.7, -9.9, 71.3), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },

		//Front Drivers Corner
		{ Pos = Vector(-21, -1.2, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-22.3, -2, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-23.5, -2.7, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-24.8, -3.7, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-26, -4.3, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-26.8, -4.8, 71), Ang = Angle(0,-45,-1), LSTG1 = true, LSTG3 = true },

		//Front Drivers
		{ Pos = Vector(-11.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-10.2, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-8.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-7.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },

		//Deck Lights
		{ Pos = Vector(7.8, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(9.3, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11.1, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(12.5, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(14.2, -68.9, 50.4), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Corner
		{ Pos = Vector(35.1, 112.3, 32.4), Ang = Angle(0,-135,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(35.1, 111.8, 34.2), Ang = Angle(0,-135,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(35.1, 113.3, 30.4), Ang = Angle(0,-135,-1), LSTG2 = true, LSTG3 = true },

		//Driver Rear Window
		{ Pos = Vector(-38.3, -43.6, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -41.9, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-38.3, -40.4, 47), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		//Passenger Rear Window
		{ Pos = Vector(38.3, -43.6, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -41.9, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(38.3, -40.4, 47), Ang = Angle(0,180,-1), LSTG2 = true, LSTG3 = true },

		//Grill
		{ Pos = Vector(-9.7, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-7.4, 118.9, 32.4), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Brake
		{ Pos = Vector(33, -108, 39), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(33, -108, 37), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },

		//Front Window
		{ Pos = Vector(1.2, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(2.6, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(3.9, 43.5, 48.9), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
	},

	BlueCV2 = {
	/*
		//Lightbar Rear
		{ Pos = Vector(17.9, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(16.55, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(15.5, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(2.15, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(3.2, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(4.25, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Lightbar Front
		{ Pos = Vector(17.9, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(16.55, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(15.2, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
	*/
		//Rear Passenger
		{ Pos = Vector(7.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(8.5, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(9.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(11.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Front Passenger
		{ Pos = Vector(5.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(4.1, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(2.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(1.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
	},

	RedCV2 = {
	/*
		//Lightbar Rear
		{ Pos = Vector(-17.9, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-16.55, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-15.5, -11.6, 71.8), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },

		{ Pos = Vector(-2.15, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-3.2, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-4.25, -12.4, 71.8), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Lightbar Front
		{ Pos = Vector(-17.9, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-16.55, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-15.2, 0.4, 71.8), Ang = Angle(0,-90,-1), LSTG1 = true, LSTG3 = true },
	*/
		//Rear Drivers
		{ Pos = Vector(-7.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-8.5, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-9.8, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-11.3, -13.9, 71.3), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		//Front Drivers
		{ Pos = Vector(-5.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-4.1, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-2.6, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-1.3, -0.8, 71), Ang = Angle(0,-90,-1), LSTG3 = true },

		//Brake
		{ Pos = Vector(-33, -108, 39), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-33, -108, 37), Ang = Angle(0,90,-1), LSTG2 = true, LSTG3 = true },
	},
}

GAMEMODE:RegisterVehicle(VEHICLE)
