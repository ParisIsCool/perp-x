local VEHICLE 			= {}

VEHICLE.ID 				= "FFF"
VEHICLE.Name 			= "Ferrari FF"
VEHICLE.Make 			= "Ferrari"
VEHICLE.Model 			= "FF"
VEHICLE.WorldModel		= "models/lonewolfie/ferrari_ff.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/lwcars/ferrari_ff.txt"
VEHICLE.Cost 			= 160000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-119,29.5),0.115,Angle(0,0,85)},
}


GAMEMODE:RegisterVehicle(VEHICLE)