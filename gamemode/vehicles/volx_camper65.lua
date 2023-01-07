local VEHICLE 			= {}

VEHICLE.ID 				= "VWCamper65"
VEHICLE.Name 			= "Volkswagen Camper '65"
VEHICLE.Make 			= "Volkswagen"
VEHICLE.Model 			= "Camper '65"
VEHICLE.WorldModel		= "models/tdmcars/vw_camper65.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/vwcamper.txt"
VEHICLE.Cost 			= 55000
VEHICLE.VipOnly = true --True/False

VEHICLE.PlatePos = {
    {Vector(0,-100.5,34.5),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)