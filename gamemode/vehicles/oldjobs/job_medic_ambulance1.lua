local VEHICLE 			= {}

VEHICLE.ID 				= "$"

VEHICLE.Name 			= "Ambulance"
VEHICLE.Make 			= "GMC"
VEHICLE.Model 			= "C5500"

VEHICLE.Script 			= "c5500"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.RGBColour = true


VEHICLE.HornNoise 		= Sound( "perp2.5/FIRE_TRUCK_HORN.wav" )

VEHICLE.PaintJobs = {
	{ model = "models/sentry/c5500_ambu.mdl", skin = '0', name = '', color = Color( 0, 0, 0, 255 ) },
}
					
VEHICLE.PassengerSeats = nil
	
VEHICLE.ExitPoints = {
	Vector( -104, 70, 11 ),
	Vector( 91, 59, 11 ),
}
							
VEHICLE.DefaultIceFriction = 1.5

VEHICLE.ViewAdjustments_FirstPerson = Vector( 4, 0, 2 )

VEHICLE.RequiredClass = TEAM_MEDIC

VEHICLE.PolTakeDowns = {
	{ Vector(-35.1, 107.4, 38.3) },
	{ Vector(35.1, 107.4, 38.3) },
}
VEHICLE.PolAlleyLeft = {
	{ Pos = Vector(-51.2, -136.4, 100.8), LightAngle = Angle( 35, 180, 0) },
	{ Pos = Vector(-51.2, -28.9, 99.5), LightAngle = Angle( 35, 180, 0) }
}
VEHICLE.PolAlleyRight = {
	{ Pos = Vector(51.2, -136.4, 100.8), LightAngle = Angle( 35, 0, 0) },
	{ Pos = Vector(51.2, -28.9, 99.5), LightAngle = Angle( 35, 0, 0) }
}
VEHICLE.SirenColors = 	{
	FTRed1 = {
		//Box
		{ Pos = Vector( 35.7, -175, 106.2 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -51.2, -2.3, 99.5 ), Ang = Angle(0,0,-1) },
		{ Pos = Vector( 51.2, -2.3, 99.5 ), Ang = Angle(0,-180,-1) },
		//Bar
		{ Pos = Vector( -38.6, 12.8, 94.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 38.6, 12.8, 94.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -29.9, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -9.7, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 29.9, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 9.7, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		//Grill
		--Vector( 19.3, 119.4, 42.3 ),
		{ Pos = Vector( -19.3, 119.4, 42.3 ), Ang = Angle(0,-90,-1) },
		//Fenders
		--Vector( 50.9, 90.8, 45.4 ),
		{ Pos = Vector( -50.9, 90.8, 45.4 ), Ang = Angle(0,0,-1) },
	},
	FTRed2 = {
		//Box
		{ Pos = Vector( -35.7, -175, 106.2 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -51.2, -163.3, 100.8 ), Ang = Angle(0,0,-1) },
		{ Pos = Vector( 51.2, -163.3, 100.8 ), Ang = Angle(0,-180,-1) },
	},
	FTWhite1 = {
		//Box
		{ Pos = Vector( -21.7, -175, 106.2 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -51.2, -28.9, 99.5 ), Ang = Angle(0,0,-1) },
		{ Pos = Vector( 51.2, -28.9, 99.5 ), Ang = Angle(0,-180,-1) },
		//Bar
		{ Pos = Vector( -20.3, 12.8, 95.7 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 20.3, 12.8, 95.7 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -38.5, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 38.5, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 19.8, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -19.8, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 0.4, 12.8, 103.4 ), Ang = Angle(0,-90,-1) },
		//Grill
		{ Pos = Vector( 19.3, 119.4, 42.3 ), Ang = Angle(0,-90,-1) },
		--Vector( -19.3, 119.4, 42.3 ),
		//Fenders
		{ Pos = Vector( 50.9, 90.8, 45.4 ), Ang = Angle(0,-180,-1) },
		--Vector( -50.9, 90.8, 45.4 ),

	},
	FTWhite2 = {
		//Box
		{ Pos = Vector( 21.7, -175, 106.2 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -51.2, -136.4, 100.8 ), Ang = Angle(0,0,-1) },
		{ Pos = Vector( 51.2, -136.4, 100.8 ), Ang = Angle(0,-180,-1) },
	}
}

VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/AMBULANCE_WARNING.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.89

GAMEMODE:RegisterVehicle( VEHICLE )