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

function ENT:Draw()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
		--self:DrawEntityOutline( 1.1 )
		HALO_ENTITIES_WHITE[self] = self
	else
		HALO_ENTITIES_WHITE[self] = nil
	end

	self:DrawModel()
end

local matOutlineWhite 	= Material( "white_outline" )
local ScaleNormal		= Vector( 1, 1, 1 )
local ScaleOutline1		= ScaleNormal * 1
local ScaleOutline2		= ScaleNormal * 1.1
local matOutlineBlack 	= Material( "black_outline" )

function ENT:DrawEntityOutline( size )
	size = size or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation( 1, 1, 1 )
	
	-- First Outline	
	local Mat = Matrix()
	Mat:Scale( ScaleOutline2 * size )
	self:EnableMatrix( "RenderMultiply", Mat )

	render.MaterialOverride( matOutlineBlack )
	self:DrawModel()

	-- Second Outline
	local Mat = Matrix()
	Mat:Scale( ScaleOutline1 * size )
	self:EnableMatrix( "RenderMultiply", Mat )

	render.MaterialOverride( matOutlineWhite )
	self:DrawModel()
	
	-- Revert everything back to how it should be
	render.MaterialOverride( nil )

	local Mat = Matrix()
	Mat:Scale( ScaleNormal )
	self:EnableMatrix( "RenderMultiply", Mat )
		
	render.SuppressEngineLighting( false )
	
	local Colour = self:GetColor()
	render.SetColorModulation( Colour.r / 122, Colour.g / 255, Colour.b / 255 )
end