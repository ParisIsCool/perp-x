local VEHICLE 			= {}

VEHICLE.ID 				= "JagFT"
VEHICLE.Name 			= "Jaguar F-Type"
VEHICLE.Make 			= "Jaguar"
VEHICLE.Model 			= "F-Type"
VEHICLE.WorldModel		= "models/tdmcars/jag_ftype.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/jag_ftype.txt"
VEHICLE.Cost 			= 94000
VEHICLE.VipOnly = true --True/False

VEHICLE.PlatePos = {
    {Vector(0,-107,37),0.115,Angle(0,0,82)},
}


GAMEMODE:RegisterVehicle(VEHICLE)