local VEHICLE 			= {}

VEHICLE.ID 				= '='

VEHICLE.Name 			= "Mayor's Limo"
VEHICLE.Make 			= "Ford"
VEHICLE.Model 			= "Crown Royal"

VEHICLE.Script 			= "stretch"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {
						{ model = 'models/sentry/static/lincolntclimo.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255) },
					}
					
VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	nil

							
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = nil
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass = TEAM_SECRET_SERVICE

VEHICLE.PaintText = ""

VEHICLE.HornNoise 					= 	NORMAL_HORNS

VEHICLE.Lights = {
	-- Back Lights
	{ Pos = Vector(-25.4767, -198.0278, 39.2658), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector(25.4767, -198.0278, 39.2658), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },

	-- Reverse Lights
	{ Pos = Vector(-25.4767, -198.0278, 39.2658), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },
	{ Pos = Vector(25.4767, -198.0278, 39.2658), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },

	-- Head Lights
	{ Pos = Vector(-29.9323, 167.0016, 35.9562), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 95, 0) },
	{ Pos = Vector(29.9323, 167.0016, 35.9562), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 85, 0)}
}

VEHICLE.RevvingSound		= nil
VEHICLE.SpinoutSound		= nil

GAMEMODE:RegisterVehicle(VEHICLE)