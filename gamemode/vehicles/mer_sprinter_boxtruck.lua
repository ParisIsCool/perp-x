local VEHICLE 			= {}

VEHICLE.ID 				= "MERSPRINTERBOXTRUCK"
VEHICLE.Name 			= "Mercedes Sprinter Boxtruck"
VEHICLE.Make 			= "Mercedes"
VEHICLE.Model 			= "Sprinter Boxtruck"
VEHICLE.WorldModel		= "models/lonewolfie/merc_sprinter_boxtruck.mdl"
VEHICLE.Skin			= 0
VEHICLE.Script 			= "scripts/vehicles/LWCars/merc_sprinter_swb.txt"
VEHICLE.Cost 			= 70000
VEHICLE.VipOnly = false --True/False
VEHICLE.Truck           = true -- ents weld to bed

VEHICLE.PlatePos = {
    {Vector(0,-146,37),0.115,Angle(0,0,90)},
    {Vector(1,178.9,16),0.115,Angle(0,180,99)},
}

GAMEMODE:RegisterVehicle(VEHICLE)