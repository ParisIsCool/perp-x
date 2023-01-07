--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

include('shared.lua')

function ENT:Draw()
	if (LocalPlayer():GetEyeTrace().Entity == self.Entity and LocalPlayer():GetShootPos():Distance(self.Entity:GetPos()) < 512) then
		self:DrawEntityOutlineFromBase( )
	end
	self:DrawModel()
end