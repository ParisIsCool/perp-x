local VEHICLE 			= {}

VEHICLE.ID 				= '%%%%%^'

VEHICLE.Name 			= "Highway Maintenance"
VEHICLE.Make 			= "Big"
VEHICLE.Model 			= ""

VEHICLE.Script 			= "gmcvan"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.CustomBodyGroup = nil

VEHICLE.KeepEngineRunning = true
VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {
						{ model = 'models/tdmcars/gmcvan.mdl', skin = '8', name = '', color = Color(0, 0, 0, 255) },
					}
					
--17.9076 29.9254 63.8625

VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
								Vector(-100.2014, 5.7570, 20.5399),
								Vector(100.2014, 5.7570, 20.5399),
							}
							
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = nil
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass 	= TEAM_ROADSERVICE

VEHICLE.BodyGroups = {
	{ Group = 0, Value = 0 },
	{ Group = 1, Value = 0 },
	{ Group = 2, Value = 0 },
	{ Group = 3, Value = 0 },
	{ Group = 4, Value = 0 },

};

VEHICLE.PaintText = "Clunker"

VEHICLE.HornNoise 			= 	"perp2.5/firetruck_horn.mp3"

VEHICLE.Lights = {
	-- Back Lights
	{ Pos = Vector(-42, -124, 27), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector(42, -124, 27), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },

	-- Reverse Lights
	{ Pos = Vector(-42, -124, 27), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },
	{ Pos = Vector(42, -124, 27), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },

	-- Head Lights
	{ Pos = Vector(-40, 107, 34), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 95, 0) },
	{ Pos = Vector(40, 107, 34), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 85, 0)}
}

VEHICLE.RevvingSound		= nil
VEHICLE.SpinoutSound		= nil

VEHICLE.SirenNoise = Sound("npc/metropolice/vo/_comma.wav")
VEHICLE.SirenNoise_DurMod = 0.795
VEHICLE.SirenNoise_Alt = nil
VEHICLE.SirenColors = 	{
	Amber1 = {
		{ Pos = Vector(37, -16, 100), Ang = Angle(0,90,-1) },
		{ Pos = Vector(37, -16, 100), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(37, -16, 100), Ang = Angle(0,90,-1) },
		{ Pos = Vector(37, -16, 100), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(37, -16, 100), Ang = Angle(0,90,-1) },
		{ Pos = Vector(37, -16, 100), Ang = Angle(0,-90,-1) },
	},
	Amber2 = {
		{ Pos = Vector(-37, -16, 100), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-37, -16, 100), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-37, -16, 100), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-37, -16, 100), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-37, -16, 100), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-37, -16, 100), Ang = Angle(0,-90,-1) },
	}
}

VEHICLE.Props = {
}

GAMEMODE:RegisterVehicle(VEHICLE)