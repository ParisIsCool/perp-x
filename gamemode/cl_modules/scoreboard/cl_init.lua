module( "PulsarScoreboard", package.seeall )

WebRoot = "https://voltagegaming.com/apivb/index.php?server=gtaonline&type=" // The website root
/*Web = {
	News = WebRoot .. "news",
	Rules = WebRoot .. "rules",
	Chat = WebRoot .. "chat",
	FAQ = WebRoot .. "faq",
	Changelog = WebRoot .. "changelog",
	Header = WebRoot .. "header",
}
*/
Web = {
	News = "https://voltagegaming.com/forums/shoutbox/popup",
	--News = WebRoot .. "news",
	Rules = "http://perp.asocket.net/rules/",
	Chat = WebRoot .. "chat",
	--FAQ = WebRoot .. "faq",
	Changelog = WebRoot .. "changelog",
	Header = WebRoot .. "header",
	--ACP = "https://voltagegaming.com/gtaadminzz1/index.php"
	--FAQ = "https://www.gamingvoltage.com/faq/",
	FAQ = "https://voltagegaming.com/vgrules/index.html",
}


GradientUp = Material( "gui/gradient_up" )
GradientDown = Material( "gui/gradient_down" )
GradientTabs = Material( TextureRoot .. "gradient1_1.png" )
Mic = TextureRoot .. "mic.png"
MicMute = TextureRoot .. "micmute.png"

/*
	A convience function that registers a new tab for the scoreboard.
	Params:
	   title - The text the tab uses
	   order - Which position order should the tab be
	   element - The VGUI element the tab uses for its body
	   nohook - Should we not hook it automatically (only used to exlucde tabs that should always be there, ie. player list)
	   adminonly - Is this tab visible only to admins?
*/
function RegisterTab( title, order, element, nohook, adminonly )

	local uniquename = element .. "Tab"

	if !nohook then
		hook.Add( "ScoreboardTabs", uniquename, function()
			return vgui.Create( uniquename )
		end )
	end

	local TAB = {}
	TAB.Order = order or 1

	function TAB:GetText()
		return title or "TODO"
	end

	function TAB:CreateBody()
		return vgui.Create( element, self )
	end

	TAB.AdminOnly = adminonly

	vgui.Register( uniquename, TAB, "ScoreboardTab" )

end

/*
	A convience function that creates a simple HTML panel for tab.
	Params:
	   element - The VGUI element to bind it to
	   url - The URL to set the HTML panel to
	   height - The height of the HTML panel
*/
function CreateHTML( element, url, height )

	element.HTML = vgui.Create( "HTML", element )
	element.HTML:SetPos( 4, 25 )
	element.HTML:SetSize( element:GetWide(), height )

	element.HTML:OpenURL( url or Web.News )
	element.HTML:Dock( FILL )

end

// This is for refreshing it when we reload lua
if Gui && ValidPanel( Gui ) then
	Gui:Remove()
	Gui = nil
end

function GM:ScoreboardShow()

	// Create if needed
	if !ValidPanel( Gui ) then
		Gui = vgui.Create( "PulsarScoreboard" )
	end

	// Set visibility
	if ValidPanel( Gui ) then

		Gui:InvalidateLayout()
		Gui:SetVisible( true )
		Gui.Help:SetVisible( true )

	end

end

function GM:ScoreboardHide()

	if ValidPanel( Gui ) then
	    Gui:SetVisible( false )
		Gui.Help:SetVisible( false )
	end

end


/*
	This is used so we can enable/disable the mouse clicker when they left click.
*/
hook.Add( "Think", "PulsarScoreThink", function( ply, bind, pressed )

	if IsValid( Gui ) then

		if Gui:IsVisible() then

			if input.IsMouseDown( MOUSE_LEFT ) && !Gui.MouseEnabled then
				gui.EnableScreenClicker( true )
				RestoreCursorPosition()
				Gui.MouseEnabled = true
			end

		elseif !Gui:IsVisible() && Gui.MouseEnabled then
			RememberCursorPosition()
			gui.EnableScreenClicker( false )
			Gui.MouseEnabled = false
		end

	end

end )

/*
	Scrolls without having to click.
*/
hook.Add( "PlayerBindPress", "PlayerListScroll", function( ply, bind, pressed )

	if !ValidPanel( Gui ) then return end

	if bind == "invnext" then

		Gui.ActiveTab:GetBody().VBar:AddScroll( 2 )

	elseif bind == "invprev" then

		Gui.ActiveTab:GetBody().VBar:AddScroll( -2 )

	end

end )