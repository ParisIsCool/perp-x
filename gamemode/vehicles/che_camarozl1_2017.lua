local VEHICLE 			= {}

VEHICLE.ID 				= "CAMAROZL117"
VEHICLE.Name 			= "Chevrolet Camaro ZL1 2017"
VEHICLE.Make 			= "Chevrolet"
VEHICLE.Model 			= "Camaro ZL1 2017"
VEHICLE.WorldModel		= "models/sentry/17camaro.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/sentry/17camaro.txt"
VEHICLE.Cost 			= 160000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-128,31),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)