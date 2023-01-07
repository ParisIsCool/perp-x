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

ITEM.ID 					= 115
ITEM.Reference 				= "furniture_camera"

ITEM.Name 					= "Surveillance System (1 Camera)"
ITEM.Description			= "Spawns a monitor + camera for you to place in close range so you can view through it."

ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/props/cs_office/computer_monitor.mdl" )
ITEM.WorldModel 			= Model( "models/props/cs_office/computer_monitor.mdl" )

ITEM.ModelCamPos 			= Vector( 40, -6, 5 )
ITEM.ModelLookAt 			= Vector( 0, 0, 12 )
ITEM.ModelFOV 				= 70

if SERVER then	
	function ITEM.OnUse( Player )
		if GAMEMODE.Restarting then return Player:Notify( "This function cannot be completed, the server is pending a restart." ) end

		local count = 0
		for _, v in pairs( ents.FindByClass( "ent_cam_monitor" ) ) do
			if v.maker == Player:SteamID() then
				count = count + 1
			end
		end

		local iCanHave = Player:IsVIP() and MAX_CAM * 2 or MAX_CAM

		if not Player:SpawnProp( ITEM, "ent_cam_monitor" ) then return end

		return true
	end
end

GAMEMODE:RegisterItem( ITEM )