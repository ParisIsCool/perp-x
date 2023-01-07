
local PANEL = {}

DoIt = {'General', 'PERP', 'GMP', 'TF2TD'}

function FormatTime ( time, format )	
	local SecondsAndShit = {{"h", 3600}, {"m", 60}, {"s", 1}};
	
	for _, t in pairs(SecondsAndShit) do
		local amount = math.floor(time / t[2])
		format = string.Replace(format, t[ 1 ], string.rep("0", 2 - string.len(amount)) .. amount);
		time = time % t[2];
	end
	
	return format;
end

function PANEL:Init()
	self:SetTitle("PreyTech Achievements")
	self:MakePopup()
	self:SetDraggable(false);
	
	self.Bar = vgui.Create("gmr2_achievement_total_progress", self)
	
	self.List = vgui.Create("DPanelList", self)
	self.List:EnableVerticalScrollbar()
	self.List:SetPadding(4)
	self.List:SetSpacing(4)
	
	self.CloseB = vgui.Create("DButton", self)
	self.CloseB:SetText("Close")
	self.CloseB.DoClick = function() self:Close() end
	
	self.Achievements = {};
	
	local AchievementClasses = {};
	
	for k, v in pairs(AchievementDatabase) do
		AchievementClasses[v.Class] = AchievementClasses[v.Class] or {};
		table.insert(AchievementClasses[v.Class], v);
	end
	
	local NumAchieved = 0;
	for _, what in pairs(DoIt) do
		for k, v in pairs(AchievementClasses[what]) do
			local NewAchievementInfo = vgui.Create('gmr2_achievement_information', self.List);
			
			local OurStatus = LocalPlayer():GetProgress(v.ID);
			
			local Percent = OurStatus / v.Goal;
			
			local PercentText = '';
			if OurStatus != v.Goal then
				if v.DisplayStyle == ACHV_NUMB then
					PercentText = OurStatus .. '/' .. v.Goal;
				elseif v.DisplayStyle == ACHV_TIME then
					PercentText = FormatTime(OurStatus, "h:m:s");
				elseif v.DisplayStyle == ACHV_BOOL then
					PercentText = 'Incomplete';
				end
			else
				PercentText = 'Complete';
			end
			
			if OurStatus == v.Goal then
				NumAchieved = NumAchieved + 1;
			end
			
			NewAchievementInfo:Setup(v.Class .. ' - ' .. v.Name, v.Description, v.Image, Percent, PercentText);
			self.List:AddItem(NewAchievementInfo);
			table.insert(self.Achievements, NewAchievementInfo);
		end
	end
	
	local PercentDone = NumAchieved / #self.Achievements;
	self.Bar:Setup(PercentDone, NumAchieved .. '/' .. #self.Achievements);
	
	self:SetSize(math.floor(ScrW() * 0.6), math.floor(ScrH() * 0.6))
	self:Center()
end

function PANEL:PerformLayout()
	local w, h = self:GetWide(), self:GetTall()
	
	self.Bar:SetPos(15, 40);
	self.Bar:SetSize(w - 30, 50);
	
	self.List:SetPos(15, 100);
	self.List:SetSize(w - 30, h - 140);
	
	self.CloseB:SetPos(w - 85, h - 34);
	self.CloseB:SetSize(70, 24);
	
	for k, v in pairs(self.Achievements) do
		v:SetSize(self.List:GetWide() - 18, 64);
	end
	self.List:InvalidateLayout();
	
	self.BaseClass.PerformLayout(self);
end

vgui.Register("gmr2_achievements", PANEL, "DFrame")