AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/griim/christmas/present_colourable.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:GetPhysicsObject():EnableMotion( false )
	
	self:DrawShadow(false)

end

util.AddNetworkString("xmascollectableset")
function ENT:Use(Player)

	if not self.Collectable then return end
	if Player:HasCollectable(self.Collectable[1],self.Collectable[2]) then return end

	Player:SetCollectable(self.Collectable[1],self.Collectable[2],true)

	Player:SetAchievementStatus("presentscollectable",Player:GetAchievementStatus("presentscollectable")+1)

	net.Start("xmascollectableset")
	net.WriteEntity(self)
	net.Send(Player)
end