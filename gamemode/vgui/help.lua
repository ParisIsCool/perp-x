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

local function CreateHTML( element, url, height )

	element.HTML = vgui.Create( "HTML", element )
	element.HTML:SetPos( 4, 25 )
	element.HTML:SetSize( element:GetWide(), height )

	element.HTML:OpenURL( url or Web.News )
	element.HTML:Dock( FILL )

end

function PANEL:Init()
	self:SetTitle( "Help" )
	self:ShowCloseButton( true )
	self:SetDraggable( true )
	
	self:SetSize( ScrW() * .50, ScrH() * .55 )
	self:SetPos( ScrW() * .20, ScrH() * .25 )

	self:SetAlpha( GAMEMODE.GetGUIAlpha() )
	
	self.PropertySheet = vgui.Create( "DPropertySheet", self )
	self.OptionsList = vgui.Create( "DPanelList", self )
	self.OptionsList:EnableHorizontal( false )
	self.OptionsList:EnableVerticalScrollbar( true )
	self.OptionsList:SetPadding( 5 )
	self.OptionsList:SetPadding( 5 )
	self.OptionsList:SetSpacing( 5 )
	self.PropertySheet:AddSheet( "Options", self.OptionsList )
	GAMEMODE.LoadOptionsList( self.OptionsList )

	self.Tips = vgui.Create( "DPanelList", self )
	self.Tips:EnableHorizontal( false )
	self.Tips:EnableVerticalScrollbar( true )
	self.Tips:SetPadding( 5 )
	self.Tips:SetPadding( 5 )
	self.Tips:SetSpacing( 5 )
	self.PropertySheet:AddSheet( "Tips", self.Tips )

	local Tips = {
		"Craft mixtures in your inventory! Make sure you have the right genetics and skills",
		"Type /discord in chat to link your discord",
		"If your car is stuck, type /carstuck in chat",
	}
	for k, v in pairs(Tips) do
		local Tip = vgui.Create("DLabel", self.Tips)
		Tip:SetText(v)
		self.Tips:AddItem(Tip)
	end
	
	self:Center()

end

function PANEL:PerformLayout()
	self:SetSize( ScrW() * .50, ScrH() * .55 )
	
	self.BaseClass.PerformLayout( self )
	
	self.PropertySheet:StretchToParent( 5, 30, 5, 5 )
end

function PANEL:Close()
	self:SetVisible( false )
end

vgui.Register( "perp2_help", PANEL, "paris_Frame" )