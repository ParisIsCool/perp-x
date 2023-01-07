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

ITEM.ID 					= 109
ITEM.Reference 				= "weapon_camera"

ITEM.Name 					= "Camera"
ITEM.Description			= "Take pictures of girls naked."

ITEM.Weight 				= 5
ITEM.Cost					= 250

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/MaxOfS2D/camera.mdl" )
ITEM.WorldModel 			= Model( "models/MaxOfS2D/camera.mdl" )

ITEM.ModelCamPos 			= Vector( 30, 15, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 2 )
ITEM.ModelFOV 				= 30

ITEM.EquipZone 				= EQUIP_SIDE

if SERVER then
	function ITEM.OnUse( Player )
		return true
	end

	function ITEM.Equip( Player )
		Player:Give( "camera" )
	end
	
	function ITEM.Holster( Player )
		Player:StripWeapon( "camera" )
	end
else
	function ITEM.OnUse( SlotID )
		if LocalPlayer():InCasino() then return LocalPlayer():Notify( "You can not equip weapons in the Casino." ) end

		GAMEMODE.AttemptToEquip( SlotID )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )