--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function EFFECT:Init( data )
	local Entity = data:GetEntity()
		
	for i = 1, 10 do
		timer.Simple( ( i - 1 ) * .02, function()
			if IsValid( Entity ) and Entity:IsPlayer() and Entity:Alive() then
				local p = GLOBAL_EMITTER:Add( "effects/extinguisher", Entity:GetShootPos() + Entity:GetAimVector() * 20 )
				p:SetVelocity( Entity:GetAimVector() * 500 )
				p:SetDieTime( 1 )
				p:SetStartAlpha( 0 )
				p:SetEndAlpha( 100 )
				p:SetStartSize( 5 )
				p:SetEndSize( 40 )
				p:SetRoll( math.Rand( 0, 10 ) )
				p:SetRollDelta( math.Rand( -0.2, 0.2 ) )
			end
		end )
	end
end

function EFFECT:Render() return end