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
	if (GAMEMODE.Options_ShowSprays:GetInt() == 0) then return end
	if (LocalPlayer():GetPos():Distance( self:GetPos() ) >= 5000) then return end
	//if (( self:GetPos() - LocalPlayer():GetPos() ):LengthSqr( ) >= 5000) then return end

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), -90)

	cam.Start3D2D(Pos + Ang:Up(), Ang, 0.11)
		pcall( self.DrawSpray, self )
	cam.End3D2D()
end

function ENT:DrawSpray()
	if self:GetGNWVar("sprayurl") == "" then

		return

	else
		
		if !self.ThumbMat then
			
			if !ValidPanel( self.HTML ) then

				self.HTML = vgui.Create( "DHTML" )
				self.HTML:SetSize( 1000, 1000 )
				self.HTML:SetPaintedManually(true)
				self.HTML:SetScrollbars(false)
				self.HTML:SetKeyBoardInputEnabled(false)
				self.HTML:SetMouseInputEnabled(false)
				self.HTML:OpenURL( self:GetGNWVar("sprayurl") )
			
			elseif !self.HTML:IsLoading() and !self.JSDelay then

				-- Force thumbnail sizes
				self.HTML:RunJavascript( [[
					document.documentElement.style.overflow = 'hidden';
					var nodes = document.getElementsByTagName('img');
					for (var i = 0; i < nodes.length; i++) {
						nodes[i].style.width = '100%';
						nodes[i].style.height = '100%';
					}
				]] )

				self.JSDelay = true

				-- Add delay to wait for JS to run
				timer.Simple(0.1, function()

					if !IsValid(self) then return end
					if !ValidPanel(self.HTML) then return end

					-- Grab HTML material
					self.HTML:UpdateHTMLTexture()
					self.ThumbMat = self.HTML:GetHTMLMaterial()

					-- Free resources after grabbing material
					self.HTML:Remove()
					self.JSDelay = nil

				end)

			else
				return -- Waiting for download to finish
			end

		end

	end

	-- Draw the HTML material
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( self.ThumbMat )
	surface.DrawTexturedRect(-216, -216, 432, 432)

end

function ENT:Think()	
	if not LocalPlayer():CanSee( self ) and not LocalPlayer():InVehicle() then return false end
end

function ENT:Initialize()
end

function ENT:OnRemove()
end