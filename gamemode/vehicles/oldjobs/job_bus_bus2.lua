--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


VEHICLE 				= {};

VEHICLE.ID 				= '---';

VEHICLE.Name 			= "New Bus";
VEHICLE.Make 			= "New Bus";
VEHICLE.Model 			= "New Bus";

VEHICLE.Script 			= "newbus";

VEHICLE.Cost 			= 0;
VEHICLE.PaintJobCost 	= 0;
VEHICLE.KeepEngineRunning = true;
VEHICLE.CustomBodyGroup = nil;

VEHICLE.RGBColour = true

VEHICLE.PaintJobs = {
						{model = 'models/tdmcars/bus.mdl', skin = '0', name = '', color = Color(0, 0, 0, 255)},
					};
					
VEHICLE.PassengerSeats 	=	nil
	
VEHICLE.ExitPoints 		=	{
								Vector(85, 210, 0.2515),
							};
							
VEHICLE.DefaultIceFriction = 0;
							
VEHICLE.PlayerReposition_Pos = nil;
VEHICLE.PlayerReposition_Ang = nil;

VEHICLE.ViewAdjustments_FirstPerson = Vector(0, 0, 0);
VEHICLE.ViewAdjustments_ThirdPerson = nil;

VEHICLE.RequiredClass 	= TEAM_BUSDRIVER;

VEHICLE.PaintText = "";

VEHICLE.HornNoise 			= 	"perp2.5/FIRE_TRUCK_HORN.wav";
VEHICLE.Lights = {
				--Head lights
				{ Pos = Vector(-31, 266, 38), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 90, 0)},
				{ Pos = Vector(31, 266, 38), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 90, 0)},
				-- Brake lights
				{ Pos = Vector(-50, -245, 50), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
				{ Pos = Vector(50, -245, 50), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0" },
				
				-- Reverse Lights
				{ Pos = Vector(-50, -245, 50), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },
				{ Pos = Vector(50, -245, 50), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255" },
				};

VEHICLE.RevvingSound		= nil;
VEHICLE.SpinoutSound		= nil;


GAMEMODE:RegisterVehicle(VEHICLE);