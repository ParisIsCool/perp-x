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

ITEM.ID 					= 56
ITEM.Reference 				= "weapon_bat"

ITEM.Name 					= "Baseball Bat"
ITEM.Description			= "Useful for home defense."

ITEM.Weight 				= 5
ITEM.Cost					= 500

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/weapons/w_basebat.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_basebat.mdl" )

ITEM.ModelCamPos 			= Vector( -8, 8, -26 )
ITEM.ModelLookAt 			= Vector( -2, -2, 10 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "weapon_perp_bat" )
	end
	
	function ITEM.Holster( Player )
		Player:StripWeapon( "weapon_perp_bat" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )