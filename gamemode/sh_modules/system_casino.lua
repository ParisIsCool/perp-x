--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


--rp_florida_v2
local Pos1 = Vector(1151, -5989, 392)
local Pos2 = Vector(-21373, 19467, -7727)

function ENTITY:InCasino()
	local Pos = self:GetPos()

	if Pos.x >= Pos1.x and Pos.x <= Pos2.x and Pos.y <= Pos1.y and Pos.y >= Pos2.y and Pos.z >= Pos1.z and Pos.z <= Pos2.z then
		return true
	end
end

function InCasino( Pos )
	if not Pos then return end

	if Pos.x >= Pos1.x and Pos.x <= Pos2.x and Pos.y <= Pos1.y and Pos.y >= Pos2.y and Pos.z >= Pos1.z and Pos.z <= Pos2.z then
		return true
	end
end