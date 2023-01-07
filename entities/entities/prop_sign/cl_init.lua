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

surface.CreateFont( "SignFont", { font = "Arial", size = 128, weight = 400, antialias = true, additive = false } )

local Signs = {}

function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawSign()
	cam.Start3D( EyePos(), EyeAngles() )
		local Pos 		= self:GetPos() + self:GetUp() * 3
		local Angle 	= self:GetAngles()
		local Text 		= self:GetGNWVar( "Text", "" )
		local Colour 	= self:GetColor()

		cam.Start3D2D( Pos, Angle, 0.1 )
			render.SuppressEngineLighting( true )
				surface.SetTextColor( Colour.r, Colour.g, Colour.b, 255 )
				surface.SetFont( "SignFont" )

				local W, H = surface.GetTextSize( Text )
				surface.SetTextPos( -( W / 2 ), -( H / 2 ) )
				surface.DrawText( Text )
			render.SuppressEngineLighting( false )
		cam.End3D2D()
	cam.End3D()
end

net.Receive( "ModifySign", function()
	local Entity = net.ReadEntity()

	if not IsValid(Entity) or not Entity.Colours then return false end

	local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 250, 114 )
		Frame:Center()
		Frame:SetTitle( "Text Sign" )
		Frame:SetVisible( true )
		Frame:MakePopup()

	local BoxList = vgui.Create( "DPanelList", Frame )
		BoxList:StretchToParent( 5, 27, 5, 5 )
		BoxList:SetPadding( 5 )
		BoxList:SetSpacing( 5 )
		BoxList:EnableHorizontal( false )

	local Text = vgui.Create( "DTextEntry", BoxList )
		Text:SetText( Entity:GetGNWVar( "Text", "" ) )

	BoxList:AddItem( Text )

	local ColoursD = vgui.Create( "DComboBox", BoxList )

	local SelectedColour = "White"

	for k, v in pairs( Entity.Colours ) do
		ColoursD:AddChoice( k )

		local Colour = Entity:GetColor()

		if Colour.r == v.r and Colour.g == v.g and Colour.b == v.b and Colour.a == v.a then
			SelectedColour = k
		end
	end 

	ColoursD:SetText( SelectedColour )

	function ColoursD:OnSelect( index, value, data )
		SelectedColour = value
	end

	BoxList:AddItem( ColoursD )

	local Button = vgui.Create( "DButton", BoxList )
	Button:SetText( "Confirm" )
	Button.DoClick = function()
		RunConsoleCommand( "modify_sign", Text:GetValue(), SelectedColour )
		Frame:Close()
	end

	BoxList:AddItem( Button )
end )

hook.Add( "RenderScreenspaceEffects", "RenderTextSigns", function()
	for _, v in pairs( ents.FindByClass( "prop_sign" ) ) do
		if LocalPlayer():CanSee( v ) and v:GetPos():Distance( LocalPlayer():GetPos() ) <= 1000 then
			v:DrawSign()
		end
	end
end )