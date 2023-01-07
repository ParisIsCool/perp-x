--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local function CryGoFaster()
	net.Start("ServerICryDieFaster") net.SendToServer()
end

local function CryGoSlower()
	net.Start("ServerICryDieSlower") net.SendToServer()
end

net.Receive("YouHaveDiedYikes", function()
	-- this means i died :(
	sound.PlayFile( "sound/paris/heavybreathing2.mp3", "", function( station, errCode, errStr )
		if ( IsValid( station ) ) then
			station:EnableLooping(true)
			hook.Add("Think", "OnSpawnStopBreathing", function()
				if LocalPlayer():Alive() and IsValid(station) then
					station:Stop()
					hook.Remove("Think", "OnSpawnStopBreathing")
				end
			end)
			hook.Add("Move", "OnSpawnStopBreathing", function()
				if input.WasMouseReleased( MOUSE_LEFT ) then
					CryGoFaster()
				elseif input.WasMouseReleased( MOUSE_RIGHT ) then
					CryGoSlower()
				end
				if LocalPlayer():Alive() then
					hook.Remove("Move", "OnSpawnStopBreathing")
				end
			end)
		end
	end )
end)

hook.Add( "Think", "PlayerDyingSounds", function()
	if not LocalPlayer():Alive() then		
		if not GAMEMODE.HeartbeatNoise then
			GAMEMODE.HeartbeatNoise = CreateSound( LocalPlayer(), Sound( "player/heartbeat1.wav" ) )
		end
		
		GAMEMODE.LastHeartBeatPlay = GAMEMODE.LastHeartBeatPlay or 0
		
		if GAMEMODE.LastHeartBeatPlay + .717 <= CurTime() then
			GAMEMODE.LastHeartBeatPlay = CurTime()
			GAMEMODE.HeartbeatNoise:Stop()
			GAMEMODE.HeartbeatNoise:Play()
		end
	elseif GAMEMODE.HeartbeatNoise then
		GAMEMODE.HeartbeatNoise:Stop()
		GAMEMODE.HeartbeatNoise = nil
	end

	for _, v in pairs( player.GetAll() ) do
		if not v:Alive() then
			v.NextGroan = v.NextGroan or CurTime() + math.random( 5, 15 )
			
			if v.NextGroan < CurTime() then				
				v.NextGroan = nil
				
				local ToUse = "male"
				if v:GetSex() == SEX_FEMALE then ToUse = "female" end
				
				local MoanFile = Sound( "vo/npc/" .. ToUse .. "01/moan0" .. math.random( 1, 5 ) .. ".wav" )
				sound.Play( MoanFile, v:GetPos(), 100, 100 )
			end
		elseif v.NextGroan then
			v.NextGroan = nil
		end
	end
end )

hook.Add( "CalcView", "DeathView", function( ply, origin, angles, fov ) 
	if not ply:Alive() then
		local ragdoll = Entity( ply:GetPNWVar( "Ragdoll", 0 ) )
		if not IsValid( ragdoll ) then return end

		local eyes = ragdoll:GetAttachment( ragdoll:LookupAttachment( "eyes" ) )

		local view = {
			origin = eyes.Pos,
			angles = eyes.Ang,
			fov = 90, 
		}

		 return view
	end
end )