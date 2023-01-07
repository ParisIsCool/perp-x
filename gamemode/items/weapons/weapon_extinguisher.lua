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

ITEM.ID 					= 64
ITEM.Reference 				= "weapon_extinguisher"

ITEM.Name 					= "Fire Extinguisher"
ITEM.Description			= "A fire extinguisher to put out fires with."

ITEM.Weight 				= 50
ITEM.Cost					= 3500

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_fire_extinguisher.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_fire_extinguisher.mdl" )

ITEM.ModelCamPos 			= Vector( 32, -4, -2 )
ITEM.ModelLookAt 			= Vector( 11, 0, 10 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE											

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end
		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "weapon_perp_fire_extinguisher" )
	end
	
	function ITEM.Holster( Player )
		Player:StripWeapon( "weapon_perp_fire_extinguisher" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "Stop trying to equip a extinguisher while your class already comes with one." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )