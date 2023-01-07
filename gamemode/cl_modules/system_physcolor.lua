--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


local alreadyIn = false

function GM.SelectPhysColor()
	if( alreadyIn ) then return end
	if( !LocalPlayer():IsVIP() ) then return end

	alreadyIn = true
	
	local Dpanel = vgui.Create( "DFrame" )
	Dpanel:SetSize( 450, 300 )
	Dpanel:SetTitle( "Physgun Color" )
	Dpanel:CenterVertical()
	Dpanel:CenterHorizontal()
	Dpanel:MakePopup()
	Dpanel:SetSkin( "perp2" )	
	Dpanel.OnClose = function() alreadyIn = false end

	local ColorPick = vgui.Create( "DColorMixer", Dpanel )
	ColorPick:SetSize( 200, 200 )
	ColorPick:SetPos( 50, 50 )
	ColorPick.Think = function()
	    local col = ColorPick:GetColor()
	    ColorPick:SetColor( Color( col.r, col.g, col.b, 255 ) )
	end

	local shape = vgui.Create( "DShape", Dpanel )
	shape:SetPos( 320, 180 )
	shape:SetSize( 60, 60 )
	shape:SetType( "Rect" )

	local TestSprite = vgui.Create( "DSprite", Dpanel )
	TestSprite:SetPos( 350, 120 )
	TestSprite:SetSize( 300, 300 )
	TestSprite:SetMaterial( Material( "sprites/physg_glow1" ) )
	TestSprite.Think = function()
	    TestSprite:SetColor( ColorPick:GetColor() )
	    shape:SetColor( ColorPick:GetColor() )
	end

	local FinButton = vgui.Create( "DButton", Dpanel )
	FinButton:SetSize( 60, 30 )
	FinButton:SetPos( 380, 260 )
	FinButton:SetText( "Purchase" )
	FinButton.DoClick = function()
		local col = ColorPick:GetColor()
		local tbl = {math.Clamp( math.Round( col.r / 255, 2 ), 0, 255 ), math.Clamp( math.Round( col.g / 255, 2 ), 0, 255 ), math.Clamp( math.Round( col.b / 255, 2 ), 0, 255 )}
		net.Start( "perp_physcolor" )
			net.WriteTable( tbl )
		net.SendToServer()

		Dpanel:Close()
	end
end