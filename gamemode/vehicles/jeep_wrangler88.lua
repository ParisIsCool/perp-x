local VEHICLE 			= {}

VEHICLE.ID 				= "Wrangler88"
VEHICLE.Name 			= "Jeep Wrangler 88"
VEHICLE.Make 			= "Jeep"
VEHICLE.Model 			= "Wrangler 88"
VEHICLE.WorldModel		= "models/tdmcars/jeep_wrangler88.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/wrangler88.txt"
VEHICLE.Cost 			= 35000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(-30,-81,38),0.115,Angle(0,0,90)},
    {Vector(0,95,28),0.115,Angle(0,180,90)},
}

GAMEMODE:RegisterVehicle(VEHICLE)