AddCSLuaFile()

ENT.Base = "whk_mediasource"

ENT.PrintName		= "TV"
ENT.Author			= "Wyozi"
ENT.Category		= "Wyozi Home Kit"

ENT.Spawnable		= true
ENT.AdminOnly		= true

ENT.Model = "models/props/cs_office/TV_plasma.mdl"

ENT.Price = 450

if SERVER then
	local cvar_health = CreateConVar("whk_health_tv", "0", FCVAR_ARCHIVE)
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

if CLIENT then
	local cvar_bleed = CreateConVar("whk_tv_colorbleeding", "0")

	local bleedRt
	function ENT:Draw()
		self:DrawModel()

		if IsValid(self.Media) then
			local mw = 860
			cam.Start3D2D(self:LocalToWorld(Vector(6.2, 0, 19)), self:LocalToWorldAngles(Angle(0, 90, 90)), 0.065)
			self.Media:draw(-mw/2, -256, mw, 512)
			cam.End3D2D()

			if cvar_bleed:GetBool() then
				bleedRt = bleedRt or GetRenderTarget("WHKTVBleedRT", 4, 4)

				render.PushRenderTarget(bleedRt)
				cam.Start2D()
				self.Media:draw(0, 0, 4, 4)
				cam.End2D()
				render.CapturePixels()
				render.PopRenderTarget()

				local clr = Color(0, 0, 0)

				for x=0, 3 do
					for y=0, 3 do
						local r, g, b = render.ReadPixel(x * (4 / 128), y * (4 / 128))
						clr.r = clr.r + r
						clr.g = clr.g + g
						clr.b = clr.b + b
					end
				end
				clr.r = clr.r / (4*4)
				clr.g = clr.g / (4*4)
				clr.b = clr.b / (4*4)

				self.TvColor = clr

				--[[
				cam.Start2D()

				local y = 100

				for x=0, 3 do
				for y=0, 3 do

				    local r, g, b = render.ReadPixel( x, y )

				    surface.SetDrawColor( r, g, b, 255 )
				    surface.DrawRect( 600 + x * 10, 400 + y * 10, 10, 10 )

				end
				end

				cam.End2D()
				]]
			end
		end
	end

	function ENT:Think()
		if cvar_bleed:GetBool() and self.TvColor then
			local dlight = DynamicLight(self:EntIndex())
			if ( dlight ) then
				dlight.pos = self:LocalToWorld(Vector(15, 0, 20))
				dlight.r = 255
				dlight.g = 255
				dlight.b = 255
				dlight.brightness = 2
				dlight.Decay = 1000
				dlight.Size = 100
				dlight.DieTime = CurTime() + 1

				local clr = self.TvColor
				dlight.r = clr.r
				dlight.g = clr.g
				dlight.b = clr.b
			end
		end

		return self.BaseClass.Think(self)
	end
end