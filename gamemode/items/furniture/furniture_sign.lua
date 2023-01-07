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

ITEM.ID 					= 114
ITEM.Reference 				= "furniture_sign"

ITEM.Name 					= "Text Sign"
ITEM.Description			= "Write on the sign."

ITEM.Weight 				= 100
ITEM.Cost					= 5000

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_lab/clipboard.mdl" )
ITEM.WorldModel 			= Model( "models/props_lab/clipboard.mdl" )

ITEM.ModelCamPos 			= Vector( 22, 6, 8 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )
		local count = 0
		for _, v in pairs( ents.FindByClass( "prop_sign" ) ) do
			if v.Owner == Player then
				count = count + 1
			end
		end
		
		local iCanHave = Player:IsVIP() and MAX_SIGNS * 2 or MAX_SIGNS

		local Prop = Player:SpawnProp( ITEM, "prop_sign" )
		if not IsValid( Prop ) then return false end

		Prop.UnBurnable = true
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )