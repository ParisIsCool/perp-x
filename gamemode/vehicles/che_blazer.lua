local VEHICLE 			= {}

VEHICLE.ID 				= "BLAZE"
VEHICLE.Name 			= "Chevrolet Blazer"
VEHICLE.Make 			= "Chevrolet"
VEHICLE.Model 			= "Blazer"
VEHICLE.WorldModel		= "models/tdmcars/chev_blazer.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/che_blazer.txt"
VEHICLE.Cost 			= 25000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-106,27),0.115,Angle(0,0,90)},
    {Vector(0,108,21),0.115,Angle(0,180,102)},
}


GAMEMODE:RegisterVehicle(VEHICLE)