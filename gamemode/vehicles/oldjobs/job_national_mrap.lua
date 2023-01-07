local VEHICLE 			= {}

VEHICLE.ID 				= 'nat1'

VEHICLE.Name 			= "NG MRAP"
VEHICLE.Make 			= "MRAP"
VEHICLE.Model 			= "MRAP"

VEHICLE.Script 			= "talmaxxpro"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_NATIONAL

VEHICLE.KeepEngineRunning = true
--VEHICLE.CustomBodyGroup = 1
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
	{model = 'models/talonvehicles/mrap_maxxpro.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
};

VEHICLE.BodyGroups = {
	{ Group = 1, Value = 0 },
	{ Group = 2, Value = 1 },
	{ Group = 3, Value = 0 },
	{ Group = 4, Value = 1 },
	{ Group = 5, Value = 0 },
	{ Group = 6, Value = 1 },
	{ Group = 7, Value = 0 },
};

VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
	Vector(68,5,13),
	Vector(68,-34,15),
	Vector(68,-14,15),
	Vector(-68,-34,15),
};

VEHICLE.PolTakeDowns = {
	{ Vector(-41.3, 57.2, 112.3) },
	{ Vector(41, 57.2, 112.3) },
}
VEHICLE.PolAlleyLeft = {
	{ Pos = Vector(-53.1, -35.8, 93.5), LightAngle = Angle( 35, 180, 0) }
}
VEHICLE.PolAlleyRight = {
	{ Pos = Vector(53.1, -35.8, 93.5), LightAngle = Angle( 35, 0, 0) }
}

VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = SoundDuration( Sound("perp2.5/SIREN_1.wav") )
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = SoundDuration( Sound("perp2.5/SIREN_2.wav") )


GAMEMODE:RegisterVehicle(VEHICLE)