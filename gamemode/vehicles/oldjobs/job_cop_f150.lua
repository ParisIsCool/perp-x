local VEHICLE 			= {}

VEHICLE.ID 				= 'G11'

VEHICLE.Name 			= "Police Car"
VEHICLE.Make 			= "Ford"
VEHICLE.Model 			= "F-150 COP"

VEHICLE.Script 			= "15f150_cop"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

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
	{model = 'models/stcars/15f150_cop.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
};

VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
	Vector(68,5,13),
	Vector(68,-34,15),
	Vector(68,-14,15),
	Vector(-68,-34,15),
};


VEHICLE.BodyGroups = {
	{ Group = 1, Value = 2 },
	{ Group = 2, Value = 1 },
	{ Group = 3, Value = 1 },
	{ Group = 4, Value = 0 },
};

--[[VEHICLE.Props = {
	{
		Model = "models/lonewolfie/ledlightholder.mdl",
		Scale = .91,
		Pos = Vector(-38, -42, 47),
		Ang = Angle( -15, 180, 0),
	},
	{
		Model = "models/lonewolfie/ledlightholder.mdl",
		Scale = .91,
		Pos = Vector(38, -42, 47),
		Ang = Angle( -15, 0, 0),
	},
	{
		Model = "models/lonewolfie/whelenavenger_double.mdl",
		Scale = 1,
		Pos = Vector(0, 44.4, 49.8),
		Ang = Angle( 0, 90, 0),
	},
}]]

GAMEMODE:RegisterVehicle(VEHICLE)