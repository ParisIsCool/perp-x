--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


local ITEM 					= {};

ITEM.ID 					= 110;
ITEM.Reference 				= "item_repair_kit";

ITEM.Name 					= "Repair Kit";
ITEM.Description			= "Useful to repair broken down cars. \n\n Repairs VCMOD 50% Health and PERP 100% Health";

ITEM.Weight 				= 20;
ITEM.Cost					= 5000;

ITEM.MaxStack 				= 20;

ITEM.InventoryModel 		= "models/items/car_battery01.mdl";
ITEM.ModelCamPos 				= Vector(0, 0, 30);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/items/car_battery01.mdl";

if SERVER then
	function ITEM.OnUse ( Player )	
		local EyeTrace = Player:GetEyeTrace();
		
		if !EyeTrace.Entity or !EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsVehicle() or EyeTrace.Entity:GetPos():Distance(Player:GetPos()) > 200 then
			Player:Notify('You must aim at a vehicle to use this device.');
			return false;
		end
		
		if EyeTrace.Entity.Disabled == false then
			Player:Notify('That vehicle is already fixed.');
			return false;
		end
		
		Player:Notify('The vehicle has been repaired.');
		Player:Notify('You can repair your vehicle to full health at the mechanic.');
		
		EyeTrace.Entity:EnableVehicle()
		EyeTrace.Entity:FixTires()
		EyeTrace.Entity:VC_repairPart("engine", 0.5)
		EyeTrace.Entity:VC_damageHealth(85)
		--VC.RepairHealth(EyeTrace.Entity, VC_MaxHealth/2)
		
		EyeTrace.Entity:Fire('turnon', '', .5)
		
		Player:EmitSound( "npc/dog/dog_servo1.wav" )
				
		return true;
	end
else
	function ITEM.OnUse ( slotID )		
		surface.PlaySound( "npc/dog/dog_servo1.wav" )
		return true;
	end
end

GAMEMODE:RegisterItem(ITEM);