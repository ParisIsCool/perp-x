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

ITEM.ID 					= 77
ITEM.Reference 				= "item_stim_pack"

ITEM.Name 					= "Stim Pack"
ITEM.Description 			= "Heals your wounds."

ITEM.Weight 				= 5
ITEM.Cost 					= 400

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/healthvial.mdl" )
ITEM.WorldModel 			= Model( "models/healthvial.mdl" )

ITEM.ModelCamPos 			= Vector( 12, -4, 6 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
ITEM.ModelFOV 				= 70

if SERVER then
	local Health = 100

	function ITEM.OnUse( Player )
		if Player.LastStimmed and Player.LastStimmed > CurTime() - 3 then
			return Player:Notify( "CALM THE FUCK DOWN!!!" )
		end
		Player.LastStimmed = CurTime()

		Player:SetHealth( math.Clamp( Player:Health() + Health, 0, 100 ) )
		
		Player:EmitSound( "items/smallmedkit1.wav" )
		
		Player.Crippled = nil
	
		if Player.Crippled then
			Player.Crippled = false
			Player:FindRunSpeed()
		end
		
		return true
	end
else
	function ITEM.OnUse()
		if GAMEMODE.LastStimmed and GAMEMODE.LastStimmed > CurTime() + 1 then return surface.PlaySound( "buttons/button10.wav" ) end
		GAMEMODE.LastStimmed = CurTime()

		surface.PlaySound( "items/smallmedkit1.wav" )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )