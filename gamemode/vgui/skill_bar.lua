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

surface.CreateFont( "SkillsFont", { font = "Tahoma", size = ScreenScale( 8 ), weight = 1000, antialias = true, additive = false } )

function PANEL:Init ( )
	self.MonitorSkill = 'ERROR'
	self.LerpSkillLevel = 0
	self.LerpSkillLevelInf = 0
end

function PANEL:PerformLayout ( )
	surface.SetFont("SkillsFont")
	local x, y = surface.GetTextSize("whatever.")
	self:SetHeight(y * 1.5)
end

function PANEL:Paint ( )
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawRect(1, 1, self:GetWide() - 2, self:GetTall() - 2)
	
	local previousLevelExperience = GAMEMODE.GetRequiredExperience(LocalPlayer():GetSkillLevel(self.RealSkill))
	local nextLevelExperience = GAMEMODE.GetRequiredExperience(LocalPlayer():GetSkillLevel(self.RealSkill) + 1)
	local neededExperience = nextLevelExperience - previousLevelExperience
	local aquiredExperience = LocalPlayer():GetExperience(self.RealSkill) - previousLevelExperience
	
	local percentThere = aquiredExperience / neededExperience

	self.LerpSkillLevel = Lerp(FrameTime()*10,self.LerpSkillLevel,self.LerpSkillLevelInf)
	self.LerpSkillLevelInf = percentThere
	
	if LocalPlayer():GetSkillLevel(self.RealSkill) ~= GAMEMODE.MaxSkillLevel_Level then
		surface.SetDrawColor(200, 50, 50, 200)
		surface.DrawRect(1, 1, (self:GetWide() - 2) * self.LerpSkillLevel, self:GetTall() - 2)
	else
		surface.SetDrawColor(200, 50, 50, 200)
		surface.DrawRect(1, 1, self:GetWide() - 2, self:GetTall() - 2)
	end
	
	draw.SimpleText(SKILLS_DATABASE[self.MonitorSkill][2], 'SkillsFont', self:GetWide() * .025, self:GetTall() * .5, Color(0, 0, 0, 255), 0, 1)
	if(LocalPlayer():GetSkillLevel(self.RealSkill) ~= GAMEMODE.MaxSkillLevel_Level) then
	draw.SimpleText(math.ceil(percentThere * 100) .. "%", 'SkillsFont', self:GetWide() * .5, self:GetTall() * .5, Color(0, 0, 0, 255), 0, 1)
	else
	draw.SimpleText("MAXED", 'SkillsFont', self:GetWide() * .5, self:GetTall() * .5, Color(0, 0, 0, 255), 0, 1)
	end
	draw.SimpleText("Level " .. LocalPlayer():GetSkillLevel(self.RealSkill) .. "/" .. GAMEMODE.MaxSkillLevel_Level, 'SkillsFont', self:GetWide() * .975, self:GetTall() * .5, Color(0, 0, 0, 255), 2, 1)
end

function PANEL:SetSkill ( SkillID )
	self.RealSkill = SkillID
	self.MonitorSkill = GAMEMODE.GetRealSkillID(SkillID)
	self:PerformLayout()
	return self
end

vgui.Register('perp2_skill_bar', PANEL)