--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_lab/clipboard.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	self:GetPhysicsObject():Wake()
end

function ENT:StartTouch( Entity )
	if not IsValid( self.weld ) and Entity:GetClass() == "prop_vehicle_jeep" and Entity.vehicleTable --[[and ( Entity.vehicleTable.ID == "F" or Entity.vehicleTable.ID == "w" or Entity.vehicleTable.ID == "e" or Entity.vehicleTable.ID == "LL")]] and Entity.Owner == self.Owner then
		self.weld = constraint.Weld( self, Entity, 0, 0, 0, true )

		local eff = EffectData()
		eff:SetOrigin( self:GetPos() )
		util.Effect( "ManhackSparks", eff )

		self:EmitSound( "physics/metal/sawblade_stick1.wav" )

		if self:IsPlayerHolding() then
			self:GetPhysicsObject():EnableMotion( false )

			timer.Simple( 0.5, function()
				if IsValid( self ) and IsValid( self:GetPhysicsObject() ) then
					self:GetPhysicsObject():EnableMotion( true )
				end
			end )
		end
	end
end

function ENT:Think()
	if self:GetNWBool("RainbowSign") then
		self:SetColor(HSVToColor( CurTime() % 6 * 60, 1, 1 ))
	end
end

util.AddNetworkString("ModifySign")
function ENT:Use( Player )
	local Trace = {}
		Trace.start = Player:EyePos()
		Trace.endpos = Trace.start + Player:GetAimVector() * 128
		Trace.filter = Player

	local Tr = util.TraceLine( Trace )

	if not IsValid( Tr.Entity ) or not IsValid( Tr.Entity.Owner ) then return end

	if Player == Tr.Entity.Owner then
		self:GetPhysicsObject():Sleep()

		net.Start( "ModifySign" )
			net.WriteEntity( Tr.Entity )
		net.Send(Player)
	end
end

local eastereggs = {}
eastereggs["terraria"] = 	"Minecraft"
eastereggs["minecraft"] = 	"Terraria"
eastereggs["gmod"] = 		"Garry's Mod"
eastereggs["egg"] = 		"not egg"

local eastereggscolor = {}
eastereggscolor["420"] = Color(0,255,0,200)

concommand.Add( "modify_sign", function( Player, Command, Args )
	if not Args[1] and not Args[2] then return end

	local Trace = {}
		Trace.start = Player:EyePos()
		Trace.endpos = Trace.start + Player:GetAimVector() * 128
		Trace.filter = Player

	local Tr = util.TraceLine( Trace )

	if IsValid( Tr.Entity ) and Tr.Entity:GetClass() == "prop_sign" and Tr.Entity.Owner == Player then
		if string.len( Args[1] ) > 30 then return Player:ChatMessage( "Your text message must be under 30 characters." ) end

		Tr.Entity:GetPhysicsObject():Wake()

		Tr.Entity.TextString = Args[1]

		if eastereggs[string.lower(Tr.Entity.TextString)] then
			Player:Notify("Activated Easter Egg: " .. eastereggs[string.lower(Tr.Entity.TextString)])
			Tr.Entity.TextString = eastereggs[string.lower(Tr.Entity.TextString)]
		end

		Tr.Entity:SetColor( Tr.Entity.Colours[ Args[2] ] or Color( 255, 255, 255, 255 ) )

		if eastereggscolor[string.lower(Tr.Entity.TextString)] then
			Player:Notify("Activated Easter Egg: " .. string.lower(Tr.Entity.TextString))
			Tr.Entity:SetColor( eastereggscolor[string.lower(Tr.Entity.TextString)] or Color( 255, 255, 255, 255 ) )
		end

		if string.lower(Tr.Entity.TextString) == "rainbow" then
			Tr.Entity:SetNWBool("RainbowSign", true)
			Player:Notify("Activated Easter Egg: Rainbow")
		else
			Tr.Entity:SetNWBool("RainbowSign", false)
		end

		Tr.Entity:SetGNWVar( "Text", Tr.Entity.TextString )
	end
end )
