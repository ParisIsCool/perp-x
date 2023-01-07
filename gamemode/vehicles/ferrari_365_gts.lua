local VEHICLE 			= {}

VEHICLE.ID 				= "F365GTS"
VEHICLE.Name 			= "Ferrari 365 GTS"
VEHICLE.Make 			= "Ferrari"
VEHICLE.Model 			= "365 GTS"
VEHICLE.WorldModel		= "models/lonewolfie/ferrari_365gts.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/lwcars/ferrari_365gts.txt"
VEHICLE.Cost 			= 110000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-105,35),0.115,Angle(0,0,77)},
}


GAMEMODE:RegisterVehicle(VEHICLE)