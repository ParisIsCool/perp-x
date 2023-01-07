--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

include( "shared.lua" )

local x = -50
local y = -50
local w = 100
local h = 100

local hand = surface.GetTextureID( "perp2/clock/hand_long" )

function ENT:Draw()
	self:DrawModel()
	
	local handRotation = ( GetGNWVar( "temp", 35 ) / 100 ) * -270
	
	for i = 0, 1 do
		local ang = self:GetAngles()
		
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), -90 + ( i * 180 ) )
		
		local pos = self:GetPos() + ( self:GetUp() * 1 ) + ( self:GetForward() * ( 1 - ( i * 2 ) ) )
		
		cam.Start3D2D( pos, ang, .05 )
			surface.SetDrawColor( 0, 0, 0, 175 )
			
			surface.SetTexture( hand )
			
			if i == 0 then
				surface.DrawTexturedRectRotated( x + w * .5, y + h * .5, w, h, 135 + handRotation )
			else
				surface.DrawTexturedRectRotated( x + w * .5, y + h * .5, w, h, -135 - handRotation )
			end
		cam.End3D2D()
	end
end