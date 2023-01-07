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

ITEM.ID 					= 33
ITEM.Reference 				= "weapon_mp9" -- aka uzi

ITEM.Name 					= "MP9"
ITEM.Description			= "The classic gangster weapon.\n\nRequires Rifle Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 2000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/therambotnic09/w_cw2_mp9.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/therambotnic09/w_cw2_mp9.mdl" )

ITEM.ModelCamPos 			= Vector( 2, -35, 3 )
ITEM.ModelLookAt 			= Vector( 2, 0, 3 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_MAIN

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "cw_tr09_mp9" )
	end
	
	function ITEM.Holster( Player )
		if Player:HasWeapon( "cw_tr09_mp9" ) then
			local ammo = Player:GetWeapon( "cw_tr09_mp9" ):Clip1()
			Player:GiveAmmo( ammo, "smg1" )
		end

		Player:StripWeapon( "cw_tr09_mp9" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip an UZI." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )