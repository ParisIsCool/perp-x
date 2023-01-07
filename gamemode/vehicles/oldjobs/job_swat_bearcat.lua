local VEHICLE 			= {}

VEHICLE.ID 				= '#'

VEHICLE.Name 			= "SWAT Van"
VEHICLE.Make 			= "Lenco"
VEHICLE.Model 			= "Bearcat"

VEHICLE.Script 			= "bearcat_g3"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.PaintJobs = {
						{ model = 'models/perrynsvehicles/bearcat_g3/bearcat_g3.mdl', skin = '3', name = '', color = Color(0, 0, 0, 255) },
					}
					
VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
								Vector(108.4158, 53.3863, 2.2271),
								Vector(-108.4158, 53.3863, 2.2271),
								Vector(-62.5363, -185.0254, 2.8965),
								Vector(62.5363, -185.0254, 2.8965),
							}
							
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 10)
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass 	= TEAM_SWAT

VEHICLE.PaintText = ""

VEHICLE.RevvingSound		= nil
VEHICLE.SpinoutSound		= nil

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
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.342

VEHICLE.HornNoise 			= 	Sound("perp2.5/FIRE_TRUCK_HORN.wav")
VEHICLE.SirenColors = 	{
							
	Blue = {
		//Back
		{ Pos = Vector(-44, -134.7, 93.6), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-42.2, -134.7, 93.6), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-40.4, -134.7, 93.6), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-42.1, -134.7, 91.8), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-42.1, -134.7, 95.2), Ang = Angle(0,90,-1) },
		
		//Rear Corner
		{ Pos = Vector(29.4, -102.1, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(29.1, -112.8, 113.2), Ang = Angle(0,90,-1) },
		
		//Back Rear Lightbar
		{ Pos = Vector(27, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(24.7, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(22.2, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(12.6, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(10.4, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(8.6, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(5.4, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(3.8, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(2, -114.2, 113.2), Ang = Angle(0,90,-1) },
		
		//Front Front Ltbr
		{ Pos = Vector(1.9, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(3.8, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(5.6, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(8.7, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(10.5, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(12.1, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(22.5, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(24.4, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(26.3, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		//Front Corner
		{ Pos = Vector(29.1, 51.4, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(29.1, 40.3, 113.2), Ang = Angle(0,-90,-1) },
		
		//Front Grill
		{ Pos = Vector(22.3, 137, 50.4), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(23.7, 137, 50.4), Ang = Angle(0,-90,-1) },
	},

	Red = {
		//Back
		{ Pos = Vector(41.9, -134.7, 95.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(41.9, -134.6, 93.7), Ang = Angle(0,90,-1) },
		{ Pos = Vector(41.9, -134.6, 91.9), Ang = Angle(0,90,-1) },
		{ Pos = Vector(44, -134.6, 93.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(39.9, -134.6, 93.5), Ang = Angle(0,90,-1) },
		
		//Back Rear Lightbar
		{ Pos = Vector(-1.2, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-3.1, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-5.1, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-8, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-9.8, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-11.7, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-22.5, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-24.7, -114.2, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-26.9, -114.2, 113.2), Ang = Angle(0,90,-1) },
		//Back Corner
		{ Pos = Vector(-29.4, -113, 113.2), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-29.4, -102.1, 113.2), Ang = Angle(0,90,-1) },
		
		//Front Corner
		{ Pos = Vector(-29.4, 40.6, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-29.4, 51, 113.2), Ang = Angle(0,-90,-1) },
		//Front Ltbr
		{ Pos = Vector(-26.9, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-25.2, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-23, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-11.8, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-10.2, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-8.4, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-5.4, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-3.7, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-1.8, 52.3, 113.2), Ang = Angle(0,-90,-1) },
		//Left
		{ Pos = Vector(-53.5, -35.7, 97.6), Ang = Angle(0,0,-1) },
		{ Pos = Vector(-53.5, -37.1, 97.6), Ang = Angle(0,0,-1) },
		{ Pos = Vector(-53.5, -34.2, 97.6), Ang = Angle(0,0,-1) },
		//Right
		{ Pos = Vector(53.5, -35.7, 97.6), Ang = Angle(0,-180,-1) },
		{ Pos = Vector(53.5, -37.1, 97.6), Ang = Angle(0,-180,-1) },
		{ Pos = Vector(53.5, -34.2, 97.6), Ang = Angle(0,-180,-1) },
		//Grill Lights
		{ Pos = Vector(-24.3, 137, 50.4), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-22.6, 137, 50.4), Ang = Angle(0,-90,-1) },
	},
}

GAMEMODE:RegisterVehicle(VEHICLE)