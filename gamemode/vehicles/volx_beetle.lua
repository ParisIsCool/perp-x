local VEHICLE 			= {}

VEHICLE.ID 				= "VolkswagenBeatle"
VEHICLE.Name 			= "Volkswagen Beatle"
VEHICLE.Make 			= "Volkswagen"
VEHICLE.Model 			= "Beatle"
VEHICLE.WorldModel		= "models/tdmcars/vw_beetleconv.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/vwbeetleconv.txt"
VEHICLE.Cost 			= 22000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-96.5,23),0.115,Angle(0,0,76)},
    {Vector(0,104,21.7),0.115,Angle(0,180,80)},
}



GAMEMODE:RegisterVehicle(VEHICLE)