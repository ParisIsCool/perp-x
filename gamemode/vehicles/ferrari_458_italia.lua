local VEHICLE 			= {}

VEHICLE.ID 				= "F458ITALIA"
VEHICLE.Name 			= "Ferrari 458 Italia"
VEHICLE.Make 			= "Ferrari"
VEHICLE.Model 			= "458 Italia"
VEHICLE.WorldModel		= "models/lonewolfie/ferrari_458.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/lwcars/ferrari_458.txt"
VEHICLE.Cost 			= 285000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-112,29),0.115,Angle(0,0,83)},
}


GAMEMODE:RegisterVehicle(VEHICLE)