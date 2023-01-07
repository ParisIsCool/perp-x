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

ITEM.ID 					= 999
ITEM.Reference 				= "weapon_fidget"

ITEM.Name 					= "Fidget Spinner"
ITEM.Description			= "Huh... wonder what this is?"

ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_workshop/fidget_spinner.mdl" )
ITEM.WorldModel 			= Model( "models/props_workshop/fidget_spinner.mdl" )

ITEM.ModelCamPos 			= Vector( 4, -4, 14 )
ITEM.ModelLookAt 			= Vector( -2, 2, -6 )
ITEM.ModelFOV 				= 30

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "weapon_perp_fidget" )
	end

	function ITEM.Holster( Player )
		Player:StripWeapon( "weapon_perp_fidget" )
	end
else
	function ITEM.OnUse( SlotID )
		if !LocalPlayer():IsVIP() then return LocalPlayer():Notify( "You must be a VIP to equip a Spinner." ) end

		GAMEMODE.AttemptToEquip( SlotID )

		return true
	end
end

GAMEMODE:RegisterItem( ITEM )
