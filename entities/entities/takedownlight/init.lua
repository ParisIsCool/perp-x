--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:DrawShadow( false )

	local PT = ents.Create( "env_projectedtexture" )
		PT:SetAngles( self:GetAngles() )
		PT:SetPos( self:GetPos() )
		PT:SetParent( self )
		PT:SetAttachment( { Ang = self:GetAngles(), Pos = self:GetPos() } )
		PT:SetKeyValue( "enableshadows", 0 )
		PT:SetKeyValue( "farz", 4096 )
		PT:SetKeyValue( "nearz", 128 )
		PT:SetKeyValue( "lightfov", 60 )

		local Colour = self:GetColor()
		PT:SetKeyValue( "lightcolor", Format( "%i %i %i 1500", Colour.r, Colour.g, Colour.b ) )

		PT:Spawn()
		PT.Active = true

		PT:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )

	self.Project = PT
end

function ENT:Think()
	if !self.Project then return end
	if self.Active and not self.Project.Active then -- if lights on 
		local Colour = self:GetColor()
		self.Project:SetKeyValue( "lightcolor", Format( "%i %i %i 1500", Colour.r, Colour.g, Colour.b ) )

		self.Project.Active = true
	elseif not self.Active and self.Project.Active then
		self.Project:SetKeyValue( "lightcolor", "0 0 0 0" )

		self.Project.Active = nil
	end
end