--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]
 

local VEHICLE 			= {}


VEHICLE.ID 				= 'FB';


VEHICLE.Name 			= "Crown Victoria FBI";
VEHICLE.Make 			= "Ford";
VEHICLE.Model 			= "Crown Victoria";

VEHICLE.Script 			= "crownvicpolice"

VEHICLE.Cost 			= 0
VEHICLE.PaintJobCost 	= 0

VEHICLE.RequiredClass 	= TEAM_FBI

VEHICLE.KeepEngineRunning = true
VEHICLE.CustomBodyGroup = nil
VEHICLE.DefaultIceFriction = 0
							
VEHICLE.PlayerReposition_Pos = nil
VEHICLE.PlayerReposition_Ang = nil

VEHICLE.ViewAdjustments_FirstPerson = Vector(4, 0, 2)
VEHICLE.ViewAdjustments_ThirdPerson = nil


VEHICLE.HornNoise 			= 	Sound("perp2.5/phorn2.wav")

VEHICLE.PaintText = ""


VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {						
						{model = 'models/sentry/07crownvic_uc.mdl', skin = '0', name = 'black', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
								Vector(-103.0634, -23.6848, -11.1878),
								Vector(68.9006, -23.6848, -11.1878),
								Vector(68.9006, -14.02453, -11.1878),
								Vector(-103.0634, -14.02453, -11.1878),
							};
		
VEHICLE.Props = {
	{
		Model = "models/lonewolfie/whelenavenger_double.mdl",
		Scale = 1,
		Pos = Vector(0, 44.4, 49.8),
		Ang = Angle( 0, 90, 0),
	},
}
					
VEHICLE.SirenColors = 	{
	BlueCV = {
		//Deck Lights
		{ Pos = Vector(-7.8, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-9.3, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-11.1, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-12.5, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(-14.2, -68.9, 50.4), Ang = Angle(0,90,-1) },
		//Corner
		{ Pos = Vector(-35.1, 112.3, 32.4), Ang = Angle(0,-45,-1) },
		//Grill
		{ Pos = Vector(9.7, 118.9, 32.4), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(7.4, 118.9, 32.4), Ang = Angle(0,-90,-1) },
		
		//Front Window
		{ Pos = Vector(-1.2, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-2.6, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-3.9, 43.5, 48.9), Ang = Angle(0,-90,-1) },
	},

	RedCV = {
		//Deck Lights
		{ Pos = Vector(7.8, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(9.3, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(11.1, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(12.5, -68.9, 50.4), Ang = Angle(0,90,-1) },
		{ Pos = Vector(14.2, -68.9, 50.4), Ang = Angle(0,90,-1) },
		//Corner
		{ Pos = Vector(35.1, 112.3, 32.4), Ang = Angle(0,-135,-1) },
		//Grill
		{ Pos = Vector(-9.7, 118.9, 32.4), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(-7.4, 118.9, 32.4), Ang = Angle(0,-90,-1) },
		
		//Front Window
		{ Pos = Vector(1.2, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(2.6, 43.5, 48.9), Ang = Angle(0,-90,-1) },
		{ Pos = Vector(3.9, 43.5, 48.9), Ang = Angle(0,-90,-1) },
	},
};	

VEHICLE.SirenNoise = Sound("perp2.5/SIREN_1.wav")
VEHICLE.SirenNoise_DurMod = 5.368
VEHICLE.SirenNoise_Alt = Sound("perp2.5/SIREN_2.wav")
VEHICLE.SirenNoise_Alt_DurMod = 0.342



GAMEMODE:RegisterVehicle(VEHICLE) 