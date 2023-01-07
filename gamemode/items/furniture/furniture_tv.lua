--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local ITEM 					= {}

ITEM.ID 					= 230
ITEM.Reference 				= "item_tv"

ITEM.Name 					= "TV"
ITEM.Description			= "Useful for store managers.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 30
ITEM.Cost					= 300

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= "models/gmod_tower/suitetv_large.mdl";
ITEM.ModelCamPos 				= Vector(30, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/gmod_tower/suitetv_large.mdl";

ITEM.ModelCamPos 			= Vector( 100, 0, 70 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse(Player)
		local vStart = Player:GetShootPos()
		local vForward = Player:GetAimVector()
		local trace = {}
			trace.start = vStart
			trace.endpos = vStart + ( vForward * 100 )
			trace.filter = Player

		local tr = util.TraceLine( trace )

		local NewProp = ents.Create( "mediaplayer_tv" )
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
