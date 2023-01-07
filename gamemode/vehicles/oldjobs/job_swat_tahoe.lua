local VEHICLE 			= {}

VEHICLE.ID 				= "SG4"

VEHICLE.Name 			= 'Chevrolet Tahoe'
VEHICLE.Make 			= "Chevrolet"
VEHICLE.Model 			= "Tahoe"

VEHICLE.Script 			= "chev_tahoe"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_SWAT

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.ChiefSub = true

VEHICLE.PaintJobs = {
	{ model = "models/lonewolfie/chev_tahoe_police.mdl", skin = "0", name = "Black", color = Color( 0, 0, 0, 255 ) },
}

VEHICLE.RGBColour = true

VEHICLE.BodyGroups = {
	{ Group = 2, Value = 1 },
	{ Group = 4, Value = 2 },
	{ Group = 6, Value = 1 },
};

VEHICLE.PlayerReposition_Pos = Vector( -18.95, 0, 35 )
VEHICLE.PlayerReposition_Ang = Angle( 0, 90, 0 )

VEHICLE.PassengerSeats = nil
	
VEHICLE.ExitPoints = {
	Vector( -90, 4.6053, 6.5827 ),
	Vector( 116.3831, 11.0841, 6.8897 )
}
							
VEHICLE.DefaultIceFriction = .4

VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")
VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.342

VEHICLE.PolTakeDowns = {
	{ Vector(-41.7, 44.3, 72.2) },
	{ Vector(25.5, 0, 97.7) },
	{ Vector(8.4, 0, 97.7) },
	{ Vector(-8.5, 0, 97.7) },
	{ Vector(-25.3, 0, 97.7) },
}

VEHICLE.SirenColorsStages = {
	BlueC = {
		//Front Window
		{ Pos = Vector(-25, 28.7, 75.5), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-26.8, 28.7, 75.5), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-28.6, 28.7, 75.5), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Pushbar Intersectors
		{ Pos = Vector(23.2, 121.8, 31.2), Ang = Angle(0,-180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.2, 121.8, 32.3), Ang = Angle(0,-180,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.2, 121.8, 30), Ang = Angle(0,-180,-1), LSTG2 = true, LSTG3 = true },
		//Grill Lights
		{ Pos = Vector(22.9, 109.9, 47.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(21.4, 109.9, 47.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(20, 109.9, 47.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-18.3, 111.4, 39.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-19.7, 111.4, 39.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-21.1, 111.4, 39.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Front Bumper
		{ Pos = Vector(-36.3, 103.9, 22.8), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		//Rear Bumper
		{ Pos = Vector(-36.3, -116.3, 30.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-35, -116.8, 30.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-33.6, -117.2, 30.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Rear Backflash
		{ Pos = Vector(39.6, -107.1, 50.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Rear Window
		{ Pos = Vector(26.8, -100.5, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(25.3, -100.6, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(23.8, -100.8, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		
		{ Pos = Vector(-21.8, -101.1, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-20.3, -101.1, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-18.8, -101.3, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		
		{ Pos = Vector(17, -101.6, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(15.4, -101.7, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(13.9, -101.9, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
	},

	BlueC2 = {
		//Front Window
		{ Pos = Vector(25, 28.7, 75.5), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(26.8, 28.7, 75.5), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(28.6, 28.7, 75.5), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Pushbar Intersectors
		{ Pos = Vector(-23.2, 121.8, 31.2), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.2, 121.8, 32.3), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.2, 121.8, 30), Ang = Angle(0,0,-1), LSTG2 = true, LSTG3 = true },
		//Grill Lights
		{ Pos = Vector(-22.9, 109.9, 47.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-21.4, 109.9, 47.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(-20, 109.9, 47.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(18.3, 111.4, 39.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(19.7, 111.4, 39.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		{ Pos = Vector(21.1, 111.4, 39.3), Ang = Angle(0,-90,-1), LSTG3 = true },
		//Front Bumper
		{ Pos = Vector(36.3, 103.9, 22.8), Ang = Angle(0,-90,-1), LSTG2 = true, LSTG3 = true },
		//Rear Bumper
		{ Pos = Vector(36.3, -116.3, 30.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(35, -116.8, 30.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(33.6, -117.2, 30.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Rear Backflash
		{ Pos = Vector(-39.6, -107.1, 50.7), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		//Rear Window
		{ Pos = Vector(-26.8, -100.5, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-25.3, -100.6, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-23.8, -100.8, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		
		{ Pos = Vector(21.8, -101.1, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(20.3, -101.1, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(18.8, -101.3, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		
		{ Pos = Vector(-17, -101.6, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-15.4, -101.7, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
		{ Pos = Vector(-13.9, -101.9, 82.1), Ang = Angle(0,90,-1), LSTG1 = true, LSTG2 = true, LSTG3 = true },
	}
}
			
VEHICLE.RevvingSound = "vehicles/tdmcars/crownvic/rev.wav"
VEHICLE.SpinoutSound = "vehicles/golf/skid_highfriction.wav"

GAMEMODE:RegisterVehicle( VEHICLE )
