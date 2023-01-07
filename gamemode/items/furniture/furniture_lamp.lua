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

ITEM.ID 					= 52
ITEM.Reference 				= "furniture_lamp"

ITEM.Name 					= "Lamp"
ITEM.Description			= "Stands in the corner and looks good.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 10
ITEM.Cost					= 200

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl" )
ITEM.WorldModel 			= Model( "models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl" )

ITEM.ModelCamPos 			= Vector( -68, 56, 30 )
ITEM.ModelLookAt 			= Vector( 0, 0, 29 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local prop = Player:SpawnProp( ITEM, "prop_lamp" )
		
		if not prop or not IsValid( prop ) then return end

		prop.flashlight = ents.Create( "env_projectedtexture" )
			prop.flashlight:SetParent( prop )
					
			prop.flashlight:SetLocalPos( Vector( 0, 0, 80 ) )
			prop.flashlight:SetLocalAngles( Angle(90, 0, 0 ) )
					
			prop.flashlight:SetKeyValue( "enableshadows", 0 )
			prop.flashlight:SetKeyValue( "farz", 512 )
			prop.flashlight:SetKeyValue( "nearz", 64 )
					
			prop.flashlight:SetKeyValue( "lightfov", 100 )

			prop.flashlight:SetKeyValue( "lightcolor", "255 255 255 255" )
		prop.flashlight:Spawn()
				
		prop.flashlight:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )
		prop.flashlight:Fire( "TurnOff", "", 0 )
				
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )