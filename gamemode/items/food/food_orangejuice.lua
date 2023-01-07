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

ITEM.ID 					= 75
ITEM.Reference 				= "food_orangejuice"

ITEM.Name 					= "Orange Juice"
ITEM.Description			= "Orange juice, good for your health."

ITEM.Weight 				= 2
ITEM.Cost 					= 10

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_plasticbottle003a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_plasticbottle003a.mdl" )

ITEM.ModelCamPos 			= Vector( 48, 0, 28 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV				= 30

if SERVER then
	local Health = 0

	function ITEM.OnUse( Player )
		if Player.LastAte and Player.LastAte > CurTime() - 3 then
			return Player:Notify( "Stop drinking so fast, you're gonna become fat." )
		end
		Player.LastAte = CurTime()

		Player:EmitSound( "perp/drinking.mp3" )
        
        Player:AddHunger( 10 )
		-- Player:SetHealth( math.Clamp( Player:Health() + Health, 0, 100 ) )
		
		return true
	end
else
	function ITEM.OnUse()
		if GAMEMODE.LastAte and GAMEMODE.LastAte > os.time() + 1 then return surface.PlaySound( "buttons/button10.wav" ) end
		GAMEMODE.LastAte = os.time()

		--surface.PlaySound( "perp/drinking.mp3" )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )