local VEHICLE 			= {}

VEHICLE.ID 				= "$$"

VEHICLE.Name 			= "Ambulance"
VEHICLE.Make 			= "Ford"
VEHICLE.Model 			= "F350"

VEHICLE.Script 			= "ford_f350_ambu"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.RGBColour = true

VEHICLE.HornNoise 		= Sound( "perp2.5/FIRE_TRUCK_HORN.wav" )

VEHICLE.PaintJobs = {
	{ model = "models/LoneWolfie/ford_f350_ambu.mdl", skin = '2', name = '', color = Color( 0, 0, 0, 255 ) },
}

VEHICLE.PassengerSeats = nil

VEHICLE.ExitPoints = {
	Vector( -104, 70, 11 ),
	Vector( 91, 59, 11 ),
}

VEHICLE.DefaultIceFriction = 0

VEHICLE.ViewAdjustments_FirstPerson = nil

VEHICLE.RequiredClass = TEAM_MEDIC

VEHICLE.AmbDoorLights = {
		{ Pos = Vector(-45.55,-171.3,102.9), LightAngle = Angle(35,-90,0) }, -- 5
		{ Pos = Vector(43.5,-171.3,102.804), LightAngle = Angle(35,-90,0) }, -- 6
}

VEHICLE.PolTakeDowns = true

VEHICLE.PolAlleyLeft = {
		{ Pos = Vector(-59.1,-19.74,113.120), LightAngle = Angle(35,180,0) }, -- 16 Left
		{ Pos = Vector(-59.1,-133.363,113.126), LightAngle = Angle(35,180,0) }, -- 18 Left
}
VEHICLE.PolAlleyRight = {
		{ Pos = Vector(56.952,-133.363,113.126), LightAngle = Angle(35,0,0) }, -- 17 Right
		{ Pos = Vector(57.455,-58.272,113.120), LightAngle = Angle(35,0,0) }, -- 15 Right
}

