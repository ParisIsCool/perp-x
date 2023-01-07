--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

/*   _								
	( )							   
   _| |   __   _ __   ___ ___	 _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

*/

local matBlurScreen = Material( "pp/blurscreen" )

/*
	This is designed for Paint functions..
*/
function Derma_DrawBackgroundBlur( panel, starttime )

	local Fraction = 1

	if ( starttime ) then
		Fraction = math.Clamp( (SysTime() - starttime) / 1, 0, 1 )
	end

	local x, y = panel:LocalToScreen( 0, 0 )

	DisableClipping( true )
	
	surface.SetMaterial( matBlurScreen )	
	surface.SetDrawColor( 255, 255, 255, 255 )
		
	for i=0.33, 1, 0.33 do
		matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
		if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
	end
	
	surface.SetDrawColor( 10, 10, 10, 200 * Fraction )
	surface.DrawRect( x * -1, y * -1, ScrW(), ScrH() )
	
	DisableClipping( false )

end

/*
	Display a simple message box.
	
	Derma_Message( "Hey Some Text Here!!!", "Message Title (Optional)", "Button Text (Optional)" )
	
*/
function Derma_Message( strText, strTitle, strButtonText )

	local Window = vgui.Create( "DFrame" )
		Window:SetTitle( strTitle or "Message" )
		Window:SetDraggable( false )
		Window:ShowCloseButton( true )
		Window:SetBackgroundBlur( true )
		Window:SetDrawOnTop( true )
		
	local InnerPanel = vgui.Create( "DPanel", Window )
	
	local Text = vgui.Create( "DLabel", InnerPanel )
		Text:SetText( strText or "Message Text" )
		Text:SizeToContents()
		Text:SetContentAlignment( 5 )
		Text:SetTextColor( color_white )
		
	local ButtonPanel = vgui.Create( "DPanel", Window )
		ButtonPanel:SetTall( 30 )
		
	local Button = vgui.Create( "DButton", ButtonPanel )
		Button:SetText( strButtonText or "OK" )
		Button:SizeToContents()
		Button:SetTall( 20 )
		Button:SetWide( Button:GetWide() + 20 )
		Button:SetPos( 5, 5 )
		Button.DoClick = function() Window:Close() end
		
	ButtonPanel:SetWide( Button:GetWide() + 10 )
	
	local w, h = Text:GetSize()
	
	Window:SetSize( w + 50, h + 25 + 45 + 10 )
	Window:Center()
	
	InnerPanel:StretchToParent( 5, 25, 5, 45 )
	
	Text:StretchToParent( 5, 5, 5, 5 )	
	
	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )
	
	Window:MakePopup()
	Window:DoModal()

end

/*
	Ask a question with multiple answers..
	
	Derma_Query( "Would you like me to punch you right in the face?", "Question!",
						"Yesss", 	function() MsgN( "Pressed YES!") end, 
						"Nope!", 	function() MsgN( "Pressed Nope!") end, 
						"Cancel", 	function() MsgN( "Cancelled!") end )
		
*/
function Derma_Query( strText, strTitle, ... )

	local Window = vgui.Create( "DFrame" )
		Window:SetTitle( strTitle or "Message Title (First Parameter)" )
		Window:SetDraggable( false )
		Window:ShowCloseButton( true )
		Window:SetBackgroundBlur( true )
		Window:SetDrawOnTop( true )
		
	local InnerPanel = vgui.Create( "DPanel", Window )
	
	local Text = vgui.Create( "DLabel", InnerPanel )
		Text:SetText( strText or "Message Text (Second Parameter)" )
		Text:SizeToContents()
		Text:SetContentAlignment( 5 )
		Text:SetTextColor( color_white )

	local ButtonPanel = vgui.Create( "DPanel", Window )
		ButtonPanel:SetTall( 30 )

	local arg = { ... }

	-- Loop through all the options and create buttons for them.
	local NumOptions = 0
	local x = 5
	for k=1, 8, 2 do
		
		if ( arg[k] == nil ) then break end
		
		local Text = arg[k]
		local Func = arg[k+1] or function() end
	
		local Button = vgui.Create( "DButton", ButtonPanel )
			Button:SetText( Text )
			Button:SizeToContents()
			Button:SetTall( 20 )
			Button:SetWide( Button:GetWide() + 20 )
			Button.DoClick = function() Window:Close() Func() end
			Button:SetPos( x, 5 )
			
		x = x + Button:GetWide() + 5
			
		ButtonPanel:SetWide( x ) 
		NumOptions = NumOptions + 1
	
	end

	
	local w, h = Text:GetSize()
	
	w = math.max( w, ButtonPanel:GetWide() )
	
	Window:SetSize( w + 50, h + 25 + 45 + 10 )
	Window:Center()
	
	InnerPanel:StretchToParent( 5, 25, 5, 45 )
	
	Text:StretchToParent( 5, 5, 5, 5 )	
	
	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )
	
	Window:MakePopup()
	Window:DoModal()
	
	if ( NumOptions == 0 ) then
	
		Window:Close()
		Error( "Derma_Query: Created Query with no Options!?" )
	
	end

