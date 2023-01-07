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

ITEM.ID 					= 42
ITEM.Reference 				= "item_house_alarm"

ITEM.Name 					= "House Alarm"
ITEM.Description			= "Alerts the police department if someone attemps to break into your home or business."

ITEM.Weight 				= 5
ITEM.Cost					= 250

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_lab/reciever01d.mdl" )
ITEM.WorldModel 			= Model( "models/props_lab/reciever01d.mdl" )

ITEM.ModelCamPos 			= Vector( 17, 0, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

-- TODO: Clean up code

if SERVER then
	function ITEM.OnUse ( Player )		
		local w = Player:GetEyeTrace()
		
		if (!w.Entity or !IsValid(w.Entity) or !w.Entity:IsDoor()) then
			return Player:Notify("You must be aiming at a door to use this item.")
		 end
		
		if (w.Entity:GetPos():Distance(Player:GetPos()) > 200) then
			return Player:Notify("You must be aiming at a door to use this item.")
		 end
		
		local GroupTable = w.Entity:GetPropertyTable()
		
		if (!GroupTable) then
			return Player:Notify("You must be aiming at a door you own to use this item.")
		 end
		
		if (w.Entity:GetDoorOwner() ~= Player) then
			return Player:Notify("You must be aiming at a door you own to use this item.")
		 end
		
		if (GAMEMODE.HouseAlarms[GroupTable.ID]) then
			return Player:Notify("This property already has a house alarm.")
		 end
		
		Player:Notify("House alarm installed.")
		
		GAMEMODE.HouseAlarms[ GroupTable.ID ] = true
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )