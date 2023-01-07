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

ITEM.ID 					= 199;
ITEM.Reference 				= "item_fuelcan";

ITEM.Name 					= "Fuel Can";
ITEM.Description			= "Fill up your car!";

ITEM.Weight 				= 1;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 1;

ITEM.InventoryModel 		= "models/props_junk/metalgascan.mdl";
ITEM.ModelCamPos 				= Vector(30, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_junk/metalgascan.mdl";

ITEM.RestrictedSelling	 	= true; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

function ITEM.OnUse(Player)
	local vStart = Player:GetShootPos()
	local vForward = Player:GetAimVector()
	local trace = {}
		trace.start = vStart
		trace.endpos = vStart + ( vForward * 100 )
		trace.filter = Player
	
	local tr = util.TraceLine( trace )
	
	local NewProp = ents.Create( "ent_fuelcan" )
		NewProp:SetPos( tr.HitPos + Vector( 0, 0, 32 ) )
		NewProp.ItemSpawner = Player
		NewProp.pickupPlayer = Player
		NewProp:Spawn()
	return true;

end

	function ITEM.OnDrop ( Player )
		return true;
	end

else

function ITEM.OnUse(slotid)
	return true;
end

	function ITEM.OnDrop ( )
		return true;
	end

end

GAMEMODE:RegisterItem(ITEM);