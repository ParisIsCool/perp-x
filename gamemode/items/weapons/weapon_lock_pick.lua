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

ITEM.ID 					= 43
ITEM.Reference 				= "weapon_lock_pick"

ITEM.Name 					= "Lock Pick"
ITEM.Description			= "Useful for going where you don't belong.\n\nRequires level 3 strength to use."

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/weapons/w_crowbar.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_crowbar.mdl" )

ITEM.ModelCamPos 			= Vector( 8, 9, 24 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		if Player:Team() ~= TEAM_CITIZEN then return end

		if Player:GetSkillLevel( GENE_STRENGTH ) < 3 then return end

		return true
	end
	
	function ITEM.Equip( Player )
		Player:Give( "weapon_perp_lock_pick" )
	end
	
	function ITEM.Holster( Player )
		Player:StripWeapon( "weapon_perp_lock_pick" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end
		if LocalPlayer():Team() ~= TEAM_CITIZEN then return LocalPlayer():Notify( "Only Citizens can use this!" ) end
		if LocalPlayer():GetSkillLevel( GENE_STRENGTH ) < 3 then return LocalPlayer():Notify( "You must have level 3 strength to use this item." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )