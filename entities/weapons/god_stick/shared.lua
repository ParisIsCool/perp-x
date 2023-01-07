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
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.PrintName 			= "God Stick"
	SWEP.Slot 			= 0
	SWEP.SlotPos 			= 5
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= true
end

SWEP.Author		 	        = "aSocket"
SWEP.Instructions  			= "Left click to fire, right click to change"

SWEP.ViewModelFOV   			= 62
SWEP.ViewModelFlip  			= false
SWEP.AnimPrefix  			= "stunstick"

SWEP.NextStrike 			= 0

if CLIENT then SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/myicon/god" ) end

SWEP.ViewModel                          = Model( "models/weapons/v_stunstick.mdl" );
SWEP.WorldModel                         = Model( "models/weapons/w_stunbaton.mdl" );

SWEP.Sound 				= Sound( "weapons/stunstick/stunstick_swing1.wav" )
SWEP.Sound1 				= Sound( "npc/metropolice/vo/moveit.wav" )
SWEP.Sound2 				= Sound( "npc/metropolice/vo/movealong.wav" )

SWEP.Primary.ClipSize	  		= -1		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		 -- Default number of bullets in a clip
SWEP.Primary.Automatic   		= false	 -- Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize  		= -1	   -- Size of a clip
SWEP.Secondary.DefaultClip	        = 0	   -- Default number of bullets in a clip
SWEP.Secondary.Automatic		= false	   -- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"

/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	if SERVER then
		self.Gear = 1
		util.AddNetworkString( "bodygroups" )
	end

	self:SetWeaponHoldType( "melee" )
end

local SLAP_SOUNDS = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
	"physics/body/body_medium_impact_soft5.wav",
	"physics/body/body_medium_impact_soft6.wav",
	"physics/body/body_medium_impact_soft7.wav"
}

local Gears = {}
local DevGears = {}
local devs = { "STEAM_0:0:82381032", "STEAM_0:0:89634933" }

/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end
 
function SWEP:DoFlash( ply )
end

local Gears = {};

 /*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
    if CurTime() < self.NextStrike then return end
    if not self.Owner:IsAdmin() then
        if SERVER then self.Owner:StripWeapon( self.Weapon:GetClass() ) end
        return false
    end

    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    
    local Colour = self.Owner:GetColor()
    
    if Colour.a ~= 0 then
        self.Weapon:EmitSound( self.Sound )
    end
    
    self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.NextStrike = ( CurTime() + .3 )

	local trace = self.Owner:GetEyeTrace()

	local Gear = self.Owner:GetNWInt("CurGear") or 1
	if not Gears[ Gear ] then Gear = 1 end

    if CLIENT then if Gears[ Gear ][ 6 ] then Gears[ Gear ][ 6 ](self.Owner,trace) end return end

	if Gears[ Gear ][ 3 ] and not self.Owner:IsSuperAdmin() then
		return self.Owner:Notify( "This gear requires Super Admin status." )
	end

	Gears[ Gear ][ 4 ]( self.Owner, trace )
end

local function AddGear( Title, Desc, SA, Func, Dev, ClientFunc )
	table.insert( Gears, { Title, Desc, SA, Func, Dev, ClientFunc } )
end

AddGear( "Client Reload Warning", "Left click to toggle disguise status.", false,
	function( Player, Trace )
		if not Player:IsAdmin() then
			return Player:Notify( "This gear requires Admin status." )
		end

		for k, v in pairs(player.GetAll()) do
			v:Notify("A client reload is about to occur! Your game might freeze for a few seconds!")
		end

	end, true
)

local ct = ""
local points = {}
AddGear( "Clear Clipboard", "TOOL: Left click to ADD current position to clipboard.", false,
	function( Player, Trace ) end, true, function(ply)
		ct = ""
		points = {}
	end
)

AddGear( "Copy Map Car Spawnpoint", "TOOL: Left click to ADD current position to clipboard.", false,
	function( Player, Trace ) end, true, function(ply)
		local p = ply:GetPos()
		local a = ply:GetAngles() - Angle(0,-90,0)
		a.p = math.Round(a.p / 90) * 90
		a.y = math.Round(a.y / 90) * 90
		a.r = math.Round(a.r / 90) * 90
		ct = ct .. Format("\t{Vector(%i,%i,%i), Angle(%i,%i,%i)},\n",p.x,p.y,p.z,a.p,a.y,a.r)
		SetClipboardText(ct)
	end
)

AddGear( "Copy Door Info", "TOOL: Left click to ADD current door info to clipboard.", false,
	function( Player, Trace ) end, true, function(ply, Trace)
		local p = Trace.Entity:GetPos()
		local m = Trace.Entity:GetModel()
		ct = ct .. Format("\t{pos=Vector(%i,%i,%i), model=\"%s\"},\n",p.x,p.y,p.z,m)
		SetClipboardText(ct)
	end
)

AddGear( "Copy Job Spawnpoint", "TOOL: Left click to ADD current position to clipboard.", false,
	function( Player, Trace ) end, true, function(ply)
		local p = ply:GetPos()
		local a = ply:GetAngles()
		a.p = math.Round(a.p / 90) * 90
		a.y = math.Round(a.y / 90) * 90
		a.r = math.Round(a.r / 90) * 90
		ct = ct .. Format("\t{Vector(%i,%i,%i), Angle(%i,%i,%i)},\n",p.x,p.y,p.z,a.p,a.y,a.r)
		SetClipboardText(ct)
	end
)

AddGear( "Copy Lookat Pos", "TOOL: Left click to ADD current hitpos to clipboard.", false,
	function( Player, Trace ) end, true, function(ply)
		local p = ply:GetEyeTrace().HitPos
		table.insert(points,p)
		ct = ct .. Format("\tVector(%i,%i,%i),\n",p.x,p.y,p.z)
		SetClipboardText(ct)
	end
)

AddGear( "Get Entity Info", "TOOL: Left click to ADD current entits info to clipboard.", false,
	function( Player, Trace ) end, true, function(ply)
		local e = ply:GetEyeTrace().Entity
		if e == game.GetWorld() then return end
		local p = e:GetPos()
		local a = e:GetAngles()
		SetClipboardText(Format("\t{pos=Vector(%i,%i,%i),ang=Angle(%i,%i,%i),model='%s'}\n",p.x,p.y,p.z,a.p,a.y,a.r,e:GetModel()))
	end
)

AddGear( "Get Vehicle Plates", "TOOL: Left click to ADD current hitpos to clipboard.", false,
	function( Player, Trace ) end, true, function(Player, Trace)
		if IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
			local Pos = Trace.Entity:WorldToLocal( Player:GetEyeTrace().HitPos )

			local str = string.format([[
				VEHICLE.PlatePos = {
					{Vector(%i,%i,%i),0.115,Angle(0,0,90)},
				}
			]], Pos.x,Pos.y,Pos.z)
			SetClipboardText(str)
		end
	end
)

AddGear( "Get Bodygroups", "TOOL: Left click to PRINT bodygroups.", false,
	function( Player, Trace ) end, true, function(ply)
		local e = ply:GetEyeTrace().Entity
		if e == game.GetWorld() then return end
		PrintTable(e:GetBodyGroups())
	end
)

local circle = Material("hud/circle.png")
hook.Add("PostDrawTranslucentRenderables", "WaypointSystem", function()
	for _, p in pairs(points) do
		cam.Start3D2D( p + Vector(0,0,3), Angle(0,90,0), 0.07 )
		surface.SetDrawColor(132, 0, 255, Alpha)
		surface.SetMaterial(circle)
		surface.DrawTexturedRect(-200, -200, 400, 400)
		cam.End3D2D()
	end
end)
hook.Remove("PostDrawOpaqueRenderables", "WaypointSystem")

AddGear( "Invisible", "Left click to go invisible.", false,
	function( Player, Trace )
		if not Player.Invisible then
			Player.Invisible = true
			Player:SetPNWVar( "invisible", 1 )
			Player:SetGNWVar( "invisible", 1 ) --Sets GNWVar for hud radar
			Player:SetColor( Color( 0, 0, 0, 0 ) )
			Player:SetNoDraw( true )
			Player:DrawWorldModel( false )

			Player:ChatPrint( "Invisibility on." )
		else
			Player.Invisible = nil
			Player:SetPNWVar( "invisible", 0 )
			Player:SetGNWVar( "invisible", 0 ) --Sets GNWVar for hud radar
			Player:SetColor( Color( 255, 255, 255, 255 ) )
			Player:SetNoDraw( false )
			Player:DrawWorldModel( true )

			Player:ChatPrint( "Invisibility off." )
		end
	end
)

AddGear( "God Mode", "Left click to alternate between god and mortal.", false,
	function( Player, Trace )
		if Player:HasGodMode() then
			Player.IsGod = nil
			Player:GodDisable()
			Player:ChatPrint( "You are no longer in god mode." )
		else
			Player.IsGod = true
			Player:GodEnable()
			Player:ChatPrint( "You are now in god mode" )
		end
	end
)

AddGear( "Disguise", "Left click to toggle disguise status.", false,
	function( Player, Trace )
		if not Player:IsAdmin() then
			return Player:Notify( "This gear requires Admin status." )
		end

		Player:ConCommand("disguise")
		Player:ChatPrint( "Disguise toggled." )
	end
)

AddGear( "Respawn/Revive Player", "Aim at a corpse/player to respawn them.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
			Trace.Entity:Notify( "An administrator has respawned you." )
			Trace.Entity:Spawn()
			ASS_LogAction( Player, ASS_ACL_REVIVE, "respawned " .. ASS_FullNick( Trace.Entity ) )
		elseif IsValid( Trace.Entity ) and Trace.Entity:GetClass() == "prop_ragdoll" then
			local Owner = Trace.Entity.Owner

			if Owner and IsValid( Owner ) then
				Owner.DontFixCripple = true -- if player is mayor then it'll "demote" them without this, and dont fix broken legs :P
				Owner:Spawn()
				Owner:SetPos( Trace.HitPos )

				if Owner.Ammo then
					for k, v in pairs( Owner.Ammo ) do
						Owner:GiveAmmo( v, k )
					end

					Owner.Ammo = nil
				end

				Owner:Notify( "An admin has revived you. A Reminder: This still counts as a death." )

				--ASS_LogAction( Player, ASS_ACL_REVIVE, "revived " .. ASS_FullNick( Owner ) )
			end
		end
	end
)

AddGear( "Fix Car", "Aim at a disabled car to fix it.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
			Trace.Entity:VC_RepairFull_Admin()
			Trace.Entity:SetGNWVar('Fuel', 10000)

			for k, v in pairs(ents.FindInSphere(Trace.Entity:GetPos(), 300)) do
				if v:GetClass() == "ent_fire" then
					v:Remove()
				end
			end

			Player:ChatPrint( "Vehicle repaired." )
		end
	end
)

AddGear( "Freeze", "Target a player to change his freeze state.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			if Trace.Entity.IsFrozens then
				Trace.Entity.IsFrozens = nil
				Trace.Entity:UnLock()

				Player:ChatPrint( "Player unfrozen." )
				Trace.Entity:ChatPrint( "You have been unfrozen." )

			else
				Trace.Entity.IsFrozens = true
				Trace.Entity:Lock()

				Player:ChatPrint( "Player frozen." )
				Trace.Entity:ChatPrint( "You have been frozen." )
			end
		end
	end
)

AddGear( "Super Remover", "Click and remove ANY entity... be careful.", false,
	function( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

		if IsValid( Trace.Entity ) then
			Trace.Entity:Remove()
			Player:ChatPrint( "Removed " .. tostring(Trace.Entity) )
		else
			Player:ChatPrint( "Error! Invalid entity!" )
		end
end, true )



AddGear( "Get Prop Owner", "Aim at a prop and click to get the owner.", false,
	function( Player, Trace )
		if not IsValid( Trace.Entity ) then return Player:ChatPrint( "Invalid Entity/Prop: " .. tostring( Trace.Entity ) ) end

		local Spawner = Trace.Entity.Spawner
		if Spawner then
			return Player:ChatPrint( "This entity/prop is owned by: " .. Spawner.Name .. " (" .. Spawner.RPName .. ") <" .. Spawner.SteamID .. ">" .. ( not IsValid( Spawner.Entity ) and " |DISCONNECTED|" or "" ) )
		end

		if IsValid( Trace.Entity.Owner ) then
			return Player:ChatPrint( "This entity/prop is owned by: " .. Trace.Entity.Owner:Nick() .. " (" .. Trace.Entity.Owner:GetRPName() .. ") <" .. Trace.Entity.Owner:SteamID() .. ">" )
		end

		if string.find( Trace.Entity:GetClass(), "npc" ) then
			return Player:ChatPrint( "That's owned by the server, dummy." )
		elseif string.find( Trace.Entity:GetClass(), "func_brush" ) then
			return Player:ChatPrint( "That's owned by the server, dummy." )
		elseif string.find( Trace.Entity:GetClass(), "func_tracktrain" ) then
			return Player:ChatPrint( "That's owned by the server, dummy." )
		elseif string.find( Trace.Entity:GetClass(), "slotmachine" ) then
			return Player:ChatPrint( "That's owned by the server, dummy." )
		end

		return Player:ChatPrint( "This entity/prop is not owned :(" )
	end
)

AddGear( "Remover", "Aim at any object to remove it.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			if !Player:IsOwner() then
				if string.find( Trace.Entity:GetClass(), "prop_ragdoll" ) then
					return Player:ChatPrint( "You cannot remove ragdolls, idiot." )
				elseif string.find( Trace.Entity:GetClass(), "npc_nextbot" ) then
					return Player:ChatPrint( "You cannot remove NPCs." )
				elseif string.find( Trace.Entity:GetClass(), "door" ) then
					return Player:ChatPrint( "You cannot remove doors, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_door" ) then
					return Player:ChatPrint( "You cannot remove doors, silly." )
				elseif string.find( Trace.Entity:GetClass(), "prop_door_rotating" ) then
					return Player:ChatPrint( "You cannot remove doors, silly." )
				elseif string.find( Trace.Entity:GetClass(), "prop_dynamic" ) then
					return Player:ChatPrint( "You cannot remove this, silly." )
				elseif string.find( Trace.Entity:GetClass(), "button" ) then
					return Player:ChatPrint( "You cannot remove buttons, silly." )
				elseif string.find( Trace.Entity:GetClass(), "npc" ) then
					return Player:ChatPrint( "You cannot remove npcs, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_brush" ) then
					return Player:ChatPrint( "You cannot remove the sky box, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_tracktrain" ) then
					return Player:ChatPrint( "You cannot remove elevators, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_movelinear" ) then
					return Player:ChatPrint( "You cannot remove elevators, silly." )
				elseif string.find( Trace.Entity:GetClass(), "prop_physics" ) then
					return Player:ChatPrint( "You cannot remove that, you goose." )
				elseif string.find( Trace.Entity:GetClass(), "slotmachine" ) then
					return Player:ChatPrint( "You cannot remove that, you dumbshit." )
				elseif string.find( Trace.Entity:GetClass(), "vehicle" ) and Trace.Entity.DemoVehicle then
					return Player:ChatPrint( "You cannot remove a demo vehicle." )
				end
			end

			if Trace.Entity:IsVehicle() and IsValid( Trace.Entity:GetDriver() ) then
				Trace.Entity:GetDriver():ExitVehicle()
			end

			if Trace.Entity:IsPlayer() then
				Trace.Entity:Kill()
			else
				Trace.Entity:Remove()
			end
		end
	end
)

AddGear( "OOC Toggle", "Left click to toggle OOC status.", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		Player:ConCommand( "perp_a_ooct" )
		Player:ChatPrint( "OOC toggled." )
	end
)

AddGear( "Check Bank Status", "Check bank amount.", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		Player:ChatPrint( "Bank Status:" )
		Player:ConCommand( "perp_bankrobberyinfo" )
	end
)

AddGear( "[SM] Freeze/Unfreeze All", "Left click to unfreeze all the players.", false,
	function( Player, Trace )
		if not Player:IsServerManager() then
			return Player:Notify( "This gear requires Server Manager status." )
		end

		if PERP_AllPlayersAreFrozen == false then
			Player:ConCommand( "perp_a_fa" )
			Player:ChatPrint( "Everyone has been frozen." )
		else
			Player:ConCommand( "perp_a_ufa" )
			Player:ChatPrint( "Everyone has been unfrozen." )
		end
	end, false
)

AddGear( "Server Status Toggle", "Left click to get server information.", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Admin status." )
		end

		Player:ConCommand( "serverstats" )
		Player:ChatPrint( "Server Status Toggled." )
	end
)

AddGear( "Stopsound", "Left click to stop sounds.", false,
	function( Player, Trace )
		if not Player:IsAdmin() then
			return Player:Notify( "This gear requires Admin status." )
		end
		
		Player:ConCommand( "stopsound" )
		--Trace.Entity:RunConsoleCommand( "stopsound" )
		Player:ChatPrint( "OOC toggled." )
	end
)

AddGear( "Kill Player", "Aim at a player to slay him.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			Trace.Entity:Kill()
			Player:ChatPrint( "Player killed." )
		end
	end
)

AddGear( "Slap Player", "Aim at an entity to slap him.", false,
	function( Player, Trace )
		if not Trace.Entity:IsPlayer() then
			local RandomVelocity = Vector( math.random( 500 ) - 250, math.random( 500 ) - 250, math.random( 500 ) - ( 500 / 4 ) )
			local RandomSound = SLAP_SOUNDS[ math.random( #SLAP_SOUNDS ) ]

			Trace.Entity:EmitSound( RandomSound )
			Trace.Entity:GetPhysicsObject():SetVelocity( RandomVelocity )
			Player:ChatPrint( "Entity slapped." )
		else
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			local RandomVelocity = Vector( math.random( 500 ) - 250, math.random( 500 ) - 250, math.random( 500 ) - ( 500 / 4 ) )
			local RandomSound = SLAP_SOUNDS[ math.random( #SLAP_SOUNDS ) ]

			Trace.Entity:EmitSound( RandomSound )
			Trace.Entity:SetVelocity( RandomVelocity )
			Player:ChatPrint( "Player slapped." )
		end
	end
)

AddGear( "Super Slap Player", "Aim at an entity to super slap him.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) then
			if not Trace.Entity:IsPlayer() then
				local RandomVelocity = Vector( math.random( 50000 ) - 25000, math.random( 50000 ) - 25000, math.random( 50000 ) - ( 50000 / 4 ) )
				local RandomSound = SLAP_SOUNDS[ math.random( #SLAP_SOUNDS ) ]

				Trace.Entity:EmitSound( RandomSound )
				Trace.Entity:GetPhysicsObject():SetVelocity( RandomVelocity )
				Player:ChatPrint( "Entity super slapped." )
			else
				if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

				local RandomVelocity = Vector( math.random( 5000 ) - 2500, math.random( 5000 ) - 2500, math.random( 5000 ) - ( 5000 / 4 ) )
				local RandomSound = SLAP_SOUNDS[ math.random( #SLAP_SOUNDS ) ]

				Trace.Entity:EmitSound( RandomSound )
				Trace.Entity:SetVelocity( RandomVelocity )
				Player:ChatPrint( "Player super slapped." )
			end
		end
	end
)

AddGear( "Warn Player", "Aim at a player to warn him.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			if Trace.Entity:IsVehicle() and IsValid( Trace.Entity:GetDriver() ) then
				Trace.Entity:GetDriver():Notify( "An admin thinks you're doing something stupid. Stop." )
				return Player:ChatPrint( "Player warned." )
			elseif Trace.Entity:IsPlayer() then
				Trace.Entity:Notify( "An admin thinks you're doing something stupid. Stop." )
				Player:ChatPrint( "Player warned." )
			end
		end
	end
)

--	Player:SetModel("models/marcuspa/marcus_pa.mdl");


AddGear( "Kick Player", "Aim at a player to kick him.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			Trace.Entity:Kick( "Consider this a warning." )
			Player:ChatPrint( "Player kicked." )
		end
	end
)

AddGear( "Arrest/Release Player", "Aim at a player to arrest/release them,", false,
	function( Player, Trace )
		local Victim = Trace.Entity

		if not IsValid( Victim ) or not Victim:IsPlayer() then return Player:ChatPrint( "Aim at a player!" ) end

		if not Victim.CurrentlyArrested then
			Victim:Arrest()
			Victim:SetNWBool("isPlayerArrested", true)
			

			ASS_LogAction( Player, ASS_ACL_ARREST, "arrested " .. ASS_FullNick( Victim ) )
		else
			Victim:UnArrest()
			Victim:SetNWBool("isPlayerArrested", false)

			ASS_LogAction( Player, ASS_ACL_ARREST, "released " .. ASS_FullNick( Victim ) )
		end
	end
)

AddGear( "Close Door", "Aim at a door to close it.", false,
	function ( Player, Trace )
		if IsValid( Trace.Entity ) and ( Trace.Entity:IsDoor() or Trace.Entity:IsVehicle() ) then
		--	Trace.Entity:Fire( "lock", "", 0 )
			Trace.Entity:Fire( "close", "", .5 )
			Player:ChatPrint( "Door closed." )
		end
	end
)


AddGear( "[O] Skin Changer", "Aim at car to change skin. Then type in chat what number", false,
	function ( Player, Trace )
		if ( IsValid( Trace.Entity ) ) then
			local ent = Trace.Entity
			Player:ChatPrint( "Type in chat what number skin you want." )
			hook.Add("PlayerSay", "SkinChangerGetNumber"..Player:UniqueID(), function( ply, text )
				hook.Remove("PlayerSay", "SkinChangerGetNumber"..Player:UniqueID())
				if isnumber(tonumber(text)) then
					Trace.Entity:Fire( "Skin", text, .5 )
					Player:ChatPrint( "Skin changed." )
				end
			end)
		end
	end, true
)

AddGear( "Disable Car", "Aim at a car to disable it.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
			--Trace.Entity:DisableVehicle()
			Trace.Entity:VC_DamageFull_Admin()


			Player:ChatPrint( "Vehicle disabled." )
		end
	end
)

AddGear( "Extinguish (Local)", "Extinguishes the fires near where you aim.", false,
	function( Player, Trace )
		for _, v in pairs( ents.FindInSphere( Trace.HitPos, 250 ) ) do
			if v:GetClass() == "ent_fire" then
				v:KillFire()
			end
		end

		Player:ChatPrint( "Fires extinguished nearby." )
	end
)

 AddGear( "Extinguish (All)", "Extinguishes all fires on the map.", false,
	function( Player, Trace )
		for _, v in pairs( ents.FindByClass("ent_fire" ) ) do
			v:KillFire()
		end

		for _, v in pairs( player.GetAll() ) do
			v:Notify( "All fires on the map have been extinguished to preserve gameplay." )
		end

		Player:ChatPrint( "Fires extinguished." )
	end
)

AddGear( "Remove Shrooms (Local)", "Kabooms the shrooms near where you aim.", false,
	function( Player, Trace )

		for _, v in pairs( ents.FindInSphere( Trace.HitPos, 300 ) ) do
			if v:GetClass() == "ent_shroom" then
				v:Remove()
			end
		end

		if Trace.Entity:GetClass() == "ent_shroom" then
				Trace.Entity:Remove()
		end

		Player:ChatPrint( "Shrooms kaboomed nearby." )
	end
)

AddGear( "Remove Shrooms (All)", "Removes all shrooms on the map.", false,
 function( Player, Trace )
	 if Player:GetLevel() > 1 then
	 	Player:Notify("This gear requires Server Manager+ status.");
	 	return false;
	 end

	 for _, v in pairs( ents.FindByClass("ent_shroom" ) ) do
		 v:Remove()
	 end

	 for _, v in pairs( player.GetAll() ) do
		 v:Notify( "All shrooms on the map have been kaboomed to preserve gameplay." )
	 end

	 Player:ChatPrint( "Shrooms kaboomed." )
 end
)

if SERVER then
	util.AddNetworkString("Diguise2.0Activated")
end

AddGear( "Disguise 2.0 (Beta)", "Attempts to make you completely invisible.", false,
 function( Player, Trace )
	if Player:GetNWBool("Disguise2") then
		Player:SetNWBool("Disguise2", false)
		Player:ChatPrint( "Disguised 2.0 turned off." )
		net.Start("Diguise2.0Activated")
		net.Broadcast()
	else
		Player:SetNWBool("Disguise2", true)
		Player:ChatPrint( "Disguised 2.0 turned on." )
		net.Start("Diguise2.0Activated")
		net.Broadcast()
	end
 end
)

if SERVER then
	util.AddNetworkString("perp_bomb")
end

AddGear( "Explode (No Damage)", "Aim at any object to explode it.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			if string.find( Trace.Entity:GetClass(), "prop_ragdoll" ) then
				return Player:ChatPrint( "You cannot remove ragdolls, idiot." )
			elseif string.find( Trace.Entity:GetClass(), "door" ) then
				return Player:ChatPrint( "You cannot explode doors, silly." )
			elseif string.find( Trace.Entity:GetClass(), "button" ) then
				return Player:ChatPrint( "You cannot explode buttons, silly." )
			elseif string.find( Trace.Entity:GetClass(), "npc" ) then
				return Player:ChatPrint( "You cannot explode npcs, silly." )
			elseif string.find( Trace.Entity:GetClass(), "func_brush" ) then
				return Player:ChatPrint( "You cannot remove the sky box, silly." )
			elseif string.find( Trace.Entity:GetClass(), "func_tracktrain" ) then
				return Player:ChatPrint( "You cannot remove elevators, silly." )
			elseif string.find( Trace.Entity:GetClass(), "prop_physics" ) then
				return Player:ChatPrint( "You cannot remove that, you goose." )
			elseif string.find( Trace.Entity:GetClass(), "slotmachine" ) then
				return Player:ChatPrint( "You cannot remove that, you dumbshit." )
			end

			if Trace.Entity:IsVehicle() then
				--Trace.Entity:VC_DamageFull_Admin()
				timer.Simple(0.5, function()
					if IsValid(Trace.Entity) then
						Trace.Entity:VC_setHealth(0)
					end
				end)
				if IsValid(Trace.Entity:GetDriver()) then
					Trace.Entity:GetDriver():ExitVehicle()
				end
			end

			local recipient = RecipientFilter()
			recipient:AddPVS( Trace.Entity:GetPos() )
			recipient:AddPlayer( Player )

			net.Start( "perp_bomb" )
				net.WriteVector( Trace.Entity:GetPos() )
			net.Send(recipient)

			timer.Simple( .5, function()
				if IsValid( Trace.Entity ) then
					if Trace.Entity:IsPlayer() then
						Trace.Entity:Kill()
					elseif string.find( tostring(Trace.Entity), "jeep" ) then
						--Trace.Entity:DisableVehicle(true, false)
						--Trace.Entity:GetDriver():ExitVehicle()
					else
						Trace.Entity:Remove()
					end
				end
			end)

		end
	end
)

AddGear( "Ignite", "Spawns a fire wherever you're aiming.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			if string.find( Trace.Entity:GetClass(), "door" ) then
				return Player:ChatPrint( "You cannot ignite doors, silly." )
			elseif string.find( Trace.Entity:GetClass(), "button" ) then
				return Player:ChatPrint( "You cannot ignite buttons, silly." )
			elseif string.find( Trace.Entity:GetClass(), "npc" ) then
				return Player:ChatPrint( "You cannot ignite npcs, silly." )
			elseif string.find( Trace.Entity:GetClass(), "vehicle" ) then
				return Player:ChatPrint( "You cannot ignite vehicles, silly." )
			end

			Trace.Entity:Ignite( 60 )
		else
			local Fire = ents.Create( "ent_fire" )
				Fire:SetPos( Trace.HitPos )
				Fire:Spawn()
				Fire.Starter = Player

			Player:ChatPrint( "Fire started." )
		end
	end
)

AddGear( "Teleport", "Teleports you to a targeted location.", false,
	function( Player, Trace )
		local EndPos = Trace.HitPos
		local CloserToUs = ( Player:GetPos() - EndPos ):Angle():Forward()

		Player:SetPos( EndPos + ( CloserToUs * 20 ) )
		Player:ChatPrint( "Teleported." )
	end
)

AddGear( "Lock Door/Vehicle", "Aim at a door/vehicle to lock it.", false,
	function ( Player, Trace )
		if IsValid( Trace.Entity ) and ( Trace.Entity:IsDoor() or Trace.Entity:IsVehicle() ) then
			Trace.Entity:Fire( "lock", "", 0 )
			Trace.Entity:Fire( "close", "", .5 )
			Player:ChatPrint( "Door/Vehicle locked." )
		end
	end
)

AddGear( "Unlock Door/Vehicle", "Aim at a door/vehicle to unlock it.", false,
	function ( Player, Trace )
		if IsValid( Trace.Entity ) and ( Trace.Entity:IsDoor() or Trace.Entity:IsVehicle() ) then
			Trace.Entity:Fire( "unlock", "", 0 )
			Trace.Entity:Fire( "open", "", .5 )
			Player:ChatPrint( "Door/Vehicle unlocked." )
		end
	end
)


AddGear( "Bring Personal Vehicle", "Click to bring your car..", false,
	function ( Player, Trace )
		if not Player:IsSuperAdmin() then
			Player:Notify("This gear requires SA+ status.");
			return false
		end
		if IsValid(Player.currentVehicle) then
			Player.currentVehicle:SetPos(Player:GetPos() + Vector(0,0,50))
			Player:EnterVehicle(Player.currentVehicle)
		end
	end
)


AddGear( "Biggify", "Make yourself larger", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			Player:Notify("This gear requires SA status.");
			return false;
		end

		Player:SetModelScale( Player:GetModelScale() * 1.25, 1 )
		Player:SetViewOffset( Player:GetViewOffset() * 1.10, 1 )
	end
)

AddGear( "Smallify", "Make yourself smaller", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			Player:Notify("This gear requires SA status.");
			return false;
		end

		Player:SetModelScale( Player:GetModelScale() * 0.8, 1 )
		Player:SetViewOffset( Player:GetViewOffset() * 0.8, 1 )
	end
)

AddGear( "Reset Size", "Reset your size", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			Player:Notify("This gear requires SA status.");
			return false;
		end

		Player:SetModelScale( 1, 1 )
		Player:SetViewOffset( Vector( 0,0,64 ), 1 )
	end
)

AddGear( "Explode (Damage)", "Aim at any object to explode it.", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			Player:Notify("This gear requires SA status.");
			return false;
		end
		if IsValid( Trace.Entity ) then
			if Trace.Entity:IsPlayer() and ( Trace.Entity:IsOwner() or ( Trace.Entity:IsSuperAdmin() and not Player:IsOwner() ) or ( Trace.Entity:IsAdmin() and not Player:IsSuperAdmin() ) ) then
				return Player:ChatPrint( "This player has the same or a better rank than you, you can't do this." )
			end

			if string.find( Trace.Entity:GetClass(), "prop_ragdoll" ) then
					return Player:ChatPrint( "You cannot remove ragdolls, idiot." )
				elseif string.find( Trace.Entity:GetClass(), "npc_nextbot" ) then
					return Player:ChatPrint( "You cannot remove NPCs." )
				elseif string.find( Trace.Entity:GetClass(), "door" ) then
					return Player:ChatPrint( "You cannot remove doors, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_door" ) then
					return Player:ChatPrint( "You cannot remove doors, silly." )
				elseif string.find( Trace.Entity:GetClass(), "prop_door_rotating" ) then
					return Player:ChatPrint( "You cannot remove doors, silly." )
				elseif string.find( Trace.Entity:GetClass(), "prop_dynamic" ) then
					return Player:ChatPrint( "You cannot remove this, silly." )
				elseif string.find( Trace.Entity:GetClass(), "button" ) then
					return Player:ChatPrint( "You cannot remove buttons, silly." )
				elseif string.find( Trace.Entity:GetClass(), "npc" ) then
					return Player:ChatPrint( "You cannot remove npcs, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_brush" ) then
					return Player:ChatPrint( "You cannot remove the sky box, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_tracktrain" ) then
					return Player:ChatPrint( "You cannot remove elevators, silly." )
				elseif string.find( Trace.Entity:GetClass(), "func_movelinear" ) then
					return Player:ChatPrint( "You cannot remove elevators, silly." )
				elseif string.find( Trace.Entity:GetClass(), "prop_physics" ) then
					return Player:ChatPrint( "You cannot remove that, you goose." )
				elseif string.find( Trace.Entity:GetClass(), "slotmachine" ) then
					return Player:ChatPrint( "You cannot remove that, you dumbshit." )
				elseif string.find( Trace.Entity:GetClass(), "vehicle" ) and Trace.Entity.DemoVehicle then
					return Player:ChatPrint( "You cannot remove a demo vehicle." )
				end

			if Trace.Entity:IsVehicle() and IsValid( Trace.Entity:GetDriver() ) then
				Trace.Entity:VC_DamageFull_Admin()
				if IsValid(Trace.Entity:GetDriver()) then
					Trace.Entity:GetDriver():ExitVehicle()
				end
			end

			local recipient = RecipientFilter()
			recipient:AddPVS( Trace.Entity:GetPos() )
			recipient:AddPlayer( Player )

			net.Start( "perp_bomb" )
				net.WriteVector( Trace.Entity:GetPos() )
			net.Send(recipient)

			for i = 1, 5 do
				util.BlastDamage( Player, Player, Trace.Entity:GetPos(), 300, 300 )
			end

			if Trace.Entity:IsPlayer() then
				Trace.Entity:Kill()
			else
				Trace.Entity:Remove()
			end
		end
	end
)

AddGear( "[O] Telekinesis ( Stupid )", "Left click to make it float.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end
		local self = Player:GetActiveWeapon()

		if self.Floater then
			self.Floater = nil
			self.FloatSmart = nil
		elseif IsValid( Trace.Entity ) then
			self.Floater = Trace.Entity
			self.FloatSmart = nil
		end
	end
)

AddGear( "[O] Telekinesis ( Smart )", "Left click to make it float and follow your crosshairs.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

		local self = Player:GetActiveWeapon()

		if self.Floater then
			self.Floater = nil
			self.FloatSmart = nil
		elseif IsValid( Trace.Entity ) then
			self.Floater = Trace.Entity
			self.FloatSmart = true
		end
	end
)

AddGear("[SM] Delete Tornados", "Left click to kill all tornados.", false,
	function ( Player, Trace )
		if not Player:IsServerManager() then
			return Player:Notify( "This gear requires Server Manager status." )
		end

			for k, v in pairs(ents.FindByClass('weather_tornado')) do
				v:Remove();
			end

			for k, v in pairs(player.GetAll()) do
				v:Notify("All tornados on the map have been removed to preserve gameplay.");
			end

			Player:PrintMessage(HUD_PRINTTALK, "Tornados removed.");
	end
)

AddGear( "[SM] Update Alert", "Left click to alert the server about an update.", false,
	function ( Player, Trace )
		if not Player:IsServerManager() then
			return Player:Notify( "This gear requires Server Manager status." )
		end

		for k, v in pairs(player.GetAll()) do
			v:Notify( "UPDATE ALERT" );
			v:Notify( "We are preparing to pushing an update, please prepare for lag." )
		end

		Player:PrintMessage( HUD_PRINTTALK, "Alert Sent." );
	end
)

AddGear( "[O] Damage ALL CARS", "Left click to close all doors, just in-case there's a bug.", false,
	function( Player )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

		for _, v in pairs( ents.GetAll() ) do
			if v:IsVehicle() then
				v:VC_DamageFull_Admin()
			end
		end
	end
)


AddGear( "[O] Repair ALL CARS", "Left click to close all doors, just in-case there's a bug.", false,
	function( Player )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

		for _, v in pairs( ents.GetAll() ) do
			if v:IsVehicle() then
				v:VC_RepairFull_Admin()

			end
		end
	end
)

AddGear( "[O] Car health [5000]", "USES VC_setHealth", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end
		
		if IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
			
			Trace.Entity:VC_setHealthMax(5000)
			Trace.Entity:VC_setHealth(5000)

			Player:ChatPrint( Trace.Entity:VC_getHealth(true) .. "%" )
			Player:ChatPrint( Trace.Entity:VC_getHealth() )
		end
	end
)

AddGear( "[O] Set Engine Upgrade", "Sets engine upgrade, type number in chat.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

		hook.Remove("PlayerSay", "EngineUpgrade"..Player:SteamID())
		hook.Add("PlayerSay", "EngineUpgrade"..Player:SteamID(), function(ply,text)
			if ply == Player then
				local enginenum = tonumber(text)
				if not isnumber(enginenum) then return end
				hook.Remove("PlayerSay", "EngineUpgrade"..Player:SteamID())
				local vehicle = Player.currentVehicle
				if not IsValid(vehicle) then return end
				local params = vehicle:GetVehicleParams()
				params.engine.horsepower = vehicle.OGhorsepwower + 24*(UpgradeLevel or 0)
				params.engine.maxSpeed = vehicle.OGmaxSpeed + 5*(UpgradeLevel or 0)
				vehicle:SetVehicleParams(params)
				ply:Notify("Set engine upgrade to level: " .. enginenum)
				ply:Notify("Horsepower: " .. params.engine.horsepower)
				ply:Notify("MaxSpeed: " .. params.engine.maxSpeed)
			end
		end)

	end
)

AddGear( "[O] Get Car Health", "Gets max health, health and health percent of vehicle.", false,
	function( Player, Trace )
		if IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
			if not Player:IsOwner() then
				return Player:Notify( "This gear requires Owner status." )
			end
			
			local VC_HEALTH_max = Trace.Entity:VC_getHealthMax()
			local VC_HEALTH_perc = Trace.Entity:VC_getHealth(true)
			local VC_HEALTH = Trace.Entity:VC_getHealth()

			Player:ChatPrint( VC_HEALTH_max )
			Player:ChatPrint( VC_HEALTH_perc .. "%" )
			Player:ChatPrint( VC_HEALTH )
		end
	end
)

AddGear( "[O] Flying Car", "Left click to make a car fly.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

		if IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
			Trace.Entity.CanFly = true
			Player:ChatPrint( "You are now the proud owner of a flying car." )
		end
	end
)

AddGear( "Tornado", "Left click to spawn a tornado.", false,
	function ( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

			local Fire = ents.Create('weather_tornado');
			Fire:SetPos(Trace.HitPos);
			Fire:Spawn();

			Player:PrintMessage(HUD_PRINTTALK, "Tornado spawned.");
	end, true
)

AddGear( "Clear Weather", "Left click to clear weather.", false,
	function ( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

		StormFox.SetWeather("clear", 1, 30)
		StormFox.SetThunder( false )

		timer.Destroy("SpawnTornadosinStorm")

			Player:PrintMessage(HUD_PRINTTALK, "A sun is coming!");
	end, true
)


AddGear( "Tornado Weather", "Left click to create tornado prone weather.", false,
	function ( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

		StormFox.SetWeather("rain", 1, 30)
		StormFox.SetThunder( true )
		StormFox.SetNetworkData( "Wind", 20 )

		local tornadospots = {
			Vector(-3199,12377,120),
			Vector(-3199,12377,120),
			Vector(5697,7655,120),
			Vector(4971,-1677,-71),
			Vector(-4104,-527,-112),
			Vector(-8060,540,-48),
			Vector(-5742,2395,-48),
			Vector(-2513,3431,-112),
			Vector(1408,10183,128),
		}

		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("A Tornado Warning is in affect for Southside... TAKE COVER!")
		end

		EmitSound( Sound( "paris/tornsiren.mp3"	), Vector(-1646,3047,1262), 1, CHAN_AUTO, 1, 130, 0, 100 )

		timer.Create("SpawnTornadosinStorm", 20, math.random(4,11), function()
			local Fire = ents.Create('weather_tornado');
			Fire:SetPos(tornadospots[math.random(#tornadospots,1)]);
			Fire:Spawn()
		end)

			Player:PrintMessage(HUD_PRINTTALK, "A storm is approaching...");
	end, true
)



AddGear( "Break Legs", "Breaks you legs", false,
	function( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

				Player.Crippled = true
				Player:Notify( "You've broken your legs!" )
	end, true
)

AddGear( "Fix Legs", "Fix you legs", false,
	function( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

				Player.Crippled = nil
				Player:Notify( "You've fixed your legs!" )
	end, true
)

// rope mane //
-- it's perp code so i get to write bad code too :)
local ropeObj = nil
local ropeTarget1 = nil
local ropeTarget2
function setRopeTarget(target)
	if ropeTarget2 then
            if IsValid(ropeObj) then 
                ropeObj:Remove() 
                ropeObj = nil
            end
            ropeTarget1 = target
            ropeTarget2 = nil
    else
    	ropeTarget2 = target
    end 
end
AddGear( "[O] Attach Rope", "Left click to attach rope.", false,
        function(Player, Trace)
            if not Player:IsOwner() then return Player:Notify("This gear requires Owner status.") end
            if not IsValid(Trace.Entity) then return setRopeTarget(Player) end
            setRopeTarget(Trace.Entity)
            if ropeTarget1 and ropeTarget2 then
                local vec = Vector(0, 0, 0)
                if ropeTarget1 == Player then
                    vec = Vector(0, 0, 50) + (Player:EyeAngles():Right() * -20)
                 end
                ropeObj = constraint.Rope(ropeTarget1, ropeTarget2, 0, 0, vec, Vector(0, 0, 0), 150, 0, 0, 1, "cable/rope", false)
            end
        end
)
    
// SOUNDS //

AddGear( "[O] Oh my legs", "Plays the sound.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end
			--[[
			local MoanFile
			if Player:GetSex() == SEX_MALE then
				MoanFile = Sound( "vo/npc/male01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			else
				MoanFile = Sound( "vo/npc/female01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			end
			]]

			local MoanFile
			MoanFile = Sound( "vo/npc/male01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			--MoanFile = Sound( "vo/Streetwar/sniper/male01/c17_09_greeting.wav" )
			--MoanFile = Sound( "vo/npc/male01/question06.wav" )

			//sound.Play( MoanFile, Player:GetPos(), 100, 100 )
			//sound.Play( MoanFile, Player:GetPos(), 100, 180 ) //high pitch
			//sound.Play( MoanFile, Player:GetPos(), 100, 80 ) //demon pitch
			sound.Play( MoanFile, Player:GetPos(), 100, 100 )
		
	end
)

AddGear( "[O] Death moan", "Plays the sound.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end
			--[[
			local MoanFile
			if Player:GetSex() == SEX_MALE then
				MoanFile = Sound( "vo/npc/male01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			else
				MoanFile = Sound( "vo/npc/female01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			end
			]]

			local ToUse = "male"
	
			local MoanFile = Sound( "vo/npc/" .. ToUse .. "01/moan0" .. math.random( 1, 5 ) .. ".wav" )
			sound.Play( MoanFile, Player:GetPos(), 100, 100 )
		
	end
)

AddGear( "[O] Cheese", "Left click to spawn a bot.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

			local MoanFile
			--MoanFile = Sound( "vo/npc/male01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			--MoanFile = Sound( "vo/Streetwar/sniper/male01/c17_09_greeting.wav" )
			MoanFile = Sound( "vo/npc/male01/question06.wav" )

			//sound.Play( MoanFile, Player:GetPos(), 100, 100 )
			//sound.Play( MoanFile, Player:GetPos(), 100, 180 ) //high pitch
			//sound.Play( MoanFile, Player:GetPos(), 100, 80 ) //demon pitch
			sound.Play( MoanFile, Player:GetPos(), 100, 100 )

	end
)

AddGear( "[O] Hi", "Left click to spawn a bot.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

			local MoanFile
			--MoanFile = Sound( "vo/npc/male01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			--MoanFile = Sound( "vo/Streetwar/sniper/male01/c17_09_greeting.wav" )
			MoanFile = Sound( "vo/npc/male01/hi0" .. math.random( 1, 2 ) .. ".wav" )

			//sound.Play( MoanFile, Player:GetPos(), 100, 100 )
			//sound.Play( MoanFile, Player:GetPos(), 100, 180 ) //high pitch
			//sound.Play( MoanFile, Player:GetPos(), 100, 80 ) //demon pitch
			sound.Play( MoanFile, Player:GetPos(), 100, 100 )

	end
)

AddGear( "[O] Hax", "Left click to spawn a bot.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

			local which = math.random( 1, 2 )
			local MoanFile
			--MoanFile = Sound( "vo/npc/male01/myleg0" .. math.random( 1, 2 ) .. ".wav" )
			--MoanFile = Sound( "vo/Streetwar/sniper/male01/c17_09_greeting.wav" )
			
			if which == 1 then
				MoanFile = Sound( "vo/npc/male01/hacks0" .. math.random( 1, 2 ) .. ".wav" )
			else
				MoanFile = Sound( "vo/npc/male01/thehacks0" .. math.random( 1, 2 ) .. ".wav" )
			end
			
			//sound.Play( MoanFile, Player:GetPos(), 100, 100 )
			//sound.Play( MoanFile, Player:GetPos(), 100, 180 ) //high pitch
			//sound.Play( MoanFile, Player:GetPos(), 100, 80 ) //demon pitch
			sound.Play( MoanFile, Player:GetPos(), 100, 100 )

	end
)

// SOUNDS END //

AddGear( "[O] Save All Players", "Left click to save all players connected.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

		Player:ConCommand("perp_save_all")
		Player:ChatPrint( "Saving all players." )

	end
)

AddGear( "Snow", "Left click to change the weather. ( Takes up to a minute after fire. )", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		RunConsoleCommand("sw_weather", "snow")
		--Player:ConCommand("daynight_setweather snow")
		Player:ChatPrint( "Let it snow, let it snow, let it snow! (Snow Started)" )
	end, false
)

AddGear( "Rain", "Left click to change the weather. ( Takes up to a minute after fire. )", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		RunConsoleCommand("sw_weather", "rain")
		--Player:ConCommand("daynight_setweather rain")
		Player:ChatPrint( "It's raining men! (Rain Started)" )
	end, false
)

AddGear( "Clear Weather", "Left click to change the weather. ( Takes up to a minute after fire. )", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		RunConsoleCommand("sw_stopweather")
		--Player:ConCommand("daynight_setweather clear")
		Player:ChatPrint( "Rain rain, go away! Come again another day! (Rain Cleared)" )
	end, false
)

AddGear( "Pause Lottery", "Left click to pause the lottery.", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		PauseLottery()

		Player:ChatPrint( "Paused the lottery..." )
	end, false
)

AddGear( "Resume Lottery", "Left click to resume the lottery.", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		ResumeLottery()

		Player:ChatPrint( "Resumed the lottery..." )
	end, false
)

AddGear( "Restart Lottery/Refund All", "Left click to restart the lottery (Refunds everyone don't worry).", true,
	function( Player, Trace )
		if not Player:IsSuperAdmin() then
			return Player:Notify( "This gear requires Senior Administrator status." )
		end

		RestartLottery()

		Player:ChatPrint( "Restarted the lottery..." )
	end, false
)

AddGear("Map Lights [On]", "Left click to spawn a discnado.", false,
	function ( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

			for k,v in pairs(ents.GetAll()) do if v:GetName()=="1" then v:Fire("turnon") end end
			--for k,v in pairs(ents.GetAll()) do if v:GetName()=="1" then v:Fire("turnon") end end

			Player:PrintMessage(HUD_PRINTTALK, "Lights on.");
	end, true
)

AddGear("Map Lights [Off]", "Left click to spawn a discnado.", false,
	function ( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

		for k,v in pairs(ents.GetAll()) do if v:GetName()=="1" then v:Fire("turnoff") end end

			Player:PrintMessage(HUD_PRINTTALK, "LIGHTS OFF!.");
	end, true
)

AddGear( "[O] Add Bot", "Left click to spawn a bot.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end

		RunConsoleCommand("bot")

	end, true
)

AddGear( "[O] Remove Bots", "Left click to make bots go poof.", false,
	function( Player, Trace )
		if not Player:IsOwner() then
			return Player:Notify( "This gear requires Owner status." )
		end
		for k, v in pairs(player.GetAll()) do
			if v and v:IsBot() then
				Player:ChatPrint("Bots gone poof!")
				v:Kick("Fuck off bot, no one likes you.")
			end
		end
	end, true
)

AddGear( "Random Cars", "Left click to create random cars.", false,
	function( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

		local randCar = table.Random( VEHICLE_DATABASE )

		GAMEMODE:SpawnVehicle( Player, randCar.ID, { RGBColour = Color( math.random( 0, 255), math.random( 0, 255), math.random( 0, 255), 255 ), PaintID = 1, HeadLights = 1 }, { Trace.HitPos, Angle(0,0,0) }, true )

	end, true
)

AddGear( "Spawn Specific Vehicle", "Left click to create random cars.", false,
	function( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end

		Player:ChatPrint("Type the ID of the car you want in chat")

		hook.Remove("PlayerSay", "SpawnSpecficVehicle"..Player:SteamID())
		hook.Add("PlayerSay", "SpawnSpecficVehicle"..Player:SteamID(), function(ply,text)
			if ply == Player then
				local id = text
				local randCar
				hook.Remove("PlayerSay", "SpawnSpecficVehicle"..Player:SteamID())
				randCar = VEHICLE_DATABASE[id]
				GAMEMODE:SpawnVehicle( Player, randCar.ID, { RGBColour = Color( 255, 255, 255, 255 ), PaintID = 1, HeadLights = 1 }, { Trace.HitPos, Player:GetAngles() }, true )
			end
		end)

	end, true
)

AddGear( "Get Car ID", "Left click to get the car's ID.", false,
	function( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end
		local vehicle = Trace.Entity

		Player:ChatPrint( "Vehicle ID: " .. vehicle:GetNWString("veh_id") )

	end, true
)

AddGear( "Open Garage", "Left click to open your garage.", false,
	function( Player, Trace )
		if not table.HasValue( devs, Player:SteamID() ) then
			return Player:Notify( "This gear requires Developer status." )
		end
		Player:SendLua([[GAMEMODE.ShowGarageView()]])
	end, true
)


function SWEP:Think()
	if not IsValid( self.Owner ) then return end

	if IsValid( self.Floater ) then
		local trace = {}
		trace.start = self.Floater:GetPos()
		trace.endpos = trace.start - Vector( 0, 0, 100000 )
		trace.filter = { self.Floater }
		local tr = util.TraceLine( trace )

		local altitude = tr.HitPos:Distance( trace.start )

		local ent = self.Spazzer
		local vec

		if self.FloatSmart then
			local trace = {}
			trace.start = self.Owner:GetShootPos()
			trace.endpos = trace.start + ( self.Owner:GetAimVector() * 400 )
			trace.filter = { self.Owner, self.Weapon }
			local tr = util.TraceLine( trace )

			vec = trace.endpos - self.Floater:GetPos()
		else
			vec = Vector( 0, 0, 0 )
		end

		if altitude < 150 then
			if vec == Vector( 0, 0, 0 ) then
				vec = Vector( 0, 0, 25 )
			else
				vec = vec + Vector( 0, 0, 100 )
			end
		end

		vec:Normalize()

		if self.Floater:IsPlayer() then
			local speed = self.Floater:GetVelocity()
			self.Floater:SetVelocity( ( vec * 1 ) + speed )
		else
			local speed = self.Floater:GetPhysicsObject():GetVelocity()
			self.Floater:GetPhysicsObject():SetVelocity( ( vec * math.Clamp( ( self.Floater:GetPhysicsObject():GetMass() / 20), 10, 20 ) ) + speed )
		end
	else
		self.Floater = nil
	end
end

if CLIENT then
	surface.CreateFont( "GodStick", { font = "Arial", size = 16, weight = 800, antialias = true, additive = false } )

	local chRotate = 0
	function SWEP:DrawHUD()
		local godstickCrosshair = surface.GetTextureID( "perp2/crosshairs/godstick_crosshairv4" )
		local trace = self.Owner:GetEyeTrace()
		local x = ( ScrW() / 2 )
		local y = ( ScrH() / 2 )

		if IsValid( trace.Entity ) then
			draw.WordBox( 8, ( x - 100 ), 10, "Target: " .. tostring( trace.Entity ) .. " Model: " .. trace.Entity:GetModel():lower(), "GodStick", Color( 50, 50, 75, 100 ), Color( 255, 0, 0, 255 ) )
			surface.SetDrawColor( 255, 0, 0, 255 )
			chRotate = chRotate + 8
		else
			draw.WordBox( 8, ( x - 100 ), 10, "Target: " .. tostring( trace.Entity ), "GodStick", Color( 50, 50, 75, 100 ), Color( 255, 255, 255, 255 ) )
			surface.SetDrawColor( 255, 255, 255, 255 )
			chRotate = chRotate + 3
		end


		//Been replaced with cl mod adminnofity - shows always not just with godstick in hand
		--[[ 
			if LocalPlayer():GetPNWVar( "invisible" ) == 1 then
				draw.SimpleText('You are invisible.', 'PlayerNameFont', ScrW() * .5, ScrH() * .25, Color(100+ 100 * math.abs(math.sin(CurTime())), 0, 0, 255), 1, 1);
			end
		]]


		surface.SetTexture( godstickCrosshair )
		surface.DrawTexturedRectRotated( x, y, 64, 64, 0 + chRotate )
	end

	net.Receive( "bodygroups", function( len )
		print( "BODYGROUPS: Received message ( " .. len .. " bits )" )
		print( util.TableToJSON( net.ReadTable(), true ) )
		//PrintTable( net.ReadTable() )
	end )
end

timer.Create( "MonitorWeaponVis", 0.5, 0, function()
	for _, v in pairs( player.GetAll() ) do
		if v.Invisible then
			v:SetColor( Color( 0, 0, 0, 0 ) )
			v:SetNoDraw( true )
			v:DrawWorldModel( false )
		end

		if v:IsAdmin() and IsValid( v:GetActiveWeapon() ) then
			local Colour = v:GetColor()
			local Colour2 = v:GetActiveWeapon():GetColor()

			if Colour.a == 0 and Colour2.a == 255 then
				v:GetActiveWeapon():SetColor( Color( Colour2.r, Colour2.g, Colour2.b, 0 ) )
			elseif Colour.a == 255 and Colour2.a == 0 then
				v:GetActiveWeapon():SetColor( Color( Colour2.r, Colour2.g, Colour2.b, 255 ) )
			end
		end
	end
end )

hook.Add( "KeyPress", "MonitorKeysForFlymobile", function( Player, Key )
	if Player:InVehicle() and Player:GetVehicle().CanFly then
		local Force

		if Key == IN_ATTACK then
			Force = Player:GetVehicle():GetUp() * 450000
		elseif Key == IN_ATTACK2 then
			Force = Player:GetVehicle():GetForward() * 100000
		end

		if Force then
			Player:GetVehicle():GetPhysicsObject():ApplyForceCenter( Force )
		end
	end
 end )

if SERVER then
	concommand.Add( "god_sg", function( Player, Command, Args )
		if not Player:HasWeapon( "god_stick" ) or not Args[1] then return end

		Player:SetNWInt("CurGear",tonumber( Args[1] ))
	end )
end

timer.Simple( .5, function() GAMEMODE.StickText = Gears[1][1] .. " - " .. Gears[1][2] end )

function SWEP:SecondaryAttack()
	if SERVER then return false end

	local MENU = DermaMenu()

	--if table.HasValue( devs, LocalPlayer():SteamID() ) then
		local MENU2 = MENU:AddSubMenu( "[DEV] Developer Tools" )
		local MENU3 = MENU:AddSubMenu( "[SA] Senior Admin Tools" )
		local MENU4 = MENU:AddSubMenu( "[SM] Server Manager Tools" )
		local MENU5 = MENU:AddSubMenu( "[O] Owner Tools" )
	--end

	for k, v in pairs( Gears ) do
		if v[5] then
			local Title = v[1]
			Title = "[DEV] " .. Title

			MENU2:AddOption( Title, function()
				RunConsoleCommand( "god_sg", k )
				LocalPlayer():ChatPrint( v[2] )
				GAMEMODE.StickText = v[1] .. " - " .. v[2]
			end )
		elseif v[3] then
			local Title = v[1]
			Title = "[SA] " .. Title

			MENU3:AddOption( Title, function()
				RunConsoleCommand( "god_sg", k )
				LocalPlayer():ChatPrint( v[2] )
				GAMEMODE.StickText = v[1] .. " - " .. v[2]
			end )
		elseif string.sub( v[1], 1, 4 ) == "[SM]" then
			local Title = v[1]

			MENU4:AddOption( Title, function()
				RunConsoleCommand( "god_sg", k )
				LocalPlayer():ChatPrint( v[2] )
				GAMEMODE.StickText = v[1] .. " - " .. v[2]
			end )
		elseif string.sub( v[1], 1, 3 ) == "[O]" then
			local Title = v[1]

			MENU5:AddOption( Title, function()
				RunConsoleCommand( "god_sg", k )
				LocalPlayer():ChatPrint( v[2] )
				GAMEMODE.StickText = v[1] .. " - " .. v[2]
			end )
		else
			local Title = v[1]

			MENU:AddOption( Title, function()
				RunConsoleCommand( "god_sg", k )
				LocalPlayer():ChatPrint( v[2] )
				GAMEMODE.StickText = v[1] .. " - " .. v[2]
			end )
		end
	end

	MENU:Open( 100, 100 )
	timer.Simple( 0, function() gui.SetMousePos( 110, 110 ) end )
end
