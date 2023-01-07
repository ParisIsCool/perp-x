--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up

local PANEL = {}

surface.CreateFont( "MixturesWarningFont2", { font = "Tahoma", size = ScreenScale( 8 ), weight = 1000, antialias = true, additive = false } )
local WarningTexture = surface.GetTextureID("perp2/warning")

function PANEL:Init ( )

end

function PANEL:PerformLayout ( )
	surface.SetFont("MixturesWarningFont2")
	local x, y = surface.GetTextSize("WHATEVAR.")
	self:SetHeight(y * 1 + 2)
end

function PANEL:Paint ( )
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(SKIN.control_color.r, SKIN.control_color.g, SKIN.control_color.b, SKIN.control_color.a))
	
	draw.SimpleText("Press on the icons to spawn a mixture. You can only craft an item if the image is green.", "MixturesWarningFont2", self:GetTall() + 8, self:GetTall() * .5, Color(255, 255, 255, 255), 0, 1)
end

vgui.Register('perp2_mixtures_tip', PANEL)