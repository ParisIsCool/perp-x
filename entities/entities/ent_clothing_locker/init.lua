--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]
--[[-----------------------------------------------------
	Clothing Locker
	Created by VENOM aka RickyBGamez for Hellzone PERP
--]]-----------------------------------------------------

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

util.AddNetworkString( "VENOM_Locker_Open" )
util.AddNetworkString( "VENOM_UpdateClothing" )

function ENT:Initialize()
	self:SetModel( "models/props_c17/Lockers001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow( true )
	
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( caller )
	net.Start( "VENOM_Locker_Open" )
	net.Send( caller )
end

local function UpdateClothing( len, ply )
	local string = net.ReadString()

	ply:SetBodyGroups( string )
end
net.Receive( "VENOM_UpdateClothing", UpdateClothing )