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
	self:SetModel( Model( "models/props_wasteland/light_spotlight01_lamp.mdl" ) )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():SetMass( 100 )
end

function ENT:OnTakeDamage()
	if self.broken then return end
	
	self.broken = true
	self.flashlight:Fire( "TurnOff", "", 0 )
	self:SetGNWVar( "TurnedOn", nil )
	
	self:SetSkin( 1 )
end