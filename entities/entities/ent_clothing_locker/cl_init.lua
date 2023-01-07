--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]
--[[-----------------------------------------------------
	Clothing Locker
	Created by VENOM aka RickyBGamez for Hellzone PERP
--]]-----------------------------------------------------

include( "shared.lua" )

function ENT:Initialize()

end

function ENT:Draw()
	self:DrawModel()
end

function InverseLerp( pos, p1, p2 )
	local range = 0
	range = p2 - p1
	if range == 0 then return 1 end
	return ( ( pos - p1 ) / range )
end

local function DrawMenu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "PERP Clothing Locker" )
	Frame:SetSize( ScrW() * 0.35, ScrH() * 0.60 )
	Frame:SetDraggable( false )
	Frame:SetBackgroundBlur( true )
	Frame:Center()
	
	local PlayerModelPanel = vgui.Create( "DModelPanel", Frame )
	PlayerModelPanel:SetSize( PlayerModelPanel:GetParent():GetWide() * ( 2 / 3 ), PlayerModelPanel:GetParent():GetTall() - 40 )
	PlayerModelPanel:SetPos( -60, 16 )

	PlayerModelPanel:SetModel( LocalPlayer():GetModel() )
	PlayerModelPanel.Entity:SetSkin( LocalPlayer():GetSkin() )
	
	PlayerModelPanel:SetLookAt( Vector( 0, 0, 72 / 2 ) )
	PlayerModelPanel:SetCamPos( Vector( 64, 0, 72 / 2 ) )
	PlayerModelPanel.Entity:SetEyeTarget( PlayerModelPanel.Entity:GetPos() + Vector( 200, 0, 64 ) )
	PlayerModelPanel:SetAmbientLight( Color( 10, 15, 50 ) )
	PlayerModelPanel:SetDirectionalLight( BOX_TOP, Color( 220, 190, 100 ) )
	
	PlayerModelPanel.rot = 110
	PlayerModelPanel.fov = 65
	PlayerModelPanel:SetFOV( PlayerModelPanel.fov )
	PlayerModelPanel.dragging = false
	PlayerModelPanel.dragging2 = false
	PlayerModelPanel.ux = 0
	PlayerModelPanel.uy = 0
	PlayerModelPanel.spinmul = 0.5
	PlayerModelPanel.zoommul = 0.09
	PlayerModelPanel.xmod = 0
	PlayerModelPanel.ymod = 0
	
	function PlayerModelPanel:LayoutEntity( ent )
		local newrot = self.rot
		local newfov = self:GetFOV()
		if self.dragging == true then
			newrot = self.rot + ( gui.MouseX() - self.ux ) * self.spinmul
			newfov = self.fov + ( self.uy - gui.MouseY() ) * self.zoommul
			if newfov < 20 then newfov = 20 end
			if newfov > 75 then newfov = 75 end
		end

		local newxmod = self.xmod
		local newymod = self.ymod
		if self.dragging2 == true then
			newxmod = self.xmod + ( self.ux - gui.MouseX() ) * 0.02
			newymod = self.ymod + ( self.uy - gui.MouseY() ) * 0.02
		end
		newxmod = math.Clamp( newxmod, -16, 16 )
		newymod = math.Clamp( newymod, -16, 16 )

		ent:SetAngles( Angle( 0, 0, 0 ) )
		self:SetFOV( newfov )

		local height = 72 / 2
		local frac = InverseLerp( newfov, 75, 20 )
		height = Lerp( frac, 72 / 2, 64 )
		
		local norm = ( self:GetCamPos() - Vector( 0, 0, 64 ) )
		norm:Normalize()
		local lookAng = norm:Angle()

		self:SetLookAt( Vector( 0, 0, height - ( 2 * frac ) ) - Vector( 0, 0, newymod * 2 * ( 1 - frac ) ) - lookAng:Right() * newxmod * 2 * ( 1 - frac ) )
		self:SetCamPos( Vector( 64 * math.sin( newrot * ( math.pi / 180 ) ), 64 * math.cos( newrot * ( math.pi / 180 ) ), height + 4 * ( 1 - frac ) ) - Vector( 0, 0, newymod * 2 * ( 1 - frac ) ) - lookAng:Right() * newxmod * 2 * ( 1-frac ) )
	end
	
	function PlayerModelPanel:OnMousePressed( k )
		self.ux = gui.MouseX()
		self.uy = gui.MouseY()
		self.dragging = ( k == MOUSE_LEFT ) or false
		self.dragging2 = ( k == MOUSE_RIGHT ) or false
	end
	
	function PlayerModelPanel:OnMouseReleased( k )
		if self.dragging == true then
			self.rot = self.rot + ( gui.MouseX() - self.ux ) * self.spinmul
			self.fov = self.fov + ( self.uy - gui.MouseY() ) * self.zoommul
			self.fov = math.Clamp( self.fov, 20, 75 )
		end
		
		if self.dragging2 == true then
			self.xmod = self.xmod + ( self.ux - gui.MouseX() ) * 0.02
			self.ymod = self.ymod + ( self.uy - gui.MouseY() ) * 0.02

			self.xmod = math.Clamp( self.xmod, -16, 16 )
			self.ymod = math.Clamp( self.ymod, -16, 16 )
		end
		
		self.dragging = false
		self.dragging2 = false
	end
	
	function PlayerModelPanel:OnCursorExited()
		if self.dragging == true or self.dragging2 == true then
			self:OnMouseReleased()
		end
	end
	
	function PlayerModelPanel:PaintOver()
		draw.DrawText( "Select Bodygroups in the right-hand panel.", "DermaDefault", Frame:GetWide() * 0.1, Frame:GetTall() * 0.02, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText( "Drag horizontally to rotate playermodel.", "DermaDefault", Frame:GetWide() * 0.1, Frame:GetTall() * 0.04, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText( "Drag vertically to zoom.", "DermaDefault", Frame:GetWide() * 0.1, Frame:GetTall() * 0.06, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText( "Right-click and drag to position the camera.", "DermaDefault", Frame:GetWide() * 0.1, Frame:GetTall() * 0.08, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
	end
	
	local CurrentBodyGroups = LocalPlayer():GetBodyGroups()
	for k, v in pairs( CurrentBodyGroups ) do
		local entmodel = PlayerModelPanel.Entity
		local CurrentBodyGroupID = LocalPlayer():GetBodygroup( v.id )
		entmodel:SetBodygroup( v.id, CurrentBodyGroupID )
	end
	
	local startx_label = Frame:GetWide() * 0.60
	local startx = Frame:GetWide() * 0.68
	local starty = 30

	for k, v in pairs( PlayerModelPanel.Entity:GetBodyGroups() ) do
		if v.name ~= "" then
			local GroupName = PlayerModelPanel.Entity:GetBodygroupName( v.id )
			local MainName = ""
			local BodyID = v.id
			
			if GroupName == "hat" then
				MainName = "Hat: "
			else
				MainName = GroupName .. ": "
			end
			
			local label = Label( MainName, Frame )
			label:SetPos( 2 + startx_label, 6 + starty )
			local SelectionBox = vgui.Create( "DComboBox", Frame )
			SelectionBox:SetPos( 7 + startx, 4 + starty )
			SelectionBox:SetSize( 175, 25 )
			SelectionBox:SetValue( GroupName )

			local tempid = 0
			local tempc = 0
			for k, j in pairs( v.submodels ) do
				if string.len( j ) == 0 then j = "N/A" end
				
				if PlayerModelPanel.Entity:GetBodygroup( v.id ) == tempc then
					SelectionBox:AddChoice( "Current: " .. string.sub( j, 1, string.len( j ) - 4 ) )
				else
					SelectionBox:AddChoice( string.sub( j, 1, string.len( j ) - 4 ) )
				end
				
				SelectionBox.ValueOfItem = tempid
				SelectionBox.OnSelect = function( panel, index, value )
					PlayerModelPanel.Entity:SetBodygroup( BodyID, SelectionBox:GetSelectedID() - 1 )
				end
				
				tempid = tempid + 1
				tempc = tempc + 1
			end
			starty = starty + 25
		end
	end
	
	local SetButton = vgui.Create( "DButton", Frame )
	SetButton:SetPos( SetButton:GetParent():GetWide() * 0.67, SetButton:GetParent():GetTall() * 0.85 )
	SetButton:SetText( "Change Attire" )
	SetButton:SetSize( 130, 45 )
	SetButton.DoClick = function()
		local tempstring = ""
		for k, v in pairs( PlayerModelPanel.Entity:GetBodyGroups() ) do
			tempstring = tempstring .. PlayerModelPanel.Entity:GetBodygroup( v.id )
		end
		net.Start( "VENOM_UpdateClothing" )
			net.WriteString( tempstring )
		net.SendToServer()
		Frame:Close()
		LocalPlayer():PrintMessage( HUD_PRINTTALK, "Your attire has been changed." )
	end
	
	Frame:MakePopup()
end
net.Receive( "VENOM_Locker_Open", DrawMenu )