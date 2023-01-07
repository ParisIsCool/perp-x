local VEHICLE 			= {}

VEHICLE.ID 				= '%%%'

VEHICLE.Name 			= "Road Services Truck"
VEHICLE.Make 			= "Big"
VEHICLE.Model 			= ""

VEHICLE.Script 			= "bigtow"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {
						{ model = 'models/sentry/p379_tow.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255) },
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
	{
		Model = "models/sentry/p379_towequip.mdl",
		Scale = 1,
		Pos = Vector(0, -1, 0),
		Ang = Angle( 0, 0, 0),
		BodyGroups = {
			{ 1, 2 }
		},
	},
	{
		Model = "models/sentry/p379_towlift.mdl",
		Scale = 1,
		Pos = Vector(0, -324.5, 20.5),
		Ang = Angle( 0, 0, 0),
		BodyGroups = {
			{ 1, 1 }
		},
	},
	{
		Model = "models/lonewolfie/whelenliberty_impala.mdl",
		Scale = 1,
		Pos = Vector(0, -9.3, 125),
		Ang = Angle( 0, -90, 0),
		Skin = 1,
		BodyGroups = {
			{ 1, 1 }
		},
	},
}

GAMEMODE:RegisterVehicle(VEHICLE)