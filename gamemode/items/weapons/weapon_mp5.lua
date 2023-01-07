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

ITEM.ID 					= 113
ITEM.Reference 				= "weapon_mp5"

ITEM.Name 					= "MP5"
ITEM.Description			= "A fully-automatic beast.\n\nRequires Rifle Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 1900

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_smg_mp5.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_smg_mp5.mdl" )

ITEM.ModelCamPos 			= Vector( 4, -36, 5 )
ITEM.ModelLookAt 			= Vector( 4, 0, 5 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_MAIN

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "cw_mp5_kry" )
	end
	
	function ITEM.Holster ( Player )
		if Player:HasWeapon( "cw_mp5_kry" ) then
			local ammo = Player:GetWeapon( "cw_mp5_kry" ):Clip1()
			Player:GiveAmmo( ammo, "smg1" )
		end

		Player:StripWeapon( "cw_mp5_kry" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip a Shotgun." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )