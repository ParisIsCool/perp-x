-- // -- // -- // -- // -- // -- // -- // --

-- [[ Fonts

surface.CreateFont("Paris_Derma", {
	font = "Roboto Thin",
	extended = false,
    size = 18,
    antialias = true,
} )

-- // -- // -- // -- // -- // -- // -- // --




-- // -- // -- // -- // -- // -- // -- // --

-- [[ DFrame

-- // -- // -- // -- // -- // -- // -- // --

local PANEL = {}

function PANEL:Init()

    self:SetSize( 100, 60 )
    self.btnMaxim:SetAlpha(0)
    self.btnMaxim:Hide()
    self.btnMinim:SetAlpha(0)
    self.btnMinim:Hide()
    self.OldShowCloseButton = vgui.GetControlTable( "DFrame" ).ShowCloseButton

    self.lblTitle:SetFont("Paris_Derma")

    function self.btnClose:Paint(w,h)
        if self:IsHovered() then
            local col = Color(200,200,200,255 * (math.abs(math.sin(CurTime()*4))))
            draw.RoundedBox( 0, 0, 0, 1, h, col)
            draw.RoundedBox( 0, w-1, 0, 1, h, col)
            draw.RoundedBox( 0, 0, 0, w, 1, col)
            draw.RoundedBox( 0, 0, h-1, w, 1, col)
            draw.RoundedBox( 0, 0, 0, w, h, Color(55,55,55,100 * (math.abs(math.sin(CurTime()*4)))))
            draw.SimpleText("X", "Paris_Derma", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color(55,55,55,50))
            draw.SimpleText("X", "Paris_Derma", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

end

function PANEL:ShowCloseButton(bool)
    self:OldShowCloseButton(bool)
    self.btnMaxim:Hide()
    self.btnMinim:Hide()
end

function PANEL:PerformLayout()
    
    local titlePush = 0

	if ( IsValid( self.imgIcon ) ) then

		self.imgIcon:SetPos( 5, 5 )
		self.imgIcon:SetSize( 16, 16 )
		titlePush = 16

	end

	self.btnClose:SetPos( self:GetWide() - 26 - 4, 0 )
	self.btnClose:SetSize( 26, 24 )

	self.btnMaxim:SetPos( self:GetWide() - 31 * 2 - 4, 0 )
	self.btnMaxim:SetSize( 31, 24 )

	self.btnMinim:SetPos( self:GetWide() - 31 * 3 - 4, 0 )
	self.btnMinim:SetSize( 31, 24 )

	--self.lblTitle:SetPos( 8 + titlePush, 2 )
	--self.lblTitle:SetSize( self:GetWide() - 25 - titlePush, 20 )
    self.lblTitle:Hide()

    if self.OverPerformLayout then self:OverPerformLayout() end

end

function PANEL:Think()

    if self.ThinkOver then self:ThinkOver() end

	local mousex = math.Clamp( gui.MouseX(), 1, ScrW() - 1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH() - 1 )

	if ( self.Dragging ) then

		local x = mousex - self.Dragging[1]
		local y = mousey - self.Dragging[2]

		-- Lock to screen bounds if screenlock is enabled
		if ( self:GetScreenLock() ) then

			x = math.Clamp( x, 0, ScrW() - self:GetWide() )
			y = math.Clamp( y, 0, ScrH() - self:GetTall() )

		end

		self:SetPos( x, y )

	end

	if ( self.Sizing ) then

		local x = mousex - self.Sizing[1]
		local y = mousey - self.Sizing[2]
		local px, py = self:GetPos()

		if ( x < self.m_iMinWidth ) then x = self.m_iMinWidth elseif ( x > ScrW() - px && self:GetScreenLock() ) then x = ScrW() - px end
		if ( y < self.m_iMinHeight ) then y = self.m_iMinHeight elseif ( y > ScrH() - py && self:GetScreenLock() ) then y = ScrH() - py end

		self:SetSize( x, y )
		self:SetCursor( "sizenwse" )
		return

	end

	local screenX, screenY = self:LocalToScreen( 0, 0 )

	if ( self.Hovered && self.m_bSizable && mousex > ( screenX + self:GetWide() - 20 ) && mousey > ( screenY + self:GetTall() - 20 ) ) then

		self:SetCursor( "sizenwse" )
		return

	end

	if ( self.Hovered && self:GetDraggable() && mousey < ( screenY + 24 ) ) then
		self:SetCursor( "sizeall" )
		return
	end

	self:SetCursor( "arrow" )

	-- Don't allow the frame to go higher than 0
	if ( self.y < 0 ) then
		self:SetPos( self.x, 0 )
	end

end

function PANEL:Paint( w, h )

    local pushy = 15

    local x, y = self:LocalToScreen( 0, 0 )

    DisableClipping(true)
    draw.RoundedBox( 0 , -2, -2, 2, h+4, Color(150,150,150,100))
    draw.RoundedBox( 0 , -2, -2, w+4, 2, Color(150,150,150,100))
    draw.RoundedBox( 0 , w, -2, 2, h+4, Color(150,150,150,100))
    draw.RoundedBox( 0 , -2, h, w+4, 2, Color(150,150,150,100))
    DisableClipping(false)

    local Fraction = 2.2

    local matBlurScreen = Material( "pp/blurscreen" )
    surface.SetMaterial( matBlurScreen )
    surface.SetDrawColor( 255, 255, 255, 255 )

    for i=0.33, 1, 0.33 do
        matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
        matBlurScreen:Recompute()
        if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
        surface.DrawTexturedRect( x * -1, (y * -1) + pushy, ScrW(), ScrH() )
    end

    --draw.RoundedBox( 0, 0, 0, w, h + pushy, Color(22,22,22,self:GetAlpha()))

    DisableClipping(true)
    draw.RoundedBox( 0 , 8, -12, w-20+4, 34, Color(150,150,150,100))
    draw.RoundedBox( 0 , 10, -10, w-20, 30, Color(22,22,22,255))
    draw.SimpleText("> " .. self.lblTitle:GetText(), "DermaDefault", w/2, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    DisableClipping(false)

end

vgui.Register( "paris_Frame", PANEL, "DFrame" )



-- // -- // -- // -- // -- // -- // -- // --

-- [[ DTextEntry

-- // -- // -- // -- // -- // -- // -- // --

local PANEL = {}

function PANEL:Init()

    self:SetSize( 100, 30 )

    self:SetTextColor( Color(255,255,255) )
    self:SetPlaceholderText("")
    self:SetCursorColor( Color(255, 255, 255,255) )
    self:SetFont("Paris_Derma")

end

function PANEL:Paint( w, h )

    local col = Color(200,200,200,255 * (math.abs(math.sin(CurTime()*4))))
    draw.RoundedBox( 0, 0, 0, 1, h, col)
    draw.RoundedBox( 0, w-1, 0, 1, h, col)
    draw.RoundedBox( 0, 0, 0, w, 1, col)
    draw.RoundedBox( 0, 0, h-1, w, 1, col)

    
    local textcol = Color(255,255,255,255)
    local highlightcol = Color(255, 64, 43,100)
    local cursorcol = Color(255,255,255,255)

    self:DrawTextEntryText( textcol, highlightcol, cursorcol )

end

vgui.Register( "paris_TextEntry", PANEL, "DTextEntry" )




-- // -- // -- // -- // -- // -- // -- // --

-- [[ DButton (Not for standard use)

-- // -- // -- // -- // -- // -- // -- // --

local PANEL = {}

function PANEL:Init()

    self:SetSize( 100, 30 )

    self:SetTextColor( Color(255,255,255) )

    self:SetFont("Paris_Derma")

end

function PANEL:Paint( w, h )

    if self:IsHovered() then
        local col = Color(200,200,200,255 * (math.abs(math.sin(CurTime()*4))))
        draw.RoundedBox( 0, 0, 0, 1, h, col)
        draw.RoundedBox( 0, w-1, 0, 1, h, col)
        draw.RoundedBox( 0, 0, 0, w, 1, col)
        draw.RoundedBox( 0, 0, h-1, w, 1, col)
        draw.RoundedBox( 0, 0, 0, w, h, Color(55,55,55,100 * (math.abs(math.sin(CurTime()*4)))))
        draw.SimpleText(self:GetText(), "Paris_Derma", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        draw.RoundedBox( 0, 0, 0, w, h, Color(55,55,55,50))
        draw.SimpleText(self:GetText(), "Paris_Derma", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

end

vgui.Register( "paris_Button", PANEL, "DButton" )




-- // -- // -- // -- // -- // -- // -- // --

-- [[ DSlider

-- // -- // -- // -- // -- // -- // -- // --

local PANEL = {}

function PANEL:Init()

    self:SetSize( 100, 30 )

end

--[[function PANEL:Paint( w, h )



end]]

vgui.Register( "paris_Slider", PANEL, "DSlider" )




-- // -- // -- // -- // -- // -- // -- // --

-- [[ DButton2 (Not for standard use)

-- // -- // -- // -- // -- // -- // -- // --

local PANEL = {}

function PANEL:Init()

    self:SetSize( 100, 30 )

    self:SetTextColor( Color(255,255,255) )

    self:SetFont("aSoc_GUIFont")

    self.Alpha = 0
    self.Alphainf = 0

end

local bccolor = Color(47,49,54)

function PANEL:Paint( w, h )

    draw.RoundedBox(h,0,0,w,h,color_white)
    if self:IsHovered() then
        self.Alphainf = 20
    else
        self.Alphainf = 0
    end
    self.Alpha = Lerp(FrameTime()*10, self.Alpha, self.Alphainf)
    draw.RoundedBox(h-6,3,3,w-6,h-6,bccolor)
    draw.RoundedBox(h-6,3,3,w-6,h-6,Color(255,255,255,self.Alpha))
    aSoc.DrawShadowedText(self.Text, "aSoc_GUIFont", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end

vgui.Register( "asoc_Button", PANEL, "DButton" )





-- // -- // -- // -- // -- // -- // -- // --

-- [[ DLabel (Not for standard use)

-- // -- // -- // -- // -- // -- // -- // --

local PANEL = {}

function PANEL:Init()

    self:SetSize( 100, 30 )
    self:SetText("")
    self.Color = color_white

end

function PANEL:Paint( w, h )

    aSoc.DrawShadowedText(self.Text, "aSoc_GUIFont", w/2, h/2, self.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end

vgui.Register( "asoc_Label", PANEL, "DPanel" )
