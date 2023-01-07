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

ITEM.ID 					= 762
ITEM.Reference 				= "weapon_p90"

ITEM.Name 					= "FN P90"
ITEM.Description			= "A small but powerful weapon.\n\nRequires Rifle Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 1950

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_smg_p90.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_smg_p90.mdl" )

ITEM.ModelCamPos 			= Vector( 2, 36, 7 )
ITEM.ModelLookAt 			= Vector( 2, 0, 7 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_MAIN

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "khr_p90" )
	end
	
	function ITEM.Holster ( Player )
		if Player:HasWeapon( "khr_p90" ) then
			local ammo = Player:GetWeapon( "khr_p90" ):Clip1()
			Player:GiveAmmo( ammo, "smg1" )
		end

		Player:StripWeapon( "khr_p90" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip an P90." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )