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
end

function ENT:Use( activator, caller )
	if not activator:IsPlayer() then return false end
	if not self.ItemID then self:Remove() return false end
	if self.Tapped and self.Tapped > CurTime() then return false end
	
	if activator:Team() ~= TEAM_CITIZEN and ITEM_DATABASE[ self.ItemID ].RestrictedSelling then self:Remove() return activator:Notify( "You've destroyed this illegal item" ) end

	if self.ForSale then
		if activator ~= self.Owner then
			if self.ForSalePrice >= 1 then
				return activator:OpenItemBuyingDialog( self, ITEM_DATABASE[ self.ItemID ].Name )
			end
		end
	end

	if not activator:CanHoldItem( self.ItemID, 1 ) then
		return activator:Notify( "You don't have enough inventory room!" )
	elseif self.ForSale then
		activator:Notify( "You picked up your own item." )

		activator.ItemsForSale = ( activator.ItemsForSale or 1 ) - 1
	end

	activator:GiveItem( self.ItemID, 1 )
	
	self.Tapped = CurTime() + 5
	
	self:Remove()
end

function ENT:SetContents( ItemID, Owner )
	self.ItemID = tonumber( ItemID )
	self.Owner = Owner
end