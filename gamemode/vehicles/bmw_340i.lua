local VEHICLE 			= {}

VEHICLE.ID 				= "BMW340i"
VEHICLE.Name 			= "BMW 340i"
VEHICLE.Make 			= "BMW"
VEHICLE.Model 			= "340i"
VEHICLE.WorldModel		= "models/tdmcars/bmw_340i.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/bmw_340i.txt"
VEHICLE.Cost 			= 89000
VEHICLE.VipOnly = true --True/False

VEHICLE.PlatePos = {
    {Vector(0,-109,39),0.115,Angle(0,0,85)},
}

GAMEMODE:RegisterVehicle(VEHICLE)