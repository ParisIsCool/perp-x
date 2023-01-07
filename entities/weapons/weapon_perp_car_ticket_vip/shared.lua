--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

SWEP.Author					= "G-Force"
SWEP.Purpose				= "Left click on a car to give the owner a ticket."

SWEP.ViewModel				= Model( "models/props_lab/clipboard.mdl" )
SWEP.WorldModel				= Model( "models/props_lab/clipboard.mdl" )

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.NextStrike 				= 0

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	if SERVER then
		self.Gear = 1
	end

	self:SetWeaponHoldType( "normal" )
end

local Gears = {}
 
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	if CurTime() < self.NextStrike then return end
	if not self.Owner:IsVIP() then
		if SERVER then self.Owner:StripWeapon( self.Weapon:GetClass() ) end
		return false
	end

	self.NextStrike = ( CurTime() + .3 )
	
	if CLIENT then return end

	local trace = self.Owner:GetEyeTrace()
	
	local Gear = self.Owner.CurGear or 1
	if not Gears[ Gear ] then self.Owner.CurGear = 1 end
	
	Gears[ Gear ][ 4 ]( self.Owner, trace )
	
	self:SetNextPrimaryFire( CurTime() + 2 )
	
end

local function AddGear( Title, Desc, SA, Func )
	table.insert( Gears, { Title, Desc, SA, Func } )
end

AddGear( "[Written Warning] - $0", "Left click to give the car's owner a warning.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket0" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 130, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Parking Ticket] - $150", "Left click to give the car's owner a parking ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket1" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 131, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Running a Traffic Control Device] - $300", "Left click to give the car's owner a ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket2" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 132, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Speeding 1-5 Over] - $200", "Left click to give the car's owner a speeding ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket3" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 133, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Speeding 5-10 Over] - $300", "Left click to give the car's owner a speeding ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket4" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 134, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Speeding 10-15 Over] - $400", "Left click to give the car's owner a speeding ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket5" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 135, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Speeding 15-20 Over] - $400", "Left click to give the car's owner a speeding ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket6" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 136, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Speeding 21+ Over -RECKLESS-] - $2000", "Left click to give the car's owner a speeding / reckless ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket7" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 137, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Reckless Driving] - $2000", "Left click to give the car's owner a reckless driving ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket8" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 138, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Failure to Yield] - $250", "Left click to give the car's owner a ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket9" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 139, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
)

AddGear( "[Hit and Run] - $750", "Left click to give the car's owner a ticket.", false,
	function( Player, Trace )
		local trEntity = Trace.Entity
		if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( Player:GetPos() ) < 200 and trEntity.Owner then
			--if trEntity.Owner:IsGovernmentOfficial() then
			--	return Player:ChatPrint( "Can't ticket government or job workers." )
			--end

			if trEntity.Disabled then
				return Player:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
			end
			
			if not trEntity.Owner:HasItem( "item_parkingticket10" ) then
				Player:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				Player:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

				Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", Player:Nick(), Player:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
				GAMEMODE:Log( "cartickets", Log )
				
				trEntity.Owner:GiveItem( 140, 1 )
				trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
				
				umsg.Start( "perp_ticket", trEntity.Owner )
					umsg.String( Player:GetRPName() )
					umsg.String( Player:SteamID() )
				umsg.End()
			else
				Player:ChatPrint( "This person has already received a ticket." )
			end
		end
	end
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
--[[
if CLIENT then
	surface.CreateFont( "GodStick", { font = "Scoreboard", size = 16, weight = 800, antialias = true, additive = false } )

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
		
		if LocalPlayer():GetPNWVar( "invisible" ) == 1 then
			draw.SimpleText('You are invisible.', 'PlayerNameFont', ScrW() * .5, ScrH() * .25, Color(100+ 100 * math.abs(math.sin(CurTime())), 0, 0, 255), 1, 1);
		end
			
		surface.SetTexture( godstickCrosshair )
		surface.DrawTexturedRectRotated( x, y, 64, 64, 0 + chRotate )
	end
end ]]--
 
if SERVER then
	concommand.Add( "perp_car_ticket", function( Player, Command, Args )
		if not Player:HasWeapon( "weapon_perp_car_ticket_vip" ) or not Args[1] then return end

		Player.CurGear = tonumber( Args[1] )
	end )
end
 
timer.Simple( .5, function() GAMEMODE.TicketText = Gears[1][1] .. " - " .. Gears[1][2] end )

function SWEP:SecondaryAttack()	
	if SERVER then return false end
	
	local MENU = DermaMenu()
	
	for k, v in pairs( Gears ) do	
		local Title = v[1]
		
		MENU:AddOption( Title, function()
			RunConsoleCommand( "perp_car_ticket", k ) 
			LocalPlayer():ChatPrint( v[2] )
			GAMEMODE.TicketText = v[1] .. " - " .. v[2]
		end )
	end
	
	MENU:Open( 100, 100 )	
	timer.Simple( 0, function() gui.SetMousePos( 110, 110 ) end )
end 