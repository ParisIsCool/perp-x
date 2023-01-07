--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function PLAYER:ForceEyeAngles( NPC )
	self.ForceEyeAnglesObj = NPC
end

function PLAYER:ClearForcedEyeAngles()
	self.ForceEyeAnglesObj = nil
end

net.Receive( "vip_time", function()
	local Time = net.ReadInt(32)

	if Time > 0 then -- unlimited vip
		GAMEMODE.VIPExpire = Time + os.time()
	else
		GAMEMODE.VIPExpire = nil
	end
end )

local timeoffset
net.Receive( "TimeSync", function()
	timeoffset = net.ReadInt(32) - os.time()
end )

function GM:Time()
	return os.time() + ( timeoffset or 0 )
end

function GetServerTime()
	return os.time() + ( timeoffset or 0 )
end

GM.Blacklists = GM.Blacklists or {}

net.Receive( "Blacklist", function()
	local Player 	= net.ReadString()
	local Type 		= net.ReadString()
	local Expire 	= net.ReadInt(32)
	local Reason 	= net.ReadString()
	local Value 	= net.ReadString()

	--print( "Blacklist", Player, Type, Expire, Reason, Value )
	
	GAMEMODE.Blacklists[ Player ] = GAMEMODE.Blacklists[ Player ] or {}

	if Value ~= "" then
		GAMEMODE.Blacklists[ Player ][ Type ] = GAMEMODE.Blacklists[ Player ][ Type ] or {}
		GAMEMODE.Blacklists[ Player ][ Type ][ Value ] = { Reason = Reason, Expire = Expire }
	else
		GAMEMODE.Blacklists[ Player ][ Type ] = { Reason = Reason, Expire = Expire }
	end
end )

net.Receive( "UnBlacklist", function()
	local Player 	= net.ReadString()
	local Type 		= net.ReadString()
	local Value 	= net.ReadString()

	--print( "UnBlacklist", Player, Type, Value )

	GAMEMODE.Blacklists[ Player ] = GAMEMODE.Blacklists[ Player ] or {}

	if Value ~= "" then
		if not GAMEMODE.Blacklists[ Player ][ Type ] or not GAMEMODE.Blacklists[ Player ][ Type ][ Value ] then return end

		GAMEMODE.Blacklists[ Player ][ Type ][ Value ] = nil
	else
		GAMEMODE.Blacklists[ Player ][ Type ] = nil
	end
end )

function PLAYER:HasBlacklist( Type, Value )
	if not GAMEMODE.Blacklists[ self:UniqueID() ] then return end

	local PossibleBlacklist = GAMEMODE.Blacklists[ self:UniqueID() ][ Type ]

	if Value and PossibleBlacklist then
		if PossibleBlacklist[ Value ] then
			if PossibleBlacklist[ Value ].Expire and ( PossibleBlacklist[ Value ].Expire == 0 or PossibleBlacklist[ Value ].Expire > GAMEMODE:Time() ) then
				return PossibleBlacklist[ Value ]
			else -- Expired
				GAMEMODE.Blacklists[ self:UniqueID() ][ Type ][ Value ] = nil
			end
		end
	elseif PossibleBlacklist then
		if PossibleBlacklist.Expire and ( PossibleBlacklist.Expire == 0 or PossibleBlacklist.Expire > GAMEMODE:Time() ) then
			return PossibleBlacklist
		else -- Expired
			GAMEMODE.Blacklists[ self:UniqueID() ][ Type ] = nil
		end
	end
end

net.Receive("BlacklistTable", function()
	GAMEMODE.Blacklists[net.ReadString()] = net.ReadTable() or {}
end)

net.Receive("BlacklistAdminTable", function()
	GAMEMODE.Blacklists = net.ReadTable() or {}
end)

function PLAYER:HasBuddy( otherPlayer )
	if self == otherPlayer then return true end

	for _, v in pairs( GAMEMODE.Buddies ) do
		if v[2] and v[2] == otherPlayer:UniqueID() then
			return true
		end
	end
end

GM.OrganizationData = GM.OrganizationData or {}
function PLAYER:GetOrganizationName()
	if self:GetGNWVar( "org", 0 ) == 0 then return end
	
	if GAMEMODE.OrganizationData[ self:GetGNWVar( "org", 0 ) ] then
		return GAMEMODE.OrganizationData[ self:GetGNWVar( "org", 0 ) ][1]
	end

	return "Unknown"
end

function PLAYER:HasLOS( Entity )
	local tr = util.TraceLine( {
		start 	= self:GetShootPos(),
		endpos 	= Entity:GetPos() + Vector( 0, 0, 64 ),
		filter 	= { Entity, self, self:GetActiveWeapon(), self:GetVehicle() },
		mask 	= bit.bor( CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE )
	} )
	
	local tr2 = util.TraceLine( {
		start 	= self:GetShootPos(),
		endpos 	= Entity:GetPos(),
		filter 	= { Entity, self, self:GetActiveWeapon(), self:GetVehicle() },
		mask 	= bit.bor( CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE )
	} )
	
	if tr.Fraction > 0.98 or tr2.Fraction > 0.98 then return true end
end

function PLAYER:CanSee( Entity, Strict )
	if not IsValid( Entity ) then return end
	
	if Strict then
		if not self:HasLOS( Entity ) then return end
	end

	if self:GetPos():Distance( Entity:GetPos() ) < 200 then return true end

	local fov = self:GetFOV()
	local Disp = Entity:GetPos() - self:GetPos()
	local Dist = Disp:Length()
	local EntWidth = Entity:BoundingRadius() * 0.5
	
	local MaxCos = math.abs( math.cos( math.acos( Dist / math.sqrt( Dist * Dist + EntWidth * EntWidth ) ) + fov * ( math.pi / 180 ) ) )
	Disp:Normalize()

	if Disp:Dot( self:EyeAngles():Forward() ) > MaxCos and Entity:GetPos():Distance( self:GetPos() ) < 5000 then
		return true
	end
end

net.Receive("PerpExtrasClientOnly", function()
	local data = net.ReadTable()
	if not LocalPlayer()[data[1]] then LocalPlayer()[data[1]] = {} end
	LocalPlayer()[data[1]] = data[2]
end)


concommand.Add("getvector", function(ply)
	local x,y,z = math.Round(ply:GetPos().x),math.Round(ply:GetPos().y),math.Round(ply:GetPos().z)
	local String = "Vector( "..x..", "..y..", "..z.." )"
	SetClipboardText(String)
	MsgC(Color(70, 211, 242), "Copied vector to clipboard.")
end)