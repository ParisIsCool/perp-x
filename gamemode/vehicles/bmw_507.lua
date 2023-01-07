local VEHICLE 			= {}

VEHICLE.ID 				= "BMW507"
VEHICLE.Name 			= "BMW 507"
VEHICLE.Make 			= "BMW"
VEHICLE.Model 			= "507"
VEHICLE.WorldModel		= "models/tdmcars/bmw507.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/507.txt"
VEHICLE.Cost 			= 60000
VEHICLE.VipOnly = true --True/False

VEHICLE.PlatePos = {
    {Vector(0,-105,29),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)