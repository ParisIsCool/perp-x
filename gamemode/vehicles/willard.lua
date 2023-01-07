local VEHICLE 			= {}

VEHICLE.ID 				= "WILLARD"
VEHICLE.Name 			= "GM Willard"
VEHICLE.Make 			= "General Motors"
VEHICLE.Model 			= "Willard"
VEHICLE.WorldModel		= 'models/sickness/willarddr.mdl'
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/willard.txt"
VEHICLE.Cost 			= 10000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(-1,-106.3,33.5),0.1,Angle(0,0,75)},
    {Vector(-1,118.5,21),0.115,Angle(0,180,91)}
}

GAMEMODE:RegisterVehicle(VEHICLE)