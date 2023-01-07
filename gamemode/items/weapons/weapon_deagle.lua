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

ITEM.ID 					= 34
ITEM.Reference 				= "weapon_deagle"

ITEM.Name 					= "Desert Eagle"
ITEM.Description			= "A deadly side-arm.\n\nRequires Pistol Ammo."

ITEM.Weight 				= 25
ITEM.Cost					= 1000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_pist_deagle.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_pist_deagle.mdl" )

ITEM.ModelCamPos 			= Vector( 4, 17, 3.5 )
ITEM.ModelLookAt 			= Vector( 4, -8, 3.5 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "cw_deagle" )
	end
	
	function ITEM.Holster( Player )
		if Player:HasWeapon( "cw_deagle" ) then
			local ammo = Player:GetWeapon( "cw_deagle" ):Clip1()
			Player:GiveAmmo( ammo, "pistol" )
		end

		Player:StripWeapon( "cw_deagle" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if not JOB_DATABASE[LocalPlayer():Team()].CanEquipInventoryGun then return LocalPlayer():Notify( "You must be a citizen to equip a Deagle." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )