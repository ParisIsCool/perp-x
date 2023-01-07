local VEHICLE 			= {}

VEHICLE.ID 				= "MERSPRINTERLWB"
VEHICLE.Name 			= "Mercedes Sprinter LWB"
VEHICLE.Make 			= "Mercedes"
VEHICLE.Model 			= "Sprinter LWB"
VEHICLE.WorldModel		= "models/lonewolfie/merc_sprinter_lwb.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/LWCars/merc_sprinter_swb.txt"
VEHICLE.Cost 			= 60000
VEHICLE.VipOnly = false --True/False
VEHICLE.Truck           = true -- ents weld to bed

VEHICLE.PlatePos = {
    {Vector(-17.5,-157,25),0.115,Angle(0,0,90)},
    {Vector(1,135,16),0.115,Angle(0,180,99)},
}


GAMEMODE:RegisterVehicle(VEHICLE)