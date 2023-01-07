local VEHICLE 			= {}

VEHICLE.ID 				= "CVFD"

VEHICLE.Name 			= "Mitsubishi Evo Lancer X Police"
VEHICLE.Make 			= "Mitsubishi"
VEHICLE.Model 			= "Evo Lancer X Police"

VEHICLE.Script 			= "mitsu_evox"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.PaintJobs = {
	{ model = "models/tdmcars/emergency/mitsu_evox.mdl", skin = "2", name = "White", color = Color( 255, 255, 255, 255 ) },
}

VEHICLE.RGBColour = true

VEHICLE.PassengerSeats = nil

VEHICLE.ExitPoints = {
	Vector( -90, 4.6053, 6.5827 ),
	Vector( 116.3831, 11.0841, 6.8897 )
}

VEHICLE.DefaultIceFriction = 0

VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 0)
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.RequiredClass = TEAM_POLICE

VEHICLE.PaintText = ""

VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")

VEHICLE.UnderglowPositions = {
	{ Vector( 0, 35, 5 ) },
	{ Vector( 0, -35, 5 ) }
}

VEHICLE.Lights = {
	{ Pos = Vector( -31.2, -105.3, 52.1 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector( 29.2, -105.3, 52.1 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector( -25.7, -105.3, 51.4 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector( 23.7, -105.3, 51.4 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector( -5.7, -105.8, 56.3 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.2, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector( 3.7, -105.8, 56.3 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.2, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
	{ Pos = Vector( -1, -105.8, 56.3 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.2, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },

	{ Pos = Vector( -21.4, -105.7, 50.7 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, ReverseColor = "255 255 255" },
	{ Pos = Vector( 19.4, -105.7, 50.7 ), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, ReverseColor = "255 255 255" },

	{ Pos = Vector( -29.5, 84.9, 37 ), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, NormalColor = "169 215 255" },
	{ Pos = Vector( 27.5, 84.9, 37 ), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, NormalColor = "169 215 255" },
	{ Pos = Vector( -25.4, 91.9, 36.2 ), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.4, DynLight = true, NormalColor = "169 215 255" },
	{ Pos = Vector( 23.4, 91.9, 36.2 ), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.4, DynLight = true, NormalColor = "169 215 255" },
	{ Pos = Vector( -35.4, 90.9, 37.5 ), Size = 1, GlowSize = 1, HeadLightAngle = Angle( -5, 95, 0 ) },
	{ Pos = Vector( 33.4, 90.9, 37.5 ), Size = 1, GlowSize = 1, HeadLightAngle = Angle( -5, 85, 0 ) }
}

VEHICLE.RevvingSound = "vehicles/tdmcars/focusrs/rev.wav"
VEHICLE.SpinoutSound = "vehicles/golf/skid_highfriction.wav"

VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.342
VEHICLE.SirenColors = {
	Blue = {
		-- Roof
		{ Pos = Vector( -11.8, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -17.2, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -23, -24.1, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -11.8, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -17.2, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -23, -24.1, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -23, -33.2, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -17.4, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -11, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -23, -33.2, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -17.4, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -11, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -11.8, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -17.2, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -23, -24.1, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -11.8, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -17.2, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -23, -24.1, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -23, -33.2, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -17.4, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -11, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -23, -33.2, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -17.4, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -11, -34.3, 73.1 ), Ang = Angle(0,90,-1) },

		-- Rear
		{ Pos = Vector( 8.1, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 10, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 11.9, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 14.4, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 16.2, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 8.1, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 10, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 11.9, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 14.4, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 16.2, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18, -75, 54 ), Ang = Angle(0,90,-1) },

		-- Front
		{ Pos = Vector( 2.6, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 9.3, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 2.6, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 9.3, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
	},

	Red = {
		-- Roof
		{ Pos = Vector( 6.6, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 12.6, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18.8, -33.4, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18.8, -23.9, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 13.1, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 6.5, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 6.6, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 12.6, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18.8, -33.4, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18.8, -23.9, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 13.1, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 6.5, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 6.6, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 12.6, -34.3, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18.8, -33.4, 73.1 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( 18.8, -23.9, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 13.1, -23, 73.1 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( 6.5, -23, 73.1 ), Ang = Angle(0,-90,-1) },

		-- Rear
		{ Pos = Vector( -11.1, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -13, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -15.2, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -17.2, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -19.4, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -21.2, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -11.1, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -13, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -15.2, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -17.2, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -19.4, -75, 54 ), Ang = Angle(0,90,-1) },
		{ Pos = Vector( -21.2, -75, 54 ), Ang = Angle(0,90,-1) },

		-- Front
		{ Pos = Vector( -6, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -12.7, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -6, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
		{ Pos = Vector( -12.7, 104.8, 28.8 ), Ang = Angle(0,-90,-1) },
	}
}

GAMEMODE:RegisterVehicle( VEHICLE )
