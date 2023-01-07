local VEHICLE 			= {}

VEHICLE.ID 				= "ToyTundCrewmax"
VEHICLE.Name 			= "Toyota Tundra Crewmax"
VEHICLE.Make 			= "Toyota"
VEHICLE.Model 			= "Tundra Crewmax"
VEHICLE.WorldModel		= "models/tdmcars/toy_tundra.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/tdmcars/toytundra.txt"
VEHICLE.Cost 			= 110000
VEHICLE.VipOnly = true --True/False
VEHICLE.Truck           = true -- ents weld to bed

VEHICLE.PlatePos = {
    {Vector(0,-138,42),0.115,Angle(0,0,90)},
    {Vector(0,143,34.5),0.115,Angle(0,180,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)