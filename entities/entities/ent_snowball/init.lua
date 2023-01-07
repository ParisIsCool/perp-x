AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
PrecacheParticleSystem("snow_impact")

function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_snowball_thrown.mdl");
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:EnableGravity(true);
	end
	self.Trail = util.SpriteTrail(self.Entity, 0, Color(255,255,255,255), false, 15, 1, 0.2, 1/(15+1)*0.5, "trails/laser.vmt") 
end

function ENT:Think()
end

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16;
	local ent = ents.Create("ent_snowball");
	ent:SetPos(SpawnPos);
	ent:Spawn();
	ent:Activate();
	ent:SetOwner(ply)
	return ent;
end

function ENT:PhysicsCollide(data)

	local damage = ents.Create("point_hurt")
	damage:SetKeyValue("DamageRadius", 1)
	damage:SetKeyValue("Damage" , 200)
	damage:SetPos(self.Entity:GetPos())
	
	local pos = self.Entity:GetPos() --Get the position of the snowball
	local effectdata = EffectData()
	effectdata:SetStart( pos )
	effectdata:SetOrigin( pos )
	effectdata:SetScale( 1 )
	util.Effect( "watersplash", effectdata ) -- effect
	util.Effect( "inflator_magic", effectdata ) -- effect
	util.Effect( "WheelDust", effectdata ) -- effect
	util.Effect( "GlassImpact", effectdata ) -- effect
	self.Entity:Remove(); --Remove the snowball
end 

-- these should work.
resource.AddFile( "materials/models/weapons/v_models/sball/v_hands.vmt" )
resource.AddFile( "materials/models/weapons/v_models/sball/v_hands.vtf" )
resource.AddFile( "materials/models/weapons/v_models/sball/v_hands_normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/snooball/s.vmt" )
resource.AddFile( "materials/models/weapons/v_models/snooball/s.vtf" )
resource.AddFile( "materials/models/weapons/v_models/snooball/s_norm.vtf" )
resource.AddFile( "materials/weapons/snowball_icon.vtf" )
resource.AddFile( "materials/weapons/snowball_icon.vmt" )
resource.AddFile( "materials/vgui/entities/real_snowball_swep.vmt" )
resource.AddFile( "materials/vgui/entities/real_snowball_swep.vtf" )

resource.AddFile( "models/weapons/v_snowball.mdl" )
resource.AddFile( "models/weapons/v_snowball.vvd" )
resource.AddFile( "models/weapons/v_snowball.dx80.vtx" )
resource.AddFile( "models/weapons/v_snowball.dx90.vtx" )
resource.AddFile( "models/weapons/v_snowball.sw.vtx" )
resource.AddFile( "models/weapons/w_snowball.mdl" )
resource.AddFile( "models/weapons/w_snowball.phy" )
resource.AddFile( "models/weapons/w_snowball.vvd" )
resource.AddFile( "models/weapons/w_snowball.dx80.vtx" )
resource.AddFile( "models/weapons/w_snowball.dx90.vtx" )
resource.AddFile( "models/weapons/w_snowball.sw.vtx" )
resource.AddFile( "models/weapons/w_snowball_thrown.mdl" )
resource.AddFile( "models/weapons/w_snowball_thrown.phy" )
resource.AddFile( "models/weapons/w_snowball_thrown.vvd" )
resource.AddFile( "models/weapons/w_snowball_thrown.dx80.vtx" )
resource.AddFile( "models/weapons/w_snowball_thrown.dx90.vtx" )
resource.AddFile( "models/weapons/w_snowball_thrown.sw.vtx" )
