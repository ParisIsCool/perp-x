local VEHICLE 			= {}

VEHICLE.ID 				= "ToyPrius"
VEHICLE.Name 			= "Toyota Prius"
VEHICLE.Make 			= "Toyota"
VEHICLE.Model 			= "Prius"
VEHICLE.WorldModel		= "models/tdmcars/prius.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/prius.txt"
VEHICLE.Cost 			= 49000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-101.5,38),0.115,Angle(0,0,80)},
}

GAMEMODE:RegisterVehicle(VEHICLE)