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

AccessorFunc( ENT, "NumBeers", "NumBeers" )

function ENT:Initialize()
	self:SetModel( "models/props/cs_militia/caseofbeer01.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	
	self:SetUseType( SIMPLE_USE )
end

function ENT:Use( activator )
	if self:GetNumBeers() > 1 then
		if not activator:CanHoldItem( 26, 1 ) then
			activator:Notify( "You don't have enough inventory room!" )
			return
		end
		activator:GiveItem( 26, 1 )
		
		self:SetNumBeers( self:GetNumBeers() - 1 )
	else
		if not activator:CanHoldItem( 85, 1 ) then
			activator:Notify( "You don't have enough inventory room!" )
			return
		end
		
		activator:GiveItem( 85, 1 )
		
		self:Remove()
	end
end