local VEHICLE 			= {}

VEHICLE.ID 				= "BMWm5e34"
VEHICLE.Name 			= "BMW M5 E34"
VEHICLE.Make 			= "BMW"
VEHICLE.Model 			= "M5 E34"
VEHICLE.WorldModel		= "models/tdmcars/bmwm5e34.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/bmwm5e34.txt"
VEHICLE.Cost 			= 30000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-112,39),0.115,Angle(0,0,90)},
    {Vector(0,115,20),0.115,Angle(0,180,95)},
}


GAMEMODE:RegisterVehicle(VEHICLE)