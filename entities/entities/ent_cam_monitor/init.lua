--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

include( "shared.lua" )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props/cs_office/computer_monitor.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	self:GetPhysicsObject():Wake()
	
	self.CamPlayers = {}

	-- Now, that we've spawned our stupid monitor, lets spawn a stupid camera that is linked to this... entity? :)
	timer.Simple( 0, function() -- Run next frame :3
		self:SpawnCam()
	end )
end

function ENT:SpawnCam()
	if IsValid( self.CamEnt ) then self.CamEnt:Remove() end

	local Camera = ents.Create( "ent_cam" )
		Camera:SetPos( self:GetPos() + Vector( 0, 0, 64 ) )
		Camera.Owner = self.Owner
		Camera:Spawn()

	self.CamEnt = Camera
end

function ENT:OnRemove()
	for _, v in pairs( self.CamPlayers ) do
		if IsValid( v ) then
			self:ToggleCam( v, false )
			v:ChatMessage( "You've left the camera view." )
			v.Cam = nil
			v.CamID = nil
		end
	end

	if IsValid( self.CamEnt ) then
		self.CamEnt:Remove()
	end
end

util.AddNetworkString("dontdrawcam")

function ENT:ToggleCam( Player, Active )
	if IsValid( Player ) then
		if Active and IsValid( self.CamEnt ) then
			Player:SetViewEntity( self.CamEnt )
			Player:SetFOV( 0, 0.01 )
			net.Start( "dontdrawcam" ) 
			net.WriteEntity( self ) 
			net.WriteBool( true ) 
			net.Send(Player)
		else
			Player:SetViewEntity( Player )
			Player:SetFOV( 0, 0.01 )
			net.Start( "dontdrawcam" ) 
			net.WriteEntity( self ) 
			net.WriteBool( false ) 
			net.Send(Player)
		end
	end
end

function ENT:Use( Player )
	if not IsValid( self.CamEnt ) or self:GetPos():Distance( self.CamEnt:GetPos() ) >= 1000 then
		return Player:ChatMessage( "Camera has no signal, move closer to monitor." )
	end

	if IsValid( Player.Cam ) then -- already in camera view :(
		Player.Cam:ToggleCam( Player, false )
		Player.Cam = nil
		Player.CamID = nil

		return
	end

	Player.CamID = table.insert( self.CamPlayers, Player )
	Player.Cam = self
	self:ToggleCam( Player, true )

	Player:ChatMessage( "Move to get out of the camera view." )

	hook.Add( "KeyPress", "CamRemove_" .. Player:SteamID(), function( player, key )
		if player ~= Player then return end
		if key ~= IN_FORWARD and key ~= IN_BACK and key ~= IN_MOVELEFT and key ~= IN_MOVERIGHT and key ~= IN_JUMP then return end

		if not IsValid( Player.Cam ) then return end

		self:ToggleCam( Player, false )
		table.remove( self.CamPlayers, Player.CamID )
		Player.Cam = nil
		Player.CamID = nil

		hook.Remove( "KeyPress", "CamRemove_" .. Player:SteamID() )
		Player:ChatMessage( "You've left the camera view." )
	end )
end

hook.Add( "PlayerDeath", "CamDeath", function( Player )
	if IsValid( Player.Cam ) then
		Player.Cam:ToggleCam( Player, false )
		table.remove( Player.Cam.CamPlayers, Player.CamID )
		Player.Cam = nil
		Player.CamID = nil

		Player:ChatMessage( "You've left the Camera view." )
	end
end )

-- If the camera is too far away from the monitor, then remove the players view :3
timer.Create( "CamConsistency", 10, 0, function()
	for _, v in pairs( ents.FindByClass( "ent_cam_monitor" ) ) do
		if IsValid( v.CamEnt ) then
			if v:GetPos():Distance( v.CamEnt:GetPos() ) >= 1000 then
				for _, Player in pairs( v.CamPlayers ) do
					v:ToggleCam( Player, false )
					table.remove( v.CamPlayers, Player.CamID )
					Player.Cam = nil
					Player.CamID = nil
					
					Player:ChatMessage( "Camera has no signal, move closer to monitor." )
				end
			end
		else
			v:SpawnCam()
		end
	end
end )