local VEHICLE 			= {}

VEHICLE.ID 				= "CHEIMPALA64"
VEHICLE.Name 			= "Chevy Impala SS 1964"
VEHICLE.Make 			= "Chevy"
VEHICLE.Model 			= "Impala SS 1964"
VEHICLE.WorldModel		= "models/sentry/impala.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/sentry/impala.txt"
VEHICLE.Cost 			= 38000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-128,18),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)
