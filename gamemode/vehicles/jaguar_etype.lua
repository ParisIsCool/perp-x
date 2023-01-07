local VEHICLE 			= {}

VEHICLE.ID 				= "JagET"
VEHICLE.Name 			= "Jaguar E-Type"
VEHICLE.Make 			= "Jaguar"
VEHICLE.Model 			= "E-Type"
VEHICLE.WorldModel		= "models/tdmcars/jag_etype.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/jag_etype.txt"
VEHICLE.Cost 			= 36000
VEHICLE.VipOnly = true --True/False

VEHICLE.PlatePos = {
    {Vector(0,-104,25),0.115,Angle(0,0,90)},
}

GAMEMODE:RegisterVehicle(VEHICLE)