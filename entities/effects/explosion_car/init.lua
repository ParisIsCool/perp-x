--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local function ParticleThink( part )
	if part:GetLifeTime() > 0.18 then 
		local vOffset = part:GetPos()	
	
		local particle = SMOKE_EMITTER:Add( "particles/smokey", vOffset )
		if particle then
			particle:SetLifeTime( 0 )
			particle:SetDieTime( 8 - part:GetLifeTime() * 2 )
				
			particle:SetStartAlpha( 150 )
			particle:SetEndAlpha( 0 )
				
			particle:SetStartSize( ( 90 - ( part:GetLifeTime() * 100 ) ) / 2 )
			particle:SetEndSize( 100 - ( part:GetLifeTime() * 100 ) )
				
			particle:SetColor( Color( 150, 150, 140 ) )
				
			particle:SetRoll( math.Rand( -0.5, 0.5 ) )
			particle:SetRollDelta( math.Rand( -0.5, 0.5 ) )
				
			particle:SetAirResistance( 250 )
				
			particle:SetGravity( Vector( 200, 200, -100 ) )
				
			particle:SetLighting( true )
			particle:SetCollide( true )
			particle:SetBounce( 0.5 )
		end		
	end
	
	part:SetNextThink( CurTime() + 0.1 )
end

function EFFECT:Init( data )
	local vOffset = data:GetOrigin()
			
	if LocalPlayer():GetPos():Distance(vOffset) < 500 then
		surface.PlaySound( Sound( "ambient/explosions/explode_3.wav" ) )
	else
		surface.PlaySound( Sound( "ambient/explosions/explode_9.wav" ) )
	end
	
	local NumParticles = 32

	for i = 0, NumParticles do
		local particle = SMOKE_EMITTER:Add( "particle/particle_smokegrenade", vOffset )
		if particle then
			local Vec = VectorRand()
			particle:SetVelocity( Vector( Vec.x, Vec.y, math.Rand( 0.5, 2 ) ) * 1500 )
			
			particle:SetLifeTime( 0 )
			particle:SetDieTime( 0.75 )
			
			particle:SetStartAlpha( 0 )
			particle:SetEndAlpha( 0 )
			
			particle:SetStartSize( 5 )
			particle:SetEndSize( 5 )
			
			particle:SetColor( Color( 0, 0, 0 ) )

			particle:SetAirResistance( 120 )
			
			particle:SetGravity( Vector( 0, 0, -1000 ) )
			
			particle:SetCollide( true )
			particle:SetBounce( 0.5 )
			particle:SetThinkFunction( ParticleThink )
			particle:SetNextThink( CurTime() + 0.1 )
		end
		
		local particle2 = SMOKE_EMITTER:Add( "particles/smokey", vOffset )
		if particle2 then
			local Vec2 = VectorRand()
			particle2:SetVelocity( Vector( Vec2.x, Vec2.y, math.Rand( 0.1, 1.5 ) ) * 1200 )
			
			particle2:SetLifeTime( 0 )
			particle2:SetDieTime( 6 )
			
			particle2:SetStartAlpha( 250 )
			particle2:SetEndAlpha( 0 )
			
			particle2:SetStartSize( 150 )
			particle2:SetEndSize( 200 )
			
			particle2:SetColor( Color( 150, 150, 140 ) )

			particle2:SetAirResistance( 250 )
			
			particle2:SetGravity( Vector( 100, 100, -80 ) )
			
			particle2:SetLighting( true )
			particle2:SetCollide( true )
			particle2:SetBounce( 0.5 )
		end
		
		local particle3 = SMOKE_EMITTER:Add( "particle/particle_smokegrenade", vOffset )
		if particle3 then
			local Vec3 = VectorRand()
			particle3:SetVelocity( Vector( Vec3.x, Vec3.y, math.Rand( 0.05, 1.5 ) ) * 500 )
				
			particle3:SetLifeTime( 0 )
			particle3:SetDieTime( 1 )
			
			particle3:SetStartAlpha( 255 )
			particle3:SetEndAlpha( 0 )
				
			particle3:SetStartSize( 100 )
			particle3:SetEndSize( 120 )
			
			particle3:SetColor( Color( 255, 80, 20 ) )					
			particle3:SetRoll( math.Rand( 0, 360 ) )
			particle3:SetRollDelta( math.Rand(-2, 2) )
				
			particle3:SetAirResistance( 150 )
			
			particle3:SetGravity( Vector( math.Rand( -200, 200 ), math.Rand( -200, 200 ), 400 ) )					
			particle3:SetCollide( true )
			particle3:SetBounce( 1 )
		end
	end
end

function EFFECT:Render() return end