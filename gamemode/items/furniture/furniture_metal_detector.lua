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

ITEM.ID 					= 87
ITEM.Reference 				= "furniture_metal_detector"

ITEM.Name 					= "Metal Detector"
ITEM.Description			= "Detects when people pass through with weapons.\nMetal detector will spawn right at your position.\nUse your view to change angles.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 100
ITEM.Cost					= 1500

ITEM.Rotate					= 90

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_wasteland/interior_fence002e.mdl" )
ITEM.WorldModel 			= Model( "models/props_wasteland/interior_fence002e.mdl" )

ITEM.ModelCamPos 			= Vector( 100, 100, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

-- TODO: Clean up

if SERVER then
	function ITEM.OnUse( Player )
		local prop = Player:SpawnProp(ITEM, "prop_metal_detector")
		
		if (!prop or !IsValid(prop)) then return false end
		
		prop:SetPos(Player:GetPos() + Vector(0, 0, 60))
		prop:SetAngles(Angle(0, Player:EyeAngles().y + 90, 0))
		
		if(prop:GetPhysicsObject()) then
			prop:GetPhysicsObject():EnableMotion(false)
		end
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )