local VEHICLE 			= {}

VEHICLE.ID 				= "G1"

VEHICLE.Name 			= "Dodge Charger SRT-8 Cop Car"
VEHICLE.Make 			= "Dodge"
VEHICLE.Model 			= "Charger"

VEHICLE.Script 			= "chargersrt8cop"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil

VEHICLE.PaintJobs = {
	{ model = "models/tdmcars/emergency/chargersrt8.mdl", skin = "12", name = "", color = Color(255, 255, 255, 255) },
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

VEHICLE.PaintText = "nope"

VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")

GAMEMODE:RegisterVehicle( VEHICLE )
