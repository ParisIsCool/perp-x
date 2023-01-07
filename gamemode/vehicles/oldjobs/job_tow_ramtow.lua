local VEHICLE 			= {}

VEHICLE.ID 				= '%%++'

VEHICLE.Name 			= "Road Services Utility Truck"
VEHICLE.Make 			= "Dodge"
VEHICLE.Model 			= "Ram 3500"

VEHICLE.Script 			= "ramtow"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {
	{ model = 'models/statetrooper/ram_tow.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255) },
}

VEHICLE.DefaultIceFriction = 0

VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = nil
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass 	= TEAM_ROADSERVICE

VEHICLE.HornNoise 			= 	NORMAL_HORNS

VEHICLE.RevvingSound		= nil
VEHICLE.SpinoutSound		= nil

VEHICLE.TrafficDirect =		{
	directions = {
		{
			{
			},
			{
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Left
				Vector(-15, -33, 128.3),
				Vector(-20, -33, 122.4),
				Vector(-21.2, -33, 110.8),
				Vector(-16.5, -33, 105.8),
				//Right
				Vector(16.5, -33, 128.3),
				Vector(22, -33, 122.4),
				Vector(22.5, -33, 110.8),
				Vector(16.5, -33, 105.8),
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Left
				Vector(-15, -33, 128.3),
				Vector(-20, -33, 122.4),
				Vector(-21.2, -33, 110.8),
				Vector(-16.5, -33, 105.8),
				//Right
				Vector(16.5, -33, 128.3),
				Vector(22, -33, 122.4),
				Vector(22.5, -33, 110.8),
				Vector(16.5, -33, 105.8),
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Left
				Vector(-15, -33, 128.3),
				Vector(-20, -33, 122.4),
				Vector(-21.2, -33, 110.8),
				Vector(-16.5, -33, 105.8),
				//Right
				Vector(16.5, -33, 128.3),
				Vector(22, -33, 122.4),
				Vector(22.5, -33, 110.8),
				Vector(16.5, -33, 105.8),
			},
		},
		{
			{
			},
			{
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Left
				Vector(-15, -33, 128.3),
				Vector(-20, -33, 122.4),
				Vector(-21.2, -33, 110.8),
				Vector(-16.5, -33, 105.8),
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Left
				Vector(-15, -33, 128.3),
				Vector(-20, -33, 122.4),
				Vector(-21.2, -33, 110.8),
				Vector(-16.5, -33, 105.8),
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Left
				Vector(-15, -33, 128.3),
				Vector(-20, -33, 122.4),
				Vector(-21.2, -33, 110.8),
				Vector(-16.5, -33, 105.8),
			
			},
		},
		{
			{
			},
			{
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Right
				Vector(16.5, -33, 128.3),
				Vector(22, -33, 122.4),
				Vector(22.5, -33, 110.8),
				Vector(16.5, -33, 105.8),
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Right
				Vector(16.5, -33, 128.3),
				Vector(22, -33, 122.4),
				Vector(22.5, -33, 110.8),
				Vector(16.5, -33, 105.8),
				//Line
				Vector(0.5, -33, 116.8),
				Vector(-7.5, -33, 116.8),
				Vector(-15, -33, 116.8),
				Vector(17.5, -33, 116.8),
				Vector(8.7, -33, 116.8),
				Vector(-23.5, -33, 116.8),
				Vector(27, -33, 116.8),
				//Right
				Vector(16.5, -33, 128.3),
				Vector(22, -33, 122.4),
				Vector(22.5, -33, 110.8),
				Vector(16.5, -33, 105.8),
			
			},
		}
	} 
}

VEHICLE.SirenColors = 	{
	Amber1 = {
		//Rear Passenger
		{ Pos = Vector(1.3, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(2.7, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(3.8, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(5.2, 5.3, 104.5), Ang = Angle(0,90,-1) },

		{ Pos = Vector(-7.3, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-8.5, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-9.8, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-11.3, 5.3, 104.5), Ang = Angle(0,90,-1) },

		{ Pos = Vector(13.3, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(14.6, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(16.1, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(17.4, 5.3, 104.5), Ang = Angle(0,90,-1) },
		//Rear Passenger Corner
		{ Pos = Vector(21, 5.6, 104.5), Ang = Angle(0,135,-1) },
		{ Pos = Vector(22.3, 6.3, 104.5), Ang = Angle(0,135,-1) },
		{ Pos = Vector(23.7, 7.2, 104.5), Ang = Angle(0,135,-1) },
		{ Pos = Vector(24.7, 7.8, 104.5), Ang = Angle(0,135,-1) },
		{ Pos = Vector(25.8, 8.6, 104.5), Ang = Angle(0,135,-1) },
		{ Pos = Vector(26.7, 9.9, 104.5), Ang = Angle(0,135,-1) },
		//Front Passenger Corner
		{ Pos = Vector(21, 18, 104.3), Ang = Angle(0,-135,-1) },
		{ Pos = Vector(22.3, 17.2, 104.3), Ang = Angle(0,-135,-1) },
		{ Pos = Vector(23.5, 16.5, 104.3), Ang = Angle(0,-135,-1) },
		{ Pos = Vector(24.8, 15.5, 104.3), Ang = Angle(0,-135,-1) },
		{ Pos = Vector(26, 14.9, 104.3), Ang = Angle(0,-135,-1) },
		{ Pos = Vector(26.8, 14.4, 104.3), Ang = Angle(0,-135,-1) },
		//Front Passenger
		{ Pos = Vector(11.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(10.2, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(8.6, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(7.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },

		{ Pos = Vector(-5.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-4.1, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-2.6, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-1.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		
		//Tail Flash
		{ Pos = Vector(-40, -157.5, 59.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-40, -157.5, 61.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-42.1, -157.5, 61.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-42.1, -157.5, 59.9), Ang = Angle(0,90,-1) },

		//Head Flash
		{ Pos = Vector(-38.7, 127.7, 55.1), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-37.6, 127.8, 55.1), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-36.4, 128.1, 55.1), Ang = Angle(0,-90,-1) },


	},

	Amber2 = {
		//Rear Drivers
		{ Pos = Vector(-1.3, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-2.7, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-3.8, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-5.2, 5.3, 104.5), Ang = Angle(0,90,-1) },

		{ Pos = Vector(7.3, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(8.5, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(9.8, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(11.3, 5.3, 104.5), Ang = Angle(0,90,-1) },

		{ Pos = Vector(-13.3, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-14.6, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-16.1, 5.3, 104.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-17.4, 5.3, 104.5), Ang = Angle(0,90,-1) },
		//Rear Drivers Corner
		{ Pos = Vector(-21, 5.6, 104.5), Ang = Angle(0,45,-1) },
		{ Pos = Vector(-22.3, 6.3, 104.5), Ang = Angle(0,45,-1) },
		{ Pos = Vector(-23.7, 7.2, 104.5), Ang = Angle(0,45,-1) },
		{ Pos = Vector(-24.7, 7.8, 104.5), Ang = Angle(0,45,-1) },
		{ Pos = Vector(-25.8, 8.6, 104.5), Ang = Angle(0,45,-1) },
		{ Pos = Vector(-26.7, 9.9, 104.5), Ang = Angle(0,45,-1) },
		//Front Drivers Corner
		{ Pos = Vector(-21, 18, 104.3), Ang = Angle(0,-45,-1) },
		{ Pos = Vector(-22.3, 17.2, 104.3), Ang = Angle(0,-45,-1) },
		{ Pos = Vector(-23.5, 16.5, 104.3), Ang = Angle(0,-45,-1) },
		{ Pos = Vector(-24.8, 15.5, 104.3), Ang = Angle(0,-45,-1) },
		{ Pos = Vector(-26, 14.9, 104.3), Ang = Angle(0,-45,-1) },
		{ Pos = Vector(-26.8, 14.4, 104.3), Ang = Angle(0,-45,-1) },
		//Front Drivers
		{ Pos = Vector(-11.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-10.2, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-8.6, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-7.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },

		{ Pos = Vector(5.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(4.1, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(2.6, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(1.3, 18.3, 104.3), Ang = Angle(0,-90,-1) },
		
		//Tail Flash
		{ Pos = Vector(40, -157.5, 59.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(40, -157.5, 61.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(42.1, -157.5, 61.5), Ang = Angle(0,90,-1) },
		{ Pos = Vector(42.1, -157.5, 59.9), Ang = Angle(0,90,-1) },
		
		//Head Flash
		{ Pos = Vector(38.7, 127.7, 55.1), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(37.6, 127.8, 55.1), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(36.4, 128.1, 55.1), Ang = Angle(0,-90,-1) },
	},
}

GAMEMODE:RegisterVehicle(VEHICLE)