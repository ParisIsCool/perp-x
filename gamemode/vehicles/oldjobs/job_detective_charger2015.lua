--ref lw workshop id is 263574779--

local VEHICLE 			= {}

VEHICLE.ID 				= "G3"

VEHICLE.Name 			= "Dodge"
VEHICLE.Make 			= "Charger"
VEHICLE.Model 			= "Undercover Police"

VEHICLE.Script 			= "dodge_charger_2015_police"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil


VEHICLE.PaintJobs = {

	{ model = "models/lonewolfie/dodge_charger_2015_undercover.mdl", skin = "0", name = "White", color = Color( 0, 0, 0, 255 ) },
}

VEHICLE.RGBColour = true

VEHICLE.PassengerSeats 	=	nil
VEHICLE.ExitPoints = {
	Vector( -90, 4.6053, 6.5827 ),
	Vector( 116.3831, 11.0841, 6.8897 )
}

VEHICLE.RadarPosition = {
	{ Pos = Vector(-1.5, 42, 46.5), Ang = Angle(0, 8, 0), Right = true },
	{ Pos = Vector(-3.5, 42.5, 46.5), Ang = Angle(0, 8, 0), Center = true },
	{ Pos = Vector(-5.5, 43, 46.5), Ang = Angle(0, 8, 0), Left = true },
}
							
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 0)
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass = TEAM_DETECTIVE

VEHICLE.PaintText = ""

VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")

		
VEHICLE.RevvingSound = "vehicles/tdmcars/focusrs/rev.wav"
VEHICLE.SpinoutSound = "vehicles/golf/skid_highfriction.wav"

VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.342
VEHICLE.PolTakeDowns = {
	{ Vector(13.1, -8.1, 72.9) },
	--{ Vector(15, -8.1, 72.9) },
	{ Vector(16.8, -8.1, 72.9) },
	{ Vector(-13.1, -8.1, 72.9) },
	--{ Vector(-15, -8.1, 72.9) },
	{ Vector(-16.8, -8.1, 72.9) },
	{ Vector(-40.7, 40.3, 51.7) },
}	
VEHICLE.PolAlleyLeft = {
	{ Vector(-26.4, -14.2, 72.9) }
}
VEHICLE.PolAlleyRight = {
	{ Vector(26.4, -14.2, 72.9) }
}
VEHICLE.TrafficDirect = {
	directions = {
		{
			{
			},
			{
				Vector(-4.8, -20.5, 72.9),
				Vector(-3.1, -20.5, 72.9),
				Vector(-1.5, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9), 
				Vector(3.1, -20.5, 72.9), 
				Vector(1.5, -20.5, 72.9),
			},
			{
				Vector(-4.8, -20.5, 72.9),
				Vector(-3.1, -20.5, 72.9),
				Vector(-1.5, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9), 
				Vector(3.1, -20.5, 72.9), 
				Vector(1.5, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9), 
				Vector(-7.3, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9),
				Vector(7.3, -20.5, 72.9),
			},
			{
				Vector(-4.8, -20.5, 72.9),
				Vector(-3.1, -20.5, 72.9),
				Vector(-1.5, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9), 
				Vector(3.1, -20.5, 72.9), 
				Vector(1.5, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9), 
				Vector(-7.3, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9),
				Vector(7.3, -20.5, 72.9),
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
			}
		},
		{
			{
			},
			{
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
			},
			{
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9),
				Vector(7.3, -20.5, 72.9),
			},
			{
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9),
				Vector(7.3, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9), 
				Vector(3.1, -20.5, 72.9), 
				Vector(1.5, -20.5, 72.9),
			},
			{
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9),
				Vector(7.3, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9), 
				Vector(3.1, -20.5, 72.9), 
				Vector(1.5, -20.5, 72.9),
				Vector(-4.8, -20.5, 72.9),
				Vector(-3.1, -20.5, 72.9),
				Vector(-1.5, -20.5, 72.9),
			},
			{
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9),
				Vector(7.3, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9), 
				Vector(3.1, -20.5, 72.9), 
				Vector(1.5, -20.5, 72.9),
				Vector(-4.8, -20.5, 72.9),
				Vector(-3.1, -20.5, 72.9),
				Vector(-1.5, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9), 
				Vector(-7.3, -20.5, 72.9),
			},
			{
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9),
				Vector(7.3, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9), 
				Vector(3.1, -20.5, 72.9), 
				Vector(1.5, -20.5, 72.9),
				Vector(-4.8, -20.5, 72.9),
				Vector(-3.1, -20.5, 72.9),
				Vector(-1.5, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9), 
				Vector(-7.3, -20.5, 72.9),
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
			}
		},
		{
			{
			},
			{
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
			},         
			{          
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9),
				Vector(-7.3, -20.5, 72.9),
			},         
			{          
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9),
				Vector(-7.3, -20.5, 72.9),
				Vector(-4.8, -20.5, 72.9), 
				Vector(-3.1, -20.5, 72.9), 
				Vector(-1.5, -20.5, 72.9),
			},
			{   
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9),
				Vector(-7.3, -20.5, 72.9),
				Vector(-4.8, -20.5, 72.9), 
				Vector(-3.1, -20.5, 72.9), 
				Vector(-1.5, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9),
				Vector(3.1, -20.5, 72.9),
				Vector(1.5, -20.5, 72.9),
			},
			{
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9),
				Vector(-7.3, -20.5, 72.9),
				Vector(-4.8, -20.5, 72.9), 
				Vector(-3.1, -20.5, 72.9), 
				Vector(-1.5, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9),
				Vector(3.1, -20.5, 72.9),
				Vector(1.5, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9), 
				Vector(7.3, -20.5, 72.9),
			},
			{
				Vector(-16.1, -20.5, 72.9),
				Vector(-14.4, -20.5, 72.9),
				Vector(-12.8, -20.5, 72.9),
				Vector(-10.4, -20.5, 72.9),
				Vector(-8.9, -20.5, 72.9),
				Vector(-7.3, -20.5, 72.9),
				Vector(-4.8, -20.5, 72.9), 
				Vector(-3.1, -20.5, 72.9), 
				Vector(-1.5, -20.5, 72.9),
				Vector(4.8, -20.5, 72.9),
				Vector(3.1, -20.5, 72.9),
				Vector(1.5, -20.5, 72.9),
				Vector(10.4, -20.5, 72.9),
				Vector(8.9, -20.5, 72.9), 
				Vector(7.3, -20.5, 72.9),
				Vector(16.1, -20.5, 72.9),
				Vector(14.4, -20.5, 72.9),
				Vector(12.8, -20.5, 72.9),
			}
		}
	}	
}



