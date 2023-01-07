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

local Types = {
	{id=28,ammo={"smg1",60},slot=1},
	{id=34,ammo={"pistol",20},slot=2},
	{id=35,ammo={"pistol",25},slot=2},
	{id=37,ammo={"buckshot",20},slot=1},
}

function ENT:Initialize()

	local Type = Types[math.random(1,#Types)]

	self:SetModel( ITEM_DATABASE[Type.id].WorldModel )
	self.Type = Type

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	self:GetPhysicsObject():Wake()
end

function ENT:StartTouch( Entity )
	if not IsValid(Entity) or not Entity:IsPlayer() then return end
	self:Remove()

	local slot = Entity:GiveItem(self.Type.id, 1)
	if not Entity.PlayerItems[self.Type.slot] then
		Entity:SwapItemPosition( slot, self.Type.slot )
		Entity:SendLua("LocalPlayer():SwapItemPosition( " .. slot ..", " .. self.Type.slot .. " )")
	end

	--Entity:SendLua("GAMEMODE.UseItem( ".. self.Type.slot .." )")
	--ITEM_DATABASE[self.Type.id].Equip(Entity)

	Entity:GiveAmmo(self.Type.ammo[2],self.Type.ammo[1],false)
end