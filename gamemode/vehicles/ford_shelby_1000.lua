local VEHICLE 			= {}

VEHICLE.ID 				= "SHELBY1000"
VEHICLE.Name 			= "Ford Shelby 1000"
VEHICLE.Make 			= "Ford"
VEHICLE.Model 			= "Shelby 1000"
VEHICLE.WorldModel		= "models/tdmcars/she_1000.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/she1000.txt"
VEHICLE.Cost 			= 140000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-114,37),0.115,Angle(0,0,85)},
}


GAMEMODE:RegisterVehicle(VEHICLE)