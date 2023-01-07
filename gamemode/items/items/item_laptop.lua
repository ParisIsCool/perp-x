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

ITEM.ID 					= 141;
ITEM.Reference 				= "item_laptop";

ITEM.Name 					= "Laptop";
ITEM.Description			= "Access the iWeb and other things!";

ITEM.Weight 				= 5;
ITEM.Cost					= 3999;

ITEM.MaxStack 				= 4;

ITEM.InventoryModel 		= "models/posablelaptop/laptop.mdl";
ITEM.ModelCamPos 				= Vector(30, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/posablelaptop/laptop.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		local Trace = Player:GetEyeTrace();
        local Prop = Player:SpawnProp( ITEM, "ent_laptop" )
		
		if not Prop or not IsValid( Prop ) then return false end
		
		return true
    end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
end

GAMEMODE:RegisterItem( ITEM )