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

ITEM.ID 					= 61
ITEM.Reference 				= "furniture_lamp_spot"

ITEM.Name 					= "Spotlight"
ITEM.Description			= "Excellent for lighting things up during the night.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 10
ITEM.Cost					= 500

ITEM.Rotate					= 180

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_wasteland/light_spotlight01_lamp.mdl" )
ITEM.WorldModel 			= Model( "models/props_wasteland/light_spotlight01_lamp.mdl" )

ITEM.ModelCamPos 			= Vector( 14, -25, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
ITEM.ModelFOV 				= 70

-- TODO: Clean up code

if SERVER then
	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_lamp_spot")
		
		if (!prop or !IsValid(prop)) then return false end

		prop.flashlight = ents.Create("env_projectedtexture")
			prop.flashlight:SetParent(prop)
					
			prop.flashlight:SetLocalPos(Vector(9, 0, 4))
			prop.flashlight:SetLocalAngles(Angle(0, 0, 0))
					
			prop.flashlight:SetKeyValue("enableshadows", 0)
			prop.flashlight:SetKeyValue("farz", 512)
			prop.flashlight:SetKeyValue("nearz", 16)
					
			prop.flashlight:SetKeyValue("lightfov", 50)
				
			local realColor = Color(255, 255, 200, 1000)
			prop.flashlight:SetKeyValue("lightcolor", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a)
		prop.flashlight:Spawn()
				
		prop.flashlight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001")
		prop.flashlight:Fire("TurnOff", "", 0)
		
		prop:SetSkin(1)
				
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )