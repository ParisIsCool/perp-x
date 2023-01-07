local PANEL = {}

function PANEL:Init()
	self.Percent = 100;
	self.Foreground = Color(201, 185, 149);
end

function PANEL:SetColor( fore )
	self.Foreground = fore;
end

function PANEL:SetPercent ( percent )
	self.Percent = percent;
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall();
	surface.SetDrawColor(62, 62, 62, 255);
	surface.DrawRect(0, 0, w, h);
	
	surface.SetDrawColor(self.Foreground.r, self.Foreground.g, self.Foreground.b, self.Foreground.a)
	surface.DrawRect(0, 0, w * self.Percent, h)
end

vgui.Register("gmr2_achievement_progress", PANEL)