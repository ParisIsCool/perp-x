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
	self.Button:SetTall( 70 )
	self.Button:SetWide( 80 )
	self.Button:SetText( "Modify" )

	self.ModelPanel = vgui.Create( "DModelPanel", self )
	self.ModelPanel:SetPos( 5, 5 )
	self.ModelPanel:SetSize( 100, 66 )
end

function PANEL:PerformLayout()
	self.Button:SetPos( self:GetWide() - 4 - self.Button:GetWide(), self:GetTall() - 4 - self.Button:GetTall() )
end

function PANEL:Paint()
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 22, 22, 22, 255 ) )

	--[[surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( 5, 5, 66, 66 )
	surface.SetTexture( 0 )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( 6, 6, 64, 64 )]]

	draw.SimpleText( self.ourName or "ERROR", "RealtorFont", 110, 0, Color( 255, 255, 255, 255 ) )

	draw.SimpleText( "Make: " .. self.ourTable.Make or "ERROR", "Default", 110, self:GetTall() * .5, Color( 255, 255, 255, 255 ) )
	draw.SimpleText( "Model: " .. self.ourTable.Model, "Default", 110, self:GetTall() * .7, Color( 255, 255, 255, 255 ) )
end

function PANEL:SetVehicle( Table )
	self.ourTable = Table
	self.ourName = Table.Name
	self.ourID = Table.ID
	self.ourModel = Table.WorldModel or ""

	if GAMEMODE.Vehicles[ self.ourID ].Disabled == 1 then
		self.Button:SetText( "Repair" )
		self.Button:SetWide( 80 )
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
		ModifyVehicle( self.ourID )

		self:GetParent():GetParent():GetParent():Remove()
	end
end

vgui.Register( "perp2_vehicle_owned_details_mod", PANEL )
