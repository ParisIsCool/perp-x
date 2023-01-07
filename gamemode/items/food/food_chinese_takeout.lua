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

ITEM.ID 					= 72
ITEM.Reference 				= "food_chinese_takeout"

ITEM.Name 					= "Chinese Takeout"
ITEM.Description 			= "Made in China."

ITEM.Weight 				= 2
ITEM.Cost				 	= 45

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_takeoutcarton001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_takeoutcarton001a.mdl" )

ITEM.ModelCamPos 			= Vector( 48, 0, 28 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 30

if SERVER then
	local Health = 20

	function ITEM.OnUse( Player )
		if Player.LastAte and Player.LastAte > CurTime() - 3 then
			return Player:Notify( "Stop eating so fast, you're gonna become fat." )
		end
		Player.LastAte = CurTime()

		Player:EmitSound( "perp2.5/eating.mp3" )
        
        Player:AddHunger( 40 )
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