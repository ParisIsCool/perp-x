local VEHICLE 			= {}

VEHICLE.ID 				= "ToyFJC"
VEHICLE.Name 			= "Toyota FJ Cruiser"
VEHICLE.Make 			= "Toyota"
VEHICLE.Model 			= "FJ Cruiser"
VEHICLE.WorldModel		= "models/tdmcars/toy_fj.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/toyfj.txt"
VEHICLE.Cost 			= 49000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-111,54.5),0.13,Angle(0,0,80)},
    {Vector(0,113,31),0.13,Angle(0,180,91)}
}

GAMEMODE:RegisterVehicle(VEHICLE)