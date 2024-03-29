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
	local function SpawnEffect_Spawn(ply)
		umsg.Start("StartSpawnEffect")
			umsg.Entity(ply)
			umsg.Entity(ply.rag)
		umsg.End()
	end
	hook.Add("PlayerSpawn", "SpawnEffect_Spawn", SpawnEffect_Spawn)
end


if CLIENT then
	local Enabled	= CreateConVar("hsp_spawn_enabled", 1, {FCVAR_REPLICATED})
	
	local Particles = CreateClientConVar("hsp_spawn_particles", 1, false, false)
	local Speed 	= CreateClientConVar("hsp_spawn_speed", 0.6, false, false)
	
	local ScanMat		= Material("blackops/spawn")
	local MatWireFrame	= Material("models/wireframe")
	local matBlurScreen	= Material("pp/blurscreen")
	local HeatWaveMat	= Material("sprites/heatwave")
	
	local SpawnWhite = CreateMaterial(
		"SpawnWound",
		"UnlitGeneric",
		{
			[ '$basetexture' ] = "models/debug/debugwhite",
			[ '$vertexalpha' ] = "1",
			[ '$vertexcolor' ] = "1",
		}
	)
	
	
	local function SetNoDrawPlayerEnts(ply, bool)
		for k,v in pairs( ents.GetAll() ) do
			if IsValid(v) and v:GetOwner() == ply then
				v:SetNoDraw(bool)
			end
		end
	end
	
	
	local function BlopsDoSpawnEffect( ply )
		if IsValid( ply ) then
			local min = ply:OBBMins()
			local max = ply:OBBMaxs()
			ply.HSPEffectHight = max.z - min.z
			ply.BuildPercent = 0
			ply.HSPEffectBuilding = true
		end
	end
	
	
	local CachedSizes = {}
	
	local function GetModelHeight(model)
		if !CachedSizes[model] then
			local mdl = ents.CreateClientProp("prop_physics")
				mdl:SetNoDraw( true )
				mdl:SetModel( model )
				local min = mdl:OBBMins()
				local max = mdl:OBBMaxs()
			mdl:Remove()
			CachedSizes[model] = max.z - min.z
		end
		return CachedSizes[model]
	end
	
	local function BlopsDoDeSpawnEffect( ragdoll )
		if IsValid( ragdoll ) then
			if !ragdoll.Despawning then
				ragdoll.HSPEffectHight = GetModelHeight( ragdoll:GetModel() )
				ragdoll.BuildPercent = 1
				ragdoll.Despawning = true
				ragdoll:SetNoDraw( true )
			end
		end
	end

	local PartEmit

	local function EmitScanlineParticles( planepos, normal, color, grav, time )
		grav = grav or Vector( 0, 0, -100 )
		time = time or Particles:GetFloat()
		
		--for i=1, math.random( 1, 3 ) do
			local ang = normal:Angle()
			local pos = planepos + ang:Right() * math.random( -16, 16 ) + ang:Up() * math.random( -16, 16 )
			
			local par = PartEmit:Add( "sprites/light_glow02_add.vmt", pos )
				par:SetVelocity( ( VectorRand() * 10 ) )
				par:SetDieTime( time )
				par:SetStartAlpha( color.a )
				par:SetEndAlpha( 0 )
				par:SetGravity( grav )
				par:SetStartSize( math.random( 2, 10 ) )
				par:SetEndSize( 0 )
				par:SetColor( color.r, color.g, color.b )
			par:SetRoll( math.random( 0, 300 ) )
		--end
	end


	hook.Add( "PrePlayerDraw", "StartClip", function( ply )
		if ply:Alive() and ply.HSPEffectBuilding and ply.HSPEffectHight and ply.BuildPercent and ply.BuildPercent < 1 and !ply.IgnoreClip then
			local downnormal = vector_up * -1
			local clippos = ply:GetPos() + vector_up * ( ply.HSPEffectHight * ply.BuildPercent )
			local distance = downnormal:Dot( clippos )
			ply.Clipping = render.EnableClipping( true )
			render.PushCustomClipPlane( downnormal, distance )
		end
	end)


	hook.Add("PostPlayerDraw", "EndClip", function( ply )
		if ply:Alive() and ply.HSPEffectBuilding and ply.HSPEffectHight and ply.BuildPercent and ply.BuildPercent < 1 and !ply.IgnoreClip then	
			render.PopCustomClipPlane()
			render.EnableClipping( ply.Clipping )
		end
	end)



	local function IsInFront( posA, posB, normal )
		local Vec1 = ( posB - posA ):GetNormalized()
		return ( normal:Dot( Vec1 ) < 0 )
	end

	function DoPlayerSpawnEffectHook( ply )

		if ply.HSPEffectBuilding and ply.HSPEffectHight and ply.BuildPercent and ply.BuildPercent < 1 then
		
			SetNoDrawPlayerEnts( ply, true )
			
			--ply.BuildPercent = math.Approach( ply.BuildPercent, 1, RealFrameTime() / 4 )
			ply.BuildPercent = math.Approach( ply.BuildPercent, 1, RealFrameTime() / Speed:GetFloat() )
			
			local eyey = ply:EyeAngles().y
			local downnormal = vector_up * -1
			local clippos = ply:GetPos() + vector_up * ( ply.HSPEffectHight * ply.BuildPercent )
			local distance = downnormal:Dot( clippos )
			local teamcolor = team.GetColor( ply:Team() )
			local alphacolor = Color( teamcolor.r, teamcolor.g, teamcolor.b, ( 1 - ply.BuildPercent ) * 255 )
			
			if !PartEmit then
				PartEmit = ParticleEmitter( LocalPlayer():GetPos() )
			end
			
			cam.Start3D( EyePos(), EyeAngles() )
			
				/////////// Render scan tex
				render.SetMaterial( ScanMat )
				local scannormal = IsInFront( EyePos(), clippos, vector_up ) and vector_up or downnormal --Will give us the normal we can currently see
				render.DrawQuadEasy( clippos, scannormal, 32, 32, alphacolor, eyey )
				/////////// Emit ze particles
				EmitScanlineParticles( clippos, scannormal, alphacolor )
				/////////// Wireframe stuff
				render.SuppressEngineLighting( true )
					/////////// Gets the color in terms of 0 to 1
					render.SetColorModulation( teamcolor.r/255,teamcolor.g/255,teamcolor.b/255 )
						render.SetBlend( 1 - ply.BuildPercent )
							render.MaterialOverride( MatWireFrame )
							////////// Draw it where the player would have been
								ply.IgnoreClip = true
									if GetPlayerLegs then
										GetPlayerLegs( ply ):DrawModel()
									end
								ply.IgnoreClip = false
							////////// Reset
							render.MaterialOverride( nil )
						render.SetBlend( 1 )
					render.SetColorModulation( 1, 1, 1 )
				render.SuppressEngineLighting( false )			
				/////////// Done
			cam.End3D()
			
		elseif ply.HSPEffectBuilding and ply.BuildPercent and ply.BuildPercent >= 1 then
			////////// Don't remove this, this makes the player flicker to wireframe instead of nodraw
			local teamcolor = team.GetColor( ply:Team() )
			cam.Start3D( EyePos(), EyeAngles() )
				/////////// Wireframe stuff
				render.SuppressEngineLighting( true )
					/////////// Gets the color in terms of 0 to 1
					render.SetColorModulation( teamcolor.r/255,teamcolor.g/255,teamcolor.b/255 )
						render.SetBlend( math.random( 0, 45 )/100 )
							render.MaterialOverride( MatWireFrame )
								////////// Draw it where the player would have been
									if GetPlayerLegs then
										GetPlayerLegs( ply ):DrawModel()
									end
								////////// Reset
							render.MaterialOverride( nil )
						render.SetBlend( 1 )
					render.SetColorModulation( 1, 1, 1 )
				render.SuppressEngineLighting( false )
				/////////// Done
			cam.End3D()
			
			timer.Simple( .05, function()
				if IsValid( ply ) and ply.HSPEffectBuilding then
					SetNoDrawPlayerEnts( ply, false )
				end
			end )
			
			timer.Simple( .30, function()
				if IsValid( ply ) and ply.HSPEffectBuilding then
					SetNoDrawPlayerEnts( ply, true )
				end
			end )
			
			timer.Simple( .60, function()
				if IsValid( ply ) and ply.HSPEffectBuilding then
					ply.HSPEffectBuilding = false 
					SetNoDrawPlayerEnts( ply, false )
				end
			end )
		end
		
	end

	function DoPlayerDeSpawnEffectHook( ragdoll )
		if IsValid( ragdoll ) and ragdoll.Despawning and ragdoll.HSPEffectHight and ragdoll.BuildPercent and ragdoll.BuildPercent > 0 and ragdoll.BuildPercent <= 1 then
			
			ragdoll.BuildPercent = math.Approach( ragdoll.BuildPercent, 0, RealFrameTime() / 6 )
			
			local bone = ragdoll:LookupBone("ValveBiped.Bip01_Head1")
			if not bone then
				bone = 1
			end
			
			local bonepos, boneang = ragdoll:GetBonePosition( bone )
			if not bonepos then return end
			
			local center = ragdoll:GetPos()
			local Norm = ( bonepos - center )
			Norm:Normalize()
			local upnormal = Norm * -1
			local downnormal = upnormal * -1
			local endpos = center + ( ragdoll.HSPEffectHight * upnormal * 0.5 )
			local clippos = endpos + downnormal * ( ragdoll.HSPEffectHight * ragdoll.BuildPercent )
			local distance = upnormal:Dot( clippos )
			local teamcolor = ragdoll.HSPEffectColor or color_white --team.GetColor( ply:Team() )
			local alphacolor = Color( teamcolor.r, teamcolor.g, teamcolor.b, ragdoll.BuildPercent * 255 )
			
			if !PartEmit then
				PartEmit = ParticleEmitter( LocalPlayer():GetPos() )
			end
			
			cam.Start3D( EyePos(), EyeAngles() )
				render.SetMaterial( ScanMat )
				local scannormal = IsInFront( EyePos(), clippos, upnormal ) and upnormal or downnormal --Will give us the normal we can currently see
				render.DrawQuadEasy( clippos, scannormal, 32, 32, alphacolor, 90 )
				EmitScanlineParticles( clippos, scannormal, alphacolor, Vector( 0, 0, 50 ) )
				
				render.SuppressEngineLighting( true )
					local bEnabledClipping = render.EnableClipping( true )
					render.SetColorModulation( 1, 1, 1 )
						render.PushCustomClipPlane( upnormal, distance )
							ragdoll:DrawModel()
						render.PopCustomClipPlane()
					render.EnableClipping( bEnabledClipping )
					render.SetColorModulation( teamcolor.r / 255,teamcolor.g / 255,teamcolor.b / 255 )		
						render.SetBlend( ragdoll.BuildPercent / 1.5 )
							render.MaterialOverride( MatWireFrame )
								ragdoll:DrawModel()
							render.MaterialOverride( nil )
						render.SetBlend( 1 )
					render.SetColorModulation( 1, 1, 1 )
				render.SuppressEngineLighting( false )
			cam.End3D()
		end
	end
	
	
	usermessage.Hook("StartSpawnEffect", function(um)
		local ply = um:ReadEntity()
		local rag = um:ReadEntity()
		
		BlopsDoSpawnEffect( ply )
		BlopsDoDeSpawnEffect( rag )
	end)
	
	
	hook.Add("PostDrawTranslucentRenderables", "RenderCoolSpawnEffect", function()
		if Enabled:GetBool() then
			for k,ply in ipairs( player.GetAll() ) do
				if ply:Alive() then
					DoPlayerSpawnEffectHook( ply )
				end
			end

			for k,ragdoll in pairs( ents.FindByClass( "prop_ragdoll" ) ) do
				DoPlayerDeSpawnEffectHook(ragdoll)
			end
		end
	end)
end