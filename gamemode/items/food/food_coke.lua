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

ITEM.ID 					= 62
ITEM.Reference 				= "food_coke"

ITEM.Name 					= "Cola"
ITEM.Description			= "A small can of cola.\n\nRestores a small amount of stamina."

ITEM.Weight 				= 5
ITEM.Cost					= 10

ITEM.MaxStack 				= 10

ITEM.InventoryModel 		= Model( "models/props_junk/PopCan01a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/PopCan01a.mdl" )

ITEM.ModelCamPos 			= Vector( 4, -8, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

local toAddStam = 15
if SERVER then
	function ITEM.OnUse( Player )		
		Player:SetNWFloat("Stamina", math.Clamp( Player:GetNWFloat("Stamina") + toAddStam, 0, 100 ) )
		Player:AddHunger( 8 )
		
		Player:EmitSound( "perp2.5/can_opening.mp3" )

		return true
	end
else
	function ITEM.OnUse()	
		timer.Simple( .5, function() surface.PlaySound( "perp2.5/drinking.mp3" ) end )
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )