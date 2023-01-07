local VEHICLE 			= {}

VEHICLE.ID 				= "Wrangler"
VEHICLE.Name 			= "Jeep Wrangler"
VEHICLE.Make 			= "Jeep"
VEHICLE.Model 			= "Wrangler"
VEHICLE.WorldModel		= "models/tdmcars/wrangler.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/tdmcars/wrangler.txt"
VEHICLE.Cost 			= 40000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-97,49),0.115,Angle(0,0,90)},
    {Vector(0,92,31),0.115,Angle(0,180,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)