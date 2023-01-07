local VEHICLE 			= {}

VEHICLE.ID 				= "G65-6x6"
VEHICLE.Name 			= "Mercedes G65-6x6"
VEHICLE.Make 			= "Mercedes"
VEHICLE.Model 			= "G65-6x6"
VEHICLE.WorldModel		= "models/lonewolfie/mer_g65_6x6.mdl"
VEHICLE.Skin			= 1
VEHICLE.Script 			= "scripts/vehicles/lwcars/mer_g65_6x6.txt"
VEHICLE.Cost 			= 145000
VEHICLE.VipOnly = true --True/False
VEHICLE.Truck           = true -- ents weld to bed

VEHICLE.PlatePos = {
    {Vector(0,-161,41),0.115,Angle(0,0,90)},
}


GAMEMODE:RegisterVehicle(VEHICLE)