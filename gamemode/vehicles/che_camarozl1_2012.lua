local VEHICLE 			= {}

VEHICLE.ID 				= "CAMAROZL1"
VEHICLE.Name 			= "Chevrolet Camaro ZL1 2012"
VEHICLE.Make 			= "Chevrolet"
VEHICLE.Model 			= "Camaro ZL1 2012"
VEHICLE.WorldModel		= "models/tdmcars/chev_camzl1.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/che_camarozl1.txt"
VEHICLE.Cost 			= 68000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-112,33.5),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)