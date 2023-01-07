--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

timer.Create( "Pong", 1, 0, function() umsg.Start( "\8P" ) umsg.End() end )

/*************************************************
	Command "perpx_giveitembag"
	Job: Gives item to Owner through Owner Item Menu
*************************************************/

concommand.Add( "perpx_giveitembeg", function(objPl, _, tblArgs)
	if not objPl:IsSuperAdmin() then return end
	
	objPl:GiveItem( tonumber( tblArgs[ 1 ] ), 1 )
end )

timer.Create( "ManageSprint", 0.2, 0, function()
	for _, v in pairs( player.GetAll() ) do
		v:CalculateStaminaLoss()
	end
end )

util.AddNetworkString("perp_bomb")

function GM.Explode( pos, damage_dealer )
	local recipient = RecipientFilter()
	recipient:AddPVS( pos )

	net.Start( "perp_bomb" )
		net.WriteVector( pos )
	net.Send(recipient)

	if damage_dealer and IsValid( damage_dealer ) and damage_dealer:IsPlayer() then
		for i = 1, 5 do
			util.BlastDamage( damage_dealer, damage_dealer, pos, 300, 300 )
		end
	end
	
	for i = 1, 5 do
		local Offset = Vector( math.random( -50, 50 ), math.random( -50, 50 ), 0 )
			
		local Trace = {}
			Trace.start = pos + Offset + Vector( 0, 0, 32 )
			Trace.endpos = pos + Offset - Vector( 0, 0, 1000 )
			Trace.mask = MASK_SOLID_BRUSHONLY
		local TR = util.TraceLine( Trace )
				
		if TR.Hit then					
			local Fire = ents.Create( "ent_fire" )
				Fire:SetPos( TR.HitPos )
			Fire:Spawn()
		end
	end
end

timer.Create( "perp2_save_economy", 60, 0, function()
	file.Write( "gtaonline/economy_budget.txt", GAMEMODE.CityBudget or 0 )
end )

util.AddNetworkString("UpdateMixtures")
function PLAYER:UnlockMixture( MixtureID )
	if self:HasMixture( MixtureID ) then return false end
	if MIXTURE_DATABASE[ MixtureID ].Free then return false end
	
	self:SetPNWVar( "mixtures", self:GetPNWVar( "mixtures", "" ) .. tostring( MixtureID ) .. "-" )
	self:Notify( "You have unlocked the " .. MIXTURE_DATABASE[ MixtureID ].Name .. " mixture!" )

	net.Start("UpdateMixtures")
	net.Send(self)
	
	return true
end

timer.Create("perp2_setdate", 60, 0, function()
	local curDate = os.date("%m.%d")
	
	if (GetGlobalString("os.date", "") != curDate) then
		SetGlobalString("os.date", curDate)
	end
end )
function GM.SetDate ( )
	local curDate = os.date("%m.%d")
	
	if (GetGlobalString("os.date", "") != curDate) then
		SetGlobalString("os.date", curDate)
	end
end
GM.SetDate()

local function cough(ply)
    ply:EmitSound("paris/coughs/cough"..math.random(1,7)..".mp3")
    ply:AddRP(50)
	ply:ReputationNotify( "+50 RP for having covid!" )
end

timer.Create("CoughTimer", 0.5, 0, function()
	for k, v in pairs(player.GetAll()) do
		if v:IsInvisible() then continue end
		local chance = math.random(1, 10000) -- 1/10000
		if chance == 1 then
			cough(v)
		end
	end
end)

