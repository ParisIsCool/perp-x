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

ITEM.ID 					= 35
ITEM.Reference 				= "weapon_fiveseven"

ITEM.Name 					= "Five-Seven"
ITEM.Description			= "A sleek-looking pistol.\n\nRequires Pistol Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 800

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_pist_fiveseven.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_pist_fiveseven.mdl" )

ITEM.ModelCamPos 			= Vector( 8, 12, 3 )
ITEM.ModelLookAt 			= Vector( 6, 5, 3 )
ITEM.ModelFOV 				= 90

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end
		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "cw_fiveseven" )
	end
	
	function ITEM.Holster( Player )
		if Player:HasWeapon( "cw_fiveseven" ) then
			local ammo = Player:GetWeapon( "cw_fiveseven" ):Clip1()
			Player:GiveAmmo( ammo, "pistol" )
		end

		Player:StripWeapon( "cw_fiveseven" )
	end	
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip a FiveSeven." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )