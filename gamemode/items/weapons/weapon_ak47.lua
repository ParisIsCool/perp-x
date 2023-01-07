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

ITEM.ID 					= 28
ITEM.Reference 				= "weapon_ak47"

ITEM.Name 					= "AK-47"
ITEM.Description			= "A fully-automatic beast.\n\nRequires Rifle Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 2400

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_ak47.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_rif_ak47.mdl" )

ITEM.ModelCamPos 			= Vector( -9, 31, 0 )
ITEM.ModelLookAt 			= Vector( -9, 0, 0 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_MAIN											

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "cw_ak47" )
	end
	
	function ITEM.Holster( Player )
		if Player:HasWeapon( "cw_ak47" ) then
			-- Uncommented by Paris ( WHY WAS IT COMMENTED?? )
			local ammo = Player:GetWeapon( "cw_ak47" ):Clip1()
			Player:GiveAmmo( ammo, "smg1" )
		end

		Player:StripWeapon( "cw_ak47" )
	end	
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip an AK-47." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )