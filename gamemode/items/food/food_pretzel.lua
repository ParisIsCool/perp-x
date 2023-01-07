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

ITEM.ID 					= 706
ITEM.Reference 				= "food_pretzel"

ITEM.Name 					= "Pretzel"
ITEM.Description 			= "Quite tasty."

ITEM.Weight 				= 2
ITEM.Cost 					= 20

ITEM.MaxStack 				= 20

-- ITEM.InventoryModel 		= Model( "models/food/hotdog.mdl" )
-- ITEM.WorldModel 			= Model( "models/food/hotdog.mdl" )

-- ITEM.ModelCamPos 			= Vector( 5, 0, 40 )
-- ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
-- ITEM.ModelFOV 				= 45

ITEM.InventoryModel 		= Model( "models/foodnhouseholditems/pretzel.mdl" )
ITEM.WorldModel 			= Model( "models/foodnhouseholditems/pretzel.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 0, 25 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 45


if SERVER then
	local Health = 20

	function ITEM.OnUse( Player )
		if Player.LastAte and Player.LastAte > CurTime() - 3 then
			return Player:Notify( "Your stomach is in a knot..." )
		end
		Player.LastAte = CurTime()

		Player:EmitSound( "perp2.5/eating.mp3" )
        
        Player:AddHunger( 22 )
		--Player:SetHealth( math.Clamp( Player:Health() + Health, 0, 100 ) )
		
		return true
	end
else
	function ITEM.OnUse()
		if GAMEMODE.LastAte and GAMEMODE.LastAte > os.time() + 1 then return surface.PlaySound( "buttons/button10.wav" ) end
		GAMEMODE.LastAte = os.time()

		--surface.PlaySound( "perp2.5/eating.mp3" )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )