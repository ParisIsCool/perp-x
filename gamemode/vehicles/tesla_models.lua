local VEHICLE 			= {}

VEHICLE.ID 				= "TESLAModelS16"
VEHICLE.Name 			= "Tesla Model S"
VEHICLE.Make 			= "Tesla"
VEHICLE.Model 			= "Model S"
VEHICLE.WorldModel		= "models/sentry/models.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/sentry/models.txt"
VEHICLE.Cost 			= 112000
VEHICLE.VipOnly = true --True/False

VEHICLE.PlatePos = {
    {Vector(0,-122,37.5),0.115,Angle(0,0,82)},
}


GAMEMODE:RegisterVehicle(VEHICLE)