local VEHICLE 			= {}

VEHICLE.ID 				= 'FIR4'

VEHICLE.Name 			= "RESCUE 1"
VEHICLE.Make 			= "Pierce"
VEHICLE.Model 			= "Pierce Rescue 1"

VEHICLE.Script 			= "fireengine"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {
						{ model = 'models/sentry/firerescue.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255) },
}
					
VEHICLE.PassengerSeats 	=	{
								{Vector(31.8, -187.9, 49), Angle(0, 0, 0) },
}
	
VEHICLE.ExitPoints = nil
							
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = nil
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass 	= TEAM_FIREMAN

VEHICLE.PaintText = ""

VEHICLE.HornNoise 			= 	Sound("perp2.5/firetruck_horn.mp3")

VEHICLE.Lights = {
	-- Back Lights
	{ Pos = Vector(-46.1, -225, 71.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector(46.1, -225, 71.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },

	-- Reverse Lights
	{ Pos = Vector(-32.8, -206.5, 43), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },
	{ Pos = Vector(32.8, -206.5, 43), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },

	-- Head Lights
	{ Pos = Vector(-42.3, 236, 62.4), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 95, 0) },
	{ Pos = Vector(42.3, 236, 62.4), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 85, 0)}
}

VEHICLE.RevvingSound		= nil
VEHICLE.SpinoutSound		= nil

VEHICLE.SirenNoise = Sound("perp2.5/firetruck_siren.mp3")
VEHICLE.SirenNoise_DurMod = 8.829360
VEHICLE.SirenNoise_Alt = nil
VEHICLE.SirenColors = {
	Blue = {
		Vector( 0, 208, 126.5 ),
		Vector( -46.7, -225, 115.8 ),
		Vector( 46.7, -225, 115.8 ),
		Vector( -46.2, -226, 58 ),
		Vector( 46.2, -226, 58 ),
	},

	Red = {
		Vector( 6.8, 208, 126.5 ),
		Vector( -6.8, 208, 126.5 ),
	}

	--[[
	White = {
		Vector( -35.1, 245, 40.2 ),
		Vector( 35.1, 245, 40.2 ),
	}
	]]
}

GAMEMODE:RegisterVehicle(VEHICLE)