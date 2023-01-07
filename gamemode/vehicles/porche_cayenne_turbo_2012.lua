local VEHICLE 			= {}

VEHICLE.ID 				= "PORCHECAYENNETURBO12"
VEHICLE.Name 			= "Porche Cayenne Turbo 2012"
VEHICLE.Make 			= "Porche"
VEHICLE.Model 			= "Porche Cayenne Turbo 2012"
VEHICLE.WorldModel		= "models/tdmcars/por_cayenne12.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/cayenne12.txt"
VEHICLE.Cost 			= 105000
VEHICLE.VipOnly = true  --True/False

VEHICLE.PlatePos = {
    {Vector(0,-116,45),0.115,Angle(0,0,90)},
}

GAMEMODE:RegisterVehicle(VEHICLE)