end


/*
	Request a string from the user
	
	Derma_StringRequest( "Question", 
					"What Is Your Favourite Color?", 
					"Type your answer here!", 
					function( strTextOut ) Derma_Message( "Your Favourite Color Is: " .. strTextOut ) end,
					function( strTextOut ) Derma_Message( "You pressed Cancel!" ) end,
					"Okey Dokey", 
					"Cancel" )
	
*/
function Derma_StringRequest( strTitle, strText, strDefaultText, fnEnter, fnCancel, strButtonText, strButtonCancelText )

	local Window = vgui.Create( "DFrame" )
		Window:SetTitle( strTitle or "Message Title (First Parameter)" )
		Window:SetDraggable( false )
		Window:ShowCloseButton( true )
		Window:SetBackgroundBlur( true )
		Window:SetDrawOnTop( true )
		
	local InnerPanel = vgui.Create( "DPanel", Window )
	
	local Text = vgui.Create( "DLabel", InnerPanel )
		Text:SetText( strText or "Message Text (Second Parameter)" )
		Text:SizeToContents()
		Text:SetContentAlignment( 5 )
		Text:SetTextColor( color_white )
		
	local TextEntry = vgui.Create( "DTextEntry", InnerPanel )
		TextEntry:SetText( strDefaultText or "" )
		TextEntry.OnEnter = function() Window:Close() fnEnter( TextEntry:GetValue() ) end
		
	local ButtonPanel = vgui.Create( "DPanel", Window )
		ButtonPanel:SetTall( 30 )
		
	local Button = vgui.Create( "DButton", ButtonPanel )
		Button:SetText( strButtonText or "OK" )
		Button:SizeToContents()
		Button:SetTall( 20 )
		Button:SetWide( Button:GetWide() + 20 )
		Button:SetPos( 5, 5 )
		Button.DoClick = function() Window:Close() fnEnter( TextEntry:GetValue() ) end
		
	local ButtonCancel = vgui.Create( "DButton", ButtonPanel )
		ButtonCancel:SetText( strButtonCancelText or "Cancel" )
		ButtonCancel:SizeToContents()
		ButtonCancel:SetTall( 20 )
		ButtonCancel:SetWide( Button:GetWide() + 20 )
		ButtonCancel:SetPos( 5, 5 )
		ButtonCancel.DoClick = function() Window:Close() if ( fnCancel ) then fnCancel( TextEntry:GetValue() ) end end
		ButtonCancel:MoveRightOf( Button, 5 )
		
	ButtonPanel:SetWide( Button:GetWide() + 5 + ButtonCancel:GetWide() + 10 )
	
	local w, h = Text:GetSize()
	w = math.max( w, 400 ) 
	
	Window:SetSize( w + 50, h + 25 + 75 + 10 )
	Window:Center()
	
	InnerPanel:StretchToParent( 5, 25, 5, 45 )
	
	Text:StretchToParent( 5, 5, 5, 35 )	
	
	TextEntry:StretchToParent( 5, nil, 5, nil )
	TextEntry:AlignBottom( 5 )
	
	TextEntry:RequestFocus()
	TextEntry:SelectAllText( true )
	
	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )
	
	Window:MakePopup()
	Window:DoModal()

