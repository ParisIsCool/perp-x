local VEHICLE 			= {}

VEHICLE.ID 				= 'G9'

VEHICLE.Name 			= "Dodge Charger 2012 Police"
VEHICLE.Make 			= "Dodge"
VEHICLE.Model 			= "Charger"

VEHICLE.Script 			= "charger12cop"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0
VEHICLE.ELS_Script = "models/tdmcars/emergency/dod_charger12.mdl";

VEHICLE.RequiredClass 	= TEAM_POLICE

--VEHICLE.MarkedCrown 	= true
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
	{model = 'models/tdmcars/emergency/dod_charger12.mdl', skin = '17', name = '', color = Color(0, 0, 0, 255)},
};

VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
	Vector(68,5,13),
	Vector(68,-34,15),
	Vector(68,-14,15),
	Vector(-68,-34,15),
};


VEHICLE.BodyGroups   = {
{Group = 0, Value = 0}, //Dodge
{Group = 1, Value = 0}, //Charger
{Group = 2, Value = 0}, //2012
{Group = 3, Value = 0}, //
{Group = 4, Value = 0}, //
{Group = 5, Value = 0}, //
{Group = 6, Value = 0}, //
{Group = 7, Value = 0}, //push bar
{Group = 8, Value = 0}, //grille leds
{Group = 9, Value = 0}, //front bumper leds
{Group = 10, Value = 0}, //front interior lightbar
{Group = 11, Value = 3}, //lightbar
{Group = 12, Value = 0}, //rear interior lightbar
{Group = 13, Value = 0}, //rear passenger leds
{Group = 14, Value = 0}, //antennas
{Group = 15, Value = 0}, //spotlights
{Group = 16, Value = 1}, //wing
{Group = 17, Value = 0}, //wheel
{Group = 18, Value = 0}, //cage

};


VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = SoundDuration( Sound("perp2.5/SIREN_1.wav") )
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = SoundDuration( Sound("perp2.5/SIREN_2.wav") )


GAMEMODE:RegisterVehicle(VEHICLE)