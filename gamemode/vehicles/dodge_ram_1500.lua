local VEHICLE 			= {}

VEHICLE.ID 				= "DodgeRAM1500Out"
VEHICLE.Name 			= "Dodge Ram 1500 Outdoorsman"
VEHICLE.Make 			= "Dodge"
VEHICLE.Model 			= "Ram 1500 Outdoorsman"
VEHICLE.WorldModel		= "models/lonewolfie/dodge_ram_1500_outdoorsman.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/lwcars/dodge_ram_1500_outdoorsman.txt"
VEHICLE.Cost 			= 70000
VEHICLE.VipOnly = true --True/False
VEHICLE.Truck           = true -- ents weld to bed

VEHICLE.PlatePos = {
    {Vector(0,-120,33),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)