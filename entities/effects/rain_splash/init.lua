--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local startFadeSize = 255 * .675

function EFFECT:Init( data )
	self.pos = data:GetOrigin() + Vector( 0, 0, 10 )

	local particle = GLOBAL_EMITTER:Add( "perp2/rain/splash", self.pos )

	if particle then
		particle:SetVelocity( Vector( 0, 0, 0 ) )
		particle:SetLifeTime( 0 )
		particle:SetDieTime( .1 )
		
		particle:SetStartAlpha( startFadeSize )
		particle:SetEndAlpha( 0 )
		
		particle:SetStartSize( 1 )
		particle:SetEndSize( 3 )
		
		particle:SetAirResistance( 0 )
		particle:SetColor( Color( 128, 128, 128, 255 ) )
	end
end

function EFFECT:Render() return end