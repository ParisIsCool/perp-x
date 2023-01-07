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
	self:SetModel( "models/hunter/plates/plate1x1.mdl" )

	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	
	self:DrawShadow( false )

	local traceData = {}
	traceData.start = self:GetPos()
	traceData.endpos = self:GetPos() - Vector(0, 0, 10)

	local trace = util.TraceLine(traceData)

	local yaw = self:GetAngles().y

	// Todo: find a better way to do this

	if yaw < 0 and yaw > (-45) then
		yaw = 0
	elseif yaw < (-45) and yaw > (-90) then
		yaw = -90
	elseif yaw < (-90) and yaw > (-45) then
		yaw = -90
	elseif yaw < (-135) and yaw > (-90) then
		yaw = -180
	elseif yaw < (-180) and yaw > (-135) then
		yaw = -180
	end

	// -90 - 180/-180 fix
	if yaw < (-90) then
		yaw = -180
	end

	//self:SetAngles(Angle(self:GetAngles().p, yaw, self:GetAngles().r))

	if !trace.HitWorld then
		// Trace hit a wall
		self:SetAngles(Angle(-90, self:GetAngles().y, self:GetAngles().r))
	end

end

function ENT:SpraySetOrg(orgid)
	self:SetGNWVar("sprayurl", "http://www.pulsareffect.com/panel/?orgspray=" .. orgid)
end

function ENT:Think()
end