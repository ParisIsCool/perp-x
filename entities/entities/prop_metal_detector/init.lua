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
	self:SetModel( "models/props_wasteland/interior_fence002e.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	
	self.AlarmSound = CreateSound( self, "ambient/alarms/klaxon1.wav" )
	self.AlarmSound:Stop()
end

local WhitelistedWeapons = { 28, 56, 34, 35, 36, 43, 112, 113, 37, 33 }
local WhitelistedWeapons2 = { "weapon_perp_ak47", "weapon_perp_bat", "cw_fiveseven", "cw_mp5_kry", "khr_p226", "cw_deagle", "cw_fiveseven", "cw_glock20", "weapon_perp_handcuffs", "weapon_perp_lock_pick", "weapon_perp_m4a1", "khr_m4a4", "weapon_perp_mp5", "cw_m3super90", "cw_tr09_mp9" }

function ENT:Think()
	local SetOff

	for _, v in pairs( ents.FindInSphere( self:GetPos(), 25 ) ) do
		if v:IsPlayer() then
			for _, v in pairs( v:GetWeapons() ) do
				if table.HasValue( WhitelistedWeapons2, v:GetClass() ) then
					SetOff = true
				end
			end
			/*
			if v.PlayerItems then
				for _, v in pairs( v.PlayerItems ) do
					if table.HasValue( WhitelistedWeapons, v.ID ) then
						SetOff = true
					end
				end
			end
			*/
		end
	end

	if SetOff and not self.Alarm then
		self.AlarmSound:Play()
		self:SetColor( Color( 255, 0, 0, 255 ) )

		self.Alarm = true

		timer.Simple( 2, function()
			if not IsValid( self ) then return end
			self.Alarm = false
		
			if self.AlarmSound then
				self.AlarmSound:Stop()
			end 

			self:SetColor( Color( 255, 255, 255, 255 ) )
		end )
	end

	self:NextThink( CurTime() + 0.2 )
	
	return true
end