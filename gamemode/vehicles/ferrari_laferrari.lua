local VEHICLE 			= {}

VEHICLE.ID 				= "LAFERRARI"
VEHICLE.Name 			= "Ferrari LaFerrari"
VEHICLE.Make 			= "Ferrari"
VEHICLE.Model 			= "LaFerrari"
VEHICLE.WorldModel		= "models/lonewolfie/ferrari_laferrari.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/lwcars/ferrari_laferrari.txt"
VEHICLE.Cost 			= 800000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-109,25),0.115,Angle(0,0,70)},
}


GAMEMODE:RegisterVehicle(VEHICLE)