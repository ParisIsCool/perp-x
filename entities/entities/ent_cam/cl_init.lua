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

function ENT:Initialize()
	self.ShouldDraw = true
end

function ENT:Draw()
	if self.ShouldDraw then
		self:DrawModel()
	end
end

net.Receive( "dontdrawcam", function()
	local Entity 	= net.ReadEntity()
	local Drawing 	= net.ReadBool()

	Entity.ShouldDraw = Drawing == true and true or nil
end )