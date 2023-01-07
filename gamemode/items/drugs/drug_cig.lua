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

ITEM.ID 					= 57
ITEM.Reference 				= "drug_cig"

ITEM.Name 					= "Shibboro Cigarettes"
ITEM.Description			= "These make you cool."

ITEM.Weight 				= 5
ITEM.Cost					= 50

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= Model( "models/boxopencigshib.mdl" )
ITEM.WorldModel 			= Model( "models/boxopencigshib.mdl" )

ITEM.ModelCamPos 			= Vector( 6, 0, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )	
		timer.Simple( 2.35, function()
			local Effect = EffectData()
				Effect:SetOrigin( Player:GetShootPos() + Player:GetAimVector() * 5 )
				util.Effect( "smoke_cig", Effect )
			
				Player:TakeDamage( 5, Player, Player )
				--Player:AddProgress(29, 1)
		end )
	
		return true
	end	
else
	function ITEM.OnUse()	
		surface.PlaySound( "perp2.5/smoke.mp3" )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )