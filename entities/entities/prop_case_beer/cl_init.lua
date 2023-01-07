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

local x = -50
local y = -50
local w = 100
local h = 100

local hand = surface.GetTextureID( "perp2/clock/hand_long" )

function ENT:Draw()
	self:DrawModel()
end
