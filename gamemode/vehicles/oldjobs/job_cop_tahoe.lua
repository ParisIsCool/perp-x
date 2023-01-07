local VEHICLE 			= {}

VEHICLE.ID 				= "G4"

VEHICLE.Name 			= 'Chevrolet Tahoe'
VEHICLE.Make 			= "Chevrolet"
VEHICLE.Model 			= "Tahoe"

VEHICLE.Script 			= "chev_tahoe"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_POLICE

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

--VEHICLE.ChiefSub = true

VEHICLE.PaintJobs = {
	{ model = "models/lonewolfie/chev_tahoe_police.mdl", skin = "3", name = "White", color = Color( 255, 255, 255, 255 ) },
}

VEHICLE.RGBColour = true

VEHICLE.PassengerSeats = nil

VEHICLE.ExitPoints = {
	Vector( -90, 4.6053, 6.5827 ),
	Vector( 116.3831, 11.0841, 6.8897 )
}

VEHICLE.RadarPosition = {
	{ Pos = Vector(-5.6, 56, 67.4), Ang = Angle(0, 0, 0), Right = true },
	{ Pos = Vector(-7.5, 56, 67.4), Ang = Angle(0, 0, 0), Center = true },
	{ Pos = Vector(-9.3, 56.5, 67.4), Ang = Angle(0, 0, 0), Left = true },
}

VEHICLE.DefaultIceFriction = 0

VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector( 0, 0, 0 )
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")
VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.342

VEHICLE.BodyGroups = {
	{ Group = 4, Value = 1},
	{ Group = 2, Value = 3},
	{ Group = 3, Value = 1},
	{ Group = 5, Value = 1},
	{ Group = 6, Value = 1},
};

VEHICLE.PolTakeDowns = {
	{ Vector(-16.3, 14.4, 93.3) },
	{ Vector(-17.5, 14.4, 93.3) },
	{ Vector(-17, 14.4, 92.3) },
	{ Vector(16.9, 14.4, 92.3) },
	{ Vector(17.6, 14.4, 93.3) },
	{ Vector(16.3, 14.4, 93.3) },
	{ Vector(-41.8, 62.4, 72.5) }
}
VEHICLE.PolAlleyLeft = {
	{ Vector(-30.6, 6.9, 92.8) }
}
VEHICLE.PolAlleyRight = {
	{ Vector(30.6, 6.9, 92.8) }
}


VEHICLE.RevvingSound = "vehicles/tdmcars/crownvic/rev.wav"
VEHICLE.SpinoutSound = "vehicles/golf/skid_highfriction.wav"

GAMEMODE:RegisterVehicle( VEHICLE )
