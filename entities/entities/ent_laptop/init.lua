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
    self:SetModel("models/posablelaptop/laptop.mdl")

    self:SetSkin(1)

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
end

util.AddNetworkString("perp_open_laptop")
function ENT:Use( activator, caller )
	if not activator:IsPlayer() then return false end
    if activator:KeyDown(IN_WALK) then
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
    else
        net.Start("perp_open_laptop")
        net.WriteEntity(self)
        net.Send(activator)
    end
end

function ENT:Think()
	local near = ents.FindInSphere( self:GetPos(), 120 )
	for k, v in pairs(near) do
		if v:IsPlayer() then
			if v:GetEyeTrace().Entity == self and self.Owner == v then
				v:SendToolTip("Press [ E ] on laptop to access the screen.\nPress [  ALT  ] + [ E ] to pick up the laptop.",2)
			end
		end
	end
end

function ENT:SetContents( ItemID, Owner )
	self.ItemID = tonumber( ItemID )
	self.Owner = Owner
end