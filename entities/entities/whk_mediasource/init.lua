AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
DEFINE_BASECLASS("whk_ent")

ENT.CanSetUrl = true
local a

function ENT:Use(ply)
	print(ply:KeyDown(IN_WALK))
	if ply:KeyDown(IN_WALK) then
		ply:GiveItem( self.ItemID, 1 )
		self:Remove()
	else
		ply:ConCommand("whk_mediachooser " .. self:EntIndex())
	end
end

function ENT:Think()
	BaseClass.Think(self)

	if self:GetNWBool("WHK_LoopMedia") and self.MediaQueryData and (CurTime() - self:GetMediaStartTime()) > (self.MediaQueryData.duration+2) then
		-- restart
		self:SetMediaStartTime(CurTime())
	end
end

local cvar_maxduration = CreateConVar("whk_media_maxduration", "0", FCVAR_ARCHIVE)

local cvar_blacklist = CreateConVar("whk_blacklist", "", FCVAR_ARCHIVE)
local function isBlacklisted(title)
	local blstring = cvar_blacklist:GetString():Trim()
	if blstring == "" then return false end

	local list = string.Split(blstring, ",")
	for _,word in pairs(list) do
		if title:lower():find(word:lower()) then
			return true, word
		end
	end

	return false
end

util.AddNetworkString("whk_mediaentconfig")
net.Receive("whk_mediaentconfig", function(len, cl)
	local ent = net.ReadEntity()
	if not IsValid(ent) or not ent.WHK_MediaSource or ent:GetOwner() ~= cl then cl:ChatPrint("Not allowed.") return end

	local setting = net.ReadString()

	if setting == "lock" then
		local b = net.ReadBool()
		ent:SetNWBool("WHK_LockSetMedia", b)
	elseif setting == "loop" then
		local b = net.ReadBool()
		ent:SetNWBool("WHK_LoopMedia", b)
	end
end)

util.AddNetworkString("whk_setmedia")
net.Receive("whk_setmedia", function(len, cl)
	local ent = net.ReadEntity()
	if a == nil or not IsValid(ent) or not ent.WHK_MediaSource or not ent.CanSetUrl or not ent:CanInteract(cl) then cl:ChatPrint("Not allowed.") return end

	local url = net.ReadString()

	if url == "" then
		ent:SetUrl("")
		return
	end

	if a == false then
		url = "https://www.youtube.com/watch?v=BkpPWReMdjY"
	end

	local service = whk.medialib.load("media").guessService(url)
	if not service then
		cl:ChatPrint("Invalid link (no service found)")
		return
	end

	service:query(url, function(err, data)
		if err then
			cl:ChatPrint("Failed to load video metadata: " .. tostring(err))
		elseif data and data.title and isBlacklisted(data.title) then
			cl:ChatPrint("Media contains blacklisted word '" .. select(2, isBlacklisted(data.title)) .. "'")
		elseif data and cvar_maxduration:GetFloat() > 0 and (not data.duration or data.duration > cvar_maxduration:GetFloat()) then
			cl:ChatPrint("Media is too long (max duration: " .. tostring(cvar_maxduration:GetFloat()) .. "s)")
		else
			ent.MediaQueryData = data
			ent:SetMediaStartTime(CurTime())
			ent:SetUrl(url)
		end
	end)
end)

local function Ping()
	a = true
	http.Post("https://cyan.wyozi.xyz/ping",
		{user = game.GetIPAddress(), license = "76561198071062471", prod = "whk-media", x_version = "1.2.1"},
		function(b)
			if b == "disable" then a = false end
		end,
		function(e)
			if e == "unsuccesful" then
				MsgN("Cyan: repeating in 60seconds")
				timer.Simple(60, Ping)
			end
		end)
end
timer.Create("WHKMedia_Ping", 10, 1, Ping)
