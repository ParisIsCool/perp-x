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

-- Code from ULX so thank Megiddo for this. This is so players don't get stuck in the world when you teleport them
local function playerSend( from, to, force )
	if not to:IsInWorld() and not force then return false end -- No way we can do this one
		local yawForward = to:EyeAngles().yaw
	local directions = { -- Directions to try
		math.NormalizeAngle( yawForward - 180 ), -- Behind first
		math.NormalizeAngle( yawForward + 180 ), -- Front
		math.NormalizeAngle( yawForward + 90 ), -- Right
		math.NormalizeAngle( yawForward - 90 ), -- Left
		yawForward,
	}
		local t = {}
	t.start = to:GetPos() + Vector( 0, 0, 15 ) -- Move them up a bit so they can travel across the ground
	t.filter = { to, from }
		local i = 1
	t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
	local tr = util.TraceEntity( t, from )
	while tr.Hit do -- While it's hitting something, check other angles
		i = i + 1
		if i > #directions then  -- No place found
			if force then
				return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
			else
				return false
			end
		end
			t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47
			tr = util.TraceEntity( t, from )
	end
	return tr.HitPos
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )

	local EyeTrace = self.Owner:GetEyeTrace()
	if not EyeTrace.Entity or not EyeTrace.Entity:GetClass() == "prop_ragdoll" then return end
	if not IsValid( EyeTrace.Entity.Owner ) then return end

	if EyeTrace.Entity.Owner:Alive() then return end
	
	local Distance = self.Owner:EyePos():Distance( EyeTrace.Entity:GetPos() )
	if Distance > 75 then return end

	if self.ChargeAmmount < 75 then
		if self.LastNoChargeError + 1 < CurTime() then
			self.LastNoChargeError = CurTime()
			self.Owner:Notify( "Not enough charge!" )
		end
		
		return
	end

	self.ChargeAmmount = self.ChargeAmmount - 75

	EyeTrace.Entity.Owner.DontFixCripple = true
	EyeTrace.Entity.Owner:Spawn()
	EyeTrace.Entity.Owner:SetHealth( 10 )
	EyeTrace.Entity.Owner:SetPos( EyeTrace.Entity:GetPos() )

	EyeTrace.Entity.Owner:Notify( "You have been revived by a medic!" )

	playerSend( EyeTrace.Entity.Owner, self.Owner )

	Log( Format( "%s(%s) revived %s(%s)", self.Owner:Nick(), self.Owner:GetRPName(), EyeTrace.Entity.Owner:Nick(), EyeTrace.Entity.Owner:GetRPName() ), Color( 0, 255, 0 ) )

	local Log = Format( "%s got $%i for reviving %s<%s>", self.Owner:Nick(), 50, EyeTrace.Entity.Owner:GetRPName(), EyeTrace.Entity.Owner:SteamID() )
	GAMEMODE:Log( "cashlog", Log, self.Owner:SteamID() )

	self.Owner:GiveCash( 50, true )
	self.Owner:Notify( "You have earned $50 for reviving a player." )
	
	self.Owner:GiveExperience( SKILL_FIRST_AID, 10 )
	self.Owner:AddProgress(33, 1)
end