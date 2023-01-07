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

	self.Button = vgui.Create( "asoc_Button", self )
	self.Button:SizeToContents()
	self.Button:SetTall( 30 )
	self.Button:SetWide( 80 )
	self.Button:SetText("")
	self.Button.Text = "Claim"

	self.ModelPanel = vgui.Create( "DModelPanel", self )
	self.ModelPanel:SetPos( 5, 5 )
	self.ModelPanel:SetSize( 100, 66 )
end

function PANEL:PerformLayout()
	self.Button:SetPos( self:GetWide() - 4 - self.Button:GetWide(), (self:GetTall()/2) - (self.Button:GetTall()/2) )
end

function PANEL:Paint()
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 22, 22, 22, 255 ) )

	draw.SimpleText( self.ourName or "ERROR", "RealtorFont", 120, 0, Color( 255, 255, 255, 255 ) )

	draw.SimpleText( "Make: " .. self.ourTable.Make or "ERROR", "Default", 120, self:GetTall() * .5, Color( 255, 255, 255, 255 ) )
	draw.SimpleText( "Model: " .. self.ourTable.Model, "Default", 120, self:GetTall() * .7, Color( 255, 255, 255, 255 ) )
end

function PANEL:SetVehicle( Table )
	self.ourTable = Table
	self.ourName = Table.Name
	self.ourID = Table.ID
	self.ourModel = Table.WorldModel or ""

	if GAMEMODE.Vehicles[ self.ourID ].Disabled == 1 then
		self.Button.Text = "Repair"
		self.Button:SetText("")
		self.Button:SetWide( 100 )
	end

	self.ModelPanel:SetModel( self.ourModel )
	self.ModelPanel:SetLookAt( Vector( 0, 0, 50 ) )
	self.ModelPanel:SetCamPos( Vector( 300, 300, 100 ) )
	self.ModelPanel:SetFOV( 40 )

	if IsValid(self.ModelPanel.Entity) then
		self.ModelPanel.Entity:SetSkin( Table.Skin )
	end


	local RGB = GAMEMODE.Vehicles[ self.ourID ].RGB
	if RGB then self.ModelPanel:SetColor( RGB ) end

	function self.Button.DoClick()
		net.Start( "perp_v_c") net.WriteString( self.ourID ) net.SendToServer()

		self:GetParent():GetParent():GetParent():Remove()
	end
end

vgui.Register( "perp2_vehicle_owned_details", PANEL )