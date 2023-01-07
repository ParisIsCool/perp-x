local VEHICLE 			= {}

VEHICLE.ID 				= "JGrandCherokee"
VEHICLE.Name 			= "Jeep Grand Cherokee"
VEHICLE.Make 			= "Jeep"
VEHICLE.Model 			= "Grand Cherokee"
VEHICLE.WorldModel		= "models/tdmcars/jeep_grandche.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/grandche.txt"
VEHICLE.Cost 			= 60000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-115,52),0.115,Angle(0,0,88)},
}


GAMEMODE:RegisterVehicle(VEHICLE)