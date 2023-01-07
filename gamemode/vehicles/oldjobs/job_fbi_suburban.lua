local VEHICLE 			= {}

VEHICLE.ID 				= "FBS"

VEHICLE.Name 			= 'Chevrolet Suburban'
VEHICLE.Make 			= "Chevrolet"
VEHICLE.Model 			= "Suburban"

VEHICLE.Script 			= "chev_suburban"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_FBI

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.SSSub = true

VEHICLE.PaintJobs = {
	{ model = "models/lonewolfie/chev_suburban_pol_und.mdl", skin = "0", name = "White", color = Color( 255, 255, 255, 255 ) },
}

VEHICLE.RGBColour = true

VEHICLE.BodyGroups = {
	{ Group = 8, Value = 1 },
	{ Group = 9, Value = 1 },
};

VEHICLE.PassengerSeats = nil
VEHICLE.ExitPoints = {
	Vector( -90, 4.6053, 6.5827 ),
	Vector( 116.3831, 11.0841, 6.8897 )
}
							
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector( 0, 0, 0 )
VEHICLE.ViewAdjustments_ThirdPerson = nil

VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")
VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.342

VEHICLE.SirenColors = {
	Blue = {
		--[[//Running Boards
		Vector(-36.6, 26.6, 19.5),
		Vector(-36.6, 28.5, 19.5),
		Vector(-36.6, 24.9, 19.5),

		Vector(-36.6, -36.9, 19.5),
		Vector(-36.6, -38.7, 19.5),
		Vector(-36.6, -40.6, 19.5),
		Vector(36.6, 26.6, 19.5),
		Vector(36.6, 28.5, 19.5),
		Vector(36.6, 24.9, 19.5),

		Vector(36.6, -36.9, 19.5),
		Vector(36.6, -38.7, 19.5),
		Vector(36.6, -40.6, 19.5),]]--
		
		//Back All
	/*	Vector(-28.1, -114.7, 84.5),
		Vector(-26.2, -114.7, 84.5),
		Vector(-24.4, -115.4, 84.5),
		Vector(-16.4, -116.7, 84.5),
		Vector(-14.6, -116.7, 84.5),
		Vector(-12.7, -116.9, 84.5),
		Vector(28.1, -114.7, 84.5),
		Vector(26.2, -114.7, 84.5),
		Vector(24.4, -115.4, 84.5),
		Vector(16.4, -116.7, 84.5),
		Vector(14.6, -116.7, 84.5),
		Vector(12.7, -116.9, 84.5), */
		{ Pos = Vector(-39.6, -124.4, 53), Ang = Angle(0,90,-1) },
		{ Pos = Vector(39.6, -124.4, 53), Ang = Angle(0,90,-1) },

		//Grill
		{ Pos = Vector(11.6, 133.9, 50.7), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(9.8, 133.9, 50.7), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(7.9, 134.3, 50.7), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-11.6, 133.9, 50.7), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-9.8, 133.9, 50.7), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-7.9, 134.3, 50.7), Ang = Angle(0,-90,-1) },
		//Visor
		{ Pos = Vector(20.6, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(18.9, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(16.9, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-20.6, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-18.9, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-16.9, 39.9, 82.9), Ang = Angle(0,-90,-1) },
	},

	Red = {
		//Running Boards
		--[[Vector(-36.6, -6.1, 19.5),
		Vector(-36.6, -7.9, 19.5),
		Vector(-36.6, -4.2, 19.5),
		Vector(-36.6, 57.3, 19.5),
		Vector(-36.6, 59.3, 19.5),
		Vector(-36.6, 61.1, 19.5),
		Vector(36.6, -6.1, 19.5),
		Vector(36.6, -7.9, 19.5),
		Vector(36.6, -4.2, 19.5),
		Vector(36.6, 57.3, 19.5),
		Vector(36.6, 59.3, 19.5),
		Vector(36.6, 61.1, 19.5),

		//Back All
		Vector(-22.3, -116, 84.5),
		Vector(-20.4, -116, 84.5),
		Vector(-18.6, -116.3, 84.5),
		Vector(22.3, -116, 84.5),
		Vector(20.4, -116, 84.5),
		Vector(18.6, -116.3, 84.5),]]--
		{ Pos = Vector(-39.6, -124.4, 58.9), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-39.6, -124.4, 47.6), Ang = Angle(0,90,-1) },
		{ Pos = Vector(39.6, -124.4, 58.9), Ang = Angle(0,90,-1) },
		{ Pos = Vector(39.6, -124.4, 47.6), Ang = Angle(0,90,-1) },
		
		//Grill
		{ Pos = Vector(19.3, 133.2, 50.8), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(17.7, 133.2, 50.8), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(15.8, 133.5, 50.8), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-19.3, 133.2, 50.8), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-17.7, 133.2, 50.8), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-15.8, 133.5, 50.8), Ang = Angle(0,-90,-1) },

		//Visor
		{ Pos = Vector(14.5, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(12.8, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(10.9, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-14.5, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-12.8, 39.9, 82.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-10.9, 39.9, 82.9), Ang = Angle(0,-90,-1) },
	}
}

VEHICLE.UnderglowPositions = {
	{ Vector( 0, 35, 5 ) },
	{ Vector( 0, -35, 5 ) }
}	
					
VEHICLE.RevvingSound = "vehicles/tdmcars/crownvic/rev.wav"
VEHICLE.SpinoutSound = "vehicles/golf/skid_highfriction.wav"

GAMEMODE:RegisterVehicle( VEHICLE )

sound.Add( 
{
    name = "tdmcrownvic_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    sound = "vehicles/tdmcars/crownvic/idle.wav"
} )

sound.Add( 
{
    name = "tdmcrownvic_start",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    sound = "vehicles/tdmcars/crownvic/start.mp3"
} )

sound.Add( 
{
    name = "tdmcrownvic_reverse",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 90,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/tdmcars/crownvic/rev.wav"
} )

sound.Add( 
{
    name = "tdmcrownvic_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 95,
	pitchend = 104,
    sound = "vehicles/tdmcars/crownvic/first.mp3"
} )

sound.Add( 
{
    name = "tdmcrownvic_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/crownvic/second.mp3"
} )

sound.Add( 
{
    name = "tdmcrownvic_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/crownvic/third.mp3"
} )

sound.Add( 
{
    name = "tdmcrownvic_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/crownvic/fourth_cruise.wav"
} )

sound.Add( 
{
    name = "tdmcrownvic_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 85,
    pitchend = 110,
    sound = "vehicles/tdmcars/crownvic/second.mp3"
} )

sound.Add( 
{
    name = "tdmcrownvic_slowdown",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 85,
    pitchend = 110,
    sound = "vehicles/tdmcars/crownvic/throttle_off.mp3"
} )