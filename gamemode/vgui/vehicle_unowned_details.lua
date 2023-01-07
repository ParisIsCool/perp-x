--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local PANEL = {}

function PANEL:Init()
	self:SetTall( 76 )
	
	self.Button = vgui.Create( "DButton", self )
	self.Button:SizeToContents()
	self.Button:SetTall( 30 )
	self.Button:SetWide( 60 )
	self.Button:SetText( "Purchase" )
	
	self.Button2 = vgui.Create( "DButton", self )
	self.Button2:SizeToContents()
	self.Button2:SetTall( 30 )
	self.Button2:SetWide( 60 )
	self.Button2:SetText( "Demo" )

	self.ModelPanel = vgui.Create( "DModelPanel", self )
	self.ModelPanel:SetPos( 5, 5 )
	self.ModelPanel:SetSize( 100, 66 )
end

function PANEL:PerformLayout()
	self.Button:SetPos( self:GetWide() - 4 - self.Button:GetWide(), self:GetTall() - 4 - self.Button:GetTall() )
	self.Button2:SetPos( self:GetWide() - 4 - self.Button2:GetWide(), self:GetTall() - 4 - self.Button2:GetTall() * 2 )
end

function PANEL:Paint()
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 22, 22, 22, 255 ) )
	
	--[[surface.SetDrawColor( 0, 0, 0, 255)
	surface.DrawRect( 5, 5, 66, 66)]]
	surface.SetTexture( 0 )
	if self.ourTable.VipOnly and LocalPlayer():IsVIP() then
		surface.SetDrawColor( 255, 255, 255, 255 )
		--surface.DrawTexturedRect( 6, 6, 100, 64 )
	elseif self.ourTable.VipOnly and not LocalPlayer():IsVIP() then
		surface.SetDrawColor( 255, 150, 150, 100 )
		surface.DrawTexturedRect( 6, 6, 100, 64 )
	else
		surface.SetDrawColor( 255, 255, 255, 255 )
		--surface.DrawTexturedRect( 7, 6, 100, 64 )
	end
	
	draw.SimpleText( self.ourName or "ERROR", "RealtorFont", 110, 0, Color( 255, 255, 255, 255 ) )
	
	if self.ourCost > LocalPlayer():GetBank() then
		draw.SimpleText( "$" .. string.Comma(self.ourCost), "RealtorFont", self:GetWide() - 90, self:GetTall()/2, Color( 200, 0, 0, 255 ), 2, 1 )
	else
		draw.SimpleText( "$" .. string.Comma(self.ourCost), "RealtorFont", self:GetWide() - 90, self:GetTall()/2, Color( 255, 255, 255, 255 ), 2, 1 )
	end
	
	draw.SimpleText( "Make: " .. self.ourTable.Make or "ERROR", "Default", 110, self:GetTall() * .5, Color( 255, 255, 255, 255 ) )
	draw.SimpleText( "Model: " .. self.ourTable.Model, "Default", 110, self:GetTall() * .7, Color( 255, 255, 255, 255 ) )
end

function PANEL:SetVehicle( Table )
	self.ourTable = Table
	self.ourName = Table.Name
	self.ourCost = Table.Cost
	self.ourID = Table.ID
	self.ourModel = Table.WorldModel or Table.PaintJobs[1][ "model" ]
	local skinny = Table.Skin

	self.ModelPanel:SetModel( self.ourModel )
	self.ModelPanel:SetLookAt( Vector( 0, 0, 50 ) )
	self.ModelPanel:SetCamPos( Vector( 300, 300, 100 ) )
	self.ModelPanel:SetFOV( 40 )
	if skinny then
		self.ModelPanel.Entity:SetSkin(skinny)
	end

	if Table.CustomBodyGroup then self.ModelPanel.Entity:SetBodygroup( Table.CustomBodyGroup, 0 ) end

	if LocalPlayer():GetBank() < self.ourCost then
		self.Button:SetEnabled( false )
	end
	
	if LocalPlayer():GetBank() < self.ourCost then
		self.Button:SetEnabled( false )
	else
		self.Button:SetEnabled( true )
	end
	
	function self.Button.DoClick()
		if self.ourTable.VipOnly == true and not LocalPlayer():IsVIP() then
			LocalPlayer():ChatPrint( "This vehicle requires VIP status." )
		else
			local ID = self.ourID
			Derma_Query( "Are you sure that you want to buy this car?\n", "Wait a second...",
			"NOO!", function() end,
			"Yeah, buy it.", function()
				net.Start( "perp_v_p" ) net.WriteString(ID) net.SendToServer()
			end)	
				
			self:GetParent():GetParent():GetParent():Remove()
		end
	end

	function self.Button2.DoClick()
		net.Start( "perp_v_demo") net.WriteString( self.ourID ) net.SendToServer()
		
		self:GetParent():GetParent():GetParent():Remove()
	end
end

vgui.Register( "perp2_vehicle_unowned_details", PANEL )