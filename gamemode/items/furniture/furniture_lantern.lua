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

ITEM.ID 					= 258
ITEM.Reference 				= "furniture_lantern"

ITEM.Name 					= "Lantern"
ITEM.Description			= "Powerful light that can light up everything.\n\nUSE the item to drop it as prop.\nPress ALT+USE to pickup after dropping."

ITEM.Weight 				= 10
ITEM.Cost					= 300

ITEM.Rotate					= 180

ITEM.MaxStack 				= 8

ITEM.InventoryModel 		= Model( "models/props_unique/spawn_apartment/lantern.mdl" )
ITEM.WorldModel 			= Model( "models/props_unique/spawn_apartment/lantern.mdl" )

ITEM.ModelCamPos 			= Vector(30, -50, 0);
ITEM.ModelLookAt 			= Vector(0, 0, 5);
ITEM.ModelFOV 				= 70;

if SERVER then
	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_lantern")
		
		if (!prop or !IsValid(prop)) then return false end

		prop.flashlight = ents.Create("env_projectedtexture")
			prop.flashlight:SetParent(prop)
					
			prop.flashlight:SetLocalPos(Vector(9, 0, 4))
			prop.flashlight:SetLocalAngles(Angle(0, 0, 0))
					
			prop.flashlight:SetKeyValue("enableshadows", 0)
			prop.flashlight:SetKeyValue("farz", 512)
			prop.flashlight:SetKeyValue("nearz", 512)
					
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