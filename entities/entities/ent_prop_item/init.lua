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
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	
	self.costItem = true
end

function ENT:Use( activator, caller )
	if not activator:IsPlayer() then return false end
	if not self.ItemID then self:Remove() return false end
	if activator ~= self.Owner then return false end
	if self.Tapped and self.Tapped > CurTime() then return false end

	if IsValid( activator:GetActiveWeapon() ) and activator:GetActiveWeapon():GetClass() == "weapon_physgun" then return false end
	
	if not activator:CanHoldItem( self.ItemID, 1 ) then
		return activator:Notify( "You don't have enough inventory room!" )
	end
	
	self.Tapped = CurTime() + 5
	
	activator:GiveItem( self.ItemID, 1 )
	
	self:Remove()
end

function ENT:SetContents( ItemID, Owner )
	self.ItemID = tonumber( ItemID )
	self.Owner = Owner
end