local VEHICLE 			= {}

VEHICLE.ID 				= "SubaruWRXSTI04"
VEHICLE.Name 			= "Subaru Impreza WRX STi 2004"
VEHICLE.Make 			= "Subaru"
VEHICLE.Model 			= "Impreza WRX STi 2004"
VEHICLE.WorldModel		= "models/lonewolfie/subaru_impreza_2004.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/LWCars/subaru_impreza_2004.txt"
VEHICLE.Cost 			= 52000
VEHICLE.VipOnly = false --True/False

VEHICLE.PlatePos = {
    {Vector(0,-106,22),0.115,Angle(0,0,90)},
}

GAMEMODE:RegisterVehicle(VEHICLE)