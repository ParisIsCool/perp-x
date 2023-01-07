local VEHICLE 			= {}

VEHICLE.ID 				= "MitsuEvoX"
VEHICLE.Name 			= "Mitsubishi Lancer Evo X"
VEHICLE.Make 			= "Mitsubishi"
VEHICLE.Model 			= "Lancer Evo X"
VEHICLE.WorldModel		= "models/tdmcars/mitsu_evox.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/mitsu_evox.txt"
VEHICLE.Cost 			= 85000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-106,23),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)