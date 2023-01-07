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

ITEM.ID 					= 162;
ITEM.Reference 				= "item_bulletproof_vest";

ITEM.Name 					= "Bulletproof Vest";
ITEM.Description			= "A bulletproof vest.\n\nIncreases your armor by 30.";

ITEM.Weight 				= 20;
ITEM.Cost					= 5000;

ITEM.MaxStack 				= 5;

ITEM.InventoryModel 		= "models/kevlarvest/kevlarvest.mdl";
ITEM.ModelCamPos 				= Vector(-25, 0, 66);
ITEM.ModelLookAt 				= Vector(25, 0, 50);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/kevlarvest/kevlarvest.mdl";

local toAddArmor = 30;

if SERVER then
	function ITEM.OnUse ( Player )	

		if Player.LastAte and Player.LastAte > CurTime() - 3 then
			return Player:Notify( "Calm down." )
		end
		Player.LastAte = CurTime()
		
		Player:SetArmor( math.Clamp( Player:Armor() + toAddArmor, 0, 100 ) )	
	
		return true;
	end
else
	function ITEM.OnUse ( slotID )	
	
		if GAMEMODE.LastAte and GAMEMODE.LastAte + 1 > os.time() then return surface.PlaySound( "buttons/button10.wav" ) end
		GAMEMODE.LastAte = os.time()
		
		--LocalPlayer().SetArmor( math.Clamp( LocalPlayer():Armor() + toAddArmor, 0, 100 ) )
		
		return true;
	end
end

GAMEMODE:RegisterItem(ITEM);
