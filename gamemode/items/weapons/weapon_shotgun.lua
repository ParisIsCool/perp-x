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

ITEM.ID 					= 37
ITEM.Reference 				= "weapon_shotgun"

ITEM.Name 					= "Shotgun"
ITEM.Description			= "A pump-action shotgun.\n\nRequires Buckshot."

ITEM.Weight 				= 25
ITEM.Cost					= 1500

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/weapons/w_cstm_m3super90.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_cstm_m3super90.mdl" )

ITEM.ModelCamPos 			= Vector( 10, -32, 0 )
ITEM.ModelLookAt 			= Vector( 10, 0, 0 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_MAIN											

if SERVER then
	function ITEM.OnUse( Player )
		if not JOB_DATABASE[Player:Team()].CanEquipInventoryGun then return end

		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "cw_m3super90" )
	end
	
	function ITEM.Holster( Player )
		if Player:HasWeapon( "cw_m3super90" ) then
			local ammo = Player:GetWeapon( "cw_m3super90" ):Clip1()
			Player:GiveAmmo( ammo, "buckshot" )
		end

		Player:StripWeapon( "cw_m3super90" )
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