hook.Add("PlayerSay", "CarStuck", function(ply,text)
	if ((ply.carstuckcooldown or 0) - CurTime()) > 0 then
		ply:ChatPrint("Car Stuck Cooldown: " .. tostring(math.Round(ply.carstuckcooldown-CurTime(),1)) .. " second(s)." )
		return false
	end
	if string.StartWith(text, "!carstuck") then
		if IsValid(ply:GetVehicle()) then
			local veh = ply:GetVehicle()
			veh:GetPhysicsObject():AddVelocity(Vector(0,0,400) + (veh:GetForward()*-400))
			ply.carstuckcooldown = CurTime()+10
			for k, v in pairs(player.GetAll()) do
				if v:IsAdmin() then
					v:ChatPrint(string.format("%s [%s] used car stuck command.", ply:Nick(), ply:SteamID()))
				end
			end
		end
		return false
	end
end)

local function ReplaceGasPumps()
	local gaspumpmodels = {
		"models/unioncity2/props_unioncity/gaspump_712.mdl",
		"models/unioncity2/props_unioncity/gas_pump.mdl",
	}
	for _, model in pairs(gaspumpmodels) do
		for _, ent in pairs(ents.FindByModel(model)) do
			local NewGasPump = ents.Create("prop_explosivegaspump")
			NewGasPump:SetPos(ent:GetPos())
			NewGasPump:SetAngles(ent:GetAngles())
			NewGasPump:SetModel(ent:GetModel())
			NewGasPump:Spawn()
			ent:Remove()
		end
	end
end
hook.Add("InitPostEntity", "ReplaceGasPumps", ReplaceGasPumps)

local function AddVendingMachines()
	local vendingpos = {
		{pos=Vector(-882,4875,-84),ang=Angle(0,89,0)},
		{pos=Vector(7125,1220,789),ang=Angle(0,-180,0)},
		{pos=Vector(7676,5482,244),ang=Angle(0,90,0)},
		{pos=Vector(9911,1178,116),ang=Angle(0,-180,0)},
		{pos=Vector(8369,7236,220),ang=Angle(0,0,0)},
		{pos=Vector(-5705,1227,-3),ang=Angle(0,180,0)},
		{pos=Vector(550,14392,148),ang=Angle(0,0,0)},
		{pos=Vector(-3633,1141,-77),ang=Angle(0,180,0)},
		{pos=Vector(509,10701,155),ang=Angle(0,90,0)},
	}
	for _, v in pairs(vendingpos) do
		for k, v in pairs(ents.FindInSphere(v.pos,50)) do
			if v:GetClass() == "prop_vendingmachine" or v:GetClass() == "func_button" then
				v:Remove()
			end
		end
		local Vending = ents.Create("prop_vendingmachine")
		Vending:SetPos(v.pos - Vector(0,0,-30))
		Vending:SetAngles(v.ang)
		Vending:AddEffects( bit.bor( EF_NOSHADOW, EF_NODRAW ) )
		Vending:SetCollisionGroup( COLLISION_GROUP_WORLD )
		Vending:Spawn()
	end
end
hook.Add("InitPostEntity", "AddVendingMachines", AddVendingMachines)

local function AddEasterEggRadio()
	local vectors = {
		{pos=Vector(-7779,3737,-39),ang=Angle(0,-86,0),song="paris/interiorsong.mp3",length=110},
		{pos=Vector(-1416,-6147,-319),ang=Angle(-2,-97,0),song="paris/spongebobmusic.mp3",length=73},
		{pos=Vector(-2526,7655,168),ang=Angle(0,-90,0),song="paris/verychristiansong.mp3",length=150},
	}
	for _, v in pairs(vectors) do
		for k, v in pairs(ents.FindInSphere(v.pos,50)) do
			if v.MusicEgg then
				v:Remove()
			end
		end
		local Music = ents.Create("prop_radio")
		Music.MusicEgg = true
		Music.Song = v.song
		Music.SongLength = v.length
		Music:SetPos(v.pos)
		Music:SetAngles(v.ang)
		Music:Spawn()
	end
end
hook.Add("InitPostEntity", "AddEasterEggRadio", AddEasterEggRadio)

util.PrecacheModel("models/lonewolfie/ferrari_laferrari.mdl")

if bgNPC then 
	bgNPC.cfg:SetActor('police', {
		enabled = false,
	})
end