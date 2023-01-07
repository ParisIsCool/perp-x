--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up

local PANEL = {}

surface.CreateFont( "CardFont", { font = "Tahoma", size = ScreenScale( 12 ), weight = 800, antialias = true, additive = false } )

local CardTextures = {}
CardTextures[CARD_DIAMOND] = surface.GetTextureID('perp/cards/diamond')
CardTextures[CARD_HEART] = surface.GetTextureID('perp/cards/heart')
CardTextures[CARD_CLUB] = surface.GetTextureID('perp/cards/club')
CardTextures[CARD_SPADE] = surface.GetTextureID('perp/cards/spade')

local CardColors = {}
CardColors[CARD_DIAMOND] = Color(255, 0, 0, 255)
CardColors[CARD_HEART] = Color(255, 0, 0, 255)
CardColors[CARD_CLUB] = Color(0, 0, 0, 255)
CardColors[CARD_SPADE] = Color(0, 0, 0, 255)

local TEXTURE_JACK = surface.GetTextureID('perp/cards/jack')
local TEXTURE_QUEEN = surface.GetTextureID('perp/cards/queen')
local TEXTURE_KING = surface.GetTextureID('perp/cards/king')
local TEXTURE_FLIPPED = surface.GetTextureID('perp/cards/flipped')

function PANEL:Init ( )

end

function PANEL:PerformLayout ( )
	local W = ScrW() * .08
	self:SetSize(W, W * 1.4)
end

function PANEL:SetTargetX ( OurTarget )
	self.OurTargetX = OurTarget
	self.NextUpdatePos = CurTime() + .01
end

function PANEL:SetupCard ( Type, Value, FaceDown )
	self.Type = Type
	self.Value = Value
	self.FaceDown = FaceDown or false
	
	self.Texture = CardTextures[Type]
	self.TextColor = CardColors[Type]
end

function PANEL:Flip ( FaceDown )
	self.FaceDown = FaceDown or false
end

function PANEL:Think ( )
	local OurX, OurY = self:GetPos()
	
	if self.OurTargetX then
		if self.OurTargetX == OurX then
			self.OurTargetX = nil
		elseif self.NextUpdatePos < CurTime() then
			self.NextUpdatePos = CurTime() + .01
			self:SetPos(math.Clamp(OurX - 25, self.OurTargetX, OurX), OurY)
		end
	end
end

function PANEL:Paint( w, h )
	if !self.Type then return false end
	
	local W, H = self:GetWide(), self:GetTall()
	
	draw.RoundedBox(6, 0, 0, W, H, Color(0, 0, 0, 255))
	draw.RoundedBox(6, 1, 1, W - 2, H - 2, Color(255, 255, 255, 255))
	
	if self.FaceDown then
		surface.SetTexture(TEXTURE_FLIPPED)
		surface.DrawTexturedRect(5, 5, w - 10, self:GetTall() - 10)
		
		return false
	end
	
	surface.SetTexture(self.Texture)
	
	local LS = W * .2
	local HS = LS * .5
	
	local TextValue = tostring(self.Value)
	
	if self.Value == CARD_ACE then
		TextValue = "A"
		
		surface.DrawTexturedRect(W * .5 - HS, H * .5 - HS, LS, LS)
	elseif self.Value == CARD_2 then
		surface.DrawTexturedRect(W * .5 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .8 - HS, LS, LS)
	elseif self.Value == CARD_3 then
		surface.DrawTexturedRect(W * .5 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .5 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .8 - HS, LS, LS)
	elseif self.Value == CARD_4 then
		surface.DrawTexturedRect(W * .3 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .8 - HS, LS, LS)
	elseif self.Value == CARD_5 then
		surface.DrawTexturedRect(W * .3 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .5 - HS, LS, LS)
	elseif self.Value == CARD_6 then
		surface.DrawTexturedRect(W * .3 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .5 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .5 - HS, LS, LS)
	elseif self.Value == CARD_7 then
		surface.DrawTexturedRect(W * .3 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .35 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .5 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .5 - HS, LS, LS)
	elseif self.Value == CARD_8 then
		surface.DrawTexturedRect(W * .3 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .35 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .65 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .5 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .5 - HS, LS, LS)
	elseif self.Value == CARD_9 then
		surface.DrawTexturedRect(W * .3 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .4 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .4 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .5 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .6 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .6 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .8 - HS, LS, LS)
	elseif self.Value == CARD_10 then
		surface.DrawTexturedRect(W * .3 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .2 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .4 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .4 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .6 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .6 - HS, LS, LS)
		surface.DrawTexturedRect(W * .3 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .7 - HS, H * .8 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .325 - HS, LS, LS)
		surface.DrawTexturedRect(W * .5 - HS, H * .675 - HS, LS, LS)
	elseif self.Value == CARD_JACK then
		TextValue = "J"
		
		surface.SetTexture(TEXTURE_JACK)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(10, 10, W - 20, H - 20)
	elseif self.Value == CARD_QUEEN then
		TextValue = "Q"
		
		surface.SetTexture(TEXTURE_QUEEN)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(10, 10, W - 20, H - 20)
	elseif self.Value == CARD_KING then
		TextValue = "K"
		
		surface.SetTexture(TEXTURE_KING)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(10, 10, W - 20, H - 20)
	end
	
	surface.SetTexture(self.Texture)
	
	local TextPadding = 5
	local MS = LS * .6
	
	-- Write wordage at top left along with symbol...
	surface.SetFont("CardFont")
	local TW, TH = surface.GetTextSize(TextValue)
	
	local Adjust = 0
	if string.len(TextValue) > 1 then
		Adjust = TW * .25
	end
	
	draw.SimpleText(TextValue, "CardFont", TextPadding * 1.5 - Adjust, TextPadding, self.TextColor)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(TextPadding * 1.5, TextPadding * 1.2 + TH, MS, MS)
	
	-- Bottom right
	surface.SetFont("CardFont")
	local TW, TH = surface.GetTextSize(TextValue)
	
	draw.SimpleText(TextValue, "CardFont", W - TextPadding * 1.5 - TW + Adjust, H - TextPadding - TH, self.TextColor)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(W - TextPadding * 1.5 - MS, H - TextPadding - TH * 1.6, MS, MS)
end

vgui.Register('perp_card', PANEL)