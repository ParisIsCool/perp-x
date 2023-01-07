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

ITEM.ID 					= 73
ITEM.Reference 				= "food_coffee"

ITEM.Name 					= "Coffee"
ITEM.Description 			= "Short but powerful energy boosts."

ITEM.Weight 				= 2
ITEM.Cost 					= 35

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_coffeemug001a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_coffeemug001a.mdl" )

ITEM.ModelCamPos 			= Vector( 48, 0, 28 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 30

local toAddStam = 50
if SERVER then
	function ITEM.OnUse( Player )
		if Player.LastAte and Player.LastAte > CurTime() - 3 then
			return Player:Notify( "Stop drinking so fast, you're gonna become diabetic." )
		end
		Player.LastAte = CurTime()

		Player:EmitSound( "perp/drinking.mp3" )
		
		Player.Stamina = math.Clamp( Player.Stamina + toAddStam, 0, 100 )
		Player:AddHunger( 12 )

		return true
	end
else
	function ITEM.OnUse()	
		if GAMEMODE.LastAte and GAMEMODE.LastAte + 1 > os.time() then return surface.PlaySound( "buttons/button10.wav" ) end
		GAMEMODE.LastAte = os.time()

		--surface.PlaySound( "perp/drinking.mp3" )
		
		LocalPlayer().Stamina = math.Clamp( LocalPlayer().Stamina + toAddStam, 0, 100 )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )