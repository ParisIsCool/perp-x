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

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 3.3, Ang, 0.11)
		surface.SetDrawColor(Color(0, 0, 0, 255))
		surface.DrawRect(-95, -223, 190, 143)

		draw.SimpleText("Press E to view camera", "perp2_TextHUDSmall", 0, -160, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 0)

	cam.End3D2D()
end