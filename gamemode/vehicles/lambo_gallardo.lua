local VEHICLE 			= {}

VEHICLE.ID 				= "LAMBOGALLARDO"
VEHICLE.Name 			= "Lamborghini Gallardo"
VEHICLE.Make 			= "Lamborghini"
VEHICLE.Model 			= "Gallardo"
VEHICLE.WorldModel		= "models/tdmcars/gallardo.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/gallardo.txt"
VEHICLE.Cost 			= 450000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-104,18),0.115,Angle(0,0,85)},
}

GAMEMODE:RegisterVehicle(VEHICLE)