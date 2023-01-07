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

ITEM.ID 					= 36
ITEM.Reference 				= "weapon_glock"

ITEM.Name 					= "Glock"
ITEM.Description			= "A cheap gangster pistol.\n\nRequires Pistol Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 1000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_pist_glock18.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_pist_glock18.mdl" )

ITEM.ModelCamPos 			= Vector( 3, 15, 3.5 )
ITEM.ModelLookAt 			= Vector( 3, 0, 3.5 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end
		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "cw_glock20" )
	end
	
	function ITEM.Holster( Player )
		if Player:HasWeapon( "cw_glock20" ) then
			local ammo = Player:GetWeapon( "cw_glock20" ):Clip1()
			Player:GiveAmmo( ammo, "pistol" )
		end

		Player:StripWeapon( "cw_glock20" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip a Glock." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )