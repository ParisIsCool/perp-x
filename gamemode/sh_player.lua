--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

if SERVER then
	util.AddNetworkString("perp_notify")
	util.AddNetworkString("perp_rp_notify")
end

--[[
	NOTIFICATIONS 
]]--
function PLAYER:Notify( Text, truefalse )
	if not IsValid( self ) then return end
		
	if SERVER then
		net.Start( "perp_notify" )
			net.WriteString( Text )
		net.Send(self)
	else
		AddNotify( Text, NOTIFY_GENERIC, 15, truefalse )
	end
end

--[[
	REPUTATION 
]]--
function PLAYER:ReputationNotify( Text )
	if not IsValid( self ) then return end
		
	if SERVER then
		net.Start( "perp_rp_notify" )
			net.WriteString( Text )
		net.Send(self)
	else
		AddNotify( Text, NOTIFY_HINT, 7, true )
	end
end

local maxRank = 1000
local override = {
	[0] = '0',
    [1] = '10'
}

function getRankRP(rank)
    if override[rank] then return override[rank] end
    
    local prev = getRankRP(rank - 1)
    return math.floor(rank ^ 2 + prev * ((rank - 1) * 0.000005)) * 10
end

function PLAYER:IsWarrented()
	return self:GetGNWVar( "warrented", nil )
end

local MaxRank = 8000
local Ranks = {}
local function CalcLevel(lvl)
	return Ranks[lvl]
end
for i=8000,1,-1 do
	Ranks[i] = (i*1250)+((i^2)*10)
end
GM.RP_Ranks = Ranks

function PLAYER:GetRP()
	return self:GetNWInt("reputation") or 0
end

function PLAYER:FindLevel(amount) -- the most innefficient function ever
	local rp = amount or self:GetRP()
	if SERVER then
		for k, v in pairs(Ranks) do
			if (rp-v) < 0 then self:SetNWInt("rp_rank",k-1) return k-1 end
		end
	else
		for k, v in pairs(Ranks) do
			if (rp-v) < 0 then return k-1 end
		end
	end
end

if SERVER then
	function PLAYER:SetRP(amount)
		if not self:GetNWInt("rp_rank") then self:FindLevel() end
		local rank = self:GetNWInt("rp_rank")
		if amount > Ranks[rank+1] and rank != 8000 then
			self:FindLevel(amount)
		end
		self:SetNWInt("reputation",amount)
	end
	function PLAYER:AddRP(amount)
        if self:GetNWBool("isAFK") then return end
		self:SetRP(self:GetRP()+amount)
	end
	concommand.Add("addrp", function(ply,cmd,args)
		if not ply:IsLeader() then return end
		ply:AddRP(tonumber(args[1]))
	end)
	util.AddNetworkString("fixlerpedrp")
	function PLAYER:SetLerpedRP(rp)
		net.Start("fixlerpedrp")
		net.WriteInt(rp,32)
		net.Send(self)
	end
end

function PLAYER:GetRPLevel()
	return self:GetNWInt("rp_rank")
end

if CLIENT then
	function PLAYER:GetLerpedRPLevel()
		if not self.lerpedrp then self.lerpedrp = self:GetNWInt("reputation") end
		if not self.lerpedrank then self.lerpedrank = self:FindLevel(self.lerpedrp) end
		if not self.lerpedrank then self.lerpedrank = 8000 end
		local rank = self.lerpedrank
		local nextrank = Ranks[rank+1]
		if not nextrank then nextrank = Ranks[rank] end
		if self.lerpedrp > nextrank and rank != 8000 then
			self.lerpedrank = self:FindLevel(self.lerpedrp)
		end
		return self.lerpedrank
	end
	net.Receive("fixlerpedrp", function()
		LocalPlayer().lerpedrp = net.ReadInt(32)
		LocalPlayer().lerpedrank = LocalPlayer():FindLevel(LocalPlayer().lerpedrp)
	end)
end

--[[
	RP NAME 
]]--

local FakeName = {
	["STEAM_0:0:600212122"] = "aSocket.net"
}

function PLAYER:GetRPName()
	return FakeName[self:SteamID()] or self:GetGNWVar( "rp_fname", "John" ) .. " " .. self:GetGNWVar( "rp_lname", "Doe" )
end

function PLAYER:GetFirstName()
	return self:GetGNWVar( "rp_fname", "John" )
end

function PLAYER:GetLastName()
	return self:GetGNWVar( "rp_lname", "Doe" )
end

--[[
	MISC 
]]--

function PLAYER:HasVehicleOut()
	return IsValid( Entity( self:GetGNWVar( "Vehicle", -1 ) ) )
end

function PLAYER:IsDoingSomethingTooFast()
	if not self.LastSpamCheck then self.LastSpamCheck = CurTime() end
	if self.LastSpamCheck > CurTime() then
		self:Notify( "Please slow down." )
		self.LastSpamCheck = CurTime() + 0.5

		return true
	end
end

function GetVectorTraceUp( vec )
	local trace = {}
		trace.start = vec
		trace.endpos = vec + Vector( 0, 0, 999999999 )
		trace.mask = MASK_SOLID_BRUSHONLY
	
	return util.TraceLine( trace )
end

function PLAYER:GetUpTrace()
	local ourEnt = self
	if self:InVehicle() then
		ourEnt = self:GetVehicle()
	end
	
	return GetVectorTraceUp( ourEnt:GetPos() )
