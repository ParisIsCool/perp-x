AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Initialize
---------------------------------------------------------------------------------------------------------------------------------------------
*/


function ENT:SpawnFunction(ply,tr,class)
	local weap = ply:Give("weapon_policeshield");
	weap.Owner = ply;
end


function ENT:Initialize()
	self:SetModel("models/drover/shield_d.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	local phys = self:GetPhysicsObject();
	phys:Wake();
	phys:SetMass(1000)
	local ply = self.Getowning_ent and self:Getowning_ent() or nil;
	if IsValid(ply) and ply:IsPlayer() then
		self.Owner = ply;
		self:CPPISetOwner(ply);
	end
	
	self:ResetSequence(self:LookupSequence("deploy"));
end





/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Use function
---------------------------------------------------------------------------------------------------------------------------------------------
*/



function ENT:Use(activator, caller)
	if self.Owner == nil then self:Remove(); return end;
	if not IsValid(self.Owner) then self:Remove(); return end;
	if self.Owner != activator then return end;
	
	local weap = activator:Give("weapon_policeshield");
	weap.Owner = activator;
	self:Remove();
end 



/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				On Take Damage
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function ENT:OnTakeDamage(dmg)
    local typ = dmg:GetDamageType();
	
	if self.onlyExplosionDamage and bit.band(typ, DMG_BLAST) ~= DMG_BLAST then return end;
	local damage = dmg:GetDamage();
	self.currentHealth = self.currentHealth - damage;
	if self.currentHealth <= 0 then 
		self:Remove();
	end
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Another
---------------------------------------------------------------------------------------------------------------------------------------------
*/
 
function ENT:Think()
	self:NextThink(CurTime());  return true;
end

function ENT:OnRemove()

end
