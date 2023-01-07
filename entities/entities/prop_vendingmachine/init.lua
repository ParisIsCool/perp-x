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
	self:SetModel( "models/props_wasteland/gaspump001a.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():EnableMotion(false)
end

function ENT:Use(ply)
	if CurTime() < (self.NextUse or 0) then return end
	local ItemTable = ITEM_DATABASE[62]
	if ply:GetCash() > ItemTable.Cost then
		ply:TakeCash(ItemTable.Cost)
	else
		return false
	end
	self:EmitSound("paris/vending2.mp3", 100)
	timer.Simple(1.5, function()
		local ItemDrop = ents.Create( "ent_item" )
		ItemDrop:SetModel( ItemTable.WorldModel )
		ItemDrop:SetContents( ItemTable.ID, ply )
		ItemDrop:SetPos( self:GetPos() + Vector(0,0,-25) + (self:GetForward()) )
		ItemDrop:SetAngles(Angle(self:GetAngles().p+90,self:GetAngles().y+90,0))
		ItemDrop:SetSpawnEffect( true )
		ItemDrop:SetVelocity(self:GetForward()*15)
		ItemDrop:Spawn()
	end)
	self.NextUse = CurTime() + 2.5
end

function ENT:Think()
	local near = ents.FindInSphere( self:GetPos(), 120 )
	for k, v in pairs(near) do
		if v:IsPlayer() then
			if v:GetEyeTrace().Entity == self then
				v:SendToolTip("Press [ E ] on vending machine to\nbuy a cola for $" .. ITEM_DATABASE[62].Cost .. ".",2)
			end
		end
	end
end