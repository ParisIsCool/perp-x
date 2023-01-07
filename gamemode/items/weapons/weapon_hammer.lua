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

ITEM.ID 					= 116
ITEM.Reference 				= "weapon_hammer"

ITEM.Name 					= "Hammer"
ITEM.Description			= "Attacks people and objects."

ITEM.Weight 				= 5
ITEM.Cost					= 500

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/melee/w_hammer.mdl" )
ITEM.WorldModel 			= Model( "models/melee/w_hammer.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 20, 4 )
ITEM.ModelLookAt 			= Vector( 0, 0, 4 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "w_hammer" )
	end
	
	function ITEM.Holster( Player )
		Player:StripWeapon( "w_hammer" )
	end
else
	function ITEM.OnUse( SlotID )
		GAMEMODE.AttemptToEquip( SlotID )
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )