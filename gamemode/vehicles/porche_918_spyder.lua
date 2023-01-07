local VEHICLE 			= {}

VEHICLE.ID 				= "PORCHE918S"
VEHICLE.Name 			= "Porche 918 Spyder"
VEHICLE.Make 			= "Porche"
VEHICLE.Model 			= "Porche 918 Spyder"
VEHICLE.WorldModel		= "models/tdmcars/por_918.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/918spyd.txt"
VEHICLE.Cost 			= 350000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-113,29),0.115,Angle(0,0,85)},
}


GAMEMODE:RegisterVehicle(VEHICLE)