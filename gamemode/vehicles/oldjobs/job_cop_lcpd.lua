local VEHICLE 			= {}

VEHICLE.ID 				= '!'

VEHICLE.Name 			= "Police Car"
VEHICLE.Make 			= "Ford"
VEHICLE.Model 			= "Crown Royal"

VEHICLE.Script 			= "cop"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.PaintJobs = {
						{ model = 'models/sickness/lcpddr.mdl', skin = '1', name = '', color = Color(0, 0, 0, 255) },
					}
					
VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
								Vector(-103.0634, -23.6848, 11.1878),
								Vector(68.9006, -23.6848, 11.1878),
								Vector(68.9006, -14.02453, 11.1878),
								Vector(-103.0634, -14.02453, 11.1878),
							}
							
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector(4, 0, 2)
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass 	= TEAM_POLICE

VEHICLE.HornNoise 			= 	NORMAL_HORNS

VEHICLE.PaintText = ""

VEHICLE.Lights = {
	-- Back Lights
	{ Pos = Vector(-25.072500228882, -120.67079925537, 36), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector(25.072500228882, -120.67079925537, 36), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },

	-- Reverse Lights
	{ Pos = Vector(-25.072500228882, -120.67079925537, 36), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },
	{ Pos = Vector(25.072500228882, -120.67079925537, 36), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },

	-- Head Lights
	{ Pos = Vector(-25.800399780273, 104, 31), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 95, 0) },
	{ Pos = Vector(25.800399780273, 104, 31), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 85, 0)}
}

VEHICLE.RevvingSound		= nil
VEHICLE.SpinoutSound		= nil

VEHICLE.SirenNoise = Sound("perp2.5/siren_long.mp3")
VEHICLE.SirenNoise_DurMod = 4.628410 //0.795
VEHICLE.SirenNoise_Alt = Sound("perp2.5/siren_wail.mp3")
VEHICLE.SirenNoise_Alt_DurMod = 2.949440 //1
VEHICLE.SirenColors = 	{
							{Color(0, 0, 255, 255), Vector(20.7874, -15.7817, 70.4175) },
							{Color(255, 0, 0, 255), Vector(-20.2693, -15.7817, 70.4848) },
						}

GAMEMODE:RegisterVehicle(VEHICLE)