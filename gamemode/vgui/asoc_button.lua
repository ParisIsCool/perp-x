local PANEL = {}

function PANEL:Init()
    self:SetText("")

    function self:SetText(text)
        self.text = text 
    end

    self.alpha = 0
    self.alphainf = 0.5
end

local white = Color(255,255,255)
local bg = Color(125, 130, 136)
function PANEL:Paint(w,h)
    if self:IsHovered() then self.alphainf = 1 else self.alphainf = 0.2 end
    self.alpha = Lerp( 4 * FrameTime(), self.alpha , self.alphainf)
    draw.RoundedBox(0,0,0,w,h,bg)
    draw.RoundedBox(0,0,0,w,h,Color(68,68,68,self.alpha*255))
    aSoc.DrawShadowedText(self.text or "", "aSoc_GUIFont", w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("aSoc_Button", PANEL, "DButton")