VEHICLE.SirenColors = 	{
	FTRed = {
		--Rear Squares
		{ Pos = Vector(43.5,-171.3,116.465), Ang = Angle(0,90,0) }, -- 7
		{ Pos = Vector(-45.638,-171.3,116.465), Ang = Angle(0,90,0) }, -- 8
		{ Pos = Vector(43.5,-171.3,116.465), Ang = Angle(0,90,0) }, -- 7
		{ Pos = Vector(-45.638,-171.3,116.465), Ang = Angle(0,90,0) }, -- 8

		--Lightbar Rear
		{ Pos = Vector(3,-172.9,118.808), Ang = Angle(0,90,0) }, -- 31 Left
		{ Pos = Vector(-2.5,-172.9,118.808), Ang = Angle(0,90,0) }, -- 32 Left
		{ Pos = Vector(15.2,-172.9,118.808), Ang = Angle(0,90,0) }, -- 35 Left
		{ Pos = Vector(-14.7,-172.9,118.808), Ang = Angle(0,90,0) }, -- 36 Left
		{ Pos = Vector(21.3,-172.9,118.808), Ang = Angle(0,90,0) }, -- 37 Left
		{ Pos = Vector(-20.8,-172.9,118.808), Ang = Angle(0,90,0) }, -- 38 Left
		{ Pos = Vector(3,-172.9,118.808), Ang = Angle(0,90,0) }, -- 31 Left
		{ Pos = Vector(-2.5,-172.9,118.808), Ang = Angle(0,90,0) }, -- 32 Left
		{ Pos = Vector(15.2,-172.9,118.808), Ang = Angle(0,90,0) }, -- 35 Left
		{ Pos = Vector(-14.7,-172.9,118.808), Ang = Angle(0,90,0) }, -- 36 Left
		{ Pos = Vector(21.3,-172.9,118.808), Ang = Angle(0,90,0) }, -- 37 Left
		{ Pos = Vector(-20.8,-172.9,118.808), Ang = Angle(0,90,0) }, -- 38 Left

		--Sidesquares
		{ Pos = Vector(57,2.42,113.127), Ang = Angle(0,180,0) }, -- 13 Right
		{ Pos = Vector(-59.1,2.42,113.127), Ang = Angle(0,0,0) }, -- 14 Left
		{ Pos = Vector(56.952,-155.461,113.126), Ang = Angle(0,180,0) }, -- 19 Right
		{ Pos = Vector(-59.1,-155.461,113.126), Ang = Angle(0,0,0) }, -- 20 Left
		{ Pos = Vector(57,2.42,113.127), Ang = Angle(0,180,0) }, -- 13 Right
		{ Pos = Vector(-59.1,2.42,113.127), Ang = Angle(0,0,0) }, -- 14 Left
		{ Pos = Vector(56.952,-155.461,113.126), Ang = Angle(0,180,0) }, -- 19 Right
		{ Pos = Vector(-59.1,-155.461,113.126), Ang = Angle(0,0,0) }, -- 20 Left
		{ Pos = Vector(57,2.42,113.127), Ang = Angle(0,180,0) }, -- 13 Right
		{ Pos = Vector(-59.1,2.42,113.127), Ang = Angle(0,0,0) }, -- 14 Left
		{ Pos = Vector(56.952,-155.461,113.126), Ang = Angle(0,180,0) }, -- 19 Right
		{ Pos = Vector(-59.1,-155.461,113.126), Ang = Angle(0,0,0) }, -- 20 Left

		--Grill Lights
		{ Pos = Vector(14.55,156.1,50.94), Ang = Angle(0,-90,0) }, -- 12
		{ Pos = Vector(14.55,156.1,50.94), Ang = Angle(0,-90,0) }, -- 12

		--Front Squares
		{ Pos = Vector(-45.6,21.75,108.65), Ang = Angle(0,-90,0) }, -- 1
		{ Pos = Vector(43.5,21.75,108.65), Ang = Angle(0,-90,0) }, -- 2
		{ Pos = Vector(-45.6,21.75,108.65), Ang = Angle(0,-90,0) }, -- 1
		{ Pos = Vector(43.5,21.75,108.65), Ang = Angle(0,-90,0) }, -- 2

		--Lightbar Front
		{ Pos = Vector(37.708,26.9,117.13), Ang = Angle(0,-90,0) }, -- 21 Right
		{ Pos = Vector(-38.6,26.9,117.13), Ang = Angle(0,-90,0) }, -- 22 Left
		{ Pos = Vector(17.219,26.9,117.13), Ang = Angle(0,-90,0) }, -- 23 Right
		{ Pos = Vector(-18.2,26.9,117.13), Ang = Angle(0,-90,0) }, -- 24 Left
		{ Pos = Vector(37.708,26.9,117.13), Ang = Angle(0,-90,0) }, -- 21 Right
		{ Pos = Vector(-38.6,26.9,117.13), Ang = Angle(0,-90,0) }, -- 22 Left
		{ Pos = Vector(17.219,26.9,117.13), Ang = Angle(0,-90,0) }, -- 23 Right
		{ Pos = Vector(-18.2,26.9,117.13), Ang = Angle(0,-90,0) }, -- 24 Left

	},
	FTWhite = {
		--Rear Squares
		{ Pos = Vector(-45.638,-171.3,120.311), Ang = Angle(0,90,0) }, -- 5
		{ Pos = Vector(43.5,-171.3,120.311), Ang = Angle(0,90,0) }, -- 6
		{ Pos = Vector(-45.638,-171.3,120.311), Ang = Angle(0,90,0) }, -- 5
		{ Pos = Vector(43.5,-171.3,120.311), Ang = Angle(0,90,0) }, -- 6

		--Rear Square Single
		{ Pos = Vector(-45.55,-171.3,102.9), Ang = Angle(0,90,0) }, -- 9
		{ Pos = Vector(43.5,-171.3,102.804), Ang = Angle(0,90,0) }, -- 10
		{ Pos = Vector(-45.55,-171.3,102.9), Ang = Angle(0,90,0) }, -- 9
		{ Pos = Vector(43.5,-171.3,102.804), Ang = Angle(0,90,0) }, -- 10
		{ Pos = Vector(-45.55,-171.3,102.9), Ang = Angle(0,90,0) }, -- 9
		{ Pos = Vector(43.5,-171.3,102.804), Ang = Angle(0,90,0) }, -- 10

		--Lightbar Rear
		{ Pos = Vector(9.1,-172.9,118.808), Ang = Angle(0,90,0) }, -- 33 Left
		{ Pos = Vector(-8.6,-172.9,118.808), Ang = Angle(0,90,0) }, -- 34 Left
		{ Pos = Vector(9.1,-172.9,118.808), Ang = Angle(0,90,0) }, -- 33 Left
		{ Pos = Vector(-8.6,-172.9,118.808), Ang = Angle(0,90,0) }, -- 34 Left

		--Sidesquares
		{ Pos = Vector(57.455,-58.272,113.120), Ang = Angle(0,180,0) }, -- 15 Right
		{ Pos = Vector(-59.1,-19.74,113.120), Ang = Angle(0,0,0) }, -- 16 Left
		{ Pos = Vector(56.952,-133.363,113.126), Ang = Angle(0,180,0) }, -- 17 Right
		{ Pos = Vector(-59.1,-133.363,113.126), Ang = Angle(0,0,0) }, -- 18 Left
		{ Pos = Vector(57.455,-58.272,113.120), Ang = Angle(0,180,0) }, -- 15 Right
		{ Pos = Vector(-59.1,-19.74,113.120), Ang = Angle(0,0,0) }, -- 16 Left
		{ Pos = Vector(56.952,-133.363,113.126), Ang = Angle(0,180,0) }, -- 17 Right
		{ Pos = Vector(-59.1,-133.363,113.126), Ang = Angle(0,0,0) }, -- 18 Left
		{ Pos = Vector(57.455,-58.272,113.120), Ang = Angle(0,180,0) }, -- 15 Right
		{ Pos = Vector(-59.1,-19.74,113.120), Ang = Angle(0,0,0) }, -- 16 Left
		{ Pos = Vector(56.952,-133.363,113.126), Ang = Angle(0,180,0) }, -- 17 Right
		{ Pos = Vector(-59.1,-133.363,113.126), Ang = Angle(0,0,0) }, -- 18 Left

		--Grill Lights
		{ Pos = Vector(-14.55,156.1,50.94), Ang = Angle(0,-90,0) }, -- 11
		{ Pos = Vector(-14.55,156.1,50.94), Ang = Angle(0,-90,0) }, -- 11

		--Front Squares
		{ Pos = Vector(-45.6,21.75,105), Ang = Angle(0,-90,0) }, -- 3
		{ Pos = Vector(43.5,21.75,105), Ang = Angle(0,-90,0) }, -- 4
		{ Pos = Vector(27.961,26.9,117.13), Ang = Angle(0,-90,0) }, -- 25 Right
		{ Pos = Vector(-28.961,26.9,117.13), Ang = Angle(0,-90,0) }, -- 26 Left
		{ Pos = Vector(-45.6,21.75,105), Ang = Angle(0,-90,0) }, -- 3
		{ Pos = Vector(43.5,21.75,105), Ang = Angle(0,-90,0) }, -- 4
		{ Pos = Vector(27.961,26.9,117.13), Ang = Angle(0,-90,0) }, -- 25 Right
		{ Pos = Vector(-28.961,26.9,117.13), Ang = Angle(0,-90,0) }, -- 26 Left

		--Lightbar Front
		{ Pos = Vector(7.832,26.632,116.62), Ang = Angle(0,-90,0) }, -- 27 Right
		{ Pos = Vector(-8.832,26.632,116.62), Ang = Angle(0,-90,0) }, -- 28 Left
		{ Pos = Vector(47.368,26.632,116.62), Ang = Angle(0,-90,0) }, -- 29 Right
		{ Pos = Vector(-48.368,26.632,116.62), Ang = Angle(0,-90,0) }, -- 30 Left
		{ Pos = Vector(7.832,26.632,116.62), Ang = Angle(0,-90,0) }, -- 27 Right
		{ Pos = Vector(-8.832,26.632,116.62), Ang = Angle(0,-90,0) }, -- 28 Left
		{ Pos = Vector(47.368,26.632,116.62), Ang = Angle(0,-90,0) }, -- 29 Right
		{ Pos = Vector(-48.368,26.632,116.62), Ang = Angle(0,-90,0) }, -- 30 Left

	},
}

VEHICLE.SirenNoise = Sound("sirens/emv_wail.wav")
VEHICLE.SirenNoise_DurMod = SoundDuration( Sound("sirens/emv_wail.wav") )
VEHICLE.SirenNoise_Alt = Sound("sirens/emv_yelp.wav")
VEHICLE.SirenNoise_Alt_DurMod = SoundDuration( Sound("sirens/emv_yelp.wav") )

GAMEMODE:RegisterVehicle( VEHICLE )
