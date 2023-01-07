local PANEL = {}

function PANEL:Init()
	self.Text = "0/0";
	self.Percent = 100;
	
	self.Bar = vgui.Create("gmr2_achievement_progress", self);
	self.Bar:SetColor(Color(158, 195, 79));
end

function PANEL:PerformLayout()
	local w, h = self:GetWide(), self:GetTall();
	
	self.Bar:SetPos(8, h - 25);
	self.Bar:SetSize(w - 16, 16);
end

function PANEL:Setup ( Percent, Text )
	self.Percent = Percent * 100;
	self.Text = Text;
	
	self.Bar:SetPercent(Percent);
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall();
	
	surface.SetDrawColor(26, 26, 26, 255);
	surface.DrawRect(0, 0, w, h);
	
	draw.SimpleText("Achievements Earned:", "Achv_Small", 8, 7, Color( 217, 217, 217 )) ;
	draw.SimpleText(self.Text .. " ( " .. math.Round(self.Percent) .. "% )", "Achv_Small", w - 10, 7, Color( 217, 217, 217 ), TEXT_ALIGN_RIGHT);
end

vgui.Register("gmr2_achievement_total_progress", PANEL)