end

-- Taken from XLIB, funky stuff indeed
local function ToggleListing( Panel, Value )
	--Panel.TextEntry:SetEnabled( not Value )
	--Panel.TextEntry:SetPaintBackgroundEnabled( Value )
	Panel.DropButton:SetDisabled( Value )
	Panel.DropButton:SetMouseInputEnabled( not Value )
	Panel:SetMouseInputEnabled( not Value )
end

function Derma_AvailableFurniture( strText, strTitle, id, ... )
	local Window = vgui.Create( "DFrame" )
		Window:SetTitle( strTitle or "Message Title (First Parameter)" )
		Window:SetDraggable( false )
		Window:ShowCloseButton( false )
		Window:SetBackgroundBlur( true )
		Window:SetDrawOnTop( true )

	local ButtonPanel = vgui.Create( "DPanel", Window )
		ButtonPanel:SetTall( 30 )
		
	local InnerPanel = vgui.Create( "DPanel", Window )
	
	local Text = vgui.Create( "DLabel", InnerPanel )
		Text:SetText( strText or "Message Text (Second Parameter)" )
		Text:SizeToContents()
		Text:SetContentAlignment( 5 )
		Text:SetTextColor( color_white )

	local arg = { ... }

	local DComboBox = vgui.Create( "DComboBox", Window )
		DComboBox:SetSize( 180, 20 )

		if arg[1] then
			for k, v in pairs( arg[1] ) do
				DComboBox:AddChoice( k )
			end
		end

		if not arg[1] or table.Count( arg[1] ) > 0 then
			DComboBox:SetText( table.Count( DComboBox.Choices ) .. " Available" )
		else
			DComboBox:SetText( "None Available" )
			ToggleListing( DComboBox, true )
		end

	local Submit = vgui.Create( "DButton", ButtonPanel )
		Submit:SetText( "Buy" )
		Submit:SizeToContents()
		Submit:SetTall( 20 )
		Submit:SetWide( Submit:GetWide() + 20 )
		Submit:SetPos( 5, 5 )
		Submit.DoClick = function()
			if DComboBox:GetValue() == table.Count( DComboBox.Choices ) .. " Available" or DComboBox:GetValue() == "None Available" then return end
			RunConsoleCommand( "perp_b_f", id, DComboBox:GetValue() )

			for k, v in pairs( DComboBox.Choices ) do
				if v == DComboBox:GetValue() then
					table.remove( DComboBox.Choices, k )
				end
			end

			if not arg[1] or table.Count( arg[1] ) > 0 then
				DComboBox:SetText( table.Count( DComboBox.Choices ) .. " Available" )
			else
				DComboBox:SetText( "None Available" )
				ToggleListing( DComboBox, true )
			end
		end

	local Cancel = vgui.Create( "DButton", ButtonPanel )
		Cancel:SetText( "Done" )
		Cancel:SizeToContents()
		Cancel:SetTall( 20 )
		
		Cancel:SetPos( Submit:GetWide() + 10, 5 )
		Cancel:SetWide( Cancel:GetWide() + 20 )
		Cancel.DoClick = function() Window:Close() Window = nil end

	ButtonPanel:SetWide( Submit:GetWide() + 5 + Cancel:GetWide() + 5 )

	local w, h = Text:GetSize()
	w = math.max( w, 400 ) 
	
	Window:SetSize( w + 50, h + 25 + 75 + 10 )
	Window:Center()

	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )
	
	InnerPanel:StretchToParent( 5, 25, 5, 45 )
	
	Text:StretchToParent( 5, 5, 5, 5 )	

	DComboBox:CenterHorizontal()
	DComboBox:AlignBottom( Window:GetTall() / 3 )
	
	Window:MakePopup()
	
	if NumOptions == 0 then
		Window:Close()
		Error( "Derma_AvailableFurniture: Created Query with no Options!?" )
	end
end