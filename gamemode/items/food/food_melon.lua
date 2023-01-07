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

ITEM.ID 					= 74
ITEM.Reference 				= "food_melon"

ITEM.Name 					= "Melon"
ITEM.Description 			= "Melons are healthy."

ITEM.Weight 				= 2
ITEM.Cost 					= 65

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/props_junk/watermelon01.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/watermelon01.mdl" )

ITEM.ModelCamPos 			= Vector(48, 0, 28)
ITEM.ModelLookAt 			= Vector(0, 0, 0)
ITEM.ModelFOV 				= 30

if SERVER then
	local Health = 20

	function ITEM.OnUse( Player )
		if Player.LastAte and Player.LastAte > CurTime() - 3 then
			return Player:Notify( "I know melons are tasty, but seriously you're going to have a heart attack, slow down." )
		end
		Player.LastAte = CurTime()

		Player:EmitSound( "perp2.5/eating.mp3" )
        
        Player:AddHunger( 36 )
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