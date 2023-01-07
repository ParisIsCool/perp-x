--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local SHeight = 5
local SWidth = 2.5
local MaxHeight = 25
local MaxWidth = 15

function EFFECT:Render()
	if not LocalPlayer():CanSee( self.Pot, true ) then return end

	if not self.Pot.SpawnTime then
		self.Pot.SpawnTime = self.Pot:GetGNWVar( "SpawnTime" )
	end

	local GrowthPercent = ( CurTime() - ( self.Pot.SpawnTime or CurTime() ) ) / self.Pot.GrowthTime

	if GrowthPercent <= 1 then
		local W = SWidth + ( GrowthPercent * MaxWidth )

		local Mat = Matrix()
		Mat:Scale( .05 * Vector( W, W, SHeight + ( GrowthPercent * MaxHeight ) ) )
		self:EnableMatrix( "RenderMultiply", Mat )
	end

	self:SetParent( self.Pot )

	self:DrawModel()
end

function EFFECT:Think()
	if IsValid( self.Pot ) then
		local OurPos = self.Pot:LocalToWorld( self.Pot:OBBCenter() + Vector( 0, 0, 10 ) )
		local OurAng = self.Pot:LocalToWorldAngles( self.Angle )
	
		self:SetPos( OurPos )
		self:SetAngles( OurAng )
	end

	return true
end

function EFFECT:Init( data )
	self.Pot = data:GetEntity()
	self.Angle = data:GetAngles()

	if self.Pot:GetClass() == "ent_weed" then
		self:SetModel( "models/props_foliage/spikeplant01.mdl" )
	elseif self.Pot:GetClass() == "ent_cocaine" then
		self:SetModel( "models/props_foliage/ferns02.mdl" )
	end

	self:SetAngles( self.Angle )

	self:SetParent( self.Pot )

	self:PhysicsInit( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
end