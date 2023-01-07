local VEHICLE 			= {}

VEHICLE.ID 				= "LAMBOREVENTONROADSTER"
VEHICLE.Name 			= "Lamborghini Reventon Roadster"
VEHICLE.Make 			= "Lamborghini"
VEHICLE.Model 			= "Reventon Roadster"
VEHICLE.WorldModel		= "models/tdmcars/reventon_roadster.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/reventonr.txt"
VEHICLE.Cost 			= 650000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-115,32.5),0.115,Angle(0,0,80)},
}


GAMEMODE:RegisterVehicle(VEHICLE)