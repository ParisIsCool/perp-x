local VEHICLE 			= {}

VEHICLE.ID 				= "BENTLYCONTINENTALGT"
VEHICLE.Name 			= "Bently PM Continental GT"
VEHICLE.Make 			= "Bently"
VEHICLE.Model 			= "PM Continental GT"
VEHICLE.WorldModel		= "models/lonewolfie/bently_pmcontinental.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/LWCars/bently_pmcontinental.txt"
VEHICLE.Cost 			= 60000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-122.5,32),0.115,Angle(0,0,84)},
}

GAMEMODE:RegisterVehicle(VEHICLE)