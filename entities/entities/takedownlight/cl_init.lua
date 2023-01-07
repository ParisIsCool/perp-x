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

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw() end

function ENT:Initialize()
	self.VC_PVsb = util.GetPixelVisibleHandle()
end

function ENT:DrawTranslucent()
	local PNm = self:GetPos() - EyePos()
	local VcD, Pos = PNm:GetNormal():Dot( self:GetForward() * -1 )
	local Pos2 = self:GetPos() + self:GetForward()
	local Vsb = util.PixelVisible( Pos2, 8, self.VC_PVsb )
	if VcD >= 0 and Vsb then
		local Dst = math.Clamp( PNm:Length(), 32, 400 )
		local Size, Alpha = math.Clamp( Dst * VcD * 1.5, 32, 64 * self:GetGNWVar( "GlowSize", 0 ) ), math.Clamp( ( 1000 - Dst ) * VcD, 0, 100 )
		render.SetMaterial( Material( "sprites/light_ignorez" ) )
		local Colour = self:GetColor()
		render.DrawSprite( Pos2, Size * 0.1, Size * 0.4, Color( Colour.r, Colour.g, Colour.b, Alpha * Vsb ) )
		render.DrawSprite( Pos2, Size, Size, Color( Colour.r, Colour.g, Colour.b, Alpha * Vsb ) )
	end
end