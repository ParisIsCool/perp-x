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

ITEM.ID 					= 751;
ITEM.Reference 				= "item_vclight";

ITEM.Name 					= "Car Light";
ITEM.Description			= "Man! This thing so old!";

ITEM.Weight 				= 5;
ITEM.Cost					= 700;

ITEM.MaxStack 				= 25;

ITEM.InventoryModel 		= "models/maxofs2d/light_tubular.mdl";
ITEM.ModelCamPos 				= Vector(30, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/maxofs2d/light_tubular.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

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

		local NewProp = ents.Create( "vc_pickup_light" )
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

GAMEMODE:RegisterItem( ITEM )
