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

ITEM.ID 					= 112
ITEM.Reference 				= "weapon_m4a1"

ITEM.Name 					= "M4A1"
ITEM.Description			= "A fully-automatic beast.\n\nRequires Rifle Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 1950

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_rif_m4a1.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_rif_m4a1.mdl" )

ITEM.ModelCamPos 			= Vector( -4, -32, 5 )
ITEM.ModelLookAt 			= Vector( -4, 0, 5 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_MAIN

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "khr_m4a4" )
	end
	
	function ITEM.Holster ( Player )
		if Player:HasWeapon( "khr_m4a4" ) then
			local ammo = Player:GetWeapon( "khr_m4a4" ):Clip1()
			Player:GiveAmmo( ammo, "smg1" )
		end

		Player:StripWeapon( "khr_m4a4" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip an M4A1." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )