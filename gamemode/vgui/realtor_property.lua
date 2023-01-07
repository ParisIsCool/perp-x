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

surface.CreateFont( "RealtorFont", { font = "Tahoma", size = 30, weight = 1000, antialias = true, additive = false } )

function PANEL:Init()
	self:SetTall( 76 )

	self.Icon = vgui.Create( "DButton", self )
	self.Icon:SizeToContents()
	self.Icon:SetTall( 66 )
	self.Icon:SetWide( 66 )
	self.Icon:SetPos(5,5)
	self.Icon:SetText( "" )
	self.Icon.Paint = function()
		local w,h = self.Icon:GetSize()
		surface.SetMaterial( self.OurMat )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	self.Icon.DoClick = function()
		local p = vgui.Create("DFrame")
		p:SetSize(522,552)
		p:Center()
		p:SetTitle(self.OurName)
		p:MakePopup()
		p.Paint = function()
			local w,h = p:GetSize()
			draw.RoundedBox(0,0,0,w,h,Color(22,22,22,255))
			draw.RoundedBox(0,0,30,w,h,Color(255,255,255,255*math.abs(math.sin(CurTime()*4))))
			surface.SetMaterial( self.OurMat )
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawTexturedRect( 5, 35, w-10, h-40 )
		end
	end
	
	self.Button = vgui.Create( "DButton", self )
	self.Button:SizeToContents()
	self.Button:SetTall( 20 )
	self.Button:SetWide( 60 )
	self.Button:SetText( "Purchase" )

	self.Furnishing = vgui.Create( "DButton", self )
	self.Furnishing:SizeToContents()
	self.Furnishing:SetTall( 20 )
	self.Furnishing:SetWide( 60 )
	self.Furnishing:SetText( "Furnishing" )
end

local SoldMaterial = surface.GetTextureID( "perp2/sold" )

function PANEL:PerformLayout()
	self.Button:SetPos( self:GetWide() - 4 - self.Button:GetWide(), self:GetTall() - 25 - self.Button:GetTall() )
	self.Furnishing:SetPos( self:GetWide() - 4 - self.Furnishing:GetWide(), self:GetTall() - 4 - self.Furnishing:GetTall() )
end

function PANEL:Paint()
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 22, 22, 22, 255 ) )
	
	if self.IsOwned then
		surface.SetTexture( SoldMaterial )
		surface.SetDrawColor( 255, 255, 255, 150 )
		surface.DrawTexturedRect( 6, 6, 64, 64 )
	end
	
	draw.SimpleText( self.OurName, "RealtorFont", 80, 0, Color( 255, 255, 255, 255 ) )
	
	if self.OurCost > LocalPlayer():GetCash() or ( self.IsOwned and not self.WeOwn ) then
		draw.SimpleText( "$" .. string.Comma(self.OurCost), "RealtorFont", self:GetWide() - 4, 0, Color( 200, 0, 0, 255 ), 2 )
	else
		draw.SimpleText( "$" .. string.Comma(self.OurCost), "RealtorFont", self:GetWide() - 4, 0, Color( 255, 255, 255, 255 ), 2 )
	end
	
	draw.SimpleText( self.OurDescription or "ERROR", "Default", 80, self:GetTall() - 5, Color( 255, 255, 255, 255 ), 0, 4 )
end

function PANEL:SetProperty( ID )
	local OurTable = PROPERTY_DATABASE[ ID ]
	
	self.OurCost = OurTable.Cost or 0
	self.OurMat = OurTable.Texture or ""
	self.OurName = OurTable.Name or "ERROR"
	self.OurDescription = OurTable.Description or "ERROR"
	self.OurID = ID
	
	self.IsOwned = false
	local ProspectiveOwner = GetGNWVar( "p_" .. ID )
	
	if IsValid( ProspectiveOwner ) and ProspectiveOwner:IsPlayer() then
		self.IsOwned = true
		self.WeOwn = LocalPlayer() == ProspectiveOwner
	end

	if self.IsOwned then
		if not self.WeOwn then
			if not LocalPlayer():IsAdmin() then
				return self:Remove()
			else
				self.Button:SetDisabled( true )
				self.Button:SetText( "Sold" )
			end
		else
			self.Button:SetText( "Sell" )
		end
	else
		if LocalPlayer():GetCash() < self.OurCost then
			self.Button:SetDisabled( true )
		end
	end
	
	function self.Button.DoClick()
		if self.IsOwned and self.WeOwn or LocalPlayer():GetCash() >= OurTable.Cost then
			net.Start( "perp_p_b" ) net.WriteInt( self.OurID, 16 ) net.SendToServer()
			
			self:GetParent():GetParent():GetParent():GetParent():Remove()
		end
	end

	if self.IsOwned then
		if not OurTable.Furniture then
			self.Furnishing:SetDisabled( true )
			self.Furnishing:SetToolTip( "This property doesn't have any purchaseable furniture" )
		else
			self.Furnishing:SetToolTip( "You can spawn furniture for money" )
		end
	else
		self.Furnishing:SetToolTip( "You must own the property to buy furniture" )
		self.Furnishing:SetDisabled( true )
	end

	function self.Furnishing.DoClick()
		local Available = OurTable.Furniture

		if GAMEMODE.FurnishedProperties[ self.OurID ] then
			for k, v in pairs( Available ) do
				if table.HasValue( GAMEMODE.FurnishedProperties[ self.OurID ], k ) then
					Available[ k ] = nil
				end
			end
		end

		Derma_AvailableFurniture( "Available furniture for " .. self.OurName, "Furniture", self.OurID, Available )
	end
	
	timer.Simple( .1, LEAVE_DIALOG )
end

vgui.Register( "perp2_realtor_property", PANEL )