local VEHICLE 			= {}

VEHICLE.ID 				= "GTRNISMO"
VEHICLE.Name 			= "Nissan GTR Nismo"
VEHICLE.Make 			= "Nissan"
VEHICLE.Model 			= "GTR Nismo"
VEHICLE.WorldModel		= "models/sentry/nismor35.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/sentry/nismor35.txt"
VEHICLE.Cost 			= 800000
VEHICLE.VipOnly = true --True/False

VEHICLE.PlatePos = {
    {Vector(0,-105,27),0.115,Angle(0,0,80)},
}

GAMEMODE:RegisterVehicle(VEHICLE)