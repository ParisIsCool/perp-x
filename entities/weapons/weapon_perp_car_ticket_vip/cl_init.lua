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

SWEP.PrintName			= "Traffic Ticket"			
SWEP.Slot				= 4
SWEP.SlotPos			= 0
SWEP.DrawCrosshair		= false

function SWEP:DrawWorldModel()
	local iBone = self.Owner:LookupBone( "ValveBiped.Bip01_L_Hand" )
	if iBone then
		self:SetRenderOrigin( self.Owner:GetBonePosition(iBone) + self:GetUp() * 1 + self:GetForward() * 3 + self:GetRight() * 2 )
		self:SetRenderAngles( Angle( 0, self.Owner:GetAngles().y, 0 ) )
	end
	
	self:DrawModel()
end

function SWEP:GetViewModelPosition( vPos, aAngles )
	vPos = vPos + LocalPlayer():GetUp() * -10
	vPos = vPos + LocalPlayer():GetAimVector() * 20
	vPos = vPos + LocalPlayer():GetRight() * 8
	aAngles:RotateAroundAxis( aAngles:Right(), 90 )
	aAngles:RotateAroundAxis( aAngles:Forward(), 0 )

	return vPos, aAngles
end

usermessage.Hook( "perp_ticket", function( UMsg )
	local Name = UMsg:ReadString()
	local SteamID = UMsg:ReadString()
	
	Msg( "You were cited by: " .. Name .. " (" .. SteamID .. ").\n" )
	
	Derma_Message( "You have received a citation (or warning) from " .. Name .. " (" .. SteamID .. ").", "ECPD Courts", "Okay.")
end )