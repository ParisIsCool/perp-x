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

ITEM.ID 					= 700
ITEM.Reference 				= "food_bread"

ITEM.Name 					= "Bread"
ITEM.Description 			= "It's wheat bread."

ITEM.Weight 				= 2
ITEM.Cost 					= 30

ITEM.MaxStack 				= 20

ITEM.InventoryModel 		= Model( "models/foodnhouseholditems/bread_loaf.mdl" )
ITEM.WorldModel 			= Model( "models/foodnhouseholditems/bread_loaf.mdl" )

ITEM.ModelCamPos 			= Vector( 40, 0, 28 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 45

if SERVER then
	function ITEM.OnUse( Player )
		if Player.LastAte and Player.LastAte > CurTime() - 3 then
			return Player:Notify( "omnomnomnom - you should probably slow down." )
		end
		Player.LastAte = CurTime()

		Player:EmitSound( "perp2.5/eating.mp3" )
        
        Player:AddHunger( 30 )
        Player:AddSaturation(3)
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