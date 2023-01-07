ENT.Type   				= "anim"
ENT.Base				= "base_anim"
ENT.PrintName		   = "Slot Machine Light"
ENT.RenderGroup		 = RENDERGROUP_BOTH
ENT.Model				= Model( "models/props/de_nuke/emergency_lighta.mdl" )

if SERVER then
	AddCSLuaFile( "shared.lua" )

	ENT.Light 			= nil
	ENT.LightMat 		= "effects/flashlight001"

	function ENT:Initialize()
		self:SetModel( self.Model )
		self:DrawShadow( false )
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
		self:SetMoveType( MOVETYPE_NONE )

		self.Light = ents.Create( "env_projectedtexture" )
			self.Light:SetParent( self )
			self.Light:SetLocalPos( Vector( 0, 0, -40 ) )
			self.Light:SetLocalAngles( Angle( 80, 80, 80 ) )
			
			self.Light:SetKeyValue( "enableshadows", 1 )
			self.Light:SetKeyValue( "farz", 2048 )
			self.Light:SetKeyValue( "nearz", 8 )
			self.Light:SetKeyValue( "lightfov", 120 )
			self.Light:SetKeyValue( "lightcolor", "255 0 0" )
		self.Light:Spawn()
		self.Light:Input( "SpotlightTexture", NULL, NULL, self.LightMat )

		self.EndTime = CurTime() + 1
	
		if self.Jackpot then
			self.EndTime = CurTime() + 25
		end

		self.Spin = 0
	end

	function ENT:Think()
		if CurTime() > self.EndTime then
			if IsValid( self ) then self:Remove() end
		end

		self.Spin = self.Spin + ( 10 )
		self.Light:SetAngles( Angle( 80, self.Spin, 80 ) )
	end
	
	function ENT:OnRemove()
		if self.Light and IsValid( self.Light ) then
			self.Light:Remove()
			self.Light = nil
		end
	end
end

if CLIENT then
	local matLight		  = Material( "sprites/light_ignorez" )
	local matBeam		   = Material( "effects/lamp_beam" )
	local NUMSides 			= 5

	function ENT:Initialize()
		self.Lamp = nil
		self.PixVis = util.GetPixelVisibleHandle()
		
		self.Spin = 0
		self.GlowTime = 0
		self.Distance = 40
	end

	function ENT:Draw()
		self.Spin = self.Spin + ( FrameTime() * 500 )
		self:SetLocalAngles( Angle( 0, self.Spin, 0 ) )
	
		self:DrawModel()
	end
	
	function ENT:Think()
		local dlight = DynamicLight( self:EntIndex() )
		if dlight then
			dlight.Pos = self:GetPos()
			dlight.r = 255
			dlight.g = 0
			dlight.b = 0
			dlight.Brightness = .8
			dlight.Size = 256
			dlight.Decay =  80 * 5
			dlight.DieTime = CurTime() + .2
		end
	end

	function ENT:DrawTranslucent()
		--Lamp "glow"
		local LightNrm = self:GetAngles():Up()
		local ViewNormal = self:GetPos() - EyePos()
		local Distance = ViewNormal:Length()
		ViewNormal:Normalize()

		local ViewDot = ViewNormal:Dot( LightNrm )
		local Col = Color( 255, 0, 0, 255 )
		local LightPos = self:GetPos() + LightNrm * -6

		if ViewDot >= 0 then
			render.SetMaterial( matLight )
			local Visibile  = util.PixelVisible( LightPos, 16, self.PixVis )
			if not Visibile then return end
				   
			local Size = math.Clamp( Distance * Visibile * ViewDot * 2, 64, 512 )
					
			Distance = math.Clamp( Distance, 32, 800 )
			local Alpha = math.Clamp( (1000 - Distance) * Visibile * ViewDot, 0, 100 )
				   
			render.DrawSprite( LightPos, Size, Size, Col, Visibile * ViewDot )
			render.DrawSprite( LightPos, Size*0.4, Size*0.4, Color(255, 255, 255, Alpha), Visibile * ViewDot )	
		end
	end
end