end

function PLAYER:IsOutside() return self:GetUpTrace().HitSky end
function PLAYER:IsInside() return not self:IsOutside() end

function PLAYER:GetCash() return math.Round( self:GetPNWVar( "cash", 0 ) ) end
function PLAYER:GetBank() return math.Round( self:GetPNWVar( "bank", 0 ) ) end

--[[
	STAMINA 
]]--


function PLAYER:CalculateStaminaLoss()
	if not IsValid( self ) then return end

	if self.AdminStamina then return end

	if not self:GetNWFloat("Stamina") then self:SetNWFloat("Stamina", 100) end

	if self:GetObserverMode() == OBS_MODE_CHASE then return end
	
	local vel = Vector( self:GetVelocity().x, self:GetVelocity().y, 0 )
	local realSpeed = vel:Length()
	
	if SERVER and self:GetGNWVar( "typing", nil ) and realSpeed >= 20 and self.StartedTyping and self.StartedTyping + 2 < CurTime() then
		self:SetGNWVar( "typing", nil )
		self.StartedTyping = nil
	end
	
	if ( not self:InVehicle() and self:GetMoveType() ~= MOVETYPE_NOCLIP and ( ( not self.Crippled and self:KeyDown( IN_SPEED ) and realSpeed >= 50 ) or not self:OnGround() ) ) then
		-- Take
		self.LastStaminaSteal = self.LastStaminaSteal or 0
		self.NextStaminaExperience = self.NextStaminaExperience or 5

		if self.LastStaminaSteal + ( GAMEMODE.SprintDecay * ( 1 + ( self:GetSkillLevel( SKILL_STAMINA ) - 1 ) * .2 ) ) <= CurTime() then
			if self:Team() == TEAM_ZOMBIE then
				self:SetNWFloat("Stamina", math.Clamp( self:GetNWFloat("Stamina") - 8, 0, 100 ) )
			else
				self:SetNWFloat("Stamina", math.Clamp( self:GetNWFloat("Stamina") - 1, 0, 100 ) )
			end

			if SERVER and self:GetNWFloat("Stamina") == 25 then
				self:SetGNWVar( "tired", 1 )
			end
			
			self.LastStaminaSteal = CurTime()
			self.LastStaminaAdd = CurTime()
			
			self.NextStaminaExperience = self.NextStaminaExperience - 1
			if self:GetNWFloat("Stamina") ~= 0 and self.NextStaminaExperience == 0 then
				self.NextStaminaExperience = 5
				
				if SERVER then self:GiveExperience( SKILL_STAMINA, GAMEMODE.ExperienceForSprint ) end
			end
		end
	elseif self:OnGround() or self:InVehicle() or self:GetMoveType() == MOVETYPE_NOCLIP then
		-- Restore
		self.LastStaminaAdd = self.LastStaminaAdd or 0
		
		if self.LastStaminaAdd + ( GAMEMODE.SprintDecay * 6 ) <= CurTime() then
			if self:Team() == TEAM_ZOMBIE then
				self:SetNWFloat("Stamina", math.Round( math.Clamp( self:GetNWFloat("Stamina") + 4 + ( self:GetSkillLevel( SKILL_STAMINA ) - 1 ) * .4, 0, 100 ) ) )
			else
				self:SetNWFloat("Stamina", math.Round( math.Clamp( self:GetNWFloat("Stamina") + 1 + ( self:GetSkillLevel( SKILL_STAMINA ) - 1 ) * .1, 0, 100 ) ) )
			end
			
			if SERVER and self:GetNWFloat("Stamina") >= 26 and self:GetGNWVar( "tired" ) then
				self:SetGNWVar( "tired", nil )
			end
			
			self.LastStaminaAdd = CurTime()
		end
	end

	if SERVER then self:FindRunSpeed() end
end

function PLAYER:IsTransitOfficial()
	return self:Team() == TEAM_TAXI or self:Team() == TEAM_BUSDRIVER
end

function PLAYER:IsGovernmentOfficial()
	return JOB_DATABASE[self:Team()].GovOfficial
end

function PLAYER:GetTimePlayed()
	if CLIENT then
		return self:GetPNWVar( "time_played", 0 ) + ( CurTime() - GAMEMODE.LoadTime )
	else
		return self:GetPNWVar( "time_played", 0 ) + ( CurTime() - self.joinTime )
	end
end


if SERVER then
	concommand.Add("adminstamina", function(ply)
		if not ply:IsLeader() then return end
		ply.AdminStamina = not ply.AdminStamina
	end)
end

--[[
	TOOLTIPS 
]]--

function PLAYER:SendToolTip(tip,time)
	if CLIENT then
		if self.tooltip != tip or self.tooltiptime < CurTime() then
			surface.PlaySound("paris/notification2.mp3")
		end
	end
	self.tooltip = tip
	self.tooltiptime = time + CurTime()
	if SERVER then
		net.Start("sendperptooltip")
		net.WriteString(tip)
		net.WriteInt(time,32)
		net.Send(self)
	end
end

if SERVER then
	util.AddNetworkString("sendperptooltip")
else
	net.Receive("sendperptooltip", function()
		LocalPlayer():SendToolTip(net.ReadString(),net.ReadInt(32) or 10)
	end)
end