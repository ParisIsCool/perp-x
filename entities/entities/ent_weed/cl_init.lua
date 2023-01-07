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
	if LocalPlayer():GetEyeTrace().Entity == self and LocalPlayer():GetShootPos():Distance( self:GetPos() ) < 512 then
		if not self.SpawnTime then -- unsyncing issues ;/
			self.SpawnTime = self:GetGNWVar( "SpawnTime" )
		end

		if ( self.SpawnTime or CurTime() ) + self.GrowthTime < CurTime() then
			HALO_ENTITIES_DRUGS[self] = self
		end
	else
		HALO_ENTITIES_DRUGS[self] = nil
	end
	
	self:DrawModel()
end

function ENT:Initialize()
	self.SpawnTime = self:GetGNWVar( "SpawnTime" )
	self.GrowthTime = WEED_GROW_TIME

	local OurHeight = self:LocalToWorld( self:OBBMaxs() ).z
	local OurPos = self:LocalToWorld( self:OBBCenter() )
	
	self.OurLeaves = EffectData()
	self.OurLeaves:SetOrigin( Vector( OurPos.x, OurPos.y, OurHeight - 8 ) )
	self.OurLeaves:SetEntity( self )
	util.Effect( "ent_leaf", self.OurLeaves )
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
	render.SetColorModulation( Colour.r / 255, Colour.g / 255, Colour.b / 255 )
end