VEHICLE.SirenColorsStages = {
	BlueC = {
		//Lightbar Front
		{ Pos = Vector(10.5, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(8.9, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(7.3, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-4.8, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-3, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-1.5, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Right Corners
		{ Pos = Vector(20.2, -8.6, 72.9), Ang = Angle(0,-135,-1), LSTG3 = true },
		{ Pos = Vector(21.8, -9.6, 72.9), Ang = Angle(0,-135,-1), LSTG3 = true },
		{ Pos = Vector(23.7, -10.8, 72.9), Ang = Angle(0,-135,-1), LSTG3 = true },
		{ Pos = Vector(25, -11.9, 72.9), Ang = Angle(0,-135,-1), LSTG3 = true },
		{ Pos = Vector(24.9, -16.7, 72.9), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.8, -17.4, 72.9), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(21.7, -18.7, 72.9), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(19.9, -19.7, 72.9), Ang = Angle(0,135,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Lightbar Back
		{ Pos = Vector(-16.1, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-14.4, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-12.8, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(10.4, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(8.9, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(7.3, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-4.8, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-3.1, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-1.5, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Rear Window
		{ Pos = Vector(16.6, -60.2, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(14.8, -60.2, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-18.5, -60, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-20.4, -60, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },

		//Tail
		{ Pos = Vector(29.3, -115.1, 40), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Front Turn
		{ Pos = Vector(24.9, 109.1, 30.2), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		//Front Window
		{ Pos = Vector(-25, 22.5, 60.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-23, 22.5, 60.3), Ang = Angle(0,-90,-1), LSTG3 = true },
	},

	BlueC2 = {
		//Lightbar Front
		{ Pos = Vector(-10.5, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-8.9, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-7.3, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(4.8, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(3, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(1.5, -8.1, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-20.2, -8.6, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-21.8, -9.6, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-23.7, -10.8, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-25, -11.9, 72.9), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Left Corners
		{ Pos = Vector(-20.2, -8.6, 72.9), Ang = Angle(0,-45,-1), LSTG3 = true },
		{ Pos = Vector(-21.8, -9.6, 72.9), Ang = Angle(0,-45,-1), LSTG3 = true },
		{ Pos = Vector(-23.7, -10.8, 72.9), Ang = Angle(0,-45,-1), LSTG3 = true },
		{ Pos = Vector(-25, -11.9, 72.9), Ang = Angle(0,-45,-1), LSTG3 = true },
		{ Pos = Vector(-24.9, -16.7, 72.9), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.8, -17.4, 72.9), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-21.7, -18.7, 72.9), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-19.9, -19.7, 72.9), Ang = Angle(0,45,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Lightbar Back
		{ Pos = Vector(16.1, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(14.4, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(12.8, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-10.4, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-8.9, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-7.3, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(4.8, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(3.1, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(1.5, -20.5, 72.9), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Rear Window
		{ Pos = Vector(-15.4, -60, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(-13.1, -60, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(20, -60.2, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },
		{ Pos = Vector(21.7, -60.2, 63), Ang = Angle(0,90,-1), LSTG1 = true, LSTG3 = true },
		//Tail
		{ Pos = Vector(-29.3, -115.1, 40), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Front Turn
		{ Pos = Vector(-24.9, 109.1, 30.2), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		//Front Window
		{ Pos = Vector(25, 22.5, 60.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(23, 22.5, 60.3), Ang = Angle(0,-90,-1), LSTG3 = true },
	}
}


GAMEMODE:RegisterVehicle( VEHICLE )