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

ITEM.ID 					= 16
ITEM.Reference 				= "weapon_binoculars"

ITEM.Name 					= "Binoculars"
ITEM.Description			= "With three different zoom levels!"

ITEM.Weight 				= 5
ITEM.Cost					= 750

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_perpculars.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_perpculars.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 0, -12 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE											

if SERVER then
	function ITEM.OnUse( Player )
		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "weapon_perp_binoculars" )
	end
	
	function ITEM.Holster( Player )
		Player:StripWeapon( "weapon_perp_binoculars" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
	
		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )