local PANEL = {}

surface.CreateFont("PopupFont", {font="Default", size=12, weight=700, antialias=false, additive=false})
surface.CreateFont("PopupFontUB", {font="Default", size=13, weight=400, antialias=false, additive=false})

local EarnedSound = Sound("misc/achievement_earned.wav");

local PopupTime = .4;

function PANEL:Init ( )	
	surface.PlaySound(EarnedSound)
	
	self.PopupTime = CurTime() + PopupTime;
	self.DieTime = CurTime() + 10 + PopupTime * 2;
	self.OurName = "Untitled Achievement";
end

function PANEL:SetAchievement ( Name, Mat )
	self.OurName = Name;
	self.OurMaterial = Mat;
end

function PANEL:Think()
	if CurTime() < self.PopupTime then
		local Percentage = 1 - ((self.PopupTime - CurTime()) / PopupTime);
		
		self:SetPos(ScrW() - self:GetWide(), ScrH() - (self:GetTall() * Percentage));
	elseif CurTime() > self.DieTime then
		self:Remove();
	elseif CurTime() > self.DieTime - PopupTime then
		local Percentage = (self.DieTime - CurTime()) / PopupTime;
		
		self:SetPos(ScrW() - self:GetWide(), ScrH() - (self:GetTall() * Percentage));
	else
		self:SetPos(ScrW() - self:GetWide(), ScrH() - self:GetTall());
	end
end

function PANEL:PerformLayout()	
	self:SetSize(240, 94)
	self:SetPos(ScrW() - 240, ScrH())
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall()
	
	surface.SetDrawColor(47, 49, 45, 255)
	surface.DrawRect(0, 0, w, h)
	
	surface.SetDrawColor(104, 106, 101, 255)
	surface.DrawOutlinedRect(0, 0, w, h)
	
	surface.SetDrawColor(255, 255, 255, 255)
	
	if self.OurMaterial then
		surface.SetTexture(surface.GetTextureID(self.OurMaterial))
		surface.DrawTexturedRect(14, 14, 64, 64)
		
		surface.SetDrawColor(70, 70, 70, 255)
		surface.DrawOutlinedRect(13, 13, 66, 66)
	end
	
	draw.DrawText("Achievement Unlocked!", "PopupFont", 88, 25, Color( 255, 255, 255, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(self.OurName, "PopupFontUB", 88, 50, Color( 216, 222, 211, 255), TEXT_ALIGN_LEFT)
	
end
vgui.Register("gmr2_achievement_earned", PANEL)