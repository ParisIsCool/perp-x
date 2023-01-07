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

ITEM.ID 					= 128;
ITEM.Reference 				= "drug_vape1";

ITEM.Name 					= "Juicy Vape";
ITEM.Description			= "These make you cool.";

ITEM.Weight 				= 5;
ITEM.Cost					= 2900;

ITEM.MaxStack 				= 1;


ITEM.InventoryModel 		= "models/swamponions/vape.mdl";
ITEM.ModelCamPos 				= Vector(0, -11, 5);
ITEM.ModelLookAt 				= Vector(0, 0, 5);
ITEM.ModelFOV 					= 60;
ITEM.WorldModel 			= "models/swamponions/vape.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= EQUIP_SIDE;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		return false;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
	
	function ITEM.Equip ( Player )
		Player:Give("weapon_vape_juicy");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_vape_juicy");
	end
	
else

	function ITEM.OnUse ( slotID )	
		GAMEMODE.AttemptToEquip(slotID);
		
		return false;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GAMEMODE:RegisterItem( ITEM )