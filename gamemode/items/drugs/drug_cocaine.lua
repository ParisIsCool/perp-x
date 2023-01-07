--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local ITEM 					= {}

ITEM.ID 					= 69
ITEM.Reference 				= "drug_cocaine"

ITEM.Name 					= "Cocaine"
ITEM.Description 			= "Drugs are bad -WHO GIVES A SHIT??"

ITEM.Weight 				= 5
ITEM.Cost					= 120 -- 200% profit over $200 a seed.
								  -- i got the 200% from using an estimate of 3 coke per pot.

ITEM.MaxStack 				= 200

ITEM.InventoryModel 		= Model( "models/cocn.mdl" )
ITEM.WorldModel 			= Model( "models/cocn.mdl" )

ITEM.ModelCamPos			= Vector( 8, 0, 0 )
ITEM.ModelLookAt			= Vector( 0, 0, 1 )
ITEM.ModelFOV				= 70

ITEM.RestrictedSelling	 	= true -- Used for drugs and the like. So we can't sell it.

if SERVER then
	function ITEM.OnUse( Player )
		local rand = math.random( 1, 3 )

		if rand == 1 then
			if Player:Health() - 50 <= 0 then
				Player.Overdosed = true
			end

			Player:TakeDamage( 50 )
		end

		Player.CocaineEffects = true

		umsg.Start( "toggleCocaine", Player )
			umsg.Bool( true )
		umsg.End()
		
		timer.Create( Player:SteamID() .. "EndCocaine", 80, 1, function()
			if IsValid( Player ) then
				Player.CocaineEffects = nil

				umsg.Start( "toggleCocaine", Player )
					umsg.Bool( false )
				umsg.End()
			end
		end )
        
        Player:AddRP(50)
		Player:ReputationNotify( "+50 RP for doing drugs!" )
		
		return true
	end
	
	hook.Add( "PlayerDeath", "PlayerDeathCocaine", function( Player )
		if Player.CocaineEffects then
			timer.Remove( Player:SteamID() .. "EndCocaine" )
			
			umsg.Start( "toggleCocaine", Player )
				umsg.Bool( false )
			umsg.End()
		end
	end )

	function ITEM.OnSpawn( Player, Entity )
		local PhysObj = Entity:GetPhysicsObject()
		if IsValid( PhysObj ) then
			PhysObj:SetMass( 10 )
		end
	end

	function ITEM.OnDrop( Player, Trace )
		if Player:Team() ~= TEAM_CITIZEN then
			return Player:Notify( "You can not drop illegal items as a government official." )
		end

		return true
	end
else
	local tblEffects = {}
	local CocaineEnabled
	local iCocaineTime = 0

	LocalPlayer().HeartSound = CreateSound( LocalPlayer(), Sound( "player/heartbeat1.wav" ) )
	LocalPlayer().HeartSound:Stop()
	LocalPlayer().NoiceSound = CreateSound( LocalPlayer(), Sound( "ambient/machines/train_freight_loop1.wav" ) )
	LocalPlayer().NoiceSound:Stop()

	local function StopCocaineEffects()
		tblEffects = {}

		LocalPlayer().HeartSound:Stop()
		LocalPlayer().NoiceSound:Stop()
		
		CocaineEnabled = nil
		LocalPlayer():SetDSP( 1 )
	end

	usermessage.Hook( "toggleCocaine", function( UMsg )
		CocaineEnabled = UMsg:ReadBool() or nil
		iCocaineTime = 0

		if not CocaineEnabled then
			StopCocaineEffects()
		end
	end )
	
	timer.Create( "CocaineTimer", 1, 0, function()
		if not LCocaineEnabled then return end
		iCocaineTime = iCocaineTime + 1
		
		LocalPlayer():SetDSP( math.random( 1, 23 ) )
		
		LocalPlayer().NoiceSound:Play()
		
		LocalPlayer().HeartSound:ChangePitch( 50 + iCocaineTime, 0 )
		LocalPlayer().NoiceSound:ChangeVolume( 0.1, 0 )
		LocalPlayer().NoiceSound:ChangePitch( 100 + ( 100 * math.sin( CurTime() * 2 ) ), 0 )
		
		if iCocaineTime == 10 then
			for i=1, 10 do
				timer.Simple( math.random( 1, 80 ), function()
					if CocaineEnabled then	
						tblEffects[4] = true
					end
				end )
			end
			LocalPlayer().HeartSound:Play()
		elseif iCocaineTime == 12 then
			tblEffects[1] = true
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
		elseif iCocaineTime == 14 then
			tblEffects[1] = true
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
		elseif iCocaineTime == 14.5 then
			tblEffects[1] = true
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 175 )
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 175 )
		elseif iCocaineTime == 20 then
			tblEffects[2] = true
			LocalPlayer():EmitSound( "ambient/atmosphere/cave_hit6.wav", 25, 150 )
		elseif iCocaineTime == 30 then
			tblEffects[1] = true
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
		elseif iCocaineTime == 45 then
			tblEffects[1] = true
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
			tblEffects[2] = false
		elseif iCocaineTime == 62 then
			tblEffects[1] = true
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
			LocalPlayer():EmitSound( "ambient/machines/station_train_squeel.wav", 150, 200 )
		elseif iCocaineTime == 79.5 then
			surface.PlaySound( "ambient/energy/zap6.wav" )
			tblEffects[3] = true
		elseif iCocaineTime > 80 then
			StopCocaineEffects()
		end
	end )
	
	hook.Add( "RenderScreenspaceEffects", "CocaineRenderScreenspaceEffects", function()
		if not CocaineEnabled then return end
		
		local tab = {}
			tab[ "$pp_colour_addr" ] = 0
			tab[ "$pp_colour_addg" ] = 0
			tab[ "$pp_colour_addb" ] = 0
			tab[ "$pp_colour_brightness" ] = math.sin( CurTime() * 0.25 ) * 0.2
			tab[ "$pp_colour_contrast" ] = 1
			tab[ "$pp_colour_colour" ] = math.sin( CurTime() * 2 ) * 0.5
			tab[ "$pp_colour_mulr" ] = 0
			tab[ "$pp_colour_mulg" ] = 0
			tab[ "$pp_colour_mulb" ] = 0

		if tblEffects[2] then
			tab[ "$pp_colour_mulr" ] = 100 + ( math.sin( CurTime() * 3 ) * 100 )
			tab[ "$pp_colour_mulg" ] = 50 + ( math.sin( CurTime() * 4 ) * 50 )
			tab[ "$pp_colour_mulb" ] = 50 + ( math.sin( CurTime() * 5 ) * 50 )
		end

		if tblEffects[3] then
			tab[ "$pp_colour_brightness" ] = 0.2
			tab[ "$pp_colour_contrast" ] = math.random( 100, 200 ) / 100
		end
		
		DrawColorModify( tab )
		
		if tblEffects[4] then
			local i = math.random( 1, 3 )
			if i == 1 then
				surface.SetDrawColor( 255, 50, 50, 10 )
				surface.SetTexture( surface.GetTextureID( "Models/Breen/Breen_face" ) )
				surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
			elseif i == 2 then
				surface.SetDrawColor( 255, 50, 50, 10 )
				surface.SetTexture( surface.GetTextureID( "Models/Gman/gman_face_map3" ) )
				surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
			elseif i == 3 then
				surface.SetDrawColor( 255, 50, 50, 10 )
				surface.SetTexture( surface.GetTextureID( "Models/Kleiner/walter_face" ) )
				surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
			end

			tblEffects[4] = false
		else	
			DrawMotionBlur( 0.1, 0.2, 0.25 )
		end
		
		if tblEffects[1] then
			DrawSharpen( math.sin( CurTime() * 2 ) + ( iCocaineTime / 10 ), 25 + ( math.sin( CurTime() * 10 ) * 25 ) )
			
			timer.Simple( 0.45, function()
				tblEffects[1] = false
			end )
		end
	end )
end

GAMEMODE:RegisterItem( ITEM )