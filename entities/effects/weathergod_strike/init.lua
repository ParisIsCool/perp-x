function EFFECT:Init( CEffectData )
	self.Start = CEffectData:GetStart()
	self.Origin = CEffectData:GetOrigin()
	self.DieTime = CurTime() + 1
	
	local CLuaEmitter = ParticleEmitter( self.Origin )
	local i
	for i = 1, 40 do
		local CLuaParticle = CLuaEmitter:Add( "Effects/splash1", self.Origin )
		CLuaParticle:SetAirResistance( -100 )
		CLuaParticle:SetColor( Color( 255, 255, 255, 255 ) )
		CLuaParticle:SetDieTime( 10 )
		CLuaParticle:SetEndAlpha( 0 )
		CLuaParticle:SetEndSize( 50000 )
		CLuaParticle:SetGravity( Vector( math.random( -10, 10 ) * 100, math.random( -10, 10 ) * 100, 0 ), 0 )
		CLuaParticle:SetStartAlpha( 255 )
		CLuaParticle:SetStartSize( 100 )
	end
	
	for i = 1, 10 do
		local CLuaParticle = CLuaEmitter:Add( "Effects/blueflare1", self.Origin )
		CLuaParticle:SetAirResistance( 5 )
		CLuaParticle:SetColor( Color( math.random( 1, 5 ) * 51, math.random( 1, 5 ) * 51, math.random( 1, 5 ) * 51, 255 ) )
		CLuaParticle:SetDieTime( 20 )
		CLuaParticle:SetEndAlpha( 0 )
		CLuaParticle:SetEndSize( 100 )
		
		CLuaParticle:SetGravity( Vector( 0, 0, 0 ) )
		CLuaParticle:SetVelocity( VectorRand() * math.random( 1, 10000 ) )
		CLuaParticle:SetStartAlpha( 255 )
		CLuaParticle:SetStartSize( 100 )
	end
	CLuaEmitter:Finish()
	
	for i = 1, 5 do
		sound.Play( Sound( "ambient/explosions/explode_7.wav" ), self.Origin, 160, 150 )
		sound.Play( Sound( "ambient/explosions/citadel_end_explosion2.wav" ), self.Origin, 160, 150 )
	end
end

function EFFECT:Think()
	return self.DieTime > CurTime()
end

function EFFECT:Render() return end