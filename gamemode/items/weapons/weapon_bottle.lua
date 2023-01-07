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

ITEM.ID 					= 27
ITEM.Reference 				= "weapon_bottle"

ITEM.Name 					= "Empty Bottle"
ITEM.Description			= "It appears to be an empty bottle."

ITEM.Weight 				= 5
ITEM.Cost					= 50

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_glassbottle003z.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_glassbottle003z.mdl" )

ITEM.ModelCamPos 			= Vector( 1, -16, 1 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE											

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "weapon_perp_bottle" )
	end
	
	function ITEM.Holster( Player )
		Player:StripWeapon( "weapon_perp_bottle" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip a Bottle." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )