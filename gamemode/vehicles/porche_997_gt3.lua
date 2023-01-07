local VEHICLE 			= {}

VEHICLE.ID 				= "PORCHE997GTS"
VEHICLE.Name 			= "Porche 997 GTS"
VEHICLE.Make 			= "Porche"
VEHICLE.Model 			= "Porche 997 GTS"
VEHICLE.WorldModel		= "models/tdmcars/997gt3.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/997gt3.txt"
VEHICLE.Cost 			= 390000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-103,27),0.115,Angle(0,0,90)},
}

GAMEMODE:RegisterVehicle(VEHICLE)