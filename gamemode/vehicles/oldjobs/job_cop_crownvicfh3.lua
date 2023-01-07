local VEHICLE 			= {}

VEHICLE.ID 				= 'G'

VEHICLE.Name 			= "Ford Crown Victoria"
VEHICLE.Make 			= "Ford"
VEHICLE.Model 			= "2011 Crown Vic"

VEHICLE.Script 			= "for_crownvic_fh3"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_POLICE
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

VEHICLE.PaintJobs = {
	{model = 'models/tdmcars/emergency/for_crownvic_fh3.mdl', skin = '5', name = '', color = Color(0, 0, 0, 255)},
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
{Group = 12, Value = 2}, //	PUSH BAR 					(0:Simple 1:Wrap 2:CHP 3:None)
{Group = 13, Value = 1}, //	GRILLE 						(0/1)
{Group = 14, Value = 1}, //	MIRROR LIGHTS 				(0/1)
{Group = 15, Value = 2}, //	LIGHT BAR					(0:None 1:Halogen 2:CHP 3:Solex 4:LAPD)
{Group = 16, Value = 1}, //	INTERIOR EQUIPMENT			(0/1)
{Group = 17, Value = 2}, //	TOP SIREN SLOT (Control)	(0-3 Who cares...)
{Group = 18, Value = 0}, //	BOTTOM SIREN SLOT (Control)	(0/1 Who cares...)
{Group = 19, Value = 1}, //	CAGE						(0:Wall 1:Bars 2:None)
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

VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = SoundDuration( Sound("perp2.5/SIREN_1.wav") )
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = SoundDuration( Sound("perp2.5/SIREN_2.wav") )


GAMEMODE:RegisterVehicle(VEHICLE)