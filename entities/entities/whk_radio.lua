AddCSLuaFile()

if not whk then return end

ENT.Base = "whk_mediasource"

ENT.PrintName		= "Radio"
ENT.Author			= "Wyozi"
ENT.Category		= "Wyozi Home Kit"

ENT.Spawnable		= true
ENT.AdminOnly		= true

ENT.CanSetUrl = false

ENT.Model = "models/props_lab/citizenradio.mdl"

ENT.Price = 200

function ENT:OnChannelChanged(name, old, new)
	local station = whk.RadioStations[(new % (#whk.RadioStations + 1))]
	self:SetUrl(station and station.Link or "")
end

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 2, "Channel")
	self:NetworkVarNotify("Channel", self.OnChannelChanged)
end

if SERVER then
	local cvar_health = CreateConVar("whk_health_radio", "0", FCVAR_ARCHIVE)
	function ENT:Initialize()
		self.BaseClass.Initialize(self)

		local health = cvar_health:GetInt()
		self:SetHealth(health == 0 and 99999999 or health)
		self:PrecacheGibs()
	end

	function ENT:OnTakeDamage(dmginfo)
		self:SetHealth(self:Health() - dmginfo:GetDamage())

		if self:Health() <= 0 then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			util.Effect("StunstickImpact", effectdata)

			self:GibBreakClient(Vector(0, 0, 0))

			self:Remove()
		end
	end
end


ENT.RenderGroup = RENDERGROUP_BOTH

if CLIENT then
	local tdui = whk.tdui
	
	surface.CreateFont("WHK_RadioFontS", {
		font = "Roboto",
		size = 18
	})

	local back_poly = {
		{ x = 20, y = 118 },
		{ x = 0, y = 105 },
		{ x = 20, y = 92 },
	}
	local fwd_poly = {
		{ x = 80, y = 92 },
		{ x = 100, y = 105 },
		{ x = 80, y = 118 },
	}
	function ENT:DrawTranslucent()
		self.p = self.p or tdui.Create()
		local p = self.p

		local station = whk.RadioStations[(self:GetChannel() % (#whk.RadioStations + 1))]

		p:Polygon(back_poly, Color(230, 230, 230))
		if p:Button("", "DermaLarge", -8, 85, 42, 40, Color(0, 0, 0, 0)) then
			net.Start("whk_radioswitch")
			net.WriteEntity(self)
			net.WriteBool(false)
			net.SendToServer()
		end

		p:Polygon(fwd_poly, Color(230, 230, 230))
		if p:Button("", "DermaLarge", 67, 85, 42, 40, Color(0, 0, 0, 0)) then
			net.Start("whk_radioswitch")
			net.WriteEntity(self)
			net.WriteBool(true)
			net.SendToServer()
		end

		p:Cursor()

		p:Render(self:LocalToWorld(Vector(9.7, 0, 18)), self:LocalToWorldAngles(Angle(0, 180, 0)), 0.1)

		cam.Start3D2D(self:LocalToWorld(Vector(8.5, 0, 18)), self:LocalToWorldAngles(Angle(0, 90, 90)), 0.1)

		surface.SetDrawColor(0, 0, 0, 250)
		surface.DrawRect(-55, 30, 160, 30)
		draw.SimpleText(station and station.Name or "-", "WHK_RadioFontS", -50, 36)
		cam.End3D2D()
	end

	local RADIO_PARTICLES = false

	function ENT:Think()
		self.RadioEmitter = self.RadioEmitter or ParticleEmitter( self:GetPos() )

		if RADIO_PARTICLES and (not self.NextRParticle or self.NextRParticle < CurTime()) then

			local rnd = self:NearestPoint(self:GetPos() + Vector(0, 0, 10) + VectorRand() * 20)

			local emitter = self.RadioEmitter

			local particle = emitter:Add( "sprites/light_glow02_add", rnd )
			particle:SetVelocity( ( Vector( 0, 0, 1 ) + ( VectorRand() * 0.1 ) ) * math.random( 15, 30 ) )
			particle:SetDieTime( math.random( 0.3, 0.5 ) )
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( 10 )
			particle:SetEndSize( 1.5 )
			particle:SetRoll( math.random(0.5, 10) )
			particle:SetRollDelta( math.Rand(-0.2, 0.2) )
			particle:SetColor( 255*math.random(), 255*math.random(), 255*math.random() )
			particle:SetCollide( false )

			local grav = Vector(0, 0, math.random(30, 40))
			particle:SetGravity( grav )
			grav = grav + Vector(0, 0, math.random(-10, -5))

			self.NextRParticle = CurTime() + 0.1

		end

		return self.BaseClass.Think(self)
	end
end

if SERVER then
	util.AddNetworkString("whk_radioswitch")
	net.Receive("whk_radioswitch", function(len, cl)
		local ent = net.ReadEntity()
		if not IsValid(ent) or ent:GetClass() ~= "whk_radio" or not ent:CanInteract(cl) then return end

		local fwd = net.ReadBool()
		ent:SetChannel(ent:GetChannel() + (fwd and 1 or -1))
	end)
end
