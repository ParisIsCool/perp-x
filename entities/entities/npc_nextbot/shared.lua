--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

ENT.Base = "base_nextbot"
ENT.AutomaticFrameAdvance = false

function ENT:InitializeAnimation( animID )
	if SERVER then
		if animID then
			if animID ~= -1 then
				self:ResetSequence( animID )
			end
		else
			self:ResetSequence( 7 )
		end
	end
	
	self:SetAutomaticFrameAdvance( true )
end