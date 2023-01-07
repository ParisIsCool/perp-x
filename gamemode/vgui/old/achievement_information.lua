local PANEL = {}

surface.CreateFont("Achv_Small", {font="Default", size=13, weight=700, antialias=false, additive=false})
surface.CreateFont("Achv_Large", {font="Default", size=14, weight=700, antialias=true, additive=false})

function PANEL:Init()	
	self.LName = vgui.Create("DLabel", self);
	self.LName:SetFont("Achv_Large");
	self.LName:SetTextColor(Color(158, 195, 79));
	self.LName:SetPos(71, 5);
		
	self.LDesc = vgui.Create("DLabel", self);
	self.LDesc:SetFont("Achv_Small");
	self.LDesc:SetTextColor(Color(217, 217, 217));
	self.LDesc:SetPos(72, 22);
	
	self.LPercent = vgui.Create("DLabel", self);
	self.LPercent:SetFont("Achv_Small");
	self.LPercent:SetTextColor(Color(210, 210, 210));
	
	self.Bar = vgui.Create("gmr2_achievement_progress", self);
end

function PANEL:Setup ( Name, Description, Image, Percent, PercentText )
	self.Image = Image;
	
	self.LName:SetText(Name);
	self.LDesc:SetText(Description);
	self.LPercent:SetText(PercentText);
	
	self.Percent = Percent;
	
	self.Bar:SetPercent(Percent);
end

function PANEL:PerformLayout()
	local w, h = self:GetWide(), self:GetTall();
	self.Bar:SetPos(70, h - 22);
	self.Bar:SetSize(w - 200, 12);
	
	self.LName:SetSize(w, 15);
	self.LDesc:SetSize(w, 15);
	
	self.LPercent:SetSize(w, 15);
	self.LPercent:SetPos(self.Bar.X + self.Bar:GetWide() + 10, h - 24);
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall()
	
	if self.Percent == 1 then
		draw.RoundedBox(4, 0, 0, w, h, Color( 78, 78, 78));
	else
		draw.RoundedBox(4, 0, 0, w, h, Color( 52, 52, 52));
	end
	
	if !self.Image then return false; end
	
	surface.SetDrawColor(255, 255, 255, 255);
	surface.SetTexture(surface.GetTextureID(self.Image));
	surface.DrawTexturedRect(4, 4, 56, 56);
end

vgui.Register("gmr2_achievement_information